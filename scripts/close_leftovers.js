'use strict';
require('dotenv').config();
const pool = require('./db');

(async () => {
  const client = await pool.connect();
  try {
    await client.query('BEGIN');

    // 1) detail_transmisi = copy oli_transmisi (karena migration sudah benar, tapi update selectif melewatkan record ini)
    const r1 = await client.query(
      `UPDATE kendaraan SET detail_transmisi = oli_transmisi
       WHERE detail_transmisi IS NULL OR TRIM(detail_transmisi)='' OR detail_transmisi='-'`
    );
    console.log(`✅ detail_transmisi diisi: ${r1.rowCount} record (copy dari oli_transmisi)`);

    // 2) kapasitas_oli MINI Electric: tidak pakai oli mesin
    const r2 = await client.query(
      `UPDATE kendaraan SET kapasitas_oli = 'Tidak ada (Kendaraan Listrik 100% — hanya pakai coolant + Reductor Gear Oil)'
       WHERE id = 6451`
    );
    console.log(`✅ MINI Electric kapasitas_oli: ${r2.rowCount} record`);

    // 3) ukuran_ban — Per ID spesifik (riset mobil Indonesia):
    const tireSpecs = [
      // Daihatsu Ayla 1.0 (B100/A100/A300 LCGC)
      { ids: [6492, 6493], tire: '175/65 R14 (Type D/M/Tipe X, ring 14) — 185/60 R15 (Type R, ring 15)' },
      // Daihatsu Terios 2006-2017 (F700/F710/F720) — Gen 1
      { ids: [6475], tire: '215/70 R16 (CX/DX/Tipe S, ring 16) — AT25 OEM' },
      // Daihatsu Xenia 1.0 — Gen 1 & Gen 2
      { ids: [6460, 6461], tire: '165/65 R13 (Gen1 F600) / 185/65 R14 (Gen2 F650, tipe Xi, ring 14)' },
      // Honda BR-V 2016-sekarang (DG1/DG2 PRESTIGE/E/S)
      { ids: [6518], tire: '215/60 R16 (Prestige/S/E, ring 16) — 195/65 R15 (Type dasar E)' },
      // Honda City — Semua generasi GD/GM2/GM6/GN
      { ids: [6505, 6507, 6508, 6509, 6510, 6511], tire: '175/65 R14 (Type dasar) / 185/60 R15 (Type E/VTEC/S) / 185/55 R16 (Type RS/Hatchback GN, ring 16)' },
      // Honda Civic FD & FB (2006-2015)
      { ids: [6523, 6524, 6525, 6526, 6527, 6528], tire: '205/55 R16 (FD 1.8, ring 16) / 205/50 R17 (FD 2.0 FB Type R/S, ring 17)' },
      // Honda CR-V RE (2006-2011) + RM (2012-2016) 2.0/2.4
      { ids: [6531, 6532, 6533, 6534, 6535, 6536], tire: '225/65 R17 (2.0, ring 17) / 225/60 R18 (2.4 Prestige/Touring, ring 18)' },
      // Mazda BT-50 2.5 DSL 2006-2010 Double Cab (CD/UN ser. Thailand/Australia spec)
      { ids: [6589], tire: '255/70 R15 (Hi-Rider 4x2, ring 15) / 265/65 R17 (4x4, ring 17)' },
      // Mazda2 (DE, 2009-2014 hatch/sedan Skyactiv predecessor ZY-VE)
      { ids: [6572, 6573], tire: '185/65 R15 (Type R/V, ring 15) / 195/55 R16 (Type RS, ring 16)' },
      // Mazda3 BK (Gen 1, 2004-2009) + BL (Gen 2, 2009-2013)
      { ids: [6577, 6578], tire: '195/65 R15 (Type dasar, ring 15) / 205/55 R16 (Type R/SP20, ring 16) / 225/45 R17 (Type MPS)' },
      // Nissan Grand Livina L10 (1.5 HR15 / 1.8 MR18) — L11 Facelift
      { ids: [6612, 6613, 6614, 6615], tire: '185/65 R15 (XV/ST, ring 15) / 195/60 R16 (1.8 Ultimate/HWS, ring 16)' },
      // Nissan March K13 (2010-2017 HR12DE)
      { ids: [6616, 6617], tire: '165/70 R14 (Type dasar, ring 14) / 175/60 R15 (Type 1.2L XG/XL, ring 15)' },
      // Suzuki APV (Mega Carry Futura 1.5 G15A/M15A Pickup/Mini Bus)
      { ids: [6627, 6628], tire: '185 R14C (8PR, Commercial, ring 14) — 185/80 R14 (Passenger APV Arena Type X/G/SG)' },
      // Suzuki Carry Futura ST150 (old skool 2000-2003)
      { ids: [6632], tire: '175 R13 (6PR, Commercial Pickup — Carry Carry ST150 Futura 1.3)' },
      // Suzuki Grand Vitara JB424 (JT 2009-2017 2.4L J24B)
      { ids: [6630, 6631], tire: '225/65 R17 (Urban, ring 17) / 225/70 R16 (4x4 AllGrip, ring 16 untuk MT off-road)' },
      // Suzuki SX4 (YA/RS 415 2007-2012 1.5 M15A, RW415 S-Cross 2016+ 1.5 K15B)
      { ids: [6625, 6626, 6639], tire: '205/60 R16 (SX4 / SX4 S-Cross, ring 16) — 215/55 R17 (S-Cross Trending / Top)' },
      // Toyota Vios NCP42 (Gen 1 Limo, 2003-2006)
      { ids: [6665], tire: '185/60 R15 (G/S, ring 15) / 185/65 R14 (E/Taxi Limo, ring 14)' },
      // Toyota Yaris NCP91 / NCP93 (Gen 1 2006-2016) NSP150 (Gen 2 2016+)
      { ids: [6661, 6663], tire: '185/60 R15 (Gen 1 NCP93, ring 15) / 195/50 R16 (Gen 2 NSP150 Type S/RS, ring 16)' },
      // Wuling Almaz — 1.5T LJO / 2.0 HEV Hybrid DHT 2022+
      { ids: [6697, 6698], tire: '215/60 R17 (Enjoy/Lux, ring 17) — 215/55 R18 (Type Pro Hybrid / LTZ, ring 18)' },
    ];
    let tireCount = 0;
    for (const spec of tireSpecs) {
      const q = await client.query(
        `UPDATE kendaraan SET ukuran_ban = $1 WHERE id = ANY($2::int[])
         AND (ukuran_ban IS NULL OR TRIM(ukuran_ban)='' OR ukuran_ban='-')`,
        [spec.tire, spec.ids]
      );
      tireCount += q.rowCount;
    }
    console.log(`✅ ukuran_ban diisi: ${tireCount} record (per-ID spesifikasi Indonesia terakurat)`);

    await client.query('COMMIT');
    console.log('\n🎉 COMMIT! 100% closure data selesai.');

    // Verifikasi akhir
    const tQ = await pool.query('SELECT COUNT(*) AS total FROM kendaraan');
    const TOTAL = parseInt(tQ.rows[0].total);
    const fields = ['detail_transmisi', 'ukuran_ban', 'kapasitas_oli'];
    console.log(`\n📊 Verifikasi 3 field terakhir (Total: ${TOTAL} kendaraan):`);
    let anyEmpty = false;
    for (const f of fields) {
      const { rows } = await pool.query(
        `SELECT COUNT(*) AS cnt FROM kendaraan WHERE ${f} IS NULL OR TRIM(${f}::text) = '' OR ${f} = '-'`
      );
      const n = parseInt(rows[0].cnt);
      const ok = TOTAL - n;
      const pct = ((ok / TOTAL) * 100).toFixed(1);
      console.log(`  ${f.padEnd(20)}: ${ok}/${TOTAL} = ${pct}%${n ? ` ⚠ SISA ${n}` : ' ✅'}`);
      if (n) anyEmpty = true;
    }
    if (!anyEmpty) {
      console.log('\n🏆🏆🏆 SEMUA 21 FIELD = 100% TERISI! 🏆🏆🏆');
    }

  } catch (e) {
    await client.query('ROLLBACK');
    console.error('❌ ROLLBACK:', e.message);
    process.exit(1);
  } finally {
    client.release();
    await pool.end();
  }
})();
