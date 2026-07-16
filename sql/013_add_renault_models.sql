-- =============================================================================
-- 013_add_renault_models.sql
-- Menambahkan data lengkap merek Renault (Koleos, Duster, Kwid, Triber, dll)
-- =============================================================================

INSERT INTO kendaraan
  (merek, model, tahun, kategori, bahan_bakar, kode_mesin, kapasitas_cc,
   tipe_transmisi, detail_transmisi, viskositas_oli, standar_oli, kapasitas_oli,
   oli_transmisi, tipe_power_steering, fluida_power_steering)
VALUES

-- ── RENAULT KOLEOS ───────────────────────────────────────────────────────────
('Renault','Koleos (Gen 1)','2008–2015','SUV','bensin','TR25 (sebasis QR25DE)','2488 cc','CVT','X-Tronic CVT','5W-30','API SN','4.2–4.5 L','Nissan CVTF NS-2 / Renault Elf CVT','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Renault','Koleos (Gen 2)','2016–sekarang','SUV','bensin','QR25DE','2488 cc','CVT','X-Tronic CVT','5W-30','API SN / SP','4.5–4.8 L','Nissan CVTF NS-3 / Renault Elf CVT','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),

-- ── RENAULT DUSTER ───────────────────────────────────────────────────────────
('Renault','Duster','2013–2019','SUV','diesel','1.5L dCi K9K','1461 cc','Manual','6-speed MT','5W-30','ACEA C3 / C4','4.5 L','Manual: API GL-4, SAE 75W-80','Hidrolik','Renaultmatic D2 / Dexron III'),

-- ── RENAULT KIGER, KWID, TRIBER ──────────────────────────────────────────────
('Renault','Kiger (1.0L)','2021–sekarang','SUV Compact','bensin','1.0L B4D / HRA0 (Turbo)','999 cc','Manual','5-speed MT','5W-30 / 10W-40','API SN','3.0 L','Manual: API GL-4, SAE 75W-80','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Renault','Kiger (1.0L Turbo)','2021–sekarang','SUV Compact','bensin','1.0L Turbo HRA0','999 cc','CVT','X-Tronic CVT','5W-30','API SN','3.0 L','CVTF NS-3 / Elf CVT','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Renault','Kwid','2016–sekarang','City Car / Crossover','bensin','1.0L B4D','999 cc','Manual','5-speed MT','5W-30 / 10W-40','API SN','3.0 L','Manual: API GL-4, SAE 75W-80','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Renault','Kwid','2019–sekarang','City Car / Crossover','bensin','1.0L B4D','999 cc','AMT','5-speed AMT (Automated Manual)','5W-30 / 10W-40','API SN','3.0 L','Manual: API GL-4, SAE 75W-80 (untuk girboks)','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Renault','Triber','2019–sekarang','MPV 7-seat','bensin','1.0L BR10','999 cc','Manual','5-speed MT','5W-30 / 10W-40','API SN','3.0 L','Manual: API GL-4, SAE 75W-80','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Renault','Triber','2020–sekarang','MPV 7-seat','bensin','1.0L BR10','999 cc','AMT','5-speed AMT','5W-30 / 10W-40','API SN','3.0 L','Manual: API GL-4, SAE 75W-80 (untuk girboks)','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),

-- ── RENAULT CAPTUR ───────────────────────────────────────────────────────────
('Renault','Captur','2015–2019','Crossover','bensin','1.2L TCe H5F Turbo','1197 cc','AT','6-speed EDC (Efficient Dual Clutch)','5W-40','ACEA A3/B4, API SN','4.6 L','Elf Renaultmatic DWM / DCT Fluid','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),

-- ── RENAULT R.S. (RENAULT SPORT) ─────────────────────────────────────────────
('Renault','Megane R.S. (Gen 3)','2010–2016','Hatchback (Performa)','bensin','2.0L F4Rt Turbo','1998 cc','Manual','6-speed MT','5W-40','ACEA A3/B4, API SN','5.4 L','Manual: API GL-4/GL-5, SAE 75W-80','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Renault','Clio R.S.','2014–2018','Hatchback (Performa)','bensin','1.6L M5M Turbo','1618 cc','AT','6-speed EDC (Efficient Dual Clutch)','5W-40','ACEA A3/B4, API SN','4.3 L','Elf Renaultmatic DWM / DCT Fluid','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)');
