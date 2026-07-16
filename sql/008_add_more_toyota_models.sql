-- =============================================================================
-- 008_add_more_toyota_models.sql
-- Menambahkan model Toyota yang kurang (Alphard, Voxy, Raize, Yaris Cross, Corolla Cross, C-HR)
-- =============================================================================

INSERT INTO kendaraan
  (merek, model, tahun, kategori, bahan_bakar, kode_mesin, kapasitas_cc,
   tipe_transmisi, detail_transmisi, viskositas_oli, standar_oli, kapasitas_oli,
   oli_transmisi, tipe_power_steering, fluida_power_steering)
VALUES
-- Alphard / Vellfire
('Toyota','Alphard / Vellfire (Gen 2)','2008–2015','MPV Premium','bensin','2AZ-FE / 2GR-FE','2362–3456 cc','AT','CVT / 6-speed AT','5W-30 / 10W-40','API SN, ILSAC GF-5','4.3–6.1 L','Toyota CVT Fluid TC / ATF WS','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Toyota','Alphard / Vellfire (Gen 3)','2015–2023','MPV Premium','bensin','2AR-FE / 2GR-FKS','2494–3456 cc','AT','CVT / 8-speed AT','0W-20 / 5W-30','API SN/SP, ILSAC GF-5/GF-6A','4.4–6.1 L','Toyota CVT Fluid FE / ATF WS','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Toyota','Alphard / Vellfire (Gen 4)','2023–sekarang','MPV Premium','bensin','2AR-FE / A25A-FXS (Hybrid)','2494–2487 cc','CVT','CVT / e-CVT','0W-16 / 0W-20','API SP, ILSAC GF-6A','4.4–4.5 L','Toyota CVT Fluid FE / Hybrid Transaxle Fluid','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),

-- Voxy / NAV1
('Toyota','NAV1','2012–2017','MPV','bensin','3ZR-FAE','1986 cc','CVT','CVT','5W-30 / 10W-40','API SN, ILSAC GF-5','4.2 L','Toyota CVT Fluid TC / FE','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Toyota','Voxy (Gen 3)','2017–2022','MPV','bensin','3ZR-FAE','1986 cc','CVT','CVT','0W-20 / 5W-30','API SN, ILSAC GF-5','4.2 L','Toyota CVT Fluid FE','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Toyota','Voxy (Gen 4)','2022–sekarang','MPV','bensin','M20A-FKS','1986 cc','CVT','Direct Shift-CVT','0W-16 / 0W-20','API SP, ILSAC GF-6A','4.3 L','Toyota CVT Fluid FE','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),

-- Raize
('Toyota','Raize (1.0 Turbo)','2021–sekarang','SUV Compact','bensin','1KR-VET','998 cc','CVT','D-CVT','0W-20 / 5W-30','API SN/SP, ILSAC GF-6A','2.9 L','Toyota CVT Fluid FE','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Toyota','Raize (1.2)','2021–sekarang','SUV Compact','bensin','WA-VE','1198 cc','CVT','D-CVT','0W-20 / 5W-30','API SN/SP, ILSAC GF-6A','3.2 L','Toyota CVT Fluid FE','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),

-- Yaris Cross
('Toyota','Yaris Cross','2023–sekarang','SUV Compact','bensin','2NR-VE','1496 cc','CVT','CVT','0W-20 / 5W-30','API SN/SP, ILSAC GF-6A','3.5 L','Toyota CVT Fluid FE','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Toyota','Yaris Cross (Hybrid)','2023–sekarang','SUV Compact','bensin','2NR-VEX','1496 cc','CVT','e-CVT','0W-16 / 0W-20','API SP, ILSAC GF-6A','3.3 L','Hybrid Transaxle Fluid / CVT FE','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),

-- Corolla Cross
('Toyota','Corolla Cross','2020–sekarang','Crossover','bensin','2ZR-FBE','1798 cc','CVT','CVT','0W-20 / 5W-30','API SN/SP, ILSAC GF-6A','4.2 L','Toyota CVT Fluid FE','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Toyota','Corolla Cross (Hybrid)','2020–sekarang','Crossover','bensin','2ZR-FXE','1798 cc','CVT','e-CVT','0W-20','API SN/SP, ILSAC GF-6A','4.2 L','Hybrid Transaxle Fluid / CVT FE','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),

-- C-HR
('Toyota','C-HR','2018–sekarang','Crossover','bensin','2ZR-FBE','1798 cc','CVT','CVT','0W-20 / 5W-30','API SN, ILSAC GF-5','4.2 L','Toyota CVT Fluid FE','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Toyota','C-HR (Hybrid)','2019–sekarang','Crossover','bensin','2ZR-FXE','1798 cc','CVT','e-CVT','0W-20','API SN, ILSAC GF-5','4.2 L','Hybrid Transaxle Fluid / CVT FE','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)');
