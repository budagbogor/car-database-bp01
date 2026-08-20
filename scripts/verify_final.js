'use strict';
require('dotenv').config();
const pool = require('../db');

(async () => {
  try {
    const tQ = await pool.query('SELECT COUNT(*) AS total FROM kendaraan');
    const TOTAL = parseInt(tQ.rows[0].total);
    console.log(`\n📊 KELENGKAPAN DATA (Total: ${TOTAL} kendaraan)`);
    console.log('═'.repeat(65));

    const fields = [
      'tahun','kategori','bahan_bakar','kode_mesin','kapasitas_cc',
      'tipe_transmisi','detail_transmisi','viskositas_oli','standar_oli',
      'kapasitas_oli','oli_transmisi','tipe_power_steering',
      'fluida_power_steering','tipe_sistem_rem','minyak_rem',
      'ukuran_ban','merek_ban_oem','tekanan_ban','tipe_aki',
      'merek_aki_oem','rekomendasi_aftermarket'
    ];

    let totalFields = 0;
    let totalFilled = 0;
    for (const f of fields) {
      const { rows } = await pool.query(
        `SELECT COUNT(*) AS cnt FROM kendaraan WHERE ${f} IS NULL OR TRIM(${f}::text) = '' OR ${f} = '-'`
      );
      const empty = parseInt(rows[0].cnt);
      const filled = TOTAL - empty;
      const pct = ((filled / TOTAL) * 100).toFixed(1);
      totalFields += TOTAL;
      totalFilled += filled;
      const barL = Math.round((filled / TOTAL) * 18);
      const bar = '█'.repeat(barL) + '░'.repeat(18 - barL);
      const okMark = empty === 0 ? '✅' : `⚠ ${empty}`;
      console.log(` ${bar} ${f.padEnd(28)} ${filled.toString().padStart(4)}/${TOTAL} (${pct}%) ${okMark}`);
    }

    const overallPct = ((totalFilled / totalFields) * 100).toFixed(2);
    console.log('\n' + '═'.repeat(65));
    console.log(`🏆 OVERALL KELENGKAPAN: ${totalFilled}/${totalFields} = ${overallPct}%`);
    console.log('═'.repeat(65));

    console.log('\n🎯 8 Sample Random:');
    const { rows: samples } = await pool.query(
      `SELECT id, merek, model, tahun, tipe_sistem_rem, merek_ban_oem,
              tekanan_ban, tipe_aki, standar_oli, oli_transmisi, fluida_power_steering
       FROM kendaraan ORDER BY RANDOM() LIMIT 8`
    );
    samples.forEach((r,i) => {
      const empties = [];
      if (!r.tipe_sistem_rem || r.tipe_sistem_rem === '-') empties.push('rem');
      if (!r.merek_ban_oem || r.merek_ban_oem === '-') empties.push('ban_oem');
      if (!r.tekanan_ban || r.tekanan_ban === '-') empties.push('psi');
      if (!r.tipe_aki || r.tipe_aki === '-') empties.push('aki');
      if (!r.standar_oli || r.standar_oli === '-') empties.push('std_oli');
      if (!r.oli_transmisi || r.oli_transmisi === '-') empties.push('oli_trans');
      if (!r.fluida_power_steering || r.fluida_power_steering === '') empties.push('psf');
      console.log(`  ${i+1}. ${r.merek} ${r.model} (${r.tahun}) ${empties.length ? '⚠ KOSONG: ' + empties.join(',') : '✅'}`);
    });

  } catch (e) {
    console.error('Error:', e.message);
  } finally { await pool.end(); }
})();
