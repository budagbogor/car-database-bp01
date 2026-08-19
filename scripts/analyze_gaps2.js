'use strict';
require('dotenv').config();
const pool = require('./db');

(async () => {
  try {
    const qEmptyRem = await pool.query(
      `SELECT merek, kategori, COUNT(*) AS cnt FROM kendaraan
       WHERE tipe_sistem_rem IS NULL OR TRIM(tipe_sistem_rem) = '' OR tipe_sistem_rem = '-'
       GROUP BY merek, kategori ORDER BY cnt DESC`
    );
    console.log('\n=== KOSONG: tipe_sistem_rem + minyak_rem (per merek+kategori) ===');
    qEmptyRem.rows.forEach(r => console.log(`  ${r.merek.padEnd(15)} ${r.kategori.padEnd(18)}: ${r.cnt} unit`));

    const qEmptyTire = await pool.query(
      `SELECT merek, kategori, COUNT(*) AS cnt FROM kendaraan
       WHERE merek_ban_oem IS NULL OR TRIM(merek_ban_oem) = '' OR merek_ban_oem = '-' OR tekanan_ban IS NULL OR TRIM(tekanan_ban) = '' OR tekanan_ban = '-'
       GROUP BY merek, kategori ORDER BY cnt DESC`
    );
    console.log('\n=== KOSONG: merek_ban_oem + tekanan_ban ===');
    qEmptyTire.rows.forEach(r => console.log(`  ${r.merek.padEnd(15)} ${r.kategori.padEnd(18)}: ${r.cnt} unit`));

    const qEmptyAki = await pool.query(
      `SELECT merek, COUNT(*) AS cnt FROM kendaraan
       WHERE tipe_aki IS NULL OR TRIM(tipe_aki) = '' OR tipe_aki = '-'
       GROUP BY merek ORDER BY cnt DESC`
    );
    console.log('\n=== KOSONG: tipe_aki ===');
    qEmptyAki.rows.forEach(r => console.log(`  ${r.merek.padEnd(15)}: ${r.cnt} unit`));

    const qEmptyOliStd = await pool.query(
      `SELECT merek, COUNT(*) AS cnt FROM kendaraan
       WHERE standar_oli IS NULL OR TRIM(standar_oli) = '' OR standar_oli = '-'
       GROUP BY merek ORDER BY cnt DESC`
    );
    console.log('\n=== KOSONG: standar_oli ===');
    qEmptyOliStd.rows.forEach(r => console.log(`  ${r.merek.padEnd(15)}: ${r.cnt} unit`));

    const qEmptyKap = await pool.query(
      `SELECT merek, COUNT(*) AS cnt FROM kendaraan
       WHERE kapasitas_oli IS NULL OR TRIM(kapasitas_oli) = '' OR kapasitas_oli = '-'
       GROUP BY merek ORDER BY cnt DESC`
    );
    console.log('\n=== KOSONG: kapasitas_oli ===');
    qEmptyKap.rows.forEach(r => console.log(`  ${r.merek.padEnd(15)}: ${r.cnt} unit`));

    const qEmptyPS = await pool.query(
      `SELECT merek, tipe_power_steering, COUNT(*) AS cnt FROM kendaraan
       WHERE (fluida_power_steering IS NULL OR TRIM(fluida_power_steering) = '')
         AND tipe_power_steering NOT ILIKE '%Elektrik%' AND tipe_power_steering NOT ILIKE '%EPS%'
       GROUP BY merek, tipe_power_steering ORDER BY cnt DESC`
    );
    console.log('\n=== KOSONG: fluida_power_steering (HIDROLIK SAJA) ===');
    qEmptyPS.rows.forEach(r => console.log(`  ${r.merek.padEnd(15)} [${r.tipe_power_steering.padEnd(25)}]: ${r.cnt} unit`));

    const qEmptyOliTrans = await pool.query(
      `SELECT merek, tipe_transmisi, COUNT(*) AS cnt FROM kendaraan
       WHERE oli_transmisi IS NULL OR TRIM(oli_transmisi) = '' OR oli_transmisi = '-'
       GROUP BY merek, tipe_transmisi ORDER BY cnt DESC`
    );
    console.log('\n=== KOSONG: oli_transmisi ===');
    qEmptyOliTrans.rows.forEach(r => console.log(`  ${r.merek.padEnd(15)} [${r.tipe_transmisi.padEnd(8)}]: ${r.cnt} unit`));

  } catch (e) {
    console.error('Err:', e.message);
  } finally { await pool.end(); }
})();
