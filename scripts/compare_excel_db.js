'use strict';
require('dotenv').config();
const XLSX = require('xlsx');
const path = require('path');
const pool = require('../db');

const excelPath = path.join('C:', 'Users', 'snwd', 'Documents', '2026', 'KERJAAN PSD', 'DATA KENDARAAN LENGKAP 2026.xlsx');

// Cleaners
const norm = s => String(s || '').trim().replace(/\s+/g, ' ');
const isHeaderRow = r => {
  const vals = Object.values(r).map(v => norm(v).toLowerCase());
  return vals.includes('no') && vals.some(v => v.includes('model'));
};
const isCategoryOrEmpty = (no, model) => {
  const m = norm(model);
  if (!m) return true;
  const n = norm(no);
  // no = judul kategori, kosong, atau nomor tidak wajar (judul LINI)
  if (!/^\d+$/.test(n) && n !== '') return true;
  if (m.match(/^\d+\./) && m.length < 60) return false; // model legit
  if (m.length < 2) return true;
  // judul kategori biasanya mengandung LINI
  if (/^(\d+\.\s*)?LINI /i.test(m)) return true;
  return false;
};

(async () => {
  try {
    // 1) Baca DB dulu: semua merek + model (normalize untuk perbandingan)
    const dbQ = await pool.query(
      `SELECT id, merek, model, tahun FROM kendaraan`
    );
    const dbKey = new Set();
    const byBrand = {};
    for (const r of dbQ.rows) {
      const k = `${norm(r.merek).toLowerCase()}|${norm(r.model).toLowerCase()}`;
      dbKey.add(k);
      byBrand[r.merek] = byBrand[r.merek] || { count: 0, sample: null };
      byBrand[r.merek].count++;
      if (!byBrand[r.merek].sample) byBrand[r.merek].sample = r;
    }
    console.log(`DB saat ini: ${dbQ.rows.length} kendaraan, ${Object.keys(byBrand).length} merek`);
    console.log('Merek di DB:', Object.keys(byBrand).sort().join(', '));

    // 2) Parse Excel
    const wb = XLSX.readFile(excelPath);
    const allEntries = [];

    for (const merekRaw of wb.SheetNames) {
      const ws = wb.Sheets[merekRaw];
      const rows = XLSX.utils.sheet_to_json(ws, { defval: '', raw: false });
      if (rows.length < 2) continue;

      const merek = /^lepas$/i.test(merekRaw) ? 'Lepas' : merekRaw.trim();

      let headerPassed = false;
      for (const row of rows) {
        // Ambil kolom: dapat dari urutan
        const vals = Object.values(row).map(v => norm(v));
        // Cari baris header
        if (!headerPassed) {
          if (isHeaderRow(row)) headerPassed = true;
          continue;
        }

        const [no, model, segmen, cat1, cat2, cat3] = vals;
        if (isCategoryOrEmpty(no, model)) continue;

        const modelName = model.trim();
        if (!modelName) continue;
        const catatan = [segmen, cat1, cat2, cat3].filter(Boolean).join(' — ').trim();

        allEntries.push({
          merek,
          model: modelName,
          segmen: segmen.trim(),
          catatan
        });
      }
    }

    console.log(`\n✅ Total entry dari Excel: ${allEntries.length}`);

    // 3) Bandingkan: cari yang BARU (tidak ada di DB)
    const newOnes = [];
    const existingSkips = [];
    for (const e of allEntries) {
      const key = `${e.merek.toLowerCase()}|${e.model.toLowerCase()}`;
      if (dbKey.has(key)) existingSkips.push(e);
      else newOnes.push(e);
    }
    console.log(`\n⏭️  Sudah ada di DB (skip): ${existingSkips.length}`);
    console.log(`✨ MODEL BARU (akan diinsert): ${newOnes.length}`);

    if (newOnes.length === 0) {
      console.log('\nTidak ada data baru. Selesai.');
      return;
    }

    // 4) Tampilkan per merek berapa baru:
    const brandNewCount = {};
    for (const e of newOnes) {
      brandNewCount[e.merek] = (brandNewCount[e.merek] || 0) + 1;
    }
    console.log('\nPer-merek penambahan baru:');
    Object.entries(brandNewCount).sort().forEach(([m, n]) => {
      console.log(`  ${m.padEnd(15)} +${n} model`);
    });

    // 5) Simpan ke JSON untuk step insert (atau langsung insert?)
    const fs = require('fs');
    fs.writeFileSync(
      path.join(__dirname, 'new_vehicles_from_excel.json'),
      JSON.stringify(newOnes, null, 2),
      'utf8'
    );
    console.log('\n📄 Daftar baru disimpan di: scripts/new_vehicles_from_excel.json');
    console.log('Sample 5 baru:');
    newOnes.slice(0, 5).forEach((e, i) => {
      console.log(`  ${i+1}. ${e.merek} ${e.model} | Segmen: ${e.segmen || '-'} | ${e.catatan.substring(0,70)}`);
    });

  } catch (e) {
    console.error('❌ Error:', e.message);
    console.error(e.stack);
    process.exit(1);
  } finally {
    await pool.end();
  }
})();
