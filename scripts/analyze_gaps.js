'use strict';
require('dotenv').config();
const pool = require('./db');

(async () => {
  try {
    const totalQ = await pool.query('SELECT COUNT(*) AS total FROM kendaraan');
    const TOTAL = totalQ.rows[0].total;
    console.log(`\n=== ANALISIS KELENGKAPAN DATA (Total: ${TOTAL} kendaraan) ===\n`);

    const fields = [
      'tahun', 'kategori', 'bahan_bakar', 'kode_mesin', 'kapasitas_cc',
      'tipe_transmisi', 'detail_transmisi', 'viskositas_oli', 'standar_oli',
      'kapasitas_oli', 'oli_transmisi', 'tipe_power_steering',
      'fluida_power_steering', 'tipe_sistem_rem', 'minyak_rem',
      'ukuran_ban', 'merek_ban_oem', 'tekanan_ban', 'tipe_aki',
      'merek_aki_oem', 'rekomendasi_aftermarket'
    ];

    for (const f of fields) {
      const { rows } = await pool.query(
        `SELECT COUNT(*) AS cnt FROM kendaraan WHERE ${f} IS NULL OR TRIM(${f}::text) = '' OR ${f} = '-'`
      );
      const cnt = parseInt(rows[0].cnt);
      const pct = ((cnt / TOTAL) * 100).toFixed(1);
      const bar = '█'.repeat(Math.round((1 - cnt/TOTAL) * 20)) + '░'.repeat(Math.round(cnt/TOTAL * 20));
      console.log(`  ${f.padEnd(28)} ${bar} ${(TOTAL-cnt).toString().padStart(4)}/${TOTAL}  (${pct}% kosong)`);
    }

    console.log('\n=== KENDARAAN DENGAN DATA PALING KOSONG (Top 20) ===');
    const missingSql = fields.map(f => 
      `CASE WHEN ${f} IS NULL OR TRIM(${f}::text) = '' OR ${f} = '-' THEN 1 ELSE 0 END`
    ).join(' + ');
    const { rows: emptiest } = await pool.query(
      `SELECT id, merek, model, tahun, (${missingSql}) AS missing_count
       FROM kendaraan
       ORDER BY missing_count DESC
       LIMIT 20`
    );
    emptiest.forEach((r, i) => {
      console.log(`  ${(i+1).toString().padStart(2)}. [${r.missing_count} kosong] ${r.merek} ${r.model} (${r.tahun}) — id:${r.id}`);
    });

    console.log('\n=== MERK DENGAN FIELD RATA-RATA KOSONG TERBANYAK ===');
    const { rows: brandEmpty } = await pool.query(
      `SELECT merek, COUNT(*) AS total,
              AVG(${missingSql}) AS avg_missing
       FROM kendaraan
       GROUP BY merek
       HAVING COUNT(*) >= 3
       ORDER BY avg_missing DESC
       LIMIT 10`
    );
    brandEmpty.forEach((r, i) => {
      console.log(`  ${(i+1).toString().padStart(2)}. ${r.merek.padEnd(15)} ${r.total} data, avg ${(r.avg_missing).toFixed(2)} field kosong`);
    });

    const { rows: capEmpty } = await pool.query(
      `SELECT id, merek, model, tahun, kode_mesin FROM kendaraan 
       WHERE kapasitas_cc IS NULL OR TRIM(kapasitas_cc) = ''
       ORDER BY merek, model
       LIMIT 30`
    );
    console.log(`\n=== KENDARAAN TANPA KAPASITAS CC (${capEmpty.length} sample) ===`);
    capEmpty.forEach(r => console.log(`  - ${r.merek} ${r.model} (${r.tahun}) | mesin: ${r.kode_mesin} | id:${r.id}`));

    const { rows: psEmpty } = await pool.query(
      `SELECT id, merek, model, tahun FROM kendaraan 
       WHERE tipe_power_steering IS NULL OR TRIM(tipe_power_steering) = ''
       ORDER BY merek, model
       LIMIT 20`
    );
    console.log(`\n=== KENDARAAN TANPA POWER STEERING (${psEmpty.length} sample) ===`);
    psEmpty.forEach(r => console.log(`  - ${r.merek} ${r.model} (${r.tahun}) | id:${r.id}`));

    const { rows: tireEmpty } = await pool.query(
      `SELECT id, merek, model, tahun FROM kendaraan 
       WHERE ukuran_ban IS NULL OR TRIM(ukuran_ban) = '' OR ukuran_ban = '-'
       ORDER BY merek, model
       LIMIT 20`
    );
    console.log(`\n=== KENDARAAN TANPA UKURAN BAN (${tireEmpty.length} sample) ===`);
    tireEmpty.forEach(r => console.log(`  - ${r.merek} ${r.model} (${r.tahun}) | id:${r.id}`));

  } catch (e) {
    console.error('Error:', e.message);
  } finally {
    await pool.end();
  }
})();
