require('dotenv').config({ path: require('path').join(__dirname, '..', '.env') });
const p = require('../db');

const BRAND_ALIASES = {
  'vw': 'VOLKSWAGEN',
  'mercedes-benz': 'MERCEDES',
};

function titleCase(s) {
  return String(s || '').trim()
    .replace(/\s+/g, ' ')
    .split(' ')
    .map(w => {
      if (/^(BMW|MG|MINI|GWM|DFSK|EQ[ABES]|AMG|GT|ID\.|CLA|CLE|CLS|GL[A-E]|GLE|GLS|W\d+|T\d+|RS|VRS|TSI|TDI|HEV|PHEV|BEV|EPS|GL-?\d|ATF|CVT|MT|AT|DOT|PSI|R$|LINE|LWB|OH|OF|RS)$/i.test(w)) {
        return w.toUpperCase();
      }
      const first = w.charAt(0).toUpperCase();
      const rest = w.slice(1).toLowerCase();
      const hyphenated = w.split('-').map(p => p.charAt(0).toUpperCase() + p.slice(1).toLowerCase()).join('-');
      return (w.includes('-') ? hyphenated : (first + rest));
    })
    .join(' ');
}

function norm(s) {
  return String(s || '').trim().toLowerCase().replace(/\s+/g, ' ');
}

function resolveBrand(raw) {
  const n = norm(raw);
  if (BRAND_ALIASES[n]) return BRAND_ALIASES[n];
  return titleCase(raw);
}

(async () => {
  const client = await p.connect();
  try {
    await client.query('BEGIN');
    
    // 1. Normalisasi merek & model (TRIM + titlecase + alias)
    console.log('Pass 1: Normalize merek & model text...');
    const upd1 = await client.query(`
      UPDATE kendaraan
      SET merek  = TRIM(BOTH ' ' FROM merek),
          model  = TRIM(BOTH ' ' FROM model),
          kategori = TRIM(BOTH ' ' FROM COALESCE(kategori,''))
      WHERE merek <> TRIM(BOTH ' ' FROM merek)
         OR model <> TRIM(BOTH ' ' FROM model)
         OR COALESCE(kategori,'') <> TRIM(BOTH ' ' FROM COALESCE(kategori,''))
    `);
    console.log('  TRIM updated rows:', upd1.rowCount);
    
    // 2. Ambil semua data, grup per (norm(merek), norm(model))
    const { rows } = await client.query(`SELECT * FROM kendaraan ORDER BY id`);
    console.log('  Total kendaraan:', rows.length);
    
    // Skor kelengkapan data: hitung jumlah field tidak null/kosong
    const FIELDS = ['merek','model','tahun','kategori','bahan_bakar','kode_mesin','kapasitas_cc',
      'tipe_transmisi','detail_transmisi','viskositas_oli','standar_oli','kapasitas_oli','oli_transmisi',
      'tipe_power_steering','fluida_power_steering','tipe_sistem_rem','minyak_rem',
      'ukuran_ban','merek_ban_oem','tekanan_ban','tipe_aki','merek_aki_oem','rekomendasi_aftermarket'];
    function score(r) {
      let s = 0;
      FIELDS.forEach(f => { if (r[f] && String(r[f]).trim() !== '' && r[f] !== '—') s++; });
      return s;
    }
    
    const groups = new Map(); // key = normBrand|normModel
    rows.forEach(r => {
      const brandFinal = resolveBrand(r.merek);
      const modelFinal = titleCase(r.model);
      const key = `${norm(brandFinal)}|${norm(modelFinal)}`;
      if (!groups.has(key)) groups.set(key, { keep: null, dupIds: [], brandFinal, modelFinal });
      const g = groups.get(key);
      g.dupIds.push(r.id);
      const sc = score(r);
      if (!g.keep || sc > g.keep._score) { g.keep = r; g.keep._score = sc; }
    });
    
    console.log('  Jumlah group (merek+model) unique:', groups.size);
    
    // 3. Untuk setiap grup: update semua record pakai merek & model final; dan NON-PRIMARY hapus yang model-nya duplikat
    let brandUpdated = 0, modelUpdated = 0, deleted = 0;
    const deleteIds = [];
    
    for (const [, g] of groups) {
      for (const id of g.dupIds) {
        const row = rows.find(r => r.id === id);
        if (norm(row.merek) !== norm(g.brandFinal) || norm(row.model) !== norm(g.modelFinal)) {
          // Update ke brandFinal & modelFinal (case corrected)
          const u = await client.query(
            `UPDATE kendaraan SET merek=$1, model=$2 WHERE id=$3`,
            [g.brandFinal, g.modelFinal, id]
          );
          if (norm(row.merek) !== norm(g.brandFinal)) brandUpdated++;
          if (norm(row.model) !== norm(g.modelFinal)) modelUpdated++;
        }
      }
      // Jika > 1 id dengan merek+model SAMA → hapus selain yang punya skor tertinggi
      if (g.dupIds.length > 1) {
        const keepId = g.keep.id;
        for (const id of g.dupIds) {
          if (id !== keepId) deleteIds.push(id);
        }
      }
    }
    console.log('  Merek corrected:', brandUpdated, '| Model corrected:', modelUpdated);
    console.log('  Akan delete duplikat model (same norm brand+norm model):', deleteIds.length);
    
    if (deleteIds.length) {
      // Hapus dulu referensi gardan (kendaraan_differential) ON DELETE CASCADE jika ada
      const d1 = await client.query(
        `DELETE FROM kendaraan_differential WHERE kendaraan_id = ANY($1)`,
        [deleteIds]
      );
      console.log('  Delete diff rows:', d1.rowCount);
      const d2 = await client.query(
        `DELETE FROM kendaraan WHERE id = ANY($1)`,
        [deleteIds]
      );
      deleted += d2.rowCount;
      console.log('  Delete kendaraan:', d2.rowCount);
    }
    
    await client.query('COMMIT');
    console.log('\n═══ COMMIT SUCCESS ═══');
    console.log('Brand updated (correct case/alias):', brandUpdated);
    console.log('Model updated (correct case):', modelUpdated);
    console.log('Duplicate model deleted:', deleted);
    
  } catch (e) {
    await client.query('ROLLBACK');
    console.error('ROLLBACK. ERROR:', e.message);
    process.exit(1);
  } finally {
    client.release();
    p.end();
  }
})();
