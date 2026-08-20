'use strict';
require('dotenv').config();
const pool = require('../db');

const MAIN = async () => {
  const res = await pool.query(
    `SELECT id, merek, model, kategori FROM kendaraan
     WHERE ukuran_ban IS NULL OR length(trim(ukuran_ban))=0
     OR merek_ban_oem IS NULL OR length(trim(merek_ban_oem))=0
     OR tekanan_ban IS NULL OR length(trim(tekanan_ban))=0`
  );
  console.log(`🔍 Gap ada ${res.rows.length} record:`);
  console.log(res.rows.map(r => `[${r.id}] ${r.merek} — ${r.model} | ${r.kategori}`).join('\n'));
  await pool.end();
};
MAIN().catch(e => { console.error(e.message); process.exit(1); });
