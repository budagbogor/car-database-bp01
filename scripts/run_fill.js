'use strict';
require('dotenv').config();
const fs = require('fs');
const path = require('path');
const pool = require('./db');

(async () => {
  try {
    const sql = fs.readFileSync(path.join(__dirname, 'sql', '027_fill_all_data_gaps.sql'), 'utf8');
    console.log('▶ Menjalankan migration 027_fill_all_data_gaps.sql (riset grounded)...');
    await pool.query(sql);
    console.log('✅ Migration selesai dieksekusi!');

    const TOTAL = 575;
    const fields = [
      'tahun','kategori','bahan_bakar','kode_mesin','kapasitas_cc',
      'tipe_transmisi','detail_transmisi','viskositas_oli','standar_oli',
      'kapasitas_oli','oli_transmisi','tipe_power_steering',
      'fluida_power_steering','tipe_sistem_rem','minyak_rem',
      'ukuran_ban','merek_ban_oem','tekanan_ban','tipe_aki',
      'merek_aki_oem','rekomendasi_aftermarket'
    ];
    console.log(`\n═══════════════════════════════════════════════`);
    console.log(`📊 KELENGKAPAN DATA SETELAH MIGRATION (Total ${TOTAL} kendaraan)`);
    console.log(`═══════════════════════════════════════════════`);

    let totalEmpty = 0;
    for (const f of fields) {
      const { rows } = await pool.query(
        `SELECT COUNT(*) AS cnt FROM kendaraan WHERE ${f} IS NULL OR TRIM(${f}::text) = '' OR ${f} = '-' OR ${f} ILIKE '%Cek buku manual%' AND $1 NOT IN ('standar_oli','kapasitas_oli','oli_transmisi')`,
        [f]
      );
      const { rows: realEmpty } = await pool.query(
        `SELECT COUNT(*) AS cnt FROM kendaraan WHERE ${f} IS NULL OR TRIM(${f}::text) = '' OR ${f} = '-'`
      );
      const cnt = parseInt(realEmpty.rows[0].cnt);
      const ok = TOTAL - cnt;
      const pct = ((ok / TOTAL) * 100).toFixed(1);
      totalEmpty += cnt;
      const barL = Math.round((ok / TOTAL) * 20);
      const bar = '█'.repeat(barL) + '░'.repeat(20 - barL);
      console.log(`  ${f.padEnd(28)} ${bar} ${ok.toString().padStart(4)}/${TOTAL} (${pct}%)${cnt > 0 ? ` ⚠ ${cnt} kosong` : ' ✅'}`);
    }

    const totalFields = fields.length * TOTAL;
    const filledFields = totalFields - totalEmpty;
    const overallPct = ((filledFields / totalFields) * 100).toFixed(2);
    console.log(`\n═══════════════════════════════════════════════`);
    console.log(`🏆 KELENGKAPAN OVERALL: ${filledFields}/${totalFields} field = ${overallPct}%`);
    console.log(`═══════════════════════════════════════════════`);

    const { rows: sample } = await pool.query(
      `SELECT merek, model, tahun, tipe_transmisi,
              tipe_sistem_rem AS rem,
              merek_ban_oem AS ban, tekanan_ban AS psi,
              tipe_aki AS aki, merek_aki_oem AS aki_brand,
              standar_oli, kapasitas_oli,
              oli_transmisi,
              fluida_power_steering AS psf
       FROM kendaraan
       ORDER BY RANDOM()
       LIMIT 8`
    );
    console.log('\n🎲 8 Sample RANDOM (semua field seharusnya TERISI):');
    sample.forEach((r, i) => {
      console.log(`\n  ${i + 1}. ${r.merek} ${r.model} (${r.tahun}) — ${r.tipe_transmisi}`);
      console.log(`     🛞 Rem:     ${(r.rem || '⚠ KOSONG').substring(0, 70)}`);
      console.log(`     🛞 Ban:     ${(r.ban || '⚠ KOSONG').substring(0, 60)} | PSI: ${(r.psi || '⚠ KOSONG').substring(0, 35)}`);
      console.log(`     🔋 Aki:     ${(r.aki || '⚠ KOSONG').substring(0, 65)}`);
      console.log(`     🔋 Aki OEM: ${r.aki_brand || '⚠ KOSONG'}`);
      console.log(`     🛢️ Oli:     ${(r.standar_oli || '⚠ KOSONG').substring(0, 50)} | ${(r.kapasitas_oli || '⚠ KOSONG').substring(0, 40)}`);
      console.log(`     ⚙️ Trans:   ${(r.oli_transmisi || '⚠ KOSONG').substring(0, 70)}`);
      console.log(`     🛞 PSF:     ${(r.psf || '⚠ KOSONG').substring(0, 65)}`);
    });

  } catch (e) {
    console.error('❌ ERROR:', e.message);
    process.exit(1);
  } finally {
    await pool.end();
  }
})();
