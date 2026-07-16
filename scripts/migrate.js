'use strict';
// Script untuk menjalankan migrasi SQL ke PostgreSQL Sumopod
// Jalankan: node scripts/migrate.js

require('dotenv').config();
const fs   = require('fs');
const path = require('path');
const pool = require('../db');

async function migrate() {
  const files = [
    '001_create_table.sql', 
    '002_seed_data.sql', 
    '003_create_differential_table.sql', 
    '004_seed_differential_data.sql',
    '005_add_brake_columns.sql',
    '007_fix_power_steering.sql',
    '006_add_aftermarket_recommendations.sql',
    '008_add_more_toyota_models.sql'
  ];

  for (const file of files) {
    const filePath = path.join(__dirname, '..', 'sql', file);
    const sql      = fs.readFileSync(filePath, 'utf8');

    console.log(`\n▶ Menjalankan: ${file}`);
    try {
      const result = await pool.query(sql);
      // Jika ada SELECT di akhir (verifikasi)
      if (Array.isArray(result)) {
        const last = result[result.length - 1];
        if (last && last.rows && last.rows[0]) {
          console.log(`  ✅ Selesai — ${JSON.stringify(last.rows[0])}`);
        } else {
          console.log(`  ✅ Selesai`);
        }
      } else {
        console.log(`  ✅ Selesai`);
      }
    } catch (err) {
      console.error(`  ❌ Error pada ${file}:`, err.message);
      process.exit(1);
    }
  }

  console.log('\n✅ Migrasi selesai!\n');
  await pool.end();
}

migrate();
