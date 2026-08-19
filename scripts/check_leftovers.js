'use strict';
require('dotenv').config();
const pool = require('./db');

(async () => {
  try {
    console.log('\n=== SISA detail_transmisi KOSONG ===');
    const { rows: dt } = await pool.query(
      `SELECT id, merek, model, tahun, tipe_transmisi, oli_transmisi FROM kendaraan
       WHERE detail_transmisi IS NULL OR TRIM(detail_transmisi) = '' OR detail_transmisi = '-'
       ORDER BY merek, model`
    );
    dt.forEach(r => console.log(`  [${r.id}] ${r.merek} ${r.model} (${r.tahun}) | Trans: ${r.tipe_transmisi} | oli_trans: ${(r.oli_transmisi || '').substring(0,50)}`));

    console.log('\n=== SISA ukuran_ban KOSONG ===');
    const { rows: ub } = await pool.query(
      `SELECT id, merek, model, tahun, kategori FROM kendaraan
       WHERE ukuran_ban IS NULL OR TRIM(ukuran_ban) = '' OR ukuran_ban = '-'
       ORDER BY merek, model`
    );
    ub.forEach(r => console.log(`  [${r.id}] ${r.merek} ${r.model} (${r.tahun}) | Kat: ${r.kategori}`));

    console.log('\n=== SISA kapasitas_oli KOSONG ===');
    const { rows: ko } = await pool.query(
      `SELECT id, merek, model, tahun, kode_mesin, viskositas_oli FROM kendaraan
       WHERE kapasitas_oli IS NULL OR TRIM(kapasitas_oli) = '' OR kapasitas_oli = '-'`
    );
    ko.forEach(r => console.log(`  [${r.id}] ${r.merek} ${r.model} (${r.tahun}) | mesin: ${r.kode_mesin} | viskositas: ${r.viskositas_oli}`));

    console.log('\n✅ Total sisa:', dt.length + ub.length + ko.length, 'record');
  } catch (e) { console.error(e.message); } finally { await pool.end(); }
})();
