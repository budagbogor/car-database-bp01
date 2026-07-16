-- =============================================================================
-- 016_add_and_update_bmw_variants.sql
-- Memperbarui varian model BMW yang sudah ada & menambah seri baru
-- =============================================================================

-- ── 1. UPDATE MODEL BMW YANG SUDAH ADA ───────────────────────────────────────
UPDATE kendaraan 
SET model = '3 Series E90/E46 (318i, 320i, 325i, 330i)' 
WHERE merek = 'BMW' AND model = '3 Series (E90/E46)';

UPDATE kendaraan 
SET model = '3 Series F30/G20 (320i, 328i, 330i)' 
WHERE merek = 'BMW' AND model = '3 Series (F30/G20)';

UPDATE kendaraan 
SET model = '5 Series F10/G30 (520i, 523i, 528i, 530i)' 
WHERE merek = 'BMW' AND model = '5 Series (F10/G30)';

UPDATE kendaraan 
SET model = 'X1 E84/F48/U11 (sDrive18i, sDrive20i)' 
WHERE merek = 'BMW' AND model = 'X1';

UPDATE kendaraan 
SET model = 'X3 F25/G01 (sDrive20i, xDrive20i)' 
WHERE merek = 'BMW' AND model = 'X3';

UPDATE kendaraan 
SET model = 'X5 E70/F15/G05 (xDrive35i, xDrive40i)' 
WHERE merek = 'BMW' AND model = 'X5';

-- ── 2. INSERT MODEL BMW BARU ─────────────────────────────────────────────────
INSERT INTO kendaraan
  (merek, model, tahun, kategori, bahan_bakar, kode_mesin, kapasitas_cc,
   tipe_transmisi, detail_transmisi, viskositas_oli, standar_oli, kapasitas_oli,
   oli_transmisi, tipe_power_steering, fluida_power_steering)
VALUES
-- 1 Series & 2 Series
('BMW','1 Series F20/F40 (118i)','2011–sekarang','Hatchback Premium','bensin','B38 Turbo 3-Silinder','1499 cc','AT','7-speed DCT / 8-speed Steptronic','5W-30 / 0W-20','BMW LL-01 / LL-04','4.25 L','ATF ZF Lifeguard / DCT Fluid','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('BMW','2 Series F22/F44/U06 (218i)','2014–sekarang','Coupe / Gran Coupe','bensin','B38 Turbo 3-Silinder','1499 cc','AT','7-speed DCT / 8-speed Steptronic','5W-30 / 0W-20','BMW LL-01 / LL-04','4.25 L','ATF ZF Lifeguard / DCT Fluid','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),

-- 4 Series
('BMW','4 Series F32/G22 (420i, 430i)','2013–sekarang','Coupe / Gran Coupe','bensin','B48 Turbo','1998 cc','AT','8-speed Torque Converter (ZF 8HP)','0W-20 / 5W-30','BMW LL-01 / LL-04','5.2 L','ATF ZF Lifeguard 8','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),

-- 7 Series
('BMW','7 Series F01/G11/G70 (730Li, 740Li)','2008–sekarang','Sedan Premium Flagship','bensin','B48 Turbo / B58 Turbo','1998–2998 cc','AT','8-speed Torque Converter (ZF 8HP)','0W-20 / 5W-30','BMW LL-01 / LL-04','5.2–6.5 L','ATF ZF Lifeguard 8','Elektrik (EPS) / Hidrolik (F01 awal)','Tidak menggunakan fluida (sebagian F01 menggunakan CHF 11S)'),

-- X4, X6, X7 (SUV / SAC)
('BMW','X4 F26/G02 (xDrive20i, xDrive30i)','2014–sekarang','SUV Coupe (SAC)','bensin','B48 Turbo','1998 cc','AT','8-speed Torque Converter (ZF 8HP)','0W-20 / 5W-30','BMW LL-01 / LL-04','5.2 L','ATF ZF Lifeguard 8','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('BMW','X6 E71/F16/G06 (xDrive35i, xDrive40i)','2008–sekarang','SUV Coupe Premium','bensin','N55 / B58 Turbo','2979–2998 cc','AT','8-speed Torque Converter (ZF 8HP)','0W-20 / 5W-30','BMW LL-01 / LL-04','6.5 L','ATF ZF Lifeguard 8','Hidrolik (E71) / EPS (F16/G06)','Pentosin CHF 11S (E71) — EPS tanpa fluida (F16/G06)'),
('BMW','X7 G07 (xDrive40i)','2019–sekarang','SUV Premium 7-seat','bensin','B58 Turbo','2998 cc','AT','8-speed Torque Converter (ZF 8HP)','0W-20 / 5W-30','BMW LL-01 / LL-04','6.5 L','ATF ZF Lifeguard 8','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)');
