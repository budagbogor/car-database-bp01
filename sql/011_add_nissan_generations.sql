-- =============================================================================
-- 011_add_nissan_generations.sql
-- Melengkapi generasi Nissan (X-Trail, Serena, March, Elgrand) dan Datsun
-- =============================================================================

INSERT INTO kendaraan
  (merek, model, tahun, kategori, bahan_bakar, kode_mesin, kapasitas_cc,
   tipe_transmisi, detail_transmisi, viskositas_oli, standar_oli, kapasitas_oli,
   oli_transmisi, tipe_power_steering, fluida_power_steering)
VALUES

-- ── NISSAN X-TRAIL ───────────────────────────────────────────────────────────
('Nissan','X-Trail (T30)','2001–2008','SUV','bensin','QR20DE / QR25DE','1998–2488 cc','AT','4-speed Torque Converter','5W-30 / 10W-40','API SL / SN','3.9–4.2 L','Nissan Matic-D','Hidrolik','PSF Nissan Genuine / Dexron III setara'),
('Nissan','X-Trail (T30)','2001–2008','SUV','bensin','QR20DE / QR25DE','1998–2488 cc','Manual','5-speed MT','5W-30 / 10W-40','API SL / SN','3.9–4.2 L','Manual: API GL-4, SAE 75W-90','Hidrolik','PSF Nissan Genuine / Dexron III setara'),
('Nissan','X-Trail (T31)','2009–2013','SUV','bensin','MR20DE / QR25DE','1997–2488 cc','CVT','Xtronic CVT','5W-30','API SN / SP','4.2–4.8 L','Nissan CVTF NS-2','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Nissan','X-Trail (T31)','2009–2013','SUV','bensin','MR20DE','1997 cc','Manual','6-speed MT','5W-30','API SN / SP','4.2 L','Manual: API GL-4, SAE 75W-90','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Nissan','X-Trail (T33) e-Power','2023–sekarang','SUV','hybrid','KR15DDT Turbo + Motor Listrik','1497 cc','AT','Single Speed Reduction Gear','0W-20','API SP, ILSAC GF-6A','4.1 L','Nissan Matic-S / EV Reduction Gear Fluid','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),

-- ── NISSAN SERENA ────────────────────────────────────────────────────────────
('Nissan','Serena (C24)','2004–2012','MPV','bensin','QR20DE','1998 cc','AT','4-speed Torque Converter','5W-30 / 10W-40','API SL / SN','3.9–4.1 L','Nissan Matic-D','Hidrolik','PSF Nissan Genuine / Dexron III setara'),
('Nissan','Serena (C26)','2013–2017','MPV','bensin','MR20DD','1997 cc','CVT','Xtronic CVT','0W-20','API SN / SP, ILSAC GF-5','4.4 L','Nissan CVTF NS-3','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Nissan','Serena (C28) e-Power','2024–sekarang','MPV Premium','hybrid','HR14DDe + Motor Listrik','1433 cc','AT','Single Speed Reduction Gear','0W-20','API SP, ILSAC GF-6A','3.5 L','Nissan Matic-S / EV Reduction Gear Fluid','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),

-- ── NISSAN MARCH ─────────────────────────────────────────────────────────────
('Nissan','March (1.2L)','2010–2018','City Car','bensin','HR12DE','1198 cc','AT','4-speed Torque Converter (Konvensional)','5W-30','API SN / SL','3.0 L','Nissan Matic-D','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Nissan','March (1.2L)','2010–2018','City Car','bensin','HR12DE','1198 cc','Manual','5-speed MT','5W-30','API SN / SL','3.0 L','Manual: API GL-4, SAE 75W-90','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),

-- ── NISSAN ELGRAND ───────────────────────────────────────────────────────────
('Nissan','Elgrand (E52)','2010–sekarang','MPV Premium','bensin','QR25DE / VQ35DE','2488–3498 cc','CVT','Xtronic CVT','5W-30','API SN / SP','4.8–5.2 L','Nissan CVTF NS-2 / NS-3','Elektrik (EPS) / Hidrolik','Tergantung varian (EHPS / EPS)'),

-- ── DATSUN (NISSAN GROUP) ────────────────────────────────────────────────────
('Datsun','GO & GO+ Panca','2014–2020','LCGC Hatchback/MPV','bensin','HR12DE','1198 cc','Manual','5-speed MT','5W-30','API SN / SL','3.0 L','Manual: API GL-4, SAE 75W-90','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Datsun','GO & GO+ Panca','2018–2020','LCGC Hatchback/MPV','bensin','HR12DE','1198 cc','CVT','Xtronic CVT','5W-30','API SN / SL','3.0 L','Nissan CVTF NS-3','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)');
