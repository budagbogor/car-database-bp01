'use strict';
const XLSX = require('xlsx');
const path = require('path');

const excelPath = path.join('C:', 'Users', 'snwd', 'Documents', '2026', 'KERJAAN PSD', 'DATA KENDARAAN LENGKAP 2026.xlsx');

try {
  const wb = XLSX.readFile(excelPath);
  console.log('Sheet(s) tersedia:', wb.SheetNames);

  for (const sheetName of wb.SheetNames) {
    const ws = wb.Sheets[sheetName];
    const rows = XLSX.utils.sheet_to_json(ws, { defval: '' });
    console.log(`\n==== Sheet: ${sheetName} ====`);
    console.log(`Total row data: ${rows.length}`);

    if (rows.length > 0) {
      const headers = Object.keys(rows[0]);
      console.log('Kolom:', headers.map(h => `"${h}"`).join(', '));
      console.log('\nSample 3 baris pertama:');
      rows.slice(0, 3).forEach((r, i) => {
        console.log(`  ${i + 1}.`, JSON.stringify(r, null, 0));
      });
    }
  }
} catch (e) {
  console.error('Error baca Excel:', e.message);
  process.exit(1);
}
