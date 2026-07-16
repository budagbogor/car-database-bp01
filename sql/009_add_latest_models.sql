-- =============================================================================
-- 009_add_latest_models.sql
-- Menambahkan model EV, Hybrid, dan Merek-Merek Populer Baru
-- =============================================================================

INSERT INTO kendaraan
  (merek, model, tahun, kategori, bahan_bakar, kode_mesin, kapasitas_cc,
   tipe_transmisi, detail_transmisi, viskositas_oli, standar_oli, kapasitas_oli,
   oli_transmisi, tipe_power_steering, fluida_power_steering)
VALUES

-- ── WULING ───────────────────────────────────────────────────────────────────
('Wuling','Air EV','2022–sekarang','City Car','listrik','Motor Listrik (30 kW)','—','AT','Single Reduction Gear','Tidak menggunakan oli mesin','—','—','Reduction Gear Fluid (ATF khusus), ±1 L','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Wuling','BinguoEV','2023–sekarang','Hatchback','listrik','Motor Listrik (31.9/50 kW)','—','AT','Single Reduction Gear','Tidak menggunakan oli mesin','—','—','Reduction Gear Fluid (ATF khusus), ±1 L','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Wuling','Cloud EV','2024–sekarang','Hatchback','listrik','Motor Listrik (100 kW)','—','AT','Single Reduction Gear','Tidak menggunakan oli mesin','—','—','Reduction Gear Fluid (ATF khusus), ±1 L','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Wuling','Alvez','2023–sekarang','SUV Compact','bensin','LAR','1485 cc','CVT','CVT','0W-20 / 5W-30','API SN, ILSAC GF-5','4.0 L','Wuling CVT Fluid','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),

-- ── HYUNDAI ──────────────────────────────────────────────────────────────────
('Hyundai','Ioniq 5','2022–sekarang','Crossover','listrik','Permanent Magnet Sync Motor','—','AT','Single Speed Reduction Gear','Tidak menggunakan oli mesin','—','—','Hyundai/Kia EV Reduction Gear Fluid','Elektrik (MDPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Hyundai','Ioniq 6','2023–sekarang','Sedan','listrik','Permanent Magnet Sync Motor','—','AT','Single Speed Reduction Gear','Tidak menggunakan oli mesin','—','—','Hyundai/Kia EV Reduction Gear Fluid','Elektrik (MDPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Hyundai','Stargazer X','2023–sekarang','Crossover','bensin','Smartstream G1.5 MPI','1497 cc','CVT','IVT (Intelligent Variable Trans)','0W-20','API SN Plus / SP','3.8 L','Hyundai IVT Fluid','Elektrik (MDPS)','Tidak menggunakan fluida (sistem elektrik)'),

-- ── MITSUBISHI ───────────────────────────────────────────────────────────────
('Mitsubishi','Xforce','2023–sekarang','SUV Compact','bensin','4A91','1499 cc','CVT','CVT','0W-20','API SN/SP, ILSAC GF-6','4.0 L','Mitsubishi Motors DiaQueen CVT Fluid J4','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),

-- ── NISSAN ───────────────────────────────────────────────────────────────────
('Nissan','Kicks e-Power','2020–sekarang','SUV Compact','hybrid','HR12DE + Motor Listrik','1198 cc','AT','Single Speed Reduction Gear','0W-20','API SN/SP, ILSAC GF-6','3.2 L','Nissan Matic S (Reduction Gear)','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Nissan','Magnite','2020–sekarang','SUV Compact','bensin','HRA0 Turbo','999 cc','CVT','X-Tronic CVT','0W-20 / 5W-30','API SN','3.4 L','Nissan NS-3 CVT Fluid','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),

-- ── SUZUKI ───────────────────────────────────────────────────────────────────
('Suzuki','S-Presso','2022–sekarang','City Car','bensin','K10B / K10C','998 cc','AMT','AGS (Auto Gear Shift)','0W-20','API SN','2.9 L','Suzuki Gear Oil 75W (Manual / AGS aktuator fluid)','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Suzuki','Grand Vitara (Gen 4)','2023–sekarang','SUV Compact','hybrid','K15C Dual Jet Smart Hybrid','1462 cc','AT','6-speed Torque Converter','0W-16 / 0W-20','API SP','3.1 L','Suzuki ATF AW-1','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),

-- ── MAZDA ────────────────────────────────────────────────────────────────────
('Mazda','CX-30','2020–sekarang','Crossover','bensin','Skyactiv-G 2.0','1998 cc','AT','6-speed Skyactiv-Drive','0W-20','API SN/SP','4.2 L','Mazda ATF FZ','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Mazda','CX-60','2023–sekarang','SUV Premium','hybrid','e-Skyactiv G 3.3T MHEV','3283 cc','AT','8-speed Skyactiv-Drive (tanpa Torque Converter)','0W-20','API SP','5.5 L','Mazda Original ATF','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),

-- ── KIA ──────────────────────────────────────────────────────────────────────
('Kia','EV6','2022–sekarang','Crossover','listrik','Permanent Magnet Sync Motor','—','AT','Single Speed Reduction Gear','Tidak menggunakan oli mesin','—','—','Hyundai/Kia EV Reduction Gear Fluid','Elektrik (MDPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Kia','EV9','2023–sekarang','SUV Premium','listrik','Permanent Magnet Sync Motor','—','AT','Single Speed Reduction Gear','Tidak menggunakan oli mesin','—','—','Hyundai/Kia EV Reduction Gear Fluid','Elektrik (MDPS)','Tidak menggunakan fluida (sistem elektrik)'),

-- ── CHERY ────────────────────────────────────────────────────────────────────
('Chery','Omoda 5','2023–sekarang','SUV Compact','bensin','SQRE4T15C Turbo','1498 cc','CVT','CVT 9-speed virtual','5W-30','API SN / SP','4.5 L','Chery CVT Fluid','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Chery','Omoda E5','2024–sekarang','SUV Compact','listrik','Motor Listrik (150 kW)','—','AT','Single Reduction Gear','Tidak menggunakan oli mesin','—','—','Reduction Gear Fluid (ATF khusus)','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Chery','Tiggo 7 Pro','2022–sekarang','SUV','bensin','SQRE4T15C Turbo','1498 cc','CVT','CVT 9-speed virtual','5W-30','API SN / SP','4.5 L','Chery CVT Fluid','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Chery','Tiggo 8 Pro','2022–sekarang','SUV Premium 7-seat','bensin','SQRF4J20 Turbo','1998 cc','AT','7-speed DCT (Dual Clutch)','5W-30 / 5W-40','API SN / SP','4.8 L','Chery DCT Fluid','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),

-- ── MG (MORRIS GARAGES) ──────────────────────────────────────────────────────
('MG','ZS','2020–sekarang','SUV Compact','bensin','15S4C','1498 cc','CVT','CVT 8-speed virtual','5W-30','API SN','4.0 L','MG CVT Fluid','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('MG','HS','2020–sekarang','SUV','bensin','15E4E Turbo','1490 cc','AT','7-speed Twin Clutch Sportronic','5W-30','API SN','4.5 L','MG DCT Fluid','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('MG','4 EV','2023–sekarang','Hatchback','listrik','Motor Listrik (125 kW)','—','AT','Single Reduction Gear','Tidak menggunakan oli mesin','—','—','Reduction Gear Fluid','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('MG','5 GT','2022–sekarang','Sedan','bensin','15S4C','1498 cc','CVT','CVT 8-speed virtual','5W-30','API SN','4.0 L','MG CVT Fluid','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),

-- ── BYD ──────────────────────────────────────────────────────────────────────
('BYD','Atto 3','2024–sekarang','SUV Compact','listrik','Motor Listrik (150 kW)','—','AT','Single Reduction Gear','Tidak menggunakan oli mesin','—','—','BYD EV Reduction Gear Fluid, ±0.9 L','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('BYD','Dolphin','2024–sekarang','Hatchback','listrik','Motor Listrik (70/150 kW)','—','AT','Single Reduction Gear','Tidak menggunakan oli mesin','—','—','BYD EV Reduction Gear Fluid, ±0.9 L','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('BYD','Seal','2024–sekarang','Sedan','listrik','Motor Listrik (230/390 kW)','—','AT','Single Reduction Gear','Tidak menggunakan oli mesin','—','—','BYD EV Reduction Gear Fluid','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),

-- ── LEXUS ────────────────────────────────────────────────────────────────────
('Lexus','RX350h (Gen 5)','2023–sekarang','SUV Premium','hybrid','A25A-FXS','2487 cc','CVT','e-CVT','0W-16 / 0W-20','API SP, ILSAC GF-6A','4.5 L','Toyota Hybrid Transaxle Fluid / ATF WS','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Lexus','NX350h (Gen 2)','2022–sekarang','SUV Premium','hybrid','A25A-FXS','2487 cc','CVT','e-CVT','0W-16 / 0W-20','API SP, ILSAC GF-6A','4.5 L','Toyota Hybrid Transaxle Fluid / ATF WS','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Lexus','LX600','2022–sekarang','SUV Premium','bensin','V35A-FTS V6 Twin-Turbo','3444 cc','AT','10-speed Direct Shift-10AT','0W-20','API SP, ILSAC GF-6A','7.3 L','ATF WS','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)');
