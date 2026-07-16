-- =============================================================================
-- 014_add_mercedes_models.sql
-- Menambahkan line-up model Mercedes-Benz yang beredar di Indonesia
-- =============================================================================

INSERT INTO kendaraan
  (merek, model, tahun, kategori, bahan_bakar, kode_mesin, kapasitas_cc,
   tipe_transmisi, detail_transmisi, viskositas_oli, standar_oli, kapasitas_oli,
   oli_transmisi, tipe_power_steering, fluida_power_steering)
VALUES

-- ── COMPACT CARS (A, B, CLA) ─────────────────────────────────────────────────
('Mercedes-Benz','A-Class (W176/W177)','2013–sekarang','Hatchback/Sedan','bensin','M270 / M282 Turbo','1332–1595 cc','AT','7-speed Dual Clutch (7G-DCT)','5W-30 / 0W-20','MB 229.5 / MB 229.71','5.1–5.8 L','MB 236.21 / MB 236.22 (DCT Fluid)','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Mercedes-Benz','B-Class (W245)','2005–2011','Compact MPV','bensin','M266','1498–1699 cc','CVT','Autotronic CVT','5W-40 / 5W-30','MB 229.3 / MB 229.5','5.0 L','MB 236.20 (CVT Fluid)','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Mercedes-Benz','B-Class (W246)','2012–2019','Compact MPV','bensin','M270 Turbo','1595 cc','AT','7-speed Dual Clutch (7G-DCT)','5W-40 / 5W-30','MB 229.5','5.8 L','MB 236.21 (DCT Fluid)','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Mercedes-Benz','CLA-Class (C117/C118)','2013–sekarang','Sedan Coupe','bensin','M270 / M282 Turbo','1332–1595 cc','AT','7-speed Dual Clutch (7G-DCT)','5W-30 / 0W-20','MB 229.5 / MB 229.71','5.1–5.8 L','MB 236.21 / MB 236.22 (DCT Fluid)','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),

-- ── COMPACT SUV (GLA, GLB) ───────────────────────────────────────────────────
('Mercedes-Benz','GLA-Class (X156/H247)','2014–sekarang','Crossover SUV','bensin','M270 / M282 Turbo','1332–1595 cc','AT','7-speed Dual Clutch (7G-DCT)','5W-30 / 0W-20','MB 229.5 / MB 229.71','5.1–5.8 L','MB 236.21 / MB 236.22 (DCT Fluid)','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Mercedes-Benz','GLB-Class (X247)','2020–sekarang','SUV 7-seat','bensin','M282 Turbo','1332 cc','AT','7-speed Dual Clutch (7G-DCT)','0W-20 / 5W-30','MB 229.71 / MB 229.52','5.1 L','MB 236.22 (DCT Fluid)','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),

-- ── LUXURY SUV (GLE, GLS, G-Class) ───────────────────────────────────────────
('Mercedes-Benz','GLE-Class / M-Class (W166/V167)','2012–sekarang','SUV Premium','bensin','M276 V6 / M256 I6 Turbo','2996–3498 cc','AT','7G-Tronic / 9G-Tronic','0W-20 / 5W-30','MB 229.5 / MB 229.52 / MB 229.71','6.5–8.5 L','ATF MB 236.15 / MB 236.17','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Mercedes-Benz','GLE-Class (W166/V167)','2012–sekarang','SUV Premium','diesel','OM651 / OM656','2143–2925 cc','AT','9G-Tronic','5W-30','MB 229.51 / MB 229.52','6.5–8.5 L','ATF MB 236.17','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Mercedes-Benz','GLS-Class / GL-Class (X166/X167)','2013–sekarang','SUV Premium 7-seat','bensin','M278 V8 / M256 I6 Turbo','2999–4663 cc','AT','9G-Tronic','0W-20 / 5W-30','MB 229.5 / MB 229.71','8.5–9.5 L','ATF MB 236.17','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Mercedes-Benz','G-Class (W463)','2012–sekarang','SUV Premium / Offroad','bensin','M176 V8 Biturbo / M273 V8','3982–5461 cc','AT','7G-Tronic / 9G-Tronic','5W-40 / 0W-40','MB 229.5','8.5–9.5 L','ATF MB 236.15 / MB 236.17','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),

-- ── VAN PREMIUM (V-Class / Vito) ─────────────────────────────────────────────
('Mercedes-Benz','V-Class / Vito (W447)','2014–sekarang','MPV Premium / Van','bensin','M274 Turbo','1991 cc','AT','7G-Tronic / 9G-Tronic','5W-30 / 5W-40','MB 229.5','6.5 L','ATF MB 236.15 / MB 236.17','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Mercedes-Benz','V-Class / Vito (W447)','2014–sekarang','MPV Premium / Van','diesel','OM651 / OM654','1950–2143 cc','AT','7G-Tronic / 9G-Tronic','5W-30','MB 229.51 / MB 229.52','6.5–9.0 L','ATF MB 236.15 / MB 236.17','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)');
