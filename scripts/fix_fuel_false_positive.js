require('dotenv').config({ path: require('path').join(__dirname, '..', '.env') });
const p = require('../db');

(async () => {
  const client = await p.connect();
  try {
    await client.query('BEGIN');

    // FALSE POSITIVE FIX (3 record yang salah di-update jadi BENSIN — seharusnya DIESEL):
    const fixDiesel = [
      // Gran Max 1.5D — kode mesin SOHC / DVVT 1.5D = DIESEL (mesin Toyota 1ND-TV / Daihatsu 1.5D commonrail)
      { id: 6175, alasan: 'DAIHATSU Gran Max 1.5D (sufix D = diesel) — S/DVVT 1.5D mesin diesel commonrail'},
      { id: 6305, alasan: 'VOLVO XC60 D4204T D4 = DIESEL (kode mesin Dxxx Volvo = D5 diesel family)'},
      { id: 6306, alasan: 'VOLVO XC90 D5244T D5 = DIESEL (kode mesin Dxxx Volvo = D5 diesel family)'},
      { id: 6233, alasan: 'MITSUBISHI L300 4D56 = DIESEL legendaris Indonesia (4D56 diesel 2.5L)'},
    ];
    for (const x of fixDiesel) {
      const u = await client.query(`UPDATE kendaraan SET bahan_bakar='Diesel (CRDi / Common Rail / DDiS / dCi / CDTi / Turbo Diesel / Direct Injection)' WHERE id=$1 RETURNING merek, model, kode_mesin, bahan_bakar`, [x.id]);
      console.log('✅ RESTORE DIESEL id='+x.id, x.alasan, '→', u.rows[0].bahan_bakar);
    }

    // KONSOLIDASI: Ubah semua descriptor "Bensin (MPI / VVT-i / Dual VVT / Skyactiv-G)" (lama tanpa i-VTEC) → FULL STANDARD descriptor
    const rb = await client.query(`UPDATE kendaraan SET bahan_bakar='Bensin (MPI / VVT-i / Dual VVT / Skyactiv-G / i-VTEC / VVT / DVVT)' WHERE bahan_bakar='Bensin (MPI / VVT-i / Dual VVT / Skyactiv-G)'`);
    console.log('\n📦 Konsolidasi BENSIN old→standard descriptor:', rb.rowCount, 'rows');

    const rd = await client.query(`UPDATE kendaraan SET bahan_bakar='Diesel (CRDi / Common Rail / DDiS / dCi / CDTi / Turbo Diesel / Direct Injection)' WHERE bahan_bakar='Diesel (Common Rail / CRDi)'`);
    console.log('📦 Konsolidasi DIESEL old→standard descriptor:', rd.rowCount, 'rows');

    // Sisa hybrid/listrik exact lowercase (14 listrik, 10 hybrid) → upgrade ke descriptor panjang supaya UI tampil konsisten
    const rl = await client.query(`UPDATE kendaraan SET bahan_bakar='Listrik (BEV — Battery Electric Vehicle)' WHERE bahan_bakar='listrik'`);
    console.log('📦 Upgrade listrik short→descriptor:', rl.rowCount, 'rows');
    const rh = await client.query(`UPDATE kendaraan SET bahan_bakar='Bensin + Listrik (Hybrid HEV / PHEV)' WHERE bahan_bakar='hybrid'`);
    console.log('📦 Upgrade hybrid short→descriptor:', rh.rowCount, 'rows');

    // VERIFY akhir: distinct bahan bakar & sample Agya
    const df = await client.query(`SELECT bahan_bakar, COUNT(*) n FROM kendaraan GROUP BY bahan_bakar ORDER BY n DESC`);
    console.log('\n🎯 FINAL Distinct bahan_bakar:');
    df.rows.forEach(r => console.log(' ', String(r.n).padStart(5), JSON.stringify(r.bahan_bakar)));

    const agya = await client.query(`SELECT id, merek, model, kode_mesin, bahan_bakar FROM kendaraan WHERE model ILIKE $1 ORDER BY id`, ['%agya%']);
    console.log('\n✅ VERIFY AGYA (SEMUA harus BENSIN, tidak ada DIESEL):');
    agya.rows.forEach(r => {
      const ok = /bensin/i.test(r.bahan_bakar) ? '✅ BENAR' : '❌ SALAH';
      console.log(' ', ok, 'id='+r.id, r.merek, r.model, 'km='+r.kode_mesin, 'fuel='+r.bahan_bakar);
    });

    await client.query('COMMIT');
    console.log('\n✅ COMMIT FIX-FALSE-POSITIVE + KONSOLIDASI SUKSES');

  } catch (e) {
    await client.query('ROLLBACK');
    console.error('ROLLBACK. ERR:', e.message);
    process.exit(1);
  } finally {
    client.release();
    p.end();
  }
})();
