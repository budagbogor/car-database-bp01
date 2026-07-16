'use strict';
require('dotenv').config();

const express  = require('express');
const cors     = require('cors');
const path     = require('path');
const pool     = require('./db');

const app  = express();
const PORT = process.env.PORT || 3000;
const ADMIN_KEY = process.env.ADMIN_KEY || 'change-me';

// ── Middleware ────────────────────────────────────────────────────────────────
app.use(cors());
app.use(express.json());
app.use(express.static(path.join(__dirname, 'public')));

// ── Auth Middleware untuk Admin ───────────────────────────────────────────────
function requireAdmin(req, res, next) {
  const key = req.headers['x-admin-key'];
  if (!key || key !== ADMIN_KEY) {
    return res.status(401).json({ error: 'Unauthorized — admin key salah atau tidak ada.' });
  }
  next();
}

// ── Helper: build WHERE clause dari query params ──────────────────────────────
function buildFilter(query) {
  const conditions = [];
  const values     = [];
  let   idx        = 1;

  if (query.q) {
    conditions.push(
      `(merek ILIKE $${idx} OR model ILIKE $${idx} OR kode_mesin ILIKE $${idx} OR kategori ILIKE $${idx} OR tahun ILIKE $${idx})`
    );
    values.push(`%${query.q}%`);
    idx++;
  }
  if (query.fuel && query.fuel !== 'all') {
    conditions.push(`bahan_bakar = $${idx++}`);
    values.push(query.fuel);
  }
  if (query.brand) {
    conditions.push(`merek = $${idx++}`);
    values.push(query.brand);
  }
  if (query.trans) {
    conditions.push(`tipe_transmisi = $${idx++}`);
    values.push(query.trans);
  }
  if (query.category) {
    conditions.push(`kategori = $${idx++}`);
    values.push(query.category);
  }
  if (query.ps === 'eps') {
    conditions.push(`tipe_power_steering ILIKE $${idx++}`);
    values.push('%Elektrik%');
  }
  if (query.ps === 'hydraulic') {
    conditions.push(`(tipe_power_steering = 'Hidrolik' OR tipe_power_steering LIKE 'Hidrolik (%')`);
  }

  const where = conditions.length ? 'WHERE ' + conditions.join(' AND ') : '';
  return { where, values, idx };
}

// ─────────────────────────────────────────────────────────────────────────────
// GET /api/health
// ─────────────────────────────────────────────────────────────────────────────
app.get('/api/health', async (_req, res) => {
  try {
    const { rows } = await pool.query('SELECT NOW() AS now');
    res.json({ status: 'ok', db_time: rows[0].now });
  } catch (e) {
    res.status(500).json({ status: 'error', message: e.message });
  }
});

// ─────────────────────────────────────────────────────────────────────────────
// GET /api/brands  — daftar merek unik (untuk dropdown)
// ─────────────────────────────────────────────────────────────────────────────
app.get('/api/brands', async (_req, res) => {
  try {
    const { rows } = await pool.query(
      `SELECT DISTINCT merek FROM kendaraan ORDER BY merek`
    );
    res.json(rows.map(r => r.merek));
  } catch (e) {
    console.error(e);
    res.status(500).json({ error: e.message });
  }
});

// ─────────────────────────────────────────────────────────────────────────────
// GET /api/categories — daftar kategori unik (untuk dropdown)
// ─────────────────────────────────────────────────────────────────────────────
app.get('/api/categories', async (_req, res) => {
  try {
    const { rows } = await pool.query(
      `SELECT DISTINCT kategori FROM kendaraan ORDER BY kategori`
    );
    res.json(rows.map(r => r.kategori));
  } catch (e) {
    console.error(e);
    res.status(500).json({ error: e.message });
  }
});

// ─────────────────────────────────────────────────────────────────────────────
// GET /api/stats — statistik total
// ─────────────────────────────────────────────────────────────────────────────
app.get('/api/stats', async (_req, res) => {
  try {
    const { rows } = await pool.query(`
      SELECT
        COUNT(*)                                          AS total,
        COUNT(DISTINCT merek)                             AS brands,
        COUNT(DISTINCT merek || '|' || model)             AS models,
        COUNT(*) FILTER (WHERE bahan_bakar = 'bensin')   AS bensin,
        COUNT(*) FILTER (WHERE bahan_bakar = 'diesel')   AS diesel
      FROM kendaraan
    `);
    res.json(rows[0]);
  } catch (e) {
    console.error(e);
    res.status(500).json({ error: e.message });
  }
});

// ─────────────────────────────────────────────────────────────────────────────
// GET /api/kendaraan  — list dengan filter & paginasi
// Query params: q, fuel, brand, trans, category, ps, page, limit
// ─────────────────────────────────────────────────────────────────────────────
app.get('/api/kendaraan', async (req, res) => {
  try {
    const page  = Math.max(1, parseInt(req.query.page  || '1'));
    const limit = Math.min(100, Math.max(1, parseInt(req.query.limit || '24')));
    const offset = (page - 1) * limit;

    const { where, values, idx } = buildFilter(req.query);

    const countRes = await pool.query(
      `SELECT COUNT(*) AS total FROM kendaraan ${where}`,
      values
    );
    const total = parseInt(countRes.rows[0].total);

    const dataRes = await pool.query(
      `SELECT k.*,
         (SELECT COUNT(*) FROM kendaraan_differential d WHERE d.kendaraan_id = k.id) > 0 AS has_differential
       FROM kendaraan k ${where}
       ORDER BY k.merek, k.model, k.tahun
       LIMIT $${idx} OFFSET $${idx + 1}`,
      [...values, limit, offset]
    );

    res.json({
      data:        dataRes.rows,
      total,
      page,
      limit,
      total_pages: Math.ceil(total / limit),
    });
  } catch (e) {
    console.error(e);
    res.status(500).json({ error: e.message });
  }
});

// ─────────────────────────────────────────────────────────────────────────────
// GET /api/kendaraan/:id — detail satu kendaraan
// ─────────────────────────────────────────────────────────────────────────────
app.get('/api/kendaraan/:id', async (req, res) => {
  try {
    const { rows } = await pool.query(
      `SELECT * FROM kendaraan WHERE id = $1`,
      [req.params.id]
    );
    if (!rows.length) return res.status(404).json({ error: 'Data tidak ditemukan.' });

    // Fetch differential data (urut: Depan, Belakang, Transfer Case)
    const diffRes = await pool.query(
      `SELECT * FROM kendaraan_differential
       WHERE kendaraan_id = $1
       ORDER BY CASE posisi
         WHEN 'Depan' THEN 1
         WHEN 'Belakang' THEN 2
         WHEN 'Transfer Case' THEN 3
         ELSE 4
       END, id`,
      [req.params.id]
    );

    res.json({ ...rows[0], differentials: diffRes.rows });
  } catch (e) {
    console.error(e);
    res.status(500).json({ error: e.message });
  }
});

// ─────────────────────────────────────────────────────────────────────────────
// GET /api/export/csv — export hasil filter ke CSV
// ─────────────────────────────────────────────────────────────────────────────
app.get('/api/export/csv', async (req, res) => {
  try {
    const { where, values } = buildFilter(req.query);
    const { rows } = await pool.query(
      `SELECT * FROM kendaraan ${where} ORDER BY merek, model`,
      values
    );

    const header = [
      'Merek','Model','Tahun','Kategori','Bahan Bakar','Kode Mesin',
      'Kapasitas CC','Tipe Transmisi','Detail Transmisi','Viskositas Oli',
      'Standar Oli','Kapasitas Oli','Oli Transmisi','Tipe Power Steering',
      'Fluida Power Steering','Tipe Sistem Rem','Minyak Rem',
      'Ukuran Ban','Merek Ban OEM','Tekanan Ban',
      'Tipe Aki','Merek Aki OEM','Rekomendasi Aftermarket'
    ].join(',');

    const csvRows = rows.map(r => [
      r.merek, r.model, r.tahun, r.kategori, r.bahan_bakar, r.kode_mesin,
      r.kapasitas_cc, r.tipe_transmisi, r.detail_transmisi, r.viskositas_oli,
      r.standar_oli, r.kapasitas_oli, r.oli_transmisi, r.tipe_power_steering,
      r.fluida_power_steering, r.tipe_sistem_rem, r.minyak_rem,
      r.ukuran_ban, r.merek_ban_oem, r.tekanan_ban,
      r.tipe_aki, r.merek_aki_oem, r.rekomendasi_aftermarket
    ].map(v => `"${String(v || '').replace(/"/g, '""')}"`).join(','));

    const csv = [header, ...csvRows].join('\r\n');
    const bom = '\uFEFF'; // UTF-8 BOM agar Excel tidak salah baca

    res.setHeader('Content-Type', 'text/csv; charset=utf-8');
    res.setHeader('Content-Disposition', 'attachment; filename="spesifikasi-kendaraan.csv"');
    res.send(bom + csv);
  } catch (e) {
    console.error(e);
    res.status(500).json({ error: e.message });
  }
});

// ─────────────────────────────────────────────────────────────────────────────
// POST /api/kendaraan — tambah data (admin)
// ─────────────────────────────────────────────────────────────────────────────
app.post('/api/kendaraan', requireAdmin, async (req, res) => {
  const {
    merek, model, tahun, kategori, bahan_bakar, kode_mesin,
    kapasitas_cc, tipe_transmisi, detail_transmisi, viskositas_oli,
    standar_oli, kapasitas_oli, oli_transmisi,
    tipe_power_steering, fluida_power_steering,
    tipe_sistem_rem, minyak_rem,
    ukuran_ban, merek_ban_oem, tekanan_ban,
    tipe_aki, merek_aki_oem, rekomendasi_aftermarket
  } = req.body;

  if (!merek || !model) {
    return res.status(400).json({ error: 'Field merek dan model wajib diisi.' });
  }

  try {
    const { rows } = await pool.query(
      `INSERT INTO kendaraan
         (merek, model, tahun, kategori, bahan_bakar, kode_mesin,
          kapasitas_cc, tipe_transmisi, detail_transmisi, viskositas_oli,
          standar_oli, kapasitas_oli, oli_transmisi,
          tipe_power_steering, fluida_power_steering,
          tipe_sistem_rem, minyak_rem, ukuran_ban, merek_ban_oem, tekanan_ban,
          tipe_aki, merek_aki_oem, rekomendasi_aftermarket)
       VALUES ($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14,$15,$16,$17,$18,$19,$20,$21,$22,$23)
       RETURNING *`,
      [merek, model, tahun, kategori, bahan_bakar, kode_mesin,
       kapasitas_cc, tipe_transmisi, detail_transmisi, viskositas_oli,
       standar_oli, kapasitas_oli, oli_transmisi,
       tipe_power_steering, fluida_power_steering,
       tipe_sistem_rem, minyak_rem, ukuran_ban, merek_ban_oem, tekanan_ban,
       tipe_aki, merek_aki_oem, rekomendasi_aftermarket]
    );
    res.status(201).json(rows[0]);
  } catch (e) {
    console.error(e);
    res.status(500).json({ error: e.message });
  }
});

// ─────────────────────────────────────────────────────────────────────────────
// PUT /api/kendaraan/:id — edit data (admin)
// ─────────────────────────────────────────────────────────────────────────────
app.put('/api/kendaraan/:id', requireAdmin, async (req, res) => {
  const {
    merek, model, tahun, kategori, bahan_bakar, kode_mesin,
    kapasitas_cc, tipe_transmisi, detail_transmisi, viskositas_oli,
    standar_oli, kapasitas_oli, oli_transmisi,
    tipe_power_steering, fluida_power_steering,
    tipe_sistem_rem, minyak_rem,
    ukuran_ban, merek_ban_oem, tekanan_ban,
    tipe_aki, merek_aki_oem, rekomendasi_aftermarket
  } = req.body;

  try {
    const { rows } = await pool.query(
      `UPDATE kendaraan SET
         merek=$1, model=$2, tahun=$3, kategori=$4, bahan_bakar=$5,
         kode_mesin=$6, kapasitas_cc=$7, tipe_transmisi=$8,
         detail_transmisi=$9, viskositas_oli=$10, standar_oli=$11,
         kapasitas_oli=$12, oli_transmisi=$13,
         tipe_power_steering=$14, fluida_power_steering=$15,
         tipe_sistem_rem=$16, minyak_rem=$17,
         ukuran_ban=$18, merek_ban_oem=$19, tekanan_ban=$20,
         tipe_aki=$21, merek_aki_oem=$22, rekomendasi_aftermarket=$23,
         updated_at=NOW()
       WHERE id=$24
       RETURNING *`,
      [merek, model, tahun, kategori, bahan_bakar, kode_mesin,
       kapasitas_cc, tipe_transmisi, detail_transmisi, viskositas_oli,
       standar_oli, kapasitas_oli, oli_transmisi,
       tipe_power_steering, fluida_power_steering,
       tipe_sistem_rem, minyak_rem,
       ukuran_ban, merek_ban_oem, tekanan_ban,
       tipe_aki, merek_aki_oem, rekomendasi_aftermarket,
       req.params.id]
    );
    if (!rows.length) return res.status(404).json({ error: 'Data tidak ditemukan.' });
    res.json(rows[0]);
  } catch (e) {
    console.error(e);
    res.status(500).json({ error: e.message });
  }
});

// ─────────────────────────────────────────────────────────────────────────────
// DELETE /api/kendaraan/:id — hapus data (admin)
// ─────────────────────────────────────────────────────────────────────────────
app.delete('/api/kendaraan/:id', requireAdmin, async (req, res) => {
  try {
    const { rowCount } = await pool.query(
      `DELETE FROM kendaraan WHERE id = $1`,
      [req.params.id]
    );
    if (!rowCount) return res.status(404).json({ error: 'Data tidak ditemukan.' });
    res.json({ message: 'Data berhasil dihapus.' });
  } catch (e) {
    console.error(e);
    res.status(500).json({ error: e.message });
  }
});

// ─────────────────────────────────────────────────────────────────────────────
// GET /api/kendaraan/:id/differential — daftar gardan satu kendaraan
// ─────────────────────────────────────────────────────────────────────────────
app.get('/api/kendaraan/:id/differential', async (req, res) => {
  try {
    const { rows } = await pool.query(
      `SELECT * FROM kendaraan_differential
       WHERE kendaraan_id = $1
       ORDER BY CASE posisi
         WHEN 'Depan' THEN 1 WHEN 'Belakang' THEN 2 WHEN 'Transfer Case' THEN 3 ELSE 4
       END, id`,
      [req.params.id]
    );
    res.json(rows);
  } catch (e) {
    console.error(e);
    res.status(500).json({ error: e.message });
  }
});

// ─────────────────────────────────────────────────────────────────────────────
// POST /api/differential — tambah entry gardan (admin)
// ─────────────────────────────────────────────────────────────────────────────
app.post('/api/differential', requireAdmin, async (req, res) => {
  const { kendaraan_id, posisi, jenis, spesifikasi_oli, kapasitas_oli, catatan } = req.body;
  if (!kendaraan_id || !posisi) {
    return res.status(400).json({ error: 'kendaraan_id dan posisi wajib diisi.' });
  }
  try {
    const { rows } = await pool.query(
      `INSERT INTO kendaraan_differential
         (kendaraan_id, posisi, jenis, spesifikasi_oli, kapasitas_oli, catatan)
       VALUES ($1,$2,$3,$4,$5,$6) RETURNING *`,
      [kendaraan_id, posisi, jenis, spesifikasi_oli, kapasitas_oli, catatan]
    );
    res.status(201).json(rows[0]);
  } catch (e) {
    console.error(e);
    res.status(500).json({ error: e.message });
  }
});

// ─────────────────────────────────────────────────────────────────────────────
// PUT /api/differential/:id — edit entry gardan (admin)
// ─────────────────────────────────────────────────────────────────────────────
app.put('/api/differential/:id', requireAdmin, async (req, res) => {
  const { posisi, jenis, spesifikasi_oli, kapasitas_oli, catatan } = req.body;
  try {
    const { rows } = await pool.query(
      `UPDATE kendaraan_differential
       SET posisi=$1, jenis=$2, spesifikasi_oli=$3, kapasitas_oli=$4, catatan=$5, updated_at=NOW()
       WHERE id=$6 RETURNING *`,
      [posisi, jenis, spesifikasi_oli, kapasitas_oli, catatan, req.params.id]
    );
    if (!rows.length) return res.status(404).json({ error: 'Data tidak ditemukan.' });
    res.json(rows[0]);
  } catch (e) {
    console.error(e);
    res.status(500).json({ error: e.message });
  }
});

// ─────────────────────────────────────────────────────────────────────────────
// DELETE /api/differential/:id — hapus entry gardan (admin)
// ─────────────────────────────────────────────────────────────────────────────
app.delete('/api/differential/:id', requireAdmin, async (req, res) => {
  try {
    const { rowCount } = await pool.query(
      `DELETE FROM kendaraan_differential WHERE id = $1`,
      [req.params.id]
    );
    if (!rowCount) return res.status(404).json({ error: 'Data tidak ditemukan.' });
    res.json({ message: 'Data gardan berhasil dihapus.' });
  } catch (e) {
    console.error(e);
    res.status(500).json({ error: e.message });
  }
});

// ── SPA fallback ──────────────────────────────────────────────────────────────
app.get('*', (_req, res) => {
  res.sendFile(path.join(__dirname, 'public', 'index.html'));
});

// ── Start server ──────────────────────────────────────────────────────────────
app.listen(PORT, () => {
  console.log(`✅ Server berjalan di http://localhost:${PORT}`);
  console.log(`📦 Database: ${process.env.DB_HOST}:${process.env.DB_PORT}/${process.env.DB_NAME}`);
});
