'use strict';
require('dotenv').config();
const fs   = require('fs');
const path = require('path');
const pool = require('../db');

const CSV_PATH = 'C:\\Users\\snwd\\Downloads\\buku_pintar_export_2026-08-19.csv';

function parseCSVLine(line) {
  const result = [];
  let current = '';
  let inQuotes = false;
  for (let i = 0; i < line.length; i++) {
    const ch = line[i];
    if (inQuotes) {
      if (ch === '"' && line[i + 1] === '"') {
        current += '"';
        i++;
      } else if (ch === '"') {
        inQuotes = false;
      } else {
        current += ch;
      }
    } else {
      if (ch === '"') {
        inQuotes = true;
      } else if (ch === ',') {
        result.push(current.trim());
        current = '';
      } else {
        current += ch;
      }
    }
  }
  result.push(current.trim());
  return result;
}

function readCSV(filePath) {
  const raw = fs.readFileSync(filePath, 'utf8');
  const lines = raw.split(/\r?\n/).filter(l => l.trim().length > 0);
  const headers = parseCSVLine(lines[0]);
  const rows = [];
  for (let i = 1; i < lines.length; i++) {
    const cells = parseCSVLine(lines[i]);
    if (cells.length < 5) continue;
    const obj = {};
    headers.forEach((h, idx) => {
      obj[h] = (cells[idx] || '').trim();
    });
    rows.push(obj);
  }
  return rows;
}

function formatTahun(mulai, selesai) {
  const m = (mulai || '').trim();
  const s = (selesai || '').trim();
  if (!m && !s) return '';
  if (m === s) return m;
  if (s === 'Sekarang' || s === 'Sekarang' || s.toLowerCase() === 'sekarang') {
    return `${m} - Sekarang`;
  }
  if (m && s) return `${m} - ${s}`;
  return m || s;
}

function mapTransmisi(t) {
  const x = (t || '').trim();
  if (x === 'Automatic') return 'AT';
  if (x === 'Manual') return 'Manual';
  if (x === 'CVT') return 'CVT';
  if (x === 'AMT') return 'AMT';
  return x || 'Manual';
}

function combineRem(depan, belakang) {
  const d = (depan || '').trim();
  const b = (belakang || '').trim();
  if (!d && !b) return '';
  if (d && b) return `Depan: ${d}, Belakang: ${b}`;
  return d || b;
}

function combineAki(tipe, model, ampere, voltage) {
  const parts = [];
  if (tipe && tipe !== '-') parts.push(tipe);
  if (model && model !== '-') parts.push(model);
  if (ampere && ampere !== '-') parts.push(`${ampere}Ah`);
  if (voltage && voltage !== '-') parts.push(`${voltage}V`);
  return parts.length ? parts.join(' / ') : '';
}

function combineOliTransmisi(tipe, kapasitas) {
  const t = (tipe || '').trim();
  const k = (kapasitas || '').trim();
  if (!t || t === '-') return '';
  if (k && k !== '-') return `${t} (${k} L)`;
  return t;
}

function combineKapasitasOli(kap, filterKap) {
  const k = (kap || '').trim();
  const f = (filterKap || '').trim();
  if (!k || k === '-') return '';
  if (f && f !== '-' && k !== f) return `${k} L (Tanpa filter: ${f} L)`;
  return `${k} L`;
}

function buildPartsRekomendasi(row) {
  const items = [];
  const oli = row['Part - Filter Oli'];
  const udara = row['Part - Filter Udara'];
  const kabin = row['Part - Filter Kabin'];
  const busi = row['Part - Busi'];
  if (oli && oli !== '-') items.push(`<div class="rek-item"><strong>Filter Oli:</strong> ${oli}</div>`);
  if (udara && udara !== '-') items.push(`<div class="rek-item"><strong>Filter Udara:</strong> ${udara}</div>`);
  if (kabin && kabin !== '-') items.push(`<div class="rek-item"><strong>Filter Kabin:</strong> ${kabin}</div>`);
  if (busi && busi !== '-') items.push(`<div class="rek-item"><strong>Busi:</strong> ${busi}</div>`);
  return items.join('');
}

function buildBaseRekomendasi(row) {
  const viskositas = row['Oli Mesin - Viskositas'] || '';
  const transmisi = row['Transmisi'] || '';
  const minyakRem = row['Minyak Rem'] || '';
  const items = [];

  let oliMesin = 'Sesuaikan viskositas (Motul, Shell, Castrol, Mobil 1)';
  if (viskositas.includes('0W-20') || viskositas.includes('0W-16')) oliMesin = 'Motul H-Tech 100 Plus, Mobil 1, Shell Helix Eco';
  else if (viskositas.includes('5W-30') || viskositas.includes('5W-40')) oliMesin = 'Amsoil Signature, Motul 8100 X-Cess, Shell Helix Ultra';
  else if (viskositas.includes('10W-40') || viskositas.includes('10w-40') || viskositas.includes('10W40')) oliMesin = 'Shell Helix HX7, Fastron Techno, Motul Multipower';
  else if (viskositas.includes('15W-40')) oliMesin = 'Mobil Delvac 1, Shell Rimula R4 X';
  items.push(`<div class="rek-item"><strong>Mesin:</strong> ${oliMesin}</div>`);

  const t = mapTransmisi(transmisi);
  const oliT = row['Oli Transmisi - Tipe'] || '';
  let transmisiRek = 'Cek buku manual';
  if (t === 'CVT') transmisiRek = 'Aisin CFEx, Motul CVTF, Eneos CVTF';
  else if (t === 'Manual') transmisiRek = 'Motul Motylgear 75W-90, Shell Spirax S4, Red Line MT-90';
  else if (t === 'AT' && (oliT.includes('WS') || oliT.includes('Dexron VI'))) transmisiRek = 'Aisin AFW-VI, Motul ATF VI, Idemitsu ATF';
  else if (t === 'AT') transmisiRek = 'Aisin AFW+, Motul ATF 1A, Shell Spirax S3';
  items.push(`<div class="rek-item"><strong>Transmisi:</strong> ${transmisiRek}</div>`);

  let remRek = 'Prestone DOT 4 (Aman substitusi DOT 3), STP Brake Fluid';
  if (minyakRem.includes('DOT 4') || minyakRem.includes('DOT4')) remRek = 'Prestone DOT 4, STP Brake Fluid DOT 4, Motul DOT 4';
  items.push(`<div class="rek-item"><strong>Rem:</strong> ${remRek}</div>`);

  const akiTipe = row['Aki - Tipe'] || '';
  const akiModel = row['Aki - Model'] || '';
  if (akiTipe !== '-' && akiModel !== '-' && (akiTipe || akiModel)) {
    items.push(`<div class="rek-item"><strong>Aki (Battery):</strong> GS Astra Maintenance Free, Amaron Hi-Life, Bosch, Yuasa</div>`);
  }

  return items.join('');
}

async function importCSV() {
  console.log('📖 Membaca file CSV...');
  const rows = readCSV(CSV_PATH);
  console.log(`✅ Total ${rows.length} baris data ditemukan`);

  let inserted = 0;
  let updated = 0;
  let skipped = 0;
  const errors = [];

  for (let i = 0; i < rows.length; i++) {
    const row = rows[i];
    try {
      const merek       = row['Merek'] || '';
      const model       = row['Model'] || '';
      const varian      = row['Varian'] || '';
      const tahun       = formatTahun(row['Tahun Mulai'], row['Tahun Selesai']);
      const kode_mesin  = row['Kode Mesin'] !== '-' ? row['Kode Mesin'] : '';
      const tipe_transmisi = mapTransmisi(row['Transmisi']);
      const detail_transmisi = combineOliTransmisi(row['Oli Transmisi - Tipe'], row['Oli Transmisi - Kapasitas (L)']);
      const viskositas_oli = row['Oli Mesin - Viskositas'] !== '-' ? row['Oli Mesin - Viskositas'] : '';
      const standar_oli = row['Oli Mesin - Standar'] !== '-' ? row['Oli Mesin - Standar'] : '';
      const kapasitas_oli = combineKapasitasOli(row['Oli Mesin - Kapasitas (L)'], row['Oli Mesin - Kapasitas Filter (L)']);
      const oli_transmisi = detail_transmisi;
      const tipe_sistem_rem = combineRem(row['Rem - Depan'], row['Rem - Belakang']);
      const minyak_rem = row['Minyak Rem'] !== '-' ? row['Minyak Rem'] : '';
      const ukuran_ban = row['Ban - Ukuran'] !== '-' ? row['Ban - Ukuran'] : '';
      const tipe_aki = combineAki(row['Aki - Tipe'], row['Aki - Model'], row['Aki - Ampere'], row['Aki - Voltage']);
      const merek_aki_oem = row['Aki - Tipe'] && row['Aki - Tipe'] !== '-' ? 'OEM Bawaan' : '';

      const baseRek = buildBaseRekomendasi(row);
      const partsRek = buildPartsRekomendasi(row);
      const rekomendasi_aftermarket = baseRek + partsRek;

      if (!merek || !model) {
        skipped++;
        continue;
      }

      const searchModel = varian ? `${model} ${varian}`.trim() : model;

      const { rows: existing } = await pool.query(
        `SELECT id FROM kendaraan 
         WHERE merek ILIKE $1 
           AND (model ILIKE $2 OR model ILIKE $3)
           AND kode_mesin ILIKE $4
         LIMIT 1`,
        [merek, searchModel, model, kode_mesin || '%']
      );

      if (existing.length > 0) {
        await pool.query(
          `UPDATE kendaraan SET
             tahun = COALESCE(NULLIF($1,''), tahun),
             kode_mesin = COALESCE(NULLIF($2,''), kode_mesin),
             tipe_transmisi = COALESCE(NULLIF($3,''), tipe_transmisi),
             detail_transmisi = COALESCE(NULLIF($4,''), detail_transmisi),
             viskositas_oli = COALESCE(NULLIF($5,''), viskositas_oli),
             standar_oli = COALESCE(NULLIF($6,''), standar_oli),
             kapasitas_oli = COALESCE(NULLIF($7,''), kapasitas_oli),
             oli_transmisi = COALESCE(NULLIF($8,''), oli_transmisi),
             tipe_sistem_rem = COALESCE(NULLIF($9,''), tipe_sistem_rem),
             minyak_rem = COALESCE(NULLIF($10,''), minyak_rem),
             ukuran_ban = COALESCE(NULLIF($11,''), ukuran_ban),
             tipe_aki = COALESCE(NULLIF($12,''), tipe_aki),
             merek_aki_oem = COALESCE(NULLIF($13,''), merek_aki_oem),
             rekomendasi_aftermarket = COALESCE(NULLIF($14,''), rekomendasi_aftermarket),
             updated_at = NOW()
           WHERE id = $15`,
          [tahun, kode_mesin, tipe_transmisi, detail_transmisi,
           viskositas_oli, standar_oli, kapasitas_oli, oli_transmisi,
           tipe_sistem_rem, minyak_rem, ukuran_ban, tipe_aki, merek_aki_oem,
           rekomendasi_aftermarket, existing[0].id]
        );
        updated++;
      } else {
        let bahan_bakar = 'bensin';
        if (kode_mesin.toLowerCase().includes('d') && 
            (merek.includes('Toyota') || merek.includes('Daihatsu') || 
             merek.includes('Isuzu') || merek.includes('Mitsubishi') ||
             merek.includes('Ford') || merek.includes('Nissan'))) {
          bahan_bakar = 'diesel';
        }
        if (model.toLowerCase().includes('diesel')) bahan_bakar = 'diesel';

        const finalModel = varian ? `${model} ${varian}`.trim() : model;
        let kategori = '';
        const lcModel = finalModel.toLowerCase();
        if (lcModel.includes('pickup') || lcModel.includes('carry') || lcModel.includes('triton') || lcModel.includes('hilux') || lcModel.includes('navara') || lcModel.includes('ranger') || lcModel.includes('colorado') || lcModel.includes('l300') || lcModel.includes('apv')) kategori = 'Pickup / Utility';
        else if (lcModel.includes('fortuner') || lcModel.includes('pajero') || lcModel.includes('terios') || lcModel.includes('rush') || lcModel.includes('pajero sport')) kategori = 'SUV 7-seat';
        else if (lcModel.includes('cr-v') || lcModel.includes('cx-5') || lcModel.includes('x-trail') || lcModel.includes('hr-v') || lcModel.includes('outlander') || lcModel.includes('almaz') || lcModel.includes('creta') || lcModel.includes('kicks')) kategori = 'SUV';
        else if (lcModel.includes('xenia') || lcModel.includes('avanza') || lcModel.includes('ertiga') || lcModel.includes('xpander') || lcModel.includes('mobilio') || lcModel.includes('br-v') || lcModel.includes('stargazer') || lcModel.includes('xl7') || lcModel.includes('luxio') || lcModel.includes('biante') || lcModel.includes('livina')) kategori = 'Low MPV';
        else if (lcModel.includes('innova') || lcModel.includes('serena') || lcModel.includes('voxy') || lcModel.includes('alphard') || lcModel.includes('staria') || lcModel.includes('carnival')) kategori = 'Medium MPV';
        else if (lcModel.includes('ayla') || lcModel.includes('agya') || lcModel.includes('brio') || lcModel.includes('sigra') || lcModel.includes('calya') || lcModel.includes('santro') || lcModel.includes('ignis')) kategori = 'LCGC Hatchback';
        else if (lcModel.includes('sirion') || lcModel.includes('jazz') || lcModel.includes('yaris') || lcModel.includes('mazda 2') || lcModel.includes('city hatchback') || lcModel.includes('swift') || lcModel.includes('baleno')) kategori = 'Hatchback';
        else if (lcModel.includes('corolla') || lcModel.includes('camry') || lcModel.includes('accord') || lcModel.includes('civic') || lcModel.includes('city') || lcModel.includes('mazda 3') || lcModel.includes('mazda 6') || lcModel.includes('3 series') || lcModel.includes('5 series') || lcModel.includes('c-class') || lcModel.includes('e-class')) kategori = 'Sedan';
        else if (lcModel.includes('crossover') || lcModel.includes('raize') || lcModel.includes('rocky') || lcModel.includes('sienta') || lcModel.includes('wrv') || lcModel.includes('frv') || lcModel.includes('corolla cross') || lcModel.includes('yaris cross') || lcModel.includes('force') || lcModel.includes('xforce')) kategori = 'Crossover';
        else if (lcModel.includes('electric') || lcModel.includes('ev') || lcModel.includes('bingguo') || lcModel.includes('cloud ev') || lcModel.includes('air ev') || lcModel.includes('ioniq') || lcModel.includes('ev6')) kategori = 'EV';
        else if (lcModel.includes('land cruiser') || lcModel.includes('jimny') || lcModel.includes('jeep') || lcModel.includes('mu-x') || lcModel.includes('everest')) kategori = 'SUV Premium';
        else kategori = 'Hatchback / Sedan';

        let kapasitas_cc = '';
        const ccMatch = varian.match(/(\d+\.?\d*)\s*(?:L|CC)?/i) || model.match(/(\d+\.?\d*)\s*(?:L|CC)?/i);
        if (ccMatch) {
          const num = parseFloat(ccMatch[1]);
          if (num < 5) kapasitas_cc = `${Math.round(num * 1000)} cc`;
          else kapasitas_cc = `${Math.round(num)} cc`;
        }

        let tipe_power_steering = 'Elektrik (EPS)';
        const tahunAngka = parseInt(row['Tahun Mulai'] || '0');
        if (tahunAngka > 0 && tahunAngka < 2012) tipe_power_steering = 'Hidrolik';
        if (lcModel.includes('gran max') || lcModel.includes('carry') || lcModel.includes('l300')) tipe_power_steering = 'Hidrolik (Varian atas) / Tanpa PS (Varian bawah)';
        const fluida_power_steering = tipe_power_steering.includes('Hidrolik') ? 'PSF Universal / ATF Dexron III' : '';

        await pool.query(
          `INSERT INTO kendaraan
             (merek, model, tahun, kategori, bahan_bakar, kode_mesin, kapasitas_cc,
              tipe_transmisi, detail_transmisi, viskositas_oli, standar_oli, kapasitas_oli,
              oli_transmisi, tipe_power_steering, fluida_power_steering,
              tipe_sistem_rem, minyak_rem, ukuran_ban, merek_ban_oem, tekanan_ban,
              tipe_aki, merek_aki_oem, rekomendasi_aftermarket)
           VALUES ($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14,$15,$16,$17,$18,$19,$20,$21,$22,$23)`,
          [merek, finalModel, tahun, kategori, bahan_bakar, kode_mesin, kapasitas_cc,
           tipe_transmisi, detail_transmisi, viskositas_oli, standar_oli, kapasitas_oli,
           oli_transmisi, tipe_power_steering, fluida_power_steering,
           tipe_sistem_rem, minyak_rem, ukuran_ban, '-', '-',
           tipe_aki, merek_aki_oem, rekomendasi_aftermarket]
        );
        inserted++;
      }

      if ((i + 1) % 50 === 0) {
        console.log(`  ⏳ Progress: ${i + 1}/${rows.length} (Insert: ${inserted}, Update: ${updated})`);
      }
    } catch (e) {
      console.error(`  ❌ Error baris ${i + 1} (${row['Merek']} ${row['Model']}):`, e.message);
      errors.push({ row: i + 1, merek: row['Merek'], model: row['Model'], error: e.message });
    }
  }

  console.log('\n📊 HASIL IMPORT:');
  console.log(`  ✅ Data di-update : ${updated}`);
  console.log(`  ➕ Data baru      : ${inserted}`);
  console.log(`  ⏭ Dilewati       : ${skipped}`);
  console.log(`  ❌ Error          : ${errors.length}`);
  if (errors.length) {
    console.log('\n  Detail error:');
    errors.slice(0, 10).forEach(e => console.log(`    - Baris ${e.row}: ${e.merek} ${e.model} -> ${e.error}`));
  }

  const { rows: total } = await pool.query('SELECT COUNT(*) AS total FROM kendaraan');
  console.log(`\n📦 Total data di database sekarang: ${total[0].total}`);

  await pool.end();
  console.log('\n✅ Import selesai!');
}

importCSV().catch(err => {
  console.error('FATAL:', err);
  process.exit(1);
});
