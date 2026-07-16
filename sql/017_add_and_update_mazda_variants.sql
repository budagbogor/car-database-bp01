-- =============================================================================
-- 017_add_and_update_mazda_variants.sql
-- Memperbarui penamaan Mazda dengan kode sasis & mesin, serta menambah model baru
-- =============================================================================

-- ── 1. UPDATE MODEL MAZDA YANG SUDAH ADA ─────────────────────────────────────
UPDATE kendaraan 
SET model = 'Mazda 2 (DJ) 1.5L' 
WHERE merek = 'Mazda' AND model = 'Mazda 2';

UPDATE kendaraan 
SET model = 'Mazda 3 (BM/BP) 1.5L / 2.0L' 
WHERE merek = 'Mazda' AND model = 'Mazda 3';

UPDATE kendaraan 
SET model = 'CX-5 (KE/KF) 2.0L / 2.5L' 
WHERE merek = 'Mazda' AND model = 'CX-5';

UPDATE kendaraan 
SET model = 'CX-3 (DK) 1.5L / 2.0L' 
WHERE merek = 'Mazda' AND model = 'CX-3';

UPDATE kendaraan 
SET model = 'CX-8 (KG) 2.5L' 
WHERE merek = 'Mazda' AND model = 'CX-8';

UPDATE kendaraan 
SET model = 'Mazda 6 (GJ/GL) 2.5L' 
WHERE merek = 'Mazda' AND model = 'Mazda 6';

UPDATE kendaraan 
SET model = 'BT-50 (UP/UR/TF) 2.2L / 3.0L Diesel' 
WHERE merek = 'Mazda' AND model = 'BT-50';

-- ── 2. INSERT MODEL MAZDA BARU ───────────────────────────────────────────────
INSERT INTO kendaraan
  (merek, model, tahun, kategori, bahan_bakar, kode_mesin, kapasitas_cc,
   tipe_transmisi, detail_transmisi, viskositas_oli, standar_oli, kapasitas_oli,
   oli_transmisi, tipe_power_steering, fluida_power_steering)
VALUES
-- CX-30
('Mazda','CX-30 (DM) 2.0L','2020–sekarang','SUV Compact / Crossover','bensin','PE-VPS SkyActiv-G','1998 cc','AT','6-speed Torque Converter (SkyActiv-Drive)','0W-20','API SN/SP, ILSAC GF-5/GF-6','4.2 L','ATF Mazda FZ','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),

-- CX-9
('Mazda','CX-9 (TC) 2.5L Turbo','2018–2023','SUV Premium 7-seat','bensin','PY-VPTS SkyActiv-G Turbo','2488 cc','AT','6-speed Torque Converter (SkyActiv-Drive)','5W-30 / 0W-20','API SN/SP, ILSAC GF-5/GF-6','5.0 L','ATF Mazda FZ / ATF FW','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),

-- CX-60
('Mazda','CX-60 (KH) 3.3L Turbo MHEV','2023–sekarang','SUV Premium','bensin','e-SkyActiv G 3.3 Inline-6 Turbo','3283 cc','AT','8-speed Multi-plate Clutch (tanpa torque converter)','0W-20','API SP / ILSAC GF-6A','6.5 L','Mazda Original Oil ATF-A7','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),

-- Biante
('Mazda','Biante (CC) 2.0L','2012–2018','MPV Boxy','bensin','PE-VPS SkyActiv-G / LF-VD MZR','1998 cc','AT','6-speed SkyActiv-Drive / 5-speed AT','0W-20 / 5W-30','API SN, ILSAC GF-5','4.2 L','ATF Mazda FZ (SkyActiv) / ATF M-V (MZR)','Elektrik (EPS) / Hidrolik (MZR awal)','Tidak menggunakan fluida / ATF M-III (jika hidrolik)'),

-- MX-5 (Miata) Manual
('Mazda','MX-5 Miata (ND) 2.0L','2015–sekarang','Sports Roadster','bensin','PE-VPS SkyActiv-G','1998 cc','Manual','6-speed MT (SkyActiv-MT)','0W-20','API SN/SP, ILSAC GF-5/GF-6','4.3 L','Manual: API GL-4, SAE 75W-90 (Mazda Long Life Gear Oil IS)','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),

-- MX-5 (Miata) Matic
('Mazda','MX-5 Miata (ND) 2.0L','2015–sekarang','Sports Roadster','bensin','PE-VPS SkyActiv-G','1998 cc','AT','6-speed Torque Converter (SkyActiv-Drive)','0W-20','API SN/SP, ILSAC GF-5/GF-6','4.3 L','ATF Mazda FZ','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)');
