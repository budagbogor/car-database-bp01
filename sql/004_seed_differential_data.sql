-- ============================================================
-- 004_seed_differential_data.sql
-- Data gardan / differential untuk semua kendaraan yang
-- memiliki gardan terpisah di pasaran Indonesia.
--
-- Kategori:
--   RWD  → hanya gardan belakang
--   4WD  → gardan depan + belakang + transfer case
--   AWD  → electronic rear coupling + gardan belakang
--   PT4WD → part-time 4WD (rear selalu, depan + transfer saat 4WD)
--
-- Pola INSERT:
--   SELECT k.id ... FROM kendaraan k CROSS JOIN (VALUES ...) d
--   WHERE k.merek = '...' AND k.model [LIKE / =] '...'
--   → otomatis ter-insert untuk SEMUA varian transmisi model tsb.
-- ============================================================

TRUNCATE TABLE kendaraan_differential RESTART IDENTITY;

-- ═══════════════════════════════════════════════════════════
-- TOYOTA
-- ═══════════════════════════════════════════════════════════

-- Kijang Innova (Reborn) 2015–2022 — RWD
INSERT INTO kendaraan_differential
  (kendaraan_id, posisi, jenis, spesifikasi_oli, kapasitas_oli, catatan)
SELECT k.id, d.posisi, d.jenis, d.spek, d.kap, d.cat
FROM kendaraan k CROSS JOIN (VALUES
  ('Belakang','Open Differential',
   'Toyota Gear Oil LF / Hypoid Gear Oil API GL-5 85W-90','1.4 L',
   'Penggerak belakang (RWD) — berlaku semua varian transmisi')
) d(posisi,jenis,spek,kap,cat)
WHERE k.merek='Toyota' AND k.model='Kijang Innova (Reborn)';

-- Kijang Innova Gen 1 (2005–2015) — RWD
INSERT INTO kendaraan_differential
  (kendaraan_id, posisi, jenis, spesifikasi_oli, kapasitas_oli, catatan)
SELECT k.id, d.posisi, d.jenis, d.spek, d.kap, d.cat
FROM kendaraan k CROSS JOIN (VALUES
  ('Belakang','Open Differential',
   'Hypoid Gear Oil API GL-5 85W-90','1.4 L',
   'Penggerak belakang (RWD) — berlaku semua varian transmisi')
) d(posisi,jenis,spek,kap,cat)
WHERE k.merek='Toyota' AND k.model='Kijang Innova (Gen 1)';

-- Fortuner (semua varian) — 4WD (ada varian 2WD, data untuk varian 4WD)
INSERT INTO kendaraan_differential
  (kendaraan_id, posisi, jenis, spesifikasi_oli, kapasitas_oli, catatan)
SELECT k.id, d.posisi, d.jenis, d.spek, d.kap, d.cat
FROM kendaraan k CROSS JOIN (VALUES
  ('Depan','Open Differential',
   'Toyota Gear Oil API GL-5 75W-90','1.0 L',
   'Khusus varian 4WD'),
  ('Belakang','Open Differential (LSD tersedia pada GR Sport)',
   'Toyota Gear Oil API GL-5 75W-90 / Toyota LSD Gear Oil','1.5 L',
   'Khusus varian 4WD'),
  ('Transfer Case','Part-time 4WD (Active TRAC)',
   'Toyota ATF WS','0.9 L',
   'Transfer case part-time 4WD; posisi H2-H4-L4')
) d(posisi,jenis,spek,kap,cat)
WHERE k.merek='Toyota' AND k.model LIKE 'Fortuner%';

-- Hilux — 4WD variant
INSERT INTO kendaraan_differential
  (kendaraan_id, posisi, jenis, spesifikasi_oli, kapasitas_oli, catatan)
SELECT k.id, d.posisi, d.jenis, d.spek, d.kap, d.cat
FROM kendaraan k CROSS JOIN (VALUES
  ('Depan','Open Differential',
   'Toyota Gear Oil API GL-5 75W-90','1.2 L',
   'Khusus varian 4WD'),
  ('Belakang','Open Differential',
   'Toyota Gear Oil API GL-5 75W-90','2.4 L',
   'Khusus varian 4WD'),
  ('Transfer Case','Part-time 4WD',
   'Toyota ATF WS / Transfer Oil GL-4 75W-90','1.0 L',
   'Posisi H2-H4-L4')
) d(posisi,jenis,spek,kap,cat)
WHERE k.merek='Toyota' AND k.model='Hilux';

-- Hilux Rangga — 4WD variant
INSERT INTO kendaraan_differential
  (kendaraan_id, posisi, jenis, spesifikasi_oli, kapasitas_oli, catatan)
SELECT k.id, d.posisi, d.jenis, d.spek, d.kap, d.cat
FROM kendaraan k CROSS JOIN (VALUES
  ('Depan','Open Differential',
   'Toyota Gear Oil API GL-5 75W-90','1.2 L',
   'Khusus varian 4WD'),
  ('Belakang','Open Differential',
   'Toyota Gear Oil API GL-5 75W-90','2.4 L',
   'Khusus varian 4WD'),
  ('Transfer Case','Part-time 4WD',
   'Toyota ATF WS','1.0 L',
   'Posisi H2-H4-L4')
) d(posisi,jenis,spek,kap,cat)
WHERE k.merek='Toyota' AND k.model='Hilux Rangga';

-- Rush Gen 1 (2006–2017) — Part-time 4WD (basis Terios)
INSERT INTO kendaraan_differential
  (kendaraan_id, posisi, jenis, spesifikasi_oli, kapasitas_oli, catatan)
SELECT k.id, d.posisi, d.jenis, d.spek, d.kap, d.cat
FROM kendaraan k CROSS JOIN (VALUES
  ('Depan','Open Differential',
   'API GL-5 75W-90','0.9 L',
   'Aktif saat mode 4WD (part-time)'),
  ('Belakang','Open Differential',
   'API GL-5 75W-90','1.3 L',
   'Selalu aktif (RWD bias)'),
  ('Transfer Case','Part-time 4WD',
   'Toyota ATF T-IV / API GL-4 75W-90','0.9 L',
   'Posisi 2H-4H-4L')
) d(posisi,jenis,spek,kap,cat)
WHERE k.merek='Toyota' AND k.model='Rush (Gen 1)';

-- Land Cruiser Prado / 300 — Full-time 4WD
INSERT INTO kendaraan_differential
  (kendaraan_id, posisi, jenis, spesifikasi_oli, kapasitas_oli, catatan)
SELECT k.id, d.posisi, d.jenis, d.spek, d.kap, d.cat
FROM kendaraan k CROSS JOIN (VALUES
  ('Depan','Open Differential / LSD (KDSS)',
   'Toyota Gear Oil LF API GL-5 75W-90','1.5 L',
   'Full-time 4WD; beberapa varian dilengkapi KDSS atau LSD'),
  ('Belakang','Limited Slip Differential (LSD) / Locking',
   'Toyota Gear Oil LSD API GL-5 90 / 75W-90','1.8 L',
   'Banyak varian bergardan LSD; VX/GR Sport: locking diff'),
  ('Transfer Case','Full-time 4WD (Multi-terrain Select)',
   'Toyota ATF WS','1.2 L',
   'Center differential tipe planetary, mode Hi-Lo-Lock')
) d(posisi,jenis,spek,kap,cat)
WHERE k.merek='Toyota' AND k.model='Land Cruiser Prado/300';

-- GR Yaris — GR-FOUR AWD
INSERT INTO kendaraan_differential
  (kendaraan_id, posisi, jenis, spesifikasi_oli, kapasitas_oli, catatan)
SELECT k.id, d.posisi, d.jenis, d.spek, d.kap, d.cat
FROM kendaraan k CROSS JOIN (VALUES
  ('Depan','Torsen Limited Slip Differential (LSD)',
   'API GL-5 75W-90 Fully Synthetic','0.9 L',
   'AWD GR-FOUR — distribusi torsi adaptif'),
  ('Belakang','Torsen Limited Slip Differential (LSD)',
   'API GL-5 75W-90 Fully Synthetic','0.9 L',
   'AWD GR-FOUR — distribusi torsi adaptif'),
  ('Transfer Case','GR-FOUR Active Torque Split AWD',
   'API GL-4 75W-85 / Toyota Transfer Fluid','0.4 L',
   'Kopling elektronik multi-plate; mode Track/Sport/Normal')
) d(posisi,jenis,spek,kap,cat)
WHERE k.merek='Toyota' AND k.model='GR Yaris';

-- ═══════════════════════════════════════════════════════════
-- DAIHATSU
-- ═══════════════════════════════════════════════════════════

-- Gran Max (bensin & diesel) — RWD
INSERT INTO kendaraan_differential
  (kendaraan_id, posisi, jenis, spesifikasi_oli, kapasitas_oli, catatan)
SELECT k.id, d.posisi, d.jenis, d.spek, d.kap, d.cat
FROM kendaraan k CROSS JOIN (VALUES
  ('Belakang','Open Differential',
   'Hypoid Gear Oil API GL-5 90','1.0 L',
   'Penggerak belakang (RWD) — Pickup & Minibus')
) d(posisi,jenis,spek,kap,cat)
WHERE k.merek='Daihatsu' AND (k.model LIKE 'Gran Max%' OR k.model LIKE '%Luxio%');

-- Terios (2006–2017) — Part-time 4WD
INSERT INTO kendaraan_differential
  (kendaraan_id, posisi, jenis, spesifikasi_oli, kapasitas_oli, catatan)
SELECT k.id, d.posisi, d.jenis, d.spek, d.kap, d.cat
FROM kendaraan k CROSS JOIN (VALUES
  ('Depan','Open Differential',
   'API GL-5 75W-90','0.7 L',
   'Aktif saat mode 4WD (part-time)'),
  ('Belakang','Open Differential',
   'API GL-5 75W-90','0.9 L',
   'Selalu aktif (RWD bias)'),
  ('Transfer Case','Part-time 4WD',
   'ATF T-IV / API GL-4 75W-90','0.9 L',
   'Posisi 2H-4H-4L')
) d(posisi,jenis,spek,kap,cat)
WHERE k.merek='Daihatsu' AND k.model='Terios';

-- Rocky — AWD Electronic Coupling (varian AWD)
INSERT INTO kendaraan_differential
  (kendaraan_id, posisi, jenis, spesifikasi_oli, kapasitas_oli, catatan)
SELECT k.id, d.posisi, d.jenis, d.spek, d.kap, d.cat
FROM kendaraan k CROSS JOIN (VALUES
  ('Belakang','Electronic Viscous Coupling (AWD)',
   'Toyota/Daihatsu AWD Coupling Fluid','0.3 L',
   'Khusus varian AWD — kopling rear otomatis, bukan gardan konvensional')
) d(posisi,jenis,spek,kap,cat)
WHERE k.merek='Daihatsu' AND k.model='Rocky';

-- Taruna (1997–2004) — 4WD
INSERT INTO kendaraan_differential
  (kendaraan_id, posisi, jenis, spesifikasi_oli, kapasitas_oli, catatan)
SELECT k.id, d.posisi, d.jenis, d.spek, d.kap, d.cat
FROM kendaraan k CROSS JOIN (VALUES
  ('Depan','Open Differential',
   'API GL-5 75W-90','0.8 L',
   'Varian FI/FGX/EFI 4WD'),
  ('Belakang','Open Differential',
   'API GL-5 75W-90','1.0 L',
   'Semua varian Taruna'),
  ('Transfer Case','Part-time 4WD',
   'Daihatsu ATF / API GL-4','0.8 L',
   'Posisi 2H-4H-4L')
) d(posisi,jenis,spek,kap,cat)
WHERE k.merek='Daihatsu' AND k.model='Taruna';

-- Feroza (1991–2000) — Part-time 4WD
INSERT INTO kendaraan_differential
  (kendaraan_id, posisi, jenis, spesifikasi_oli, kapasitas_oli, catatan)
SELECT k.id, d.posisi, d.jenis, d.spek, d.kap, d.cat
FROM kendaraan k CROSS JOIN (VALUES
  ('Depan','Open Differential',
   'API GL-5 75W-90','0.7 L',
   'Part-time 4WD'),
  ('Belakang','Open Differential',
   'API GL-5 75W-90','0.9 L',
   'RWD bias'),
  ('Transfer Case','Part-time 4WD (Free-wheeling hub)',
   'API GL-4 SAE 75W-80','0.8 L',
   'Manual hub 4WD')
) d(posisi,jenis,spek,kap,cat)
WHERE k.merek='Daihatsu' AND k.model='Feroza';

-- Espass (1996–2004) — RWD
INSERT INTO kendaraan_differential
  (kendaraan_id, posisi, jenis, spesifikasi_oli, kapasitas_oli, catatan)
SELECT k.id, d.posisi, d.jenis, d.spek, d.kap, d.cat
FROM kendaraan k CROSS JOIN (VALUES
  ('Belakang','Open Differential',
   'Hypoid Gear Oil API GL-5 90','0.8 L',
   'Penggerak belakang (RWD)')
) d(posisi,jenis,spek,kap,cat)
WHERE k.merek='Daihatsu' AND k.model='Espass';

-- Zebra (1991–2003) — RWD
INSERT INTO kendaraan_differential
  (kendaraan_id, posisi, jenis, spesifikasi_oli, kapasitas_oli, catatan)
SELECT k.id, d.posisi, d.jenis, d.spek, d.kap, d.cat
FROM kendaraan k CROSS JOIN (VALUES
  ('Belakang','Open Differential',
   'Hypoid Gear Oil API GL-5 90','0.8 L',
   'Penggerak belakang (RWD)')
) d(posisi,jenis,spek,kap,cat)
WHERE k.merek='Daihatsu' AND k.model='Zebra';

-- ═══════════════════════════════════════════════════════════
-- HONDA
-- ═══════════════════════════════════════════════════════════

-- CR-V Gen 4 (2012–2017) — varian AWD (Real-time 4WD)
INSERT INTO kendaraan_differential
  (kendaraan_id, posisi, jenis, spesifikasi_oli, kapasitas_oli, catatan)
SELECT k.id, d.posisi, d.jenis, d.spek, d.kap, d.cat
FROM kendaraan k CROSS JOIN (VALUES
  ('Belakang','Electronic Viscous Coupling (Real-time AWD)',
   'Honda DPS Fluid (ATF-2.0)','0.25 L',
   'Khusus varian AWD — DPS = Dual Pump System; cek level via kaca pengintip')
) d(posisi,jenis,spek,kap,cat)
WHERE k.merek='Honda' AND k.model='CR-V' AND k.tahun LIKE '%2012%';

-- ═══════════════════════════════════════════════════════════
-- SUZUKI
-- ═══════════════════════════════════════════════════════════

-- APV / APV Arena — RWD
INSERT INTO kendaraan_differential
  (kendaraan_id, posisi, jenis, spesifikasi_oli, kapasitas_oli, catatan)
SELECT k.id, d.posisi, d.jenis, d.spek, d.kap, d.cat
FROM kendaraan k CROSS JOIN (VALUES
  ('Belakang','Open Differential',
   'Hypoid Gear Oil API GL-5 90','1.5 L',
   'Penggerak belakang (RWD)')
) d(posisi,jenis,spek,kap,cat)
WHERE k.merek='Suzuki' AND k.model LIKE 'APV%';

-- Carry 1.5 / Futura — RWD
INSERT INTO kendaraan_differential
  (kendaraan_id, posisi, jenis, spesifikasi_oli, kapasitas_oli, catatan)
SELECT k.id, d.posisi, d.jenis, d.spek, d.kap, d.cat
FROM kendaraan k CROSS JOIN (VALUES
  ('Belakang','Open Differential',
   'Hypoid Gear Oil API GL-5 90','1.0 L',
   'Penggerak belakang (RWD)')
) d(posisi,jenis,spek,kap,cat)
WHERE k.merek='Suzuki' AND k.model LIKE 'Carry%';

-- Jimny — Part-time 4WD (3-link rigid axle)
INSERT INTO kendaraan_differential
  (kendaraan_id, posisi, jenis, spesifikasi_oli, kapasitas_oli, catatan)
SELECT k.id, d.posisi, d.jenis, d.spek, d.kap, d.cat
FROM kendaraan k CROSS JOIN (VALUES
  ('Depan','Open Differential (axle rigid)',
   'Suzuki Genuine Hypoid Gear Oil API GL-5 75W-90','0.55 L',
   'Part-time 4WD; free-wheeling hub otomatis pada JB74'),
  ('Belakang','Open Differential (axle rigid)',
   'Suzuki Genuine Hypoid Gear Oil API GL-5 75W-90','0.55 L',
   'RWD bias — selalu aktif'),
  ('Transfer Case','Part-time 4WD (2H/4H/4L)',
   'Suzuki Transfer Gear Oil API GL-4 75W-85','1.3 L',
   'Low-range ratio 2.884:1; posisi 2H-4H-4L')
) d(posisi,jenis,spek,kap,cat)
WHERE k.merek='Suzuki' AND k.model='Jimny';

-- Grand Vitara — Part-time / All-grip 4WD
INSERT INTO kendaraan_differential
  (kendaraan_id, posisi, jenis, spesifikasi_oli, kapasitas_oli, catatan)
SELECT k.id, d.posisi, d.jenis, d.spek, d.kap, d.cat
FROM kendaraan k CROSS JOIN (VALUES
  ('Depan','Open Differential',
   'API GL-5 75W-90','0.9 L',
   'Aktif saat mode 4WD; varian 3-door & 5-door'),
  ('Belakang','Open Differential / LSD (pada Crossover)',
   'API GL-5 75W-90','1.0 L',
   'RWD bias'),
  ('Transfer Case','Part-time / All-grip 4WD',
   'API GL-4 75W-90 / ATF Dexron III','1.0 L',
   'Posisi 2H-4H-4L; beberapa varian All-grip otomatis')
) d(posisi,jenis,spek,kap,cat)
WHERE k.merek='Suzuki' AND k.model='Grand Vitara';

-- Escudo — Part-time 4WD
INSERT INTO kendaraan_differential
  (kendaraan_id, posisi, jenis, spesifikasi_oli, kapasitas_oli, catatan)
SELECT k.id, d.posisi, d.jenis, d.spek, d.kap, d.cat
FROM kendaraan k CROSS JOIN (VALUES
  ('Depan','Open Differential',
   'API GL-5 75W-90','0.7 L',
   'Aktif saat 4WD'),
  ('Belakang','Open Differential',
   'API GL-5 75W-90','0.9 L',
   'RWD bias'),
  ('Transfer Case','Part-time 4WD',
   'API GL-4 SAE 75W-80','0.8 L',
   'Posisi 2H-4H-4L')
) d(posisi,jenis,spek,kap,cat)
WHERE k.merek='Suzuki' AND k.model='Escudo';

-- Every — RWD
INSERT INTO kendaraan_differential
  (kendaraan_id, posisi, jenis, spesifikasi_oli, kapasitas_oli, catatan)
SELECT k.id, d.posisi, d.jenis, d.spek, d.kap, d.cat
FROM kendaraan k CROSS JOIN (VALUES
  ('Belakang','Open Differential',
   'Hypoid Gear Oil API GL-5 90','0.8 L',
   'Penggerak belakang (RWD)')
) d(posisi,jenis,spek,kap,cat)
WHERE k.merek='Suzuki' AND k.model='Every';

-- ═══════════════════════════════════════════════════════════
-- MITSUBISHI
-- ═══════════════════════════════════════════════════════════

-- Pajero Sport Gen 2 (4D56) — Part-time 4WD Easy Select
INSERT INTO kendaraan_differential
  (kendaraan_id, posisi, jenis, spesifikasi_oli, kapasitas_oli, catatan)
SELECT k.id, d.posisi, d.jenis, d.spek, d.kap, d.cat
FROM kendaraan k CROSS JOIN (VALUES
  ('Depan','Open Differential',
   'Mitsubishi Hypoid Gear Oil API GL-5 SAE 90','1.0 L',
   'Part-time 4WD Easy Select (2H/4H/4L)'),
  ('Belakang','Open Differential / LSD (Exceed)',
   'Mitsubishi Hypoid Gear Oil API GL-5 SAE 90 / LSD 90','1.5 L',
   'Semua varian; varian Exceed bergardan LSD'),
  ('Transfer Case','Easy Select 4WD (2H/4H/4L)',
   'Mitsubishi Transfer Oil (ATF Dexron III)','1.2 L',
   'Transfer case elektronik Easy Select')
) d(posisi,jenis,spek,kap,cat)
WHERE k.merek='Mitsubishi' AND k.model='Pajero Sport';

-- New Pajero Sport Gen 3 (4N15) — Super Select 4WD II
INSERT INTO kendaraan_differential
  (kendaraan_id, posisi, jenis, spesifikasi_oli, kapasitas_oli, catatan)
SELECT k.id, d.posisi, d.jenis, d.spek, d.kap, d.cat
FROM kendaraan k CROSS JOIN (VALUES
  ('Depan','Open Differential',
   'API GL-5 75W-90','1.1 L',
   'Super Select 4WD II (2H/4H/4HLc/4LLc)'),
  ('Belakang','Limited Slip Differential (AYC/LSD opsional)',
   'Mitsubishi Gear Oil API GL-5 75W-90 / GL-5 LSD 90','1.5 L',
   'LSD tersedia pada varian Dakar; ABS berperan saat traksi kurang'),
  ('Transfer Case','Super Select 4WD II',
   'Mitsubishi Transfer Fluid (GL-4 / synthetic)','1.3 L',
   'Full-time / part-time switchable; center lock tersedia')
) d(posisi,jenis,spek,kap,cat)
WHERE k.merek='Mitsubishi' AND k.model='New Pajero Sport';

-- Triton — Part-time 4WD Easy Select
INSERT INTO kendaraan_differential
  (kendaraan_id, posisi, jenis, spesifikasi_oli, kapasitas_oli, catatan)
SELECT k.id, d.posisi, d.jenis, d.spek, d.kap, d.cat
FROM kendaraan k CROSS JOIN (VALUES
  ('Depan','Open Differential',
   'Mitsubishi Hypoid Gear Oil API GL-5 75W-90','1.2 L',
   'Easy Select 4WD (2H/4H/4L) — Triton pickup double/single cabin'),
  ('Belakang','Open Differential / LSD (Ultimate)',
   'Mitsubishi Hypoid Gear Oil API GL-5 75W-90 / LSD 90','2.2 L',
   'Varian Ultimate: LSD belakang; kapasitas besar krn axle panjang'),
  ('Transfer Case','Easy Select 4WD (2H/4H/4L)',
   'Mitsubishi Transfer Oil','1.2 L',
   'Part-time 4WD — tidak bisa full-time')
) d(posisi,jenis,spek,kap,cat)
WHERE k.merek='Mitsubishi' AND k.model='Triton';

-- L300 (bensin & diesel) — RWD
INSERT INTO kendaraan_differential
  (kendaraan_id, posisi, jenis, spesifikasi_oli, kapasitas_oli, catatan)
SELECT k.id, d.posisi, d.jenis, d.spek, d.kap, d.cat
FROM kendaraan k CROSS JOIN (VALUES
  ('Belakang','Open Differential',
   'Hypoid Gear Oil API GL-5 80W-90 / SAE 90','1.7 L',
   'Penggerak belakang (RWD) — bensin & diesel')
) d(posisi,jenis,spek,kap,cat)
WHERE k.merek='Mitsubishi' AND k.model='L300';

-- Kuda — RWD
INSERT INTO kendaraan_differential
  (kendaraan_id, posisi, jenis, spesifikasi_oli, kapasitas_oli, catatan)
SELECT k.id, d.posisi, d.jenis, d.spek, d.kap, d.cat
FROM kendaraan k CROSS JOIN (VALUES
  ('Belakang','Open Differential',
   'Hypoid Gear Oil API GL-5 80W-90','1.5 L',
   'Penggerak belakang (RWD)')
) d(posisi,jenis,spek,kap,cat)
WHERE k.merek='Mitsubishi' AND k.model='Kuda';

-- Delica — Full-time / Part-time 4WD
INSERT INTO kendaraan_differential
  (kendaraan_id, posisi, jenis, spesifikasi_oli, kapasitas_oli, catatan)
SELECT k.id, d.posisi, d.jenis, d.spek, d.kap, d.cat
FROM kendaraan k CROSS JOIN (VALUES
  ('Depan','Open Differential',
   'API GL-5 75W-90','1.0 L',
   '4WD full-time / part-time (tergantung generasi)'),
  ('Belakang','Open Differential',
   'API GL-5 75W-90','1.3 L',
   'Semua varian Delica 4WD'),
  ('Transfer Case','4WD Transfer (2H/4H/4L)',
   'Mitsubishi Transfer Fluid / ATF','1.2 L',
   'Versi lama: manual; versi baru: elektronik')
) d(posisi,jenis,spek,kap,cat)
WHERE k.merek='Mitsubishi' AND k.model='Delica';

-- ═══════════════════════════════════════════════════════════
-- NISSAN
-- ═══════════════════════════════════════════════════════════

-- Terra — 4WD (platform NP300 / QX80 berbagi)
INSERT INTO kendaraan_differential
  (kendaraan_id, posisi, jenis, spesifikasi_oli, kapasitas_oli, catatan)
SELECT k.id, d.posisi, d.jenis, d.spek, d.kap, d.cat
FROM kendaraan k CROSS JOIN (VALUES
  ('Depan','Open Differential',
   'Nissan Differential Oil API GL-5 80W-90','1.1 L',
   'Aktif saat mode 4WD'),
  ('Belakang','Open Differential',
   'Nissan Differential Oil API GL-5 80W-90','1.3 L',
   'Penggerak utama (RWD bias)'),
  ('Transfer Case','Shift-On-The-Fly 4WD (2WD/4H/4L)',
   'Nissan ATF Matic-S','1.0 L',
   'Perpindahan H2-H4 bisa saat jalan pelan; L4 saat berhenti')
) d(posisi,jenis,spek,kap,cat)
WHERE k.merek='Nissan' AND k.model='Terra';

-- Navara — 4WD (D23 platform)
INSERT INTO kendaraan_differential
  (kendaraan_id, posisi, jenis, spesifikasi_oli, kapasitas_oli, catatan)
SELECT k.id, d.posisi, d.jenis, d.spek, d.kap, d.cat
FROM kendaraan k CROSS JOIN (VALUES
  ('Depan','Open Differential',
   'Nissan Differential Oil API GL-5 80W-90','1.1 L',
   'Part-time 4WD; khusus varian 4WD'),
  ('Belakang','Open Differential / LSD (VL varian)',
   'Nissan Differential Oil API GL-5 80W-90 / LSD 90','1.7 L',
   'VL Sport: LSD belakang tersedia'),
  ('Transfer Case','Part-time Shift-On-The-Fly',
   'Nissan ATF Matic-J','0.9 L',
   'Posisi 2WD-4H-4L')
) d(posisi,jenis,spek,kap,cat)
WHERE k.merek='Nissan' AND k.model='Navara';

-- X-Trail (T32) — AWD (Electronic rear coupling)
INSERT INTO kendaraan_differential
  (kendaraan_id, posisi, jenis, spesifikasi_oli, kapasitas_oli, catatan)
SELECT k.id, d.posisi, d.jenis, d.spek, d.kap, d.cat
FROM kendaraan k CROSS JOIN (VALUES
  ('Belakang','Electronic Viscous Coupling (AWD ALL MODE 4×4)',
   'Nissan Genuine Rear Diff Oil / ATF Matic-J','0.4 L',
   'Khusus varian AWD — kopling rear elektro-hidraulik; otomatis sesuai kondisi')
) d(posisi,jenis,spek,kap,cat)
WHERE k.merek='Nissan' AND k.model='X-Trail';

-- ═══════════════════════════════════════════════════════════
-- ISUZU
-- ═══════════════════════════════════════════════════════════

-- Panther (bensin & diesel) — RWD
INSERT INTO kendaraan_differential
  (kendaraan_id, posisi, jenis, spesifikasi_oli, kapasitas_oli, catatan)
SELECT k.id, d.posisi, d.jenis, d.spek, d.kap, d.cat
FROM kendaraan k CROSS JOIN (VALUES
  ('Belakang','Open Differential',
   'Hypoid Gear Oil API GL-5 85W-90 / SAE 90','2.2 L',
   'Penggerak belakang (RWD) — kapasitas besar krn axle beam solid')
) d(posisi,jenis,spek,kap,cat)
WHERE k.merek='Isuzu' AND k.model='Panther';

-- D-Max — 4WD (TF platform)
INSERT INTO kendaraan_differential
  (kendaraan_id, posisi, jenis, spesifikasi_oli, kapasitas_oli, catatan)
SELECT k.id, d.posisi, d.jenis, d.spek, d.kap, d.cat
FROM kendaraan k CROSS JOIN (VALUES
  ('Depan','Open Differential',
   'Isuzu Hypoid Gear Oil API GL-5 80W-90','0.7 L',
   'Khusus varian 4WD (Hi-Shift / Shift-on-the-Fly)'),
  ('Belakang','Open Differential',
   'Isuzu Hypoid Gear Oil API GL-5 80W-90','1.8 L',
   'RWD bias — aktif selalu'),
  ('Transfer Case','Part-time 4WD (2H/4H/4L)',
   'ATF Dexron III / Isuzu Transfer Oil','0.8 L',
   'Shift saat kecepatan rendah untuk 4L; H4 bisa saat berjalan')
) d(posisi,jenis,spek,kap,cat)
WHERE k.merek='Isuzu' AND k.model='D-Max';

-- MU-X — 4WD (berbagi platform D-Max)
INSERT INTO kendaraan_differential
  (kendaraan_id, posisi, jenis, spesifikasi_oli, kapasitas_oli, catatan)
SELECT k.id, d.posisi, d.jenis, d.spek, d.kap, d.cat
FROM kendaraan k CROSS JOIN (VALUES
  ('Depan','Open Differential',
   'Isuzu Hypoid Gear Oil API GL-5 80W-90','0.7 L',
   'Khusus varian 4WD'),
  ('Belakang','Open Differential',
   'Isuzu Hypoid Gear Oil API GL-5 80W-90','1.8 L',
   'RWD bias'),
  ('Transfer Case','Part-time 4WD (2H/4H/4L)',
   'ATF Dexron III','0.8 L',
   'Shift-on-the-fly untuk H4; stop dulu untuk L4')
) d(posisi,jenis,spek,kap,cat)
WHERE k.merek='Isuzu' AND k.model='MU-X';

-- ═══════════════════════════════════════════════════════════
-- MAZDA
-- ═══════════════════════════════════════════════════════════

-- BT-50 — 4WD (platform sama dg D-Max gen sebelumnya)
INSERT INTO kendaraan_differential
  (kendaraan_id, posisi, jenis, spesifikasi_oli, kapasitas_oli, catatan)
SELECT k.id, d.posisi, d.jenis, d.spek, d.kap, d.cat
FROM kendaraan k CROSS JOIN (VALUES
  ('Depan','Open Differential',
   'API GL-5 80W-90','0.7 L',
   'Khusus varian 4WD'),
  ('Belakang','Open Differential',
   'API GL-5 80W-90','1.8 L',
   'RWD bias'),
  ('Transfer Case','Part-time 4WD (2H/4H/4L)',
   'Mazda ATF M-III / Dexron III','0.8 L',
   'Shift-on-the-fly untuk H4')
) d(posisi,jenis,spek,kap,cat)
WHERE k.merek='Mazda' AND k.model='BT-50';

-- CX-5 — AWD (varian AWD; i-ACTIV AWD)
INSERT INTO kendaraan_differential
  (kendaraan_id, posisi, jenis, spesifikasi_oli, kapasitas_oli, catatan)
SELECT k.id, d.posisi, d.jenis, d.spek, d.kap, d.cat
FROM kendaraan k CROSS JOIN (VALUES
  ('Belakang','Electronic Coupling (i-ACTIV AWD)',
   'Mazda Genuine AWD Fluid / ATF FZ','0.35 L',
   'Khusus varian AWD — kopling elektro-hidraulik otomatis')
) d(posisi,jenis,spek,kap,cat)
WHERE k.merek='Mazda' AND k.model='CX-5';

-- CX-8 — AWD (i-ACTIV AWD)
INSERT INTO kendaraan_differential
  (kendaraan_id, posisi, jenis, spesifikasi_oli, kapasitas_oli, catatan)
SELECT k.id, d.posisi, d.jenis, d.spek, d.kap, d.cat
FROM kendaraan k CROSS JOIN (VALUES
  ('Belakang','Electronic Coupling (i-ACTIV AWD)',
   'Mazda Genuine AWD Fluid / ATF FZ','0.35 L',
   'Standar AWD pada CX-8 di Indonesia')
) d(posisi,jenis,spek,kap,cat)
WHERE k.merek='Mazda' AND k.model='CX-8';

-- ═══════════════════════════════════════════════════════════
-- HYUNDAI
-- ═══════════════════════════════════════════════════════════

-- H-1 / Staria — RWD
INSERT INTO kendaraan_differential
  (kendaraan_id, posisi, jenis, spesifikasi_oli, kapasitas_oli, catatan)
SELECT k.id, d.posisi, d.jenis, d.spek, d.kap, d.cat
FROM kendaraan k CROSS JOIN (VALUES
  ('Belakang','Open Differential',
   'Hypoid Gear Oil API GL-5 80W-90','1.5 L',
   'Penggerak belakang (RWD) — H-1 Starex, H-1 Travel, Staria')
) d(posisi,jenis,spek,kap,cat)
WHERE k.merek='Hyundai' AND k.model LIKE 'H-1%';

-- Santa Fe — AWD (HTRAC)
INSERT INTO kendaraan_differential
  (kendaraan_id, posisi, jenis, spesifikasi_oli, kapasitas_oli, catatan)
SELECT k.id, d.posisi, d.jenis, d.spek, d.kap, d.cat
FROM kendaraan k CROSS JOIN (VALUES
  ('Belakang','Electronic HTRAC AWD Coupling',
   'Hyundai/Kia HTRAC Coupling Fluid (ATF SP-IV compatible)','0.4 L',
   'Khusus varian AWD — kopling kopling elektro-hidraulik HTRAC; servis setiap 60.000 km')
) d(posisi,jenis,spek,kap,cat)
WHERE k.merek='Hyundai' AND k.model='Santa Fe';

-- Tucson — AWD (HTRAC, beberapa varian)
INSERT INTO kendaraan_differential
  (kendaraan_id, posisi, jenis, spesifikasi_oli, kapasitas_oli, catatan)
SELECT k.id, d.posisi, d.jenis, d.spek, d.kap, d.cat
FROM kendaraan k CROSS JOIN (VALUES
  ('Belakang','Electronic HTRAC AWD Coupling',
   'Hyundai/Kia HTRAC Coupling Fluid (ATF SP-IV compatible)','0.4 L',
   'Khusus varian AWD — kopling belakang elektro-hidraulik')
) d(posisi,jenis,spek,kap,cat)
WHERE k.merek='Hyundai' AND k.model='Tucson';

-- Palisade — AWD (HTRAC)
INSERT INTO kendaraan_differential
  (kendaraan_id, posisi, jenis, spesifikasi_oli, kapasitas_oli, catatan)
SELECT k.id, d.posisi, d.jenis, d.spek, d.kap, d.cat
FROM kendaraan k CROSS JOIN (VALUES
  ('Belakang','Electronic HTRAC AWD Coupling',
   'Hyundai/Kia HTRAC Coupling Fluid (ATF SP-IV compatible)','0.4 L',
   'Standar AWD pada semua Palisade di Indonesia')
) d(posisi,jenis,spek,kap,cat)
WHERE k.merek='Hyundai' AND k.model='Palisade';

-- Creta — AWD (varian tertentu)
INSERT INTO kendaraan_differential
  (kendaraan_id, posisi, jenis, spesifikasi_oli, kapasitas_oli, catatan)
SELECT k.id, d.posisi, d.jenis, d.spek, d.kap, d.cat
FROM kendaraan k CROSS JOIN (VALUES
  ('Belakang','Electronic Coupling AWD',
   'Hyundai/Kia AWD Coupling Fluid (ATF SP-IV)','0.35 L',
   'Khusus varian AWD (tersedia di Indonesia sejak 2023)')
) d(posisi,jenis,spek,kap,cat)
WHERE k.merek='Hyundai' AND k.model='Creta';

-- ═══════════════════════════════════════════════════════════
-- KIA
-- ═══════════════════════════════════════════════════════════

-- Sportage — AWD (HTRAC)
INSERT INTO kendaraan_differential
  (kendaraan_id, posisi, jenis, spesifikasi_oli, kapasitas_oli, catatan)
SELECT k.id, d.posisi, d.jenis, d.spek, d.kap, d.cat
FROM kendaraan k CROSS JOIN (VALUES
  ('Belakang','Electronic HTRAC AWD Coupling',
   'Hyundai/Kia HTRAC Coupling Fluid (ATF SP-IV compatible)','0.4 L',
   'Khusus varian AWD')
) d(posisi,jenis,spek,kap,cat)
WHERE k.merek='Kia' AND k.model='Sportage';

-- Seltos — AWD (varian tertentu)
INSERT INTO kendaraan_differential
  (kendaraan_id, posisi, jenis, spesifikasi_oli, kapasitas_oli, catatan)
SELECT k.id, d.posisi, d.jenis, d.spek, d.kap, d.cat
FROM kendaraan k CROSS JOIN (VALUES
  ('Belakang','Electronic Coupling AWD',
   'Hyundai/Kia AWD Coupling Fluid (ATF SP-IV)','0.35 L',
   'Khusus varian AWD')
) d(posisi,jenis,spek,kap,cat)
WHERE k.merek='Kia' AND k.model='Seltos';

-- ═══════════════════════════════════════════════════════════
-- WULING
-- ═══════════════════════════════════════════════════════════

-- Confero — RWD
INSERT INTO kendaraan_differential
  (kendaraan_id, posisi, jenis, spesifikasi_oli, kapasitas_oli, catatan)
SELECT k.id, d.posisi, d.jenis, d.spek, d.kap, d.cat
FROM kendaraan k CROSS JOIN (VALUES
  ('Belakang','Open Differential',
   'Hypoid Gear Oil API GL-5 80W-90 / SAE 90','1.0 L',
   'Penggerak belakang (RWD) — platform body-on-frame')
) d(posisi,jenis,spek,kap,cat)
WHERE k.merek='Wuling' AND k.model='Confero';

-- ═══════════════════════════════════════════════════════════
-- MERCEDES-BENZ
-- ═══════════════════════════════════════════════════════════

-- C-Class W203/W204 — RWD
INSERT INTO kendaraan_differential
  (kendaraan_id, posisi, jenis, spesifikasi_oli, kapasitas_oli, catatan)
SELECT k.id, d.posisi, d.jenis, d.spek, d.kap, d.cat
FROM kendaraan k CROSS JOIN (VALUES
  ('Belakang','Open Differential / LSD (AMG & Sport)',
   'MB 235.0 / API GL-5 Synthetic 75W-90','1.0 L',
   'Penggerak belakang (RWD); AMG dan Sport pack: LSD mekanis')
) d(posisi,jenis,spek,kap,cat)
WHERE k.merek='Mercedes-Benz' AND k.model='C-Class (W203/W204)';

-- C-Class W205/W206 — RWD
INSERT INTO kendaraan_differential
  (kendaraan_id, posisi, jenis, spesifikasi_oli, kapasitas_oli, catatan)
SELECT k.id, d.posisi, d.jenis, d.spek, d.kap, d.cat
FROM kendaraan k CROSS JOIN (VALUES
  ('Belakang','Open Differential / AMG Electronic LSD',
   'MB 235.8 / API GL-5 Synthetic 75W-90','0.8 L',
   'C63 AMG: Active Rear Axle Steering + E-LSD; standar: open diff')
) d(posisi,jenis,spek,kap,cat)
WHERE k.merek='Mercedes-Benz' AND k.model='C-Class (W205/W206)';

-- E-Class W211/W212 — RWD
INSERT INTO kendaraan_differential
  (kendaraan_id, posisi, jenis, spesifikasi_oli, kapasitas_oli, catatan)
SELECT k.id, d.posisi, d.jenis, d.spek, d.kap, d.cat
FROM kendaraan k CROSS JOIN (VALUES
  ('Belakang','Open Differential / LSD (63 AMG)',
   'MB 235.0 / API GL-5 Synthetic 75W-90','1.0 L',
   'Penggerak belakang (RWD); E63 AMG: LSD mekanis')
) d(posisi,jenis,spek,kap,cat)
WHERE k.merek='Mercedes-Benz' AND k.model='E-Class (W211/W212)';

-- E-Class W213 — RWD
INSERT INTO kendaraan_differential
  (kendaraan_id, posisi, jenis, spesifikasi_oli, kapasitas_oli, catatan)
SELECT k.id, d.posisi, d.jenis, d.spek, d.kap, d.cat
FROM kendaraan k CROSS JOIN (VALUES
  ('Belakang','Open Differential / Electronic LSD (AMG)',
   'MB 235.8 / API GL-5 Fully Synthetic 75W-90','0.8 L',
   'Penggerak belakang (RWD); 4MATIC opsional')
) d(posisi,jenis,spek,kap,cat)
WHERE k.merek='Mercedes-Benz' AND k.model='E-Class (W213)';

-- GLC — RWD + 4MATIC (standar di Indonesia)
INSERT INTO kendaraan_differential
  (kendaraan_id, posisi, jenis, spesifikasi_oli, kapasitas_oli, catatan)
SELECT k.id, d.posisi, d.jenis, d.spek, d.kap, d.cat
FROM kendaraan k CROSS JOIN (VALUES
  ('Belakang','Open Differential',
   'MB 235.8 / API GL-5 Fully Synthetic 75W-90','0.8 L',
   '4MATIC AWD standar; gardan belakang selalu aktif'),
  ('Transfer Case','4MATIC AWD (Electronic Multi-plate)',
   'MB 236.1 ATF Synthetic','0.5 L',
   'Transfer kopling elektrohidraulik; distribusi torsi 45:55 F:R default')
) d(posisi,jenis,spek,kap,cat)
WHERE k.merek='Mercedes-Benz' AND k.model='GLC';

-- S-Class (W221/W222/W223) — RWD / 4MATIC
INSERT INTO kendaraan_differential
  (kendaraan_id, posisi, jenis, spesifikasi_oli, kapasitas_oli, catatan)
SELECT k.id, d.posisi, d.jenis, d.spek, d.kap, d.cat
FROM kendaraan k CROSS JOIN (VALUES
  ('Belakang','Active Differential (Electronic LSD)',
   'MB 235.0 / MB 235.8 Synthetic','1.0 L',
   'S65/63 AMG: Active Rear Axle Steering + E-LSD; standar RWD di Indonesia')
) d(posisi,jenis,spek,kap,cat)
WHERE k.merek='Mercedes-Benz' AND k.model LIKE 'S-Class%';

-- ═══════════════════════════════════════════════════════════
-- BMW
-- ═══════════════════════════════════════════════════════════

-- 3 Series E90/E46 — RWD
INSERT INTO kendaraan_differential
  (kendaraan_id, posisi, jenis, spesifikasi_oli, kapasitas_oli, catatan)
SELECT k.id, d.posisi, d.jenis, d.spek, d.kap, d.cat
FROM kendaraan k CROSS JOIN (VALUES
  ('Belakang','Open Differential / LSD (M Sport)',
   'BMW Differential Fluid SAF-XO 75W-90 (PN 83 22 0 309 031)','0.85 L',
   'Penggerak belakang (RWD); M3: Mechanical LSD Drexler')
) d(posisi,jenis,spek,kap,cat)
WHERE k.merek='BMW' AND k.model='3 Series (E90/E46)';

-- 3 Series F30/G20 — RWD
INSERT INTO kendaraan_differential
  (kendaraan_id, posisi, jenis, spesifikasi_oli, kapasitas_oli, catatan)
SELECT k.id, d.posisi, d.jenis, d.spek, d.kap, d.cat
FROM kendaraan k CROSS JOIN (VALUES
  ('Belakang','Open Differential / Electronic LSD (M340i)',
   'BMW Differential Fluid SAF-XO 75W-90','0.85 L',
   'Penggerak belakang (RWD); M3: Active M Differential (E-LSD)')
) d(posisi,jenis,spek,kap,cat)
WHERE k.merek='BMW' AND k.model='3 Series (F30/G20)';

-- 5 Series F10/G30 — RWD
INSERT INTO kendaraan_differential
  (kendaraan_id, posisi, jenis, spesifikasi_oli, kapasitas_oli, catatan)
SELECT k.id, d.posisi, d.jenis, d.spek, d.kap, d.cat
FROM kendaraan k CROSS JOIN (VALUES
  ('Belakang','Open Differential / Active Differential (xDrive)',
   'BMW Differential Fluid SAF-XO 75W-90','1.0 L',
   'RWD (520i/530i); M5: Active M Differential')
) d(posisi,jenis,spek,kap,cat)
WHERE k.merek='BMW' AND k.model='5 Series (F10/G30)';

-- X1 — xDrive AWD
INSERT INTO kendaraan_differential
  (kendaraan_id, posisi, jenis, spesifikasi_oli, kapasitas_oli, catatan)
SELECT k.id, d.posisi, d.jenis, d.spek, d.kap, d.cat
FROM kendaraan k CROSS JOIN (VALUES
  ('Belakang','Electronic Rear Axle Coupling (ATC/ARC)',
   'BMW ATC/ARC Coupling Fluid','0.5 L',
   'xDrive AWD — rear coupling elektrohidraulik otomatis'),
  ('Transfer Case','xDrive Transfer Box (ATC)',
   'BMW ATC Transfer Fluid','0.8 L',
   'Distribusi torsi depan-belakang via clutch pack elektronik')
) d(posisi,jenis,spek,kap,cat)
WHERE k.merek='BMW' AND k.model='X1';

-- X3 — xDrive AWD
INSERT INTO kendaraan_differential
  (kendaraan_id, posisi, jenis, spesifikasi_oli, kapasitas_oli, catatan)
SELECT k.id, d.posisi, d.jenis, d.spek, d.kap, d.cat
FROM kendaraan k CROSS JOIN (VALUES
  ('Belakang','Open Differential / Electronic LSD (M40i)',
   'BMW Differential Fluid SAF-XO 75W-90','0.85 L',
   'xDrive AWD; gardan belakang selalu ada'),
  ('Transfer Case','xDrive Transfer Box (ATC 350/400)',
   'BMW ATC Transfer Fluid','0.8 L',
   'Split torsi F:R otomatis; mode Terrain sesuai kondisi')
) d(posisi,jenis,spek,kap,cat)
WHERE k.merek='BMW' AND k.model='X3';

-- X5 — xDrive AWD
INSERT INTO kendaraan_differential
  (kendaraan_id, posisi, jenis, spesifikasi_oli, kapasitas_oli, catatan)
SELECT k.id, d.posisi, d.jenis, d.spek, d.kap, d.cat
FROM kendaraan k CROSS JOIN (VALUES
  ('Belakang','Open Differential / Active Differential (xDrive)',
   'BMW Differential Fluid SAF-XO 75W-90','1.0 L',
   'xDrive AWD; X5 M: Active M Differential'),
  ('Transfer Case','xDrive Transfer Box (ATC 700)',
   'BMW ATC Transfer Fluid','0.8 L',
   'Distribusi torsi F:R otomatis; mode Off-road tersedia')
) d(posisi,jenis,spek,kap,cat)
WHERE k.merek='BMW' AND k.model='X5';

-- ═══════════════════════════════════════════════════════════
-- AUDI
-- ═══════════════════════════════════════════════════════════

-- A4 — quattro AWD (varian quattro)
INSERT INTO kendaraan_differential
  (kendaraan_id, posisi, jenis, spesifikasi_oli, kapasitas_oli, catatan)
SELECT k.id, d.posisi, d.jenis, d.spek, d.kap, d.cat
FROM kendaraan k CROSS JOIN (VALUES
  ('Belakang','Open Differential / Sport Differential (S4)',
   'VW/Audi G 052 145 A2 API GL-5 75W-90','0.8 L',
   'Khusus varian quattro; S4/RS4: sport/active differential'),
  ('Transfer Case','Torsen quattro / Ultra quattro AWD',
   'VW/Audi Transfer Fluid / DSG oil (bersama transmisi)','1.7 L (bersama DCT)',
   'Center Torsen diff terintegrasi di transmisi S tronic/tiptronic')
) d(posisi,jenis,spek,kap,cat)
WHERE k.merek='Audi' AND k.model='A4';

-- A6 — quattro AWD
INSERT INTO kendaraan_differential
  (kendaraan_id, posisi, jenis, spesifikasi_oli, kapasitas_oli, catatan)
SELECT k.id, d.posisi, d.jenis, d.spek, d.kap, d.cat
FROM kendaraan k CROSS JOIN (VALUES
  ('Belakang','Open Differential / Sport Differential (S6)',
   'VW/Audi G 052 145 A2 API GL-5 75W-90','0.9 L',
   'Khusus varian quattro'),
  ('Transfer Case','Torsen / Zentraldifferenzial quattro',
   'VW/Audi Transfer Fluid (terintegrasi transmisi)','1.8 L (bersama AT)',
   'Torsen center diff; default split 40:60 F:R')
) d(posisi,jenis,spek,kap,cat)
WHERE k.merek='Audi' AND k.model='A6';

-- Q5 — quattro AWD (standar)
INSERT INTO kendaraan_differential
  (kendaraan_id, posisi, jenis, spesifikasi_oli, kapasitas_oli, catatan)
SELECT k.id, d.posisi, d.jenis, d.spek, d.kap, d.cat
FROM kendaraan k CROSS JOIN (VALUES
  ('Belakang','Open Differential / Sport Differential (SQ5)',
   'VW/Audi G 052 145 A2 API GL-5 75W-90','0.9 L',
   'Standar quattro pada Q5; SQ5: active sport differential'),
  ('Transfer Case','Ultra quattro / Torsen Center Diff',
   'VW/Audi Transfer Fluid G 052 173','0.6 L',
   'Kopling Haldex 5 (Q5 gen 1) atau Ultra quattro (gen 2) — full-time AWD')
) d(posisi,jenis,spek,kap,cat)
WHERE k.merek='Audi' AND k.model='Q5';

-- ═══════════════════════════════════════════════════════════
-- VOLKSWAGEN
-- ═══════════════════════════════════════════════════════════

-- Tiguan — 4Motion AWD (varian 4Motion)
INSERT INTO kendaraan_differential
  (kendaraan_id, posisi, jenis, spesifikasi_oli, kapasitas_oli, catatan)
SELECT k.id, d.posisi, d.jenis, d.spek, d.kap, d.cat
FROM kendaraan k CROSS JOIN (VALUES
  ('Belakang','Electronic Haldex Coupling + Open Differential',
   'Haldex Oil G 052 175 A2 (coupling) + VW G 052 145 (diff)','0.2 L + 0.8 L',
   'Khusus varian 4Motion; Haldex Gen 4/5 — servis setiap 40.000 km')
) d(posisi,jenis,spek,kap,cat)
WHERE k.merek='Volkswagen' AND k.model='Tiguan';

-- ═══════════════════════════════════════════════════════════
-- VOLVO
-- ═══════════════════════════════════════════════════════════

-- XC60 — AWD (Haldex / Torque Vectoring)
INSERT INTO kendaraan_differential
  (kendaraan_id, posisi, jenis, spesifikasi_oli, kapasitas_oli, catatan)
SELECT k.id, d.posisi, d.jenis, d.spek, d.kap, d.cat
FROM kendaraan k CROSS JOIN (VALUES
  ('Belakang','Haldex Electronic Coupling + Open Differential',
   'Volvo Haldex Oil (Genuine Part 31259688) + Gear Oil 75W-90','0.24 L + 0.8 L',
   'AWD standar XC60; servis Haldex setiap 30.000–50.000 km'),
  ('Transfer Case','Haldex AWD Coupling Unit',
   'Volvo Haldex Gen 4 Fluid','0.24 L',
   'Pengiriman torsi ke belakang otomatis via Haldex clutch pack')
) d(posisi,jenis,spek,kap,cat)
WHERE k.merek='Volvo' AND k.model='XC60';

-- XC90 — AWD (Haldex + Torque Vectoring)
INSERT INTO kendaraan_differential
  (kendaraan_id, posisi, jenis, spesifikasi_oli, kapasitas_oli, catatan)
SELECT k.id, d.posisi, d.jenis, d.spek, d.kap, d.cat
FROM kendaraan k CROSS JOIN (VALUES
  ('Belakang','Haldex Electronic Coupling + Open Differential',
   'Volvo Haldex Oil (Genuine) + Gear Oil API GL-5 75W-90','0.24 L + 0.9 L',
   'AWD standar XC90; servis Haldex setiap 30.000–50.000 km')
) d(posisi,jenis,spek,kap,cat)
WHERE k.merek='Volvo' AND k.model='XC90';

-- ═══════════════════════════════════════════════════════════
-- JEEP
-- ═══════════════════════════════════════════════════════════

-- Wrangler — Solid Axle 4WD (paling otentik 4WD)
INSERT INTO kendaraan_differential
  (kendaraan_id, posisi, jenis, spesifikasi_oli, kapasitas_oli, catatan)
SELECT k.id, d.posisi, d.jenis, d.spek, d.kap, d.cat
FROM kendaraan k CROSS JOIN (VALUES
  ('Depan','Open Differential / Locking (Rubicon)',
   'Mopar Hypoid Gear Lubricant API GL-5 80W-90 / 75W-90','1.1 L',
   'Dana 30 (Sport/Sahara) — open; Dana 44 (Rubicon) — Air Locker locking diff'),
  ('Belakang','Open Differential / Locking (Rubicon)',
   'Mopar Hypoid Gear Lubricant API GL-5 80W-90 / 75W-90','1.5 L',
   'Dana 35 (JK Sport) / Dana 44 (JK Sahara/Rubicon) / Dana 44 (JL); Rubicon: Air Locker'),
  ('Transfer Case','Part-time 4WD (Command-Trac / Rock-Trac)',
   'Mopar ATF+4 / NV241OR Transfer Case Fluid','0.9 L',
   'Command-Trac (NV241): 2H-4H-N-4L; Rock-Trac (Rubicon): low-range 4:1')
) d(posisi,jenis,spek,kap,cat)
WHERE k.merek='Jeep' AND k.model='Wrangler';

-- Grand Cherokee — 4WD / AWD Quadra-Trac
INSERT INTO kendaraan_differential
  (kendaraan_id, posisi, jenis, spesifikasi_oli, kapasitas_oli, catatan)
SELECT k.id, d.posisi, d.jenis, d.spek, d.kap, d.cat
FROM kendaraan k CROSS JOIN (VALUES
  ('Depan','Open Differential',
   'Mopar Gear Oil API GL-5 75W-140 Synthetic','0.9 L',
   'Quadra-Trac I/II/Drive AWD; varian SRT & Trackhawk: Quadra-Trac III'),
  ('Belakang','Open Differential / Rear LSD (SRT)',
   'Mopar Gear Oil API GL-5 75W-140 Synthetic','1.4 L',
   'SRT & Trackhawk: Electronic LSD belakang'),
  ('Transfer Case','Quadra-Trac / Quadra-Drive II AWD',
   'Mopar ATF+4 Transfer Case Fluid','1.1 L',
   'Full-time AWD; Quadra-Drive II: Electronic limited-slip axles')
) d(posisi,jenis,spek,kap,cat)
WHERE k.merek='Jeep' AND k.model='Grand Cherokee';

-- Cherokee — AWD Jeep Active Drive
INSERT INTO kendaraan_differential
  (kendaraan_id, posisi, jenis, spesifikasi_oli, kapasitas_oli, catatan)
SELECT k.id, d.posisi, d.jenis, d.spek, d.kap, d.cat
FROM kendaraan k CROSS JOIN (VALUES
  ('Belakang','Electronic Rear Axle Disconnect + Coupling (PTU)',
   'Mopar ATF+4 / Rear Axle Fluid API GL-5 80W-90','0.5 L',
   'Jeep Active Drive — rear axle disconnect untuk efisiensi; re-engage otomatis saat diperlukan')
) d(posisi,jenis,spek,kap,cat)
WHERE k.merek='Jeep' AND k.model='Cherokee';

-- Renegade / Compass — 4WD (Active Drive)
INSERT INTO kendaraan_differential
  (kendaraan_id, posisi, jenis, spesifikasi_oli, kapasitas_oli, catatan)
SELECT k.id, d.posisi, d.jenis, d.spek, d.kap, d.cat
FROM kendaraan k CROSS JOIN (VALUES
  ('Belakang','Electronic Coupling AWD (Active Drive)',
   'Mopar ATF+4 / Rear Coupling Fluid API GL-5','0.4 L',
   'Khusus varian 4WD; PTU (Power Transfer Unit) depan + rear coupling belakang')
) d(posisi,jenis,spek,kap,cat)
WHERE k.merek='Jeep' AND k.model LIKE 'Renegade%';

-- ═══════════════════════════════════════════════════════════
-- FORD
-- ═══════════════════════════════════════════════════════════

-- Ranger — 4WD (body-on-frame T6/P703)
INSERT INTO kendaraan_differential
  (kendaraan_id, posisi, jenis, spesifikasi_oli, kapasitas_oli, catatan)
SELECT k.id, d.posisi, d.jenis, d.spek, d.kap, d.cat
FROM kendaraan k CROSS JOIN (VALUES
  ('Depan','Open Differential',
   'Ford Motorcraft Hypoid Gear Fluid XL-12 / API GL-5 75W-90','0.75 L',
   'Khusus varian 4WD; Shift-on-the-Fly H4'),
  ('Belakang','Open Differential / Locking (Wildtrak/Raptor)',
   'Ford Motorcraft Hypoid Gear Fluid XL-12 / API GL-5 75W-90','1.4 L',
   'Raptor: Electronic Locking Rear Differential; Wildtrak: open'),
  ('Transfer Case','Part-time 4WD (Electronic Shift-On-Fly)',
   'Ford Motorcraft Mercon LV ATF','0.9 L',
   '2H-4H saat jalan; 4L saat berhenti; Raptor: BorgWarner transfer case')
) d(posisi,jenis,spek,kap,cat)
WHERE k.merek='Ford' AND k.model='Ranger';

-- Everest — 4WD (platform Ranger)
INSERT INTO kendaraan_differential
  (kendaraan_id, posisi, jenis, spesifikasi_oli, kapasitas_oli, catatan)
SELECT k.id, d.posisi, d.jenis, d.spek, d.kap, d.cat
FROM kendaraan k CROSS JOIN (VALUES
  ('Depan','Open Differential',
   'Ford Motorcraft Hypoid Gear Fluid XL-12 / API GL-5 75W-90','0.75 L',
   'Khusus varian 4WD (Trend & Titanium)'),
  ('Belakang','Open Differential',
   'Ford Motorcraft Hypoid Gear Fluid XL-12 / API GL-5 75W-90','1.4 L',
   'RWD bias'),
  ('Transfer Case','Part-time 4WD (Electronic Shift-On-Fly)',
   'Ford Motorcraft Mercon LV ATF','0.9 L',
   '2H-4H-4L; posisi yang sama dg Ranger')
) d(posisi,jenis,spek,kap,cat)
WHERE k.merek='Ford' AND k.model='Everest';

-- ═══════════════════════════════════════════════════════════
-- CHEVROLET
-- ═══════════════════════════════════════════════════════════

-- Trailblazer / Colorado — 4WD
INSERT INTO kendaraan_differential
  (kendaraan_id, posisi, jenis, spesifikasi_oli, kapasitas_oli, catatan)
SELECT k.id, d.posisi, d.jenis, d.spek, d.kap, d.cat
FROM kendaraan k CROSS JOIN (VALUES
  ('Depan','Open Differential',
   'GM Axle Fluid Genuine (API GL-5 75W-90 Synthetic)','0.7 L',
   'Khusus varian 4WD; shift elektronik Z71/4x4'),
  ('Belakang','Open Differential',
   'GM Axle Fluid Genuine (API GL-5 75W-90 Synthetic)','1.8 L',
   'Semua varian Trailblazer/Colorado (RWD bias)'),
  ('Transfer Case','AutoTrac / Automatic 4WD',
   'GM Dexron VI ATF','1.0 L',
   'AutoTrac: 2H-4H Auto-4H-4L; Auto mode distribusi otomatis')
) d(posisi,jenis,spek,kap,cat)
WHERE k.merek='Chevrolet' AND k.model LIKE 'Trailblazer%';

-- Captiva — AWD (berbasis GM Theta platform)
INSERT INTO kendaraan_differential
  (kendaraan_id, posisi, jenis, spesifikasi_oli, kapasitas_oli, catatan)
SELECT k.id, d.posisi, d.jenis, d.spek, d.kap, d.cat
FROM kendaraan k CROSS JOIN (VALUES
  ('Belakang','Electronic Viscous Coupling AWD',
   'GM AWD Coupling Fluid (ATF compatible)','0.35 L',
   'Khusus varian AWD; kopling Haldex Gen 2 — otomatis')
) d(posisi,jenis,spek,kap,cat)
WHERE k.merek='Chevrolet' AND k.model='Captiva';

-- ═══════════════════════════════════════════════════════════
-- VERIFIKASI
-- ═══════════════════════════════════════════════════════════
SELECT
  COUNT(*) AS total_differential_records,
  COUNT(DISTINCT kendaraan_id) AS total_kendaraan_dengan_differential
FROM kendaraan_differential;
