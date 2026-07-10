-- =============================================================================
-- 002_seed_data.sql
-- Migrasi data dari aplikasi lama (~210 entri) ke tabel kendaraan
-- Jalankan SETELAH 001_create_table.sql
-- =============================================================================

-- Hapus data lama jika ada (aman untuk re-run)
TRUNCATE TABLE kendaraan CASCADE;

INSERT INTO kendaraan
  (merek, model, tahun, kategori, bahan_bakar, kode_mesin, kapasitas_cc,
   tipe_transmisi, detail_transmisi, viskositas_oli, standar_oli, kapasitas_oli,
   oli_transmisi, tipe_power_steering, fluida_power_steering)
VALUES

-- ── TOYOTA ────────────────────────────────────────────────────────────────────
('Toyota','Avanza','2003–2005 (Gen 1 awal)','MPV','bensin','K3-DE','1298 cc','Manual','5-speed MT','5W-30 / 10W-40','API SL/SN, ILSAC GF-5','3.0–3.5 L','Manual: SAE 75W-90 API GL-4','Hidrolik','ATF Toyota Type T-IV / Dexron II-III setara'),
('Toyota','Avanza','2006–2011 (Gen 1 VVT-i)','MPV','bensin','K3-VE / 3SZ-VE','1298–1495 cc','AT','4-speed Torque Converter','5W-30 / 10W-40','API SL/SN, ILSAC GF-5','3.5–4.0 L','ATF T-IV atau setara Dexron III, ±4.9 L','Hidrolik','ATF Toyota Type T-IV / Dexron II-III setara'),
('Toyota','Avanza','2011–2015 (Gen 2)','MPV','bensin','K3-VE / 3SZ-VE','1298–1495 cc','Manual','5-speed MT','5W-30 / 10W-40','API SL/SN, ILSAC GF-5','3.5–4.0 L','Manual: SAE 75W-90 API GL-4','Hidrolik','ATF Toyota Type T-IV / Dexron II-III setara'),
('Toyota','Avanza / Veloz','2015–2021 (Gen 2 facelift, 2NR-VE)','MPV','bensin','1NR-VE / 2NR-VE','1329–1496 cc','AT','4-speed Torque Converter','5W-30 (0W-20 utk unit baru)','API SN, ILSAC GF-5','3.5 L','ATF T-IV, ±4.9 L','Hidrolik','ATF Toyota Type T-IV / Dexron II-III setara'),
('Toyota','Avanza / Veloz FWD','2021–sekarang (Gen 3, DNGA)','MPV','bensin','1NR-VE / 2NR-VE Dual VVT-i','1329–1496 cc','CVT','CVT dgn split gear','0W-20 / 5W-30','API SN/SP, ILSAC GF-5/GF-6A','3.5 L','Toyota CVT Fluid FE, ±6.0 L','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Toyota','Calya','2016–sekarang','LCGC MPV','bensin','3NR-VE','1197 cc','Manual','5-speed MT','5W-30 / 10W-40','API SL/SN, ILSAC GF-5','3.2–3.5 L','Manual: SAE 75W-90 API GL-4','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Toyota','Calya','2016–sekarang','LCGC MPV','bensin','3NR-VE','1197 cc','AT','4-speed Torque Converter','0W-20 / 5W-30','API SN/SP, ILSAC GF-5/GF-6A','3.5 L','ATF T-IV','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Toyota','Agya','2013–2022 (Gen 1)','LCGC Hatchback','bensin','1KR-VE','998 cc','Manual','5-speed MT','5W-30 / 10W-40','API SL/SN, ILSAC GF-5','2.7 L','Manual: SAE 75W-90 API GL-4','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Toyota','Agya','2022–sekarang (Gen 2, 1.2 G)','LCGC Hatchback','bensin','3NR-VE','1197 cc','AT','4-speed Torque Converter','0W-20 / 5W-30','API SN/SP, ILSAC GF-5/GF-6A','3.5 L','ATF T-IV','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Toyota','Rush','2018–sekarang','SUV','bensin','1NR-VE / 2NR-VE','1329–1496 cc','Manual','5-speed MT','5W-30','API SN, ILSAC GF-5','2.7–3.0 L','Manual: SAE 75W-90 API GL-4','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Toyota','Rush','2018–sekarang','SUV','bensin','2NR-VE','1496 cc','AT','4-speed Torque Converter','5W-30','API SN, ILSAC GF-5','3.2–3.5 L','ATF T-IV','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Toyota','Kijang Innova (Reborn)','2015–2022','MPV','bensin','1TR-FE','1998 cc','Manual','5-speed MT','5W-30 / API SN','API SL/SN+, ILSAC GF-5','5.6 L','Manual: SAE 75W-90 API GL-4, 2.2 L','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Toyota','Kijang Innova (Reborn)','2015–2022','MPV','diesel','2GD-FTV VNT Intercooler','2393 cc','Manual','5-speed MT','5W-30 / 10W-30','API CF/CF-4, ACEA B3/B4, JASO DL-1','6.6–6.9 L','Manual: SAE 75W-90 API GL-4, 2.2 L','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Toyota','Kijang Innova (Reborn)','2015–2022','MPV','diesel','2GD-FTV VNT Intercooler','2393 cc','AT','6-speed Torque Converter','5W-30 / 10W-30','API CF/CF-4, ACEA B3/B4, JASO DL-1','6.6–6.9 L','ATF WS / T-IV, ±7 L (kuras)','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Toyota','Innova Zenix','2022–sekarang','MPV','bensin','M20A-FKS / hybrid 2ZR-FXE','1987–1798 cc','CVT','e-CVT / Direct Shift-CVT','0W-16 / 0W-20','API SN Plus/SP, ILSAC GF-6A','4.4 L','Toyota CVT Fluid FE / hybrid transaxle fluid','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Toyota','Fortuner','2016–sekarang','SUV','bensin','2TR-FE','2694 cc','Manual','6-speed MT','5W-30','API SL/SN, ILSAC GF-5','6.5 L','Manual: SAE 75W-90 API GL-4','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Toyota','Fortuner','2016–2020','SUV','diesel','2GD-FTV','2393 cc','AT','6-speed Torque Converter','5W-30 / 5W-40','API CF/CF-4, ACEA B3/B4, JASO DL-1','6.6–6.9 L','ATF WS, ±7 L (kuras)','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Toyota','Fortuner (VRZ/GR Sport)','2016–sekarang','SUV','diesel','1GD-FTV VNT','2755 cc','AT','6-speed Torque Converter','5W-30 / 5W-40','API CF/CF-4, ACEA B3/B4/B5, JASO DL-1','7.0–7.5 L','ATF WS, ±7 L (kuras)','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Toyota','Hilux','2015–sekarang','Pickup Double/Single Cabin','diesel','2GD-FTV / 1GD-FTV','2393–2755 cc','Manual','6-speed MT','5W-30 / 10W-40','API CF/CF-4, ACEA B3/B4, JASO DL-1','6.6–7.5 L','Manual: SAE 75W-90 API GL-4/GL-5','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Toyota','Hilux Rangga','2024–sekarang','Pickup','diesel','2GD-FTV','2393 cc','Manual','5-speed MT','5W-30','API CF/CF-4, ACEA B3/B4','6.6–6.9 L','Manual: SAE 75W-90 API GL-4','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Toyota','Vios / Limo','2013–2022','Sedan','bensin','1NR-FE / 2NR-FE','1329–1496 cc','Manual','5-speed MT','0W-20 / 5W-30','API SN, ILSAC GF-5','3.1–3.3 L','Manual: SAE 75W-90 API GL-4','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Toyota','Vios','2013–2022','Sedan','bensin','2NR-FE','1496 cc','CVT','CVT (Super CVT-i)','0W-20 / 5W-30','API SN, ILSAC GF-5','3.1–3.3 L','Toyota CVT Fluid TC / FE','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Toyota','Yaris','2013–sekarang','Hatchback','bensin','1NR-FE / 2NR-FE','1329–1496 cc','CVT','Super CVT-i','0W-20 / 5W-30','API SN, ILSAC GF-5','3.1–3.3 L','Toyota CVT Fluid TC / FE','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Toyota','Sienta','2016–sekarang','Compact MPV','bensin','2NR-FE','1496 cc','CVT','Super CVT-i','0W-20 / 5W-30','API SN, ILSAC GF-5','3.1–3.3 L','Toyota CVT Fluid FE','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Toyota','Corolla Altis','2001–2008 (E120/E130)','Sedan','bensin','1ZZ-FE / 4ZZ-FE','1794–1598 cc','Manual','5-speed MT','10W-40 / 5W-30','API SL/SN, ILSAC GF-3/GF-4','3.4 L','Manual: SAE 75W-90 API GL-4','Hidrolik','ATF Toyota Type T-IV / Dexron II-III setara'),
('Toyota','Corolla Altis','2019–sekarang (E210, TNGA)','Sedan','bensin','2ZR-FAE','1798 cc','CVT','Direct Shift-CVT','0W-20 / 5W-30','API SN/SP, ILSAC GF-5/GF-6A','4.2–4.4 L','Toyota CVT Fluid FE','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Toyota','Camry','2019–sekarang','Sedan','bensin','2AR-FE','2494 cc','AT','8-speed Torque Converter','0W-20 / 5W-30','API SL/SN, ILSAC GF-5','4.4 L','ATF WS','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Toyota','GR Yaris','2021–sekarang','Hot Hatch','bensin','G16E-GTS Turbo','1618 cc','Manual','6-speed MT / iMT','0W-20','API SP, ILSAC GF-6A','4.3 L','Manual: SAE 75W GL-4/5 sintetik','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Toyota','Land Cruiser Prado/300','2008–sekarang','SUV','diesel','1KD-FTV / 1VD-FTV V8','2982–4461 cc','AT','6-speed Torque Converter','5W-30 / 5W-40','API CF/CF-4, ACEA B4, JASO DL-1','9.0–9.3 L','ATF WS','Hidrolik','ATF Toyota Type T-IV / Dexron II-III setara'),
('Toyota','Kijang Innova (Gen 1)','2004–2015','MPV','bensin','1TR-FE','1998 cc','Manual','5-speed MT','10W-40 / 5W-30','API SL/SN','5.6–6.0 L','Manual: SAE 75W-90 API GL-4','Hidrolik','ATF Toyota Type T-IV / Dexron II-III setara'),
('Toyota','Kijang Innova (Gen 1)','2004–2015','MPV','diesel','2KD-FTV','2494 cc','Manual','5-speed MT','10W-40 / 15W-40','API CF/CF-4','6.6–6.9 L','Manual: SAE 75W-90 API GL-4, 2.2 L','Hidrolik','ATF Toyota Type T-IV / Dexron II-III setara'),
('Toyota','Kijang Innova (Gen 1)','2004–2015','MPV','diesel','2KD-FTV','2494 cc','AT','4-speed Torque Converter','10W-40','API CF/CF-4','6.6–6.9 L','ATF T-IV, ±7 L (kuras)','Hidrolik','ATF Toyota Type T-IV / Dexron II-III setara'),
('Toyota','Rush (Gen 1)','2006–2017','SUV','bensin','1TR-FE (dibagi dg Innova)','1998 cc','Manual','5-speed MT','10W-40 / 5W-30','API SL/SN','4.2 L','Manual: SAE 75W-90 API GL-4','Hidrolik','ATF Toyota Type T-IV / Dexron II-III setara'),
('Toyota','Etios Valco','2013–2017','Hatchback','bensin','2NR-FE','1496 cc','Manual','5-speed MT','5W-30 / 10W-40','API SN, ILSAC GF-5','3.2 L','Manual: SAE 75W-90 API GL-4','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Toyota','Yaris Cross','2022–sekarang','SUV Compact','bensin','M15A-FKS / Hybrid','1490–1490 cc','CVT','Direct Shift-CVT / e-CVT','0W-16 / 0W-20','API SN Plus/SP, ILSAC GF-6A','3.4–4.0 L','Toyota CVT Fluid FE','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Toyota','Alphard / Vellfire','2015–sekarang','MPV Premium','bensin','2AR-FE (2.5) / 8AR-FTS Turbo (2.0)','2494–1998 cc','AT','8-speed Torque Converter / CVT','0W-20 / 5W-30','API SN, ILSAC GF-5','5.3–5.7 L','ATF WS','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Toyota','Voxy / Noah (grey market)','2014–sekarang','MPV','bensin','3ZR-FAE','1986 cc','CVT','Super CVT-i','0W-20','API SN, ILSAC GF-5','4.0 L','Toyota CVT Fluid FE','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),

-- ── DAIHATSU ──────────────────────────────────────────────────────────────────
('Daihatsu','Xenia','2004–2011 (Gen 1)','MPV','bensin','EJ-DE / EJ-VE (1.0), K3-DE / K3-VE (1.3)','989–1298 cc','Manual','5-speed MT','5W-30 / 10W-40','API SL/SN, ILSAC GF-5','2.1–2.7 L','Manual: SAE 75W-90 API GL-4','Hidrolik','ATF Dexron II-III setara'),
('Daihatsu','Xenia','2011–2015 (Gen 2)','MPV','bensin','EJ-VE / K3-VE','989–1298 cc','AT','4-speed Torque Converter','5W-30 / 10W-40','API SL/SN, ILSAC GF-5','2.7–3.0 L','ATF T-IV','Hidrolik','ATF Dexron II-III setara'),
('Daihatsu','Xenia FWD','2021–sekarang (Gen 3, DNGA)','MPV','bensin','1NR-VE / 2NR-VE','1329–1496 cc','CVT','CVT dgn split gear','0W-20 / 5W-30','API SN/SP, ILSAC GF-5/GF-6A','3.5 L','Daihatsu CVTF, ±6.0 L','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Daihatsu','Sigra','2016–sekarang','LCGC MPV','bensin','1KR-DE (1.0) / 3NR-VE (1.2)','998–1197 cc','Manual','5-speed MT','10W-30 / 5W-30','API SN, ILSAC GF-5','2.5–2.7 L','Manual: SAE 75W-90 API GL-4','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Daihatsu','Sigra','2016–sekarang','LCGC MPV','bensin','3NR-VE (1.2)','1197 cc','AT','4-speed Torque Converter','0W-20 / 5W-30','API SN/SP, ILSAC GF-5','3.0 L','ATF T-IV','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Daihatsu','Ayla','2013–sekarang','LCGC Hatchback','bensin','1KR-VE (1.0) / 3NR-VE (1.2)','998–1197 cc','Manual','5-speed MT','5W-30 / 10W-30','API SL/SN, ILSAC GF-5','2.7 L','Manual: SAE 75W-90 API GL-4','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Daihatsu','Ayla','2013–sekarang','LCGC Hatchback','bensin','3NR-VE (1.2)','1197 cc','AT','4-speed Torque Converter','0W-20 / 5W-30','API SN/SP, ILSAC GF-5','3.5 L','ATF T-IV','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Daihatsu','Terios','2006–2017','SUV','bensin','K3-VE (1.3) / 3SZ-VE (1.5)','1298–1495 cc','Manual','5-speed MT','5W-30 / 10W-40','API SL/SN, ILSAC GF-5','2.7–3.0 L','Manual: SAE 75W-90 API GL-4','Hidrolik','ATF Dexron II-III setara'),
('Daihatsu','Terios','2006–2017','SUV','bensin','3SZ-VE (1.5)','1495 cc','AT','4-speed Torque Converter','5W-30','API SL/SN, ILSAC GF-5','3.2 L','ATF T-IV','Hidrolik','ATF Dexron II-III setara'),
('Daihatsu','Rocky','2021–sekarang','SUV Compact','bensin','1NR-VE / WA-VEX Turbo (1.2 3-cyl)','1198–1329 cc','CVT','CVT / D-CVT','0W-16 / 0W-20','API SN Plus/SP, ILSAC GF-6A','3.0–3.2 L','Daihatsu CVTF','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Daihatsu','Sirion','2004–2016','Hatchback','bensin','K3-VE','1298 cc','Manual','5-speed MT','5W-30 / 10W-40','API SL/SN, ILSAC GF-5','2.8 L','Manual: SAE 75W-90 API GL-4','Hidrolik','ATF Dexron II-III setara'),
('Daihatsu','Sirion','2004–2016','Hatchback','bensin','K3-VE','1298 cc','AT','4-speed Torque Converter','5W-30','API SL/SN, ILSAC GF-5','3.1 L','ATF T-IV','Hidrolik','ATF Dexron II-III setara'),
('Daihatsu','Gran Max / Luxio','2007–sekarang','Pickup/Minibus','bensin','HC-E / DVVT','1298–1495 cc','Manual','5-speed MT','10W-40 / 5W-30','API SL/SN, ILSAC GF-5','3.7–4.0 L','Manual: SAE 75W-90 API GL-4','Hidrolik','ATF Dexron II-III setara'),
('Daihatsu','Gran Max','2007–sekarang','Pickup/Minibus','diesel','S / DVVT 1.5D','1496 cc','Manual','5-speed MT','10W-40 / 15W-40','API CF, ACEA B3','5.0–5.5 L','Manual: SAE 75W-90 API GL-4','Hidrolik','ATF Dexron II-III setara'),
('Daihatsu','Espass','1994–2005','Minibus/Pickup','bensin','HD-C / HC-C','1000–1300 cc','Manual','5-speed MT','10W-40 / 20W-50','API SF/SG','3.7–4.0 L','Manual: SAE 75W-90 API GL-4','Hidrolik (varian PS) / Manual non-PS (varian dasar)','ATF Dexron II-III setara (bila dilengkapi PS)'),
('Daihatsu','Zebra','1991–2007','Minibus/Pickup','bensin','HD-C','998–1300 cc','Manual','5-speed MT','10W-40 / 20W-50','API SF/SG','3.5–3.8 L','Manual: SAE 75W-90 API GL-4','Manual non-PS (varian dasar) / Hidrolik (varian tertentu)','ATF Dexron II-III setara (bila dilengkapi PS)'),
('Daihatsu','Taruna','1999–2006','SUV','bensin','HD-E / HE-E','1500–1600 cc','Manual','5-speed MT','10W-40','API SG/SL','3.5–4.0 L','Manual: SAE 75W-90 API GL-4','Hidrolik','ATF Dexron II-III setara'),
('Daihatsu','Feroza','1993–2005','SUV Off-road','bensin','HD-C','1600 cc','Manual','5-speed MT','10W-40','API SF/SG','4.0 L','Manual: SAE 75W-90 API GL-4','Hidrolik','ATF Dexron II-III setara'),

-- ── HONDA ─────────────────────────────────────────────────────────────────────
('Honda','Brio Satya','2012–sekarang','LCGC Hatchback','bensin','L12B / L12B3','1199 cc','Manual','5-speed MT','0W-20 / 5W-30','API SN atau lebih tinggi','3.2–3.5 L','Manual: Honda MTF, SAE 75W-85 GL-4','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Honda','Brio (Satya & RS)','2012–sekarang','Hatchback','bensin','L12B / L12B3','1199 cc','CVT','Earth Dreams CVT','0W-20 / 5W-30','API SN, ILSAC GF-5','3.5–3.8 L','Honda ATF-CVT / HCF-2','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Honda','Mobilio','2014–2021','MPV','bensin','L15Z1 i-VTEC','1497 cc','Manual','5-speed MT','0W-20 / 5W-30','API SN','3.4 L','Manual: Honda MTF','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Honda','Mobilio','2014–2021','MPV','bensin','L15Z1 i-VTEC','1497 cc','CVT','Earth Dreams CVT','0W-20 / 5W-30','API SN','3.6 L','Honda ATF-CVT / HCF-2','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Honda','BR-V','2016–sekarang','SUV','bensin','L15Z1 / L15ZF','1497 cc','CVT','Earth Dreams CVT','0W-20 / 5W-30','API SN','3.4–3.6 L','Honda ATF-CVT / HCF-2','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Honda','HR-V','2015–2021 (Gen 1)','SUV','bensin','L15Z1 (1.5) / R18Z1 (1.8)','1497–1799 cc','CVT','Earth Dreams CVT','0W-20 / 5W-30','API SN','3.4–3.8 L','Honda ATF-CVT / HCF-2','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Honda','HR-V','2022–sekarang (Gen 2, RS Turbo)','SUV','bensin','L15BE VTEC Turbo','1498 cc','CVT','Earth Dreams CVT','0W-20','API SN Plus/SP','3.7 L','Honda ATF-CVT / HCF-2','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Honda','CR-V','2012–2017 (Gen 4)','SUV','bensin','R20A9 (2.0) / K24Z (2.4)','1997–2354 cc','AT','5-speed Torque Converter','0W-20 / 5W-30','API SN','4.0–4.2 L','Honda ATF Z1','Hidrolik','Honda PSF-S2 (Power Steering Fluid)'),
('Honda','CR-V','2017–2022 (Gen 5)','SUV','bensin','L15BE VTEC Turbo','1498 cc','CVT','Earth Dreams CVT','0W-20','API SN','3.9 L','Honda ATF-CVT / HCF-2','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Honda','Civic (FB)','2012–2015','Sedan','bensin','R18Z1','1799 cc','Manual','5-speed MT','0W-20 / 5W-30','API SN','3.6 L','Manual: Honda MTF','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Honda','Civic (FC) Turbo','2016–2021','Sedan','bensin','L15B7 VTEC Turbo','1498 cc','CVT','Earth Dreams CVT','0W-20','API SN','3.7 L','Honda ATF-CVT / HCF-2','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Honda','Jazz (GE8)','2008–2013','Hatchback','bensin','L15A7','1497 cc','Manual','5-speed MT','0W-20 / 5W-30','API SN','3.1 L','Manual: Honda MTF','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Honda','Jazz (GE8/GK5)','2008–2020','Hatchback','bensin','L15A7 / L15Z1','1497 cc','CVT','Earth Dreams CVT','0W-20 / 5W-30','API SN','3.3 L','Honda ATF-CVT / HCF-2','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Honda','City (Vtec, GD8)','2003–2008','Sedan','bensin','L13A / L15A','1339–1497 cc','Manual','5-speed MT','10W-30 / 5W-30','API SL/SN','3.0 L','Manual: Honda MTF','Hidrolik','Honda PSF-S2 (Power Steering Fluid)'),
('Honda','Freed','2009–2015','Compact MPV','bensin','L15A','1497 cc','AT','CVT / 5-speed AT','0W-20 / 5W-30','API SN','3.4 L','Honda ATF Z1 / HCF-2','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Honda','Accord','2003–2007','Sedan','bensin','K24A','2354 cc','AT','5-speed Torque Converter','5W-30 / 5W-20','API SL/SN','3.6 L','Honda ATF Z1','Hidrolik','Honda PSF-S2 (Power Steering Fluid)'),
('Honda','Stream','2002–2006','Compact MPV','bensin','K20A','1998 cc','Manual','5-speed MT','5W-30 / 10W-30','API SL/SN','3.5 L','Manual: Honda MTF','Hidrolik','Honda PSF-S2 (Power Steering Fluid)'),
('Honda','Odyssey','2003–2015','MPV Premium','bensin','K24A / J35A V6','2354–3471 cc','AT','5-speed Torque Converter','5W-30 / 0W-20','API SN','4.0–4.5 L','Honda ATF Z1','Hidrolik','Honda PSF-S2 (Power Steering Fluid)'),
('Honda','CR-Z','2010–2016','Hybrid Coupe','bensin','LEA IMA Hybrid','1497 cc','CVT','Earth Dreams CVT','0W-20','API SN','3.0 L','Honda ATF-CVT','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Honda','City Hatchback RS','2021–sekarang','Hatchback','bensin','L15Z1','1498 cc','CVT','Earth Dreams CVT','0W-20','API SN','3.7 L','Honda ATF-CVT / HCF-2','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Honda','WR-V','2017–2022','SUV Compact','bensin','L13Z1 / L15Z1','1498 cc','Manual','5-speed MT','0W-20 / 5W-30','API SN','3.4 L','Manual: Honda MTF','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),

-- ── SUZUKI ────────────────────────────────────────────────────────────────────
('Suzuki','Ertiga','2012–2017 (Gen 1)','MPV','bensin','K14B','1372 cc','Manual','5-speed MT','0W-20 / 5W-30','API SN, ECSTAR F7000/F9000','3.1 L','Manual: SAE 75W-90 API GL-4','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Suzuki','Ertiga','2012–2017 (Gen 1)','MPV','bensin','K14B','1372 cc','AT','4-speed Torque Converter','5W-30','API SN','3.4 L','Suzuki ATF 3317 / setara Dexron','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Suzuki','All New Ertiga','2018–sekarang (Gen 2)','MPV','bensin','K14B / K15B','1372–1462 cc','AT','4-speed Torque Converter','0W-20','ECSTAR F9000 SN/GF-5','3.4 L','Suzuki ATF 3317','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Suzuki','APV / APV Arena','2005–sekarang','MPV','bensin','G15A','1493 cc','Manual','5-speed MT','10W-40 (ECSTAR F7000)','API SL','3.75–4.0 L','Manual: SAE 75W-90 API GL-4','Hidrolik','ATF Dexron III setara'),
('Suzuki','Carry 1.5 (PU/Futura)','2005–sekarang','Pickup/Minibus','bensin','G15A','1493 cc','Manual','5-speed MT','10W-40 (ECSTAR F7000) / 0W-20 (ECSTAR F9000, unit baru)','API SL/SN','3.7–4.0 L','Manual: SAE 75W-90 API GL-4','Hidrolik','ATF Dexron III setara'),
('Suzuki','Karimun Estilo / Wagon R','2007–sekarang','City Car','bensin','K10B','998 cc','Manual','5-speed MT','10W-40 / 0W-20','API SL/SN','2.9–3.1 L','Manual: SAE 75W-90 API GL-4','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Suzuki','Swift','2005–2010','Hatchback','bensin','M15A','1490 cc','Manual','5-speed MT','10W-40','API SL','3.8 L','Manual: SAE 75W-90 API GL-4','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Suzuki','Swift','2005–2010','Hatchback','bensin','M15A','1490 cc','AT','4-speed Torque Converter','10W-40','API SL','4.2 L','Suzuki ATF 3317','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Suzuki','SX4','2007–2014','Crossover','bensin','M15A / M16A','1490–1586 cc','Manual','5-speed MT','10W-40','API SL/SN','3.7 L','Manual: SAE 75W-90 API GL-4','Hidrolik','ATF Dexron III setara'),
('Suzuki','Baleno','2019–sekarang','Hatchback','bensin','K14B','1372 cc','AT','4-speed Torque Converter','0W-20','ECSTAR F9000 SN/GF-5','3.7 L','Suzuki ATF 3317','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Suzuki','Ignis','2017–sekarang','City Car','bensin','K12M','1197 cc','AMT','AGS (Auto Gear Shift)','0W-20','ECSTAR F9000 SN','2.7–3.0 L','AGS menggunakan oli manual + aktuator elektrik, SAE 75W GL-4','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Suzuki','Jimny','2019–sekarang','SUV Off-road','bensin','K15B','1462 cc','Manual','5-speed MT','0W-20','ECSTAR F9000 SN','3.9 L','Manual: SAE 75W-90 API GL-4','Hidrolik','ATF Dexron III setara'),
('Suzuki','Jimny','2019–sekarang','SUV Off-road','bensin','K15B','1462 cc','AT','4-speed Torque Converter','0W-20','ECSTAR F9000 SN','4.1 L','Suzuki ATF 3317','Hidrolik','ATF Dexron III setara'),
('Suzuki','XL7','2020–sekarang','SUV/MPV','bensin','K15B','1462 cc','Manual','5-speed MT','0W-20','ECSTAR F9000 SN','3.1 L','Manual: SAE 75W-90 API GL-4','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Suzuki','XL7','2020–sekarang','SUV/MPV','bensin','K15B','1462 cc','AT','4-speed Torque Converter','0W-20','ECSTAR F9000 SN','3.4 L','Suzuki ATF 3317','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Suzuki','S-Cross','2017–2020','Crossover','bensin','K14B','1372 cc','AT','4-speed Torque Converter','0W-20','ECSTAR F9000 SN','3.4 L','Suzuki ATF 3317','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Suzuki','Grand Vitara','2006–2016','SUV','bensin','J20A (2.0) / J24B (2.4)','1995–2393 cc','Manual','5-speed MT','10W-40','API SL/SN','4.6–4.8 L','Manual: SAE 75W-90 API GL-4','Hidrolik','ATF Dexron III setara'),
('Suzuki','Grand Vitara','2006–2016','SUV','bensin','J24B (2.4)','2393 cc','AT','4-speed Torque Converter','10W-40','API SL/SN','5.2 L','Suzuki ATF 3317','Hidrolik','ATF Dexron III setara'),
('Suzuki','Escudo','1990–2005','SUV','bensin','G16A','1590 cc','Manual','5-speed MT','10W-40','API SG/SL','3.75 L','Manual: SAE 75W-90 API GL-4','Hidrolik','ATF Dexron III setara'),
('Suzuki','Every','2000–2019','Minibus','bensin','F10A / K10B','970–998 cc','Manual','5-speed MT','10W-40','API SL','3.0–3.3 L','Manual: SAE 75W-90 API GL-4','Hidrolik','ATF Dexron III setara'),
('Suzuki','Splash','2010–2015','Hatchback','bensin','K12B / K14B','1197–1372 cc','Manual','5-speed MT','5W-30 / 10W-40','API SL/SN','3.1 L','Manual: SAE 75W-90 API GL-4','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Suzuki','Aerio / Baleno lama','2002–2007','Sedan/Hatchback','bensin','M15A','1490 cc','Manual','5-speed MT','10W-40','API SL','3.7 L','Manual: SAE 75W-90 API GL-4','Hidrolik','ATF Dexron III setara'),
('Suzuki','Vitara / New Vitara','2022–sekarang','SUV','bensin','K15B','1462 cc','AT','6-speed Torque Converter','0W-20','ECSTAR F9000 SN','3.5–3.9 L','Suzuki ATF 3317','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),

-- ── MITSUBISHI ────────────────────────────────────────────────────────────────
('Mitsubishi','Xpander','2017–sekarang','MPV','bensin','4A91','1499 cc','Manual','5-speed MT','0W-20 fully synthetic','API SN','3.6 L','Manual: API GL-3, SAE 75W-85','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Mitsubishi','Xpander / Xpander Cross','2017–sekarang','MPV/Crossover','bensin','4A91','1499 cc','CVT','INVECS-III CVT','0W-20 fully synthetic','API SN','4.0 L','CVTF-J4 / lifetime, cek tiap 20.000 km','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Mitsubishi','Pajero Sport','2009–2015 (Gen 2)','SUV','diesel','4D56','2477 cc','Manual','5-speed MT','10W-40','API CF/CF-4','6.1 L','Manual: API GL-3, SAE 75W-85','Hidrolik','ATF Dexron III / Mitsubishi Diamond PSF'),
('Mitsubishi','Pajero Sport','2009–2015 (Gen 2)','SUV','diesel','4D56','2477 cc','AT','5-speed Torque Converter','10W-40','API CF/CF-4','6.5 L','ATF MA-1 / Dia Queen SP-III','Hidrolik','ATF Dexron III / Mitsubishi Diamond PSF'),
('Mitsubishi','New Pajero Sport','2016–sekarang (Gen 3)','SUV','diesel','4N15 MIVEC Twin-turbo','2442 cc','Manual','6-speed MT','CF 10W-40','API CF','6.5–7.0 L','Manual: API GL-3, SAE 75W-85, 2.3 L (2WD)/3.4 L (4WD)','Hidrolik','ATF Dexron III / Mitsubishi Diamond PSF'),
('Mitsubishi','New Pajero Sport','2016–sekarang (Gen 3)','SUV','diesel','4N15 MIVEC Twin-turbo','2442 cc','AT','8-speed Torque Converter','CF 10W-40','API CF','6.5–7.0 L','ATF MA-1 III, 10.4–12.8 L saat dikuras total','Hidrolik','ATF Dexron III / Mitsubishi Diamond PSF'),
('Mitsubishi','Triton','2015–sekarang','Pickup','diesel','4D56 / 4N15','2477–2442 cc','Manual','5/6-speed MT','10W-40','API CF/CF-4','6.0–7.0 L','Manual: API GL-3, SAE 75W-85','Hidrolik','ATF Dexron III / Mitsubishi Diamond PSF'),
('Mitsubishi','Mirage','2013–sekarang','Hatchback','bensin','3A92','1193 cc','CVT','INVECS-III CVT','0W-20','API SN','2.7–3.0 L','CVTF-J1/J4','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Mitsubishi','Outlander Sport / Outlander PX','2012–sekarang','SUV','bensin','4B11','1998 cc','CVT','INVECS-III CVT','0W-20 / 5W-30','API SN','4.3–4.5 L','CVTF-J4','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Mitsubishi','L300','1981–sekarang','Pickup/Minibus','diesel','4D56','2477 cc','Manual','5-speed MT','10W-40 / 15W-40','API CF','4.9–5.6 L','Manual: API GL-3, SAE 75W-85','Hidrolik','ATF Dexron III / Mitsubishi Diamond PSF'),
('Mitsubishi','Kuda','1999–2010','MPV','diesel','4D56','2477 cc','Manual','5-speed MT','10W-40 / 15W-40','API CF','5.5 L','Manual: API GL-3, SAE 75W-85','Hidrolik','ATF Dexron III / Mitsubishi Diamond PSF'),
('Mitsubishi','Lancer / Lancer EX','2000–2015','Sedan','bensin','4G13 / 4G18 / 4B11','1300–2000 cc','Manual','5-speed MT','10W-40 / 5W-30','API SL/SN','3.2–3.8 L','Manual: API GL-3, SAE 75W-85','Hidrolik','ATF Dexron III / Mitsubishi Diamond PSF'),
('Mitsubishi','Eclipse Cross','2019–2022','SUV Compact','bensin','4B40 Turbo','1499 cc','CVT','INVECS-III CVT','0W-20','API SN','4.0 L','CVTF-J4','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Mitsubishi','Delica','2023–sekarang','MPV Premium','bensin','4B40 MIVEC Turbo','1499 cc','CVT','INVECS-III CVT','0W-20','API SN','4.0 L','CVTF-J4','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),

-- ── NISSAN ────────────────────────────────────────────────────────────────────
('Nissan','Grand Livina','2007–2019','MPV','bensin','HR15DE (1.5) / MR18DE (1.8)','1498–1798 cc','Manual','5-speed MT','5W-30 / 10W-40','API SL/SN','3.5 L','Manual: API GL-4, SAE 75W-90','Hidrolik','PSF Nissan Genuine / Dexron III setara'),
('Nissan','Grand Livina','2007–2019','MPV','bensin','HR15DE (1.5) / MR18DE (1.8)','1498–1798 cc','AT','4-speed Torque Converter / Xtronic CVT (facelift)','5W-30','API SL/SN','3.8–4.0 L','ATF Matic-D/J atau Nissan CVTF NS-2/NS-3','Hidrolik','PSF Nissan Genuine / Dexron III setara'),
('Nissan','Livina (2019, platform Xpander)','2019–sekarang','MPV','bensin','4A91','1498 cc','CVT','INVECS-III CVT','0W-20','API SN','4.0 L','CVTF-J4','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Nissan','X-Trail','2014–2019 (T32)','SUV','bensin','QR25DE','2488 cc','CVT','Xtronic CVT','0W-20 / 5W-30','API SN','4.4–4.8 L','Nissan CVTF NS-3','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Nissan','March','2010–2018','City Car','bensin','HR15DE','1498 cc','Manual','5-speed MT','5W-30','API SL/SN','3.2 L','Manual: API GL-4, SAE 75W-90','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Nissan','March','2010–2018','City Car','bensin','HR15DE','1498 cc','CVT','Xtronic CVT','5W-30','API SL/SN','3.5 L','Nissan CVTF NS-2','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Nissan','Serena','2018–sekarang','MPV','bensin','MR20DD','1997 cc','CVT','Xtronic CVT','0W-20','API SN','4.4 L','Nissan CVTF NS-3','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Nissan','Juke','2011–2019','SUV Compact','bensin','HR15DE','1498 cc','CVT','Xtronic CVT','5W-30','API SL/SN','3.5 L','Nissan CVTF NS-2/NS-3','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Nissan','Terra','2018–sekarang','SUV','diesel','YS23DDT','2298 cc','AT','7-speed Torque Converter','5W-30','ACEA C3, API CJ-4','7.1 L','ATF Matic-S','Hidrolik','PSF Nissan Genuine / Dexron III setara'),
('Nissan','Navara','2015–sekarang','Pickup','diesel','YS23DDT / YD25DDTi','2298–2488 cc','Manual','6-speed MT','5W-30 / 10W-30','ACEA C3, API CJ-4','7.0–7.5 L','Manual: API GL-4, SAE 75W-90','Hidrolik','PSF Nissan Genuine / Dexron III setara'),
('Nissan','Evalia','2012–2018','MPV','bensin','HR15DE','1498 cc','Manual','5-speed MT','5W-30','API SL/SN','3.5 L','Manual: API GL-4, SAE 75W-90','Hidrolik','PSF Nissan Genuine / Dexron III setara'),
('Nissan','Teana','2008–2015','Sedan Premium','bensin','QR25DE / VQ25DE','2488 cc','CVT','Xtronic CVT','5W-30','API SL/SN','4.4 L','Nissan CVTF NS-2/NS-3','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),

-- ── ISUZU ─────────────────────────────────────────────────────────────────────
('Isuzu','Panther','1996–2021','MPV/SUV Diesel','diesel','C223 / 4JA1 / 4JB1-T','2238–2999 cc','Manual','5-speed MT','15W-40 (kental, kompresi tinggi)','API CF/CF-4','6.0–7.0 L','Manual: API GL-4, SAE 75W-90','Hidrolik','ATF Dexron III / PSF Isuzu Genuine'),
('Isuzu','D-Max','2012–sekarang','Pickup','diesel','4JJ1-TC Common Rail','2999 cc','Manual','5/6-speed MT','5W-30 / 10W-30','API CJ-4','7.0 L','Manual: API GL-4/5, SAE 75W-90','Hidrolik','ATF Dexron III / PSF Isuzu Genuine'),
('Isuzu','D-Max','2012–sekarang','Pickup','diesel','4JJ1-TC Common Rail','2999 cc','AT','6-speed Torque Converter','5W-30 / 10W-30','API CJ-4','7.0 L','ATF Isuzu genuine / setara Dexron VI','Hidrolik','ATF Dexron III / PSF Isuzu Genuine'),
('Isuzu','MU-X','2014–sekarang','SUV','diesel','4JJ1-TC Common Rail','2999 cc','AT','6-speed Torque Converter','5W-30 / 10W-30','API CJ-4','7.0 L','ATF Isuzu genuine / setara Dexron VI','Hidrolik','ATF Dexron III / PSF Isuzu Genuine'),

-- ── MAZDA ─────────────────────────────────────────────────────────────────────
('Mazda','Mazda 2','2015–sekarang','Hatchback/Sedan','bensin','P5-VPS / PE-VPS SkyActiv-G','1496–1498 cc','Manual','6-speed MT','0W-20','API SN, ILSAC GF-5','3.7–4.0 L','Manual: API GL-4, SAE 75W-90','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Mazda','Mazda 2','2015–sekarang','Hatchback/Sedan','bensin','P5-VPS SkyActiv-G','1496 cc','AT','6-speed Torque Converter (SkyActiv-Drive)','0W-20','API SN, ILSAC GF-5','4.2 L','ATF setara Dexron VI / Mazda ATF FZ','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Mazda','Mazda 3','2014–sekarang','Hatchback/Sedan','bensin','PE-VPS / P5-VPS SkyActiv-G','1998–1496 cc','AT','6-speed Torque Converter (SkyActiv-Drive)','0W-20','API SN, ILSAC GF-5','4.5 L','ATF Mazda FZ / Dexron VI','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Mazda','CX-5','2017–sekarang','SUV','bensin','PY-VPS SkyActiv-G','2488 cc','AT','6-speed Torque Converter (SkyActiv-Drive)','0W-20','API SN, ILSAC GF-5','4.5–5.0 L','ATF Mazda FZ / Dexron VI','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Mazda','CX-3','2017–2021','SUV Compact','bensin','P3-VPS SkyActiv-G','1998 cc','AT','6-speed Torque Converter (SkyActiv-Drive)','0W-20','API SN, ILSAC GF-5','4.2 L','ATF Mazda FZ / Dexron VI','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Mazda','CX-8','2019–sekarang','SUV 7-seat','bensin','PY-VPS SkyActiv-G','2488 cc','AT','6-speed Torque Converter (SkyActiv-Drive)','0W-20','API SN, ILSAC GF-5','5.0 L','ATF Mazda FZ / Dexron VI','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Mazda','Mazda 6','2013–2022','Sedan/Wagon','bensin','PY-VPS SkyActiv-G','2488 cc','AT','6-speed Torque Converter (SkyActiv-Drive)','0W-20','API SN, ILSAC GF-5','4.8 L','ATF Mazda FZ / Dexron VI','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Mazda','BT-50','2007–sekarang','Pickup','diesel','WL-C / P4AT (Isuzu-based, gen baru)','2499–2999 cc','Manual','6-speed MT','5W-30 / 10W-30','API CJ-4, ACEA B4','7.0 L','Manual: API GL-4, SAE 75W-90','Hidrolik','ATF Dexron III setara'),

-- ── HYUNDAI ───────────────────────────────────────────────────────────────────
('Hyundai','Creta','2022–sekarang','SUV','bensin','G4FG Smartstream','1497 cc','Manual','6-speed MT','0W-20','API SN, ILSAC GF-5','3.3 L','Manual: API GL-4, SAE 75W/85','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Hyundai','Creta','2022–sekarang','SUV','bensin','G4FG Smartstream','1497 cc','CVT','IVT (Intelligent Variable Transmission)','0W-20','API SN, ILSAC GF-5','3.6 L','Hyundai IVT Fluid (setara CVTF)','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Hyundai','Stargazer','2022–sekarang','MPV','bensin','G4FG Smartstream','1497 cc','Manual','6-speed MT','0W-20','API SN, ILSAC GF-5','3.3 L','Manual: API GL-4, SAE 75W/85','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Hyundai','Stargazer','2022–sekarang','MPV','bensin','G4FG Smartstream','1497 cc','CVT','IVT','0W-20','API SN, ILSAC GF-5','3.6 L','Hyundai IVT Fluid','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Hyundai','Santa Fe','2013–sekarang','SUV','diesel','D4HA CRDi Turbo','2199 cc','AT','6/8-speed Torque Converter','5W-30','ACEA C3, API CJ-4','7.4–7.8 L','ATF SP-IV / Hyundai genuine','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Hyundai','Tucson','2016–sekarang','SUV','bensin','G4NA / diesel D4HA','1999–2199 cc','AT','6-speed Torque Converter','0W-20 (bensin) / 5W-30 (diesel)','API SN / ACEA C3','4.3–7.0 L','ATF SP-IV','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Hyundai','Santa Fe','2006–2012 (CM)','SUV','diesel','D4EB CRDi','2188 cc','AT','5-speed Torque Converter','5W-30','ACEA B4, API CF','6.5–7.0 L','ATF SP-III / Dexron III setara','Hidrolik','PSF Hyundai/Kia Genuine (setara Dexron III)'),
('Hyundai','Palisade','2021–sekarang','SUV Premium 7-seat','bensin','G6DH Lambda','3778 cc','AT','8-speed Torque Converter','5W-20 / 5W-30','API SN, ILSAC GF-5','5.6 L','ATF SP-IV','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Hyundai','Avega','2007–2011','Sedan','bensin','G4ED Beta','1599 cc','Manual','5-speed MT','5W-30 / 10W-30','API SL/SN','3.3 L','Manual: API GL-4, SAE 75W/85','Hidrolik','PSF Hyundai/Kia Genuine (setara Dexron III)'),
('Hyundai','Getz / Atoz','2003–2009','Hatchback','bensin','G4EA / G4HG','1086–1341 cc','Manual','5-speed MT','5W-30 / 10W-30','API SL','3.0–3.2 L','Manual: API GL-4, SAE 75W/85','Hidrolik','PSF Hyundai/Kia Genuine (setara Dexron III)'),
('Hyundai','H-1 / Staria','2008–sekarang','MPV Premium','diesel','D4CB CRDi / diesel Staria','2497–2199 cc','AT','5/8-speed Torque Converter','5W-30','ACEA C3, API CJ-4','7.0–7.6 L','ATF SP-IV','Hidrolik (H-1) / EPS (Staria, 2021–sekarang)','PSF Hyundai Genuine (H-1) — EPS tanpa fluida (Staria)'),

-- ── KIA ───────────────────────────────────────────────────────────────────────
('Kia','Seltos','2023–sekarang','SUV','bensin','Smartstream G1.5','1497 cc','CVT','IVT','0W-20','API SN, ILSAC GF-5','3.6 L','Kia IVT Fluid','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Kia','Sonet','2023–sekarang','SUV Compact','bensin','Smartstream G1.5','1497 cc','Manual','6-speed MT','0W-20','API SN, ILSAC GF-5','3.3 L','Manual: API GL-4, SAE 75W/85','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Kia','Carnival','2022–sekarang','MPV Premium','bensin','Smartstream G2.2D (diesel) / 3.5L V6 (bensin)','2199–3470 cc','AT','8-speed Torque Converter','5W-30 (diesel) / 5W-20 (bensin)','ACEA C3 / API SN','6.5–7.0 L','ATF SP-IV','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Kia','Picanto','2004–sekarang','City Car','bensin','Kappa 1.0/1.2/1.25','999–1248 cc','Manual','5-speed MT','0W-20 / 5W-30','API SN, ILSAC GF-5','2.7–3.0 L','Manual: API GL-4, SAE 75W/85','Hidrolik (generasi awal 2004) / EPS (facelift & generasi baru)','PSF Kia Genuine (awal) — EPS tanpa fluida (baru)'),
('Kia','Rio','2005–2017','Hatchback/Sedan','bensin','Gamma 1.4/1.6','1396–1591 cc','Manual','5-speed MT','5W-30','API SL/SN','3.3 L','Manual: API GL-4, SAE 75W/85','Hidrolik','PSF Hyundai/Kia Genuine (setara Dexron III)'),
('Kia','Sportage','2016–sekarang','SUV','bensin','Nu 2.0 / diesel R2.0 CRDi','1999 cc','AT','6-speed Torque Converter','0W-20 (bensin) / 5W-30 (diesel)','API SN / ACEA C3','4.3–6.9 L','ATF SP-IV','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Kia','Carens','2013–2018','MPV','bensin','Gamma 1.7/2.0','1685–1999 cc','Manual','6-speed MT','5W-30','API SN','4.3 L','Manual: API GL-4, SAE 75W/85','Hidrolik','PSF Hyundai/Kia Genuine (setara Dexron III)'),
('Kia','Grand Sedona / Carnival lama','2015–2021','MPV Premium','diesel','A2.2 CRDi','2199 cc','AT','6-speed Torque Converter','5W-30','ACEA C3, API CJ-4','7.0 L','ATF SP-IV','Hidrolik','PSF Hyundai/Kia Genuine (setara Dexron III)'),

-- ── WULING ────────────────────────────────────────────────────────────────────
('Wuling','Confero','2017–sekarang','MPV','bensin','4A30','1485 cc','Manual','5-speed MT','5W-30 / 10W-40','API SN','3.5 L','Manual: API GL-4, SAE 75W-90','Hidrolik','ATF Dexron III setara'),
('Wuling','Confero','2017–sekarang','MPV','bensin','4A30','1485 cc','AT','4-speed Torque Converter','5W-30','API SN','4.0 L','ATF Dexron VI / setara','Hidrolik','ATF Dexron III setara'),
('Wuling','Cortez','2018–sekarang','MPV','bensin','4A30 / 1.5T Turbo (LJO)','1485 cc','Manual','5-speed MT','5W-30 / 10W-40','API SN','3.5–4.0 L','Manual: API GL-4, SAE 75W-90','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Wuling','Cortez','2018–sekarang','MPV','bensin','1.5T Turbo (LJO)','1485 cc','CVT','CVT','0W-20 / 5W-30','API SN','4.0 L','CVTF Wuling genuine','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Wuling','Almaz','2019–sekarang','SUV','bensin','LJO Turbo','1490 cc','CVT','CVT','0W-20 / 5W-30','API SN','4.2 L','CVTF Wuling genuine','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),

-- ── MERCEDES-BENZ ─────────────────────────────────────────────────────────────
('Mercedes-Benz','C-Class (W203/W204)','2000–2014','Sedan','bensin','M271 Kompressor / M111','1796–1998 cc','AT','5/7-speed Torque Converter (7G-Tronic)','5W-30 / 5W-40','MB 229.5, ACEA A3/B4, API SN/CF','5.5–6.0 L','ATF MB 236.12 / Dexron III setara','Hidrolik','MB 236.3 / ATF Dexron II setara'),
('Mercedes-Benz','C-Class (W205/W206)','2014–sekarang','Sedan','bensin','M264 Turbo','1991 cc','AT','9-speed Torque Converter (9G-Tronic)','0W-20 / 5W-30','MB 229.52/229.71, ACEA C3','5.0–5.3 L','ATF MB 236.17','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Mercedes-Benz','E-Class (W211/W212)','2002–2016','Sedan','bensin','M112/M272 V6','2496–3498 cc','AT','5/7-speed Torque Converter','5W-30 / 5W-40','MB 229.5, ACEA A3/B4','7.0–7.5 L','ATF MB 236.12/236.14','Hidrolik','MB 236.3 / ATF Dexron II setara'),
('Mercedes-Benz','E-Class (W213)','2016–sekarang','Sedan','bensin','M264 Turbo / diesel OM654','1991 cc','AT','9-speed Torque Converter (9G-Tronic)','0W-20 / 5W-30','MB 229.52/229.71, ACEA C3','6.5–7.0 L','ATF MB 236.17','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Mercedes-Benz','GLC','2016–sekarang','SUV','bensin','M274 Turbo','1991 cc','AT','9-speed Torque Converter (9G-Tronic)','0W-20 / 5W-30','MB 229.52/229.71, ACEA C3','6.5 L','ATF MB 236.17','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Mercedes-Benz','S-Class (W221/W222/W223)','2005–sekarang','Sedan Premium','bensin','M272/M276/M256 V6','2996–3498 cc','AT','7/9-speed Torque Converter','5W-30 / 0W-20','MB 229.5/229.52/229.71','8.0–8.5 L','ATF MB 236.14/236.17','Hidrolik (W221, 2005–2013) / EPS (W222 & W223, 2013–sekarang)','MB 236.3 (W221) — EPS tanpa fluida (W222/W223)'),

-- ── BMW ───────────────────────────────────────────────────────────────────────
('BMW','3 Series (E90/E46)','2000–2012','Sedan','bensin','N46B20 / M54B25','1995–2494 cc','AT','5/6-speed Torque Converter (Steptronic)','5W-30','BMW LL-01, ACEA A3/B4','5.5–6.0 L','ATF Lifetime Fill (ZF 6HP), ganti tiap 60.000 km jika servis berat','Hidrolik','Pentosin CHF 11S (sintetik, hijau)'),
('BMW','3 Series (F30/G20)','2012–sekarang','Sedan','bensin','N20B20 / B48 Turbo','1997 cc','AT','8-speed Torque Converter (ZF 8HP Steptronic)','0W-20 / 5W-30','BMW LL-01 FE/LL-04, ACEA C3','5.2–5.7 L','ATF ZF Lifeguard 8 / BMW-approved','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('BMW','5 Series (F10/G30)','2010–sekarang','Sedan Premium','bensin','N20B20 / B48/B58 Turbo','1997–2998 cc','AT','8-speed Torque Converter (ZF 8HP Steptronic)','0W-20 / 5W-30','BMW LL-01 FE/LL-04, ACEA C3','5.7–6.2 L','ATF ZF Lifeguard 8','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('BMW','X1','2016–sekarang','SUV Compact','bensin','B38/B48 Turbo','1499–1998 cc','AT','6/8-speed Torque Converter','0W-20 / 5W-30','BMW LL-04, ACEA C3','4.5–5.5 L','ATF ZF Lifeguard / Aisin AWF','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('BMW','X3','2010–sekarang','SUV','bensin','N20B20 / B47 diesel','1995–1995 cc','AT','8-speed Torque Converter (ZF 8HP)','0W-20 / 5W-30','BMW LL-01/LL-04, ACEA C3','5.2–5.7 L','ATF ZF Lifeguard 8','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('BMW','X5','2007–sekarang','SUV Premium','bensin','N52/N55/B58 Turbo','2996–2979 cc','AT','8-speed Torque Converter (ZF 8HP)','5W-30 / 0W-20','BMW LL-01/LL-04, ACEA A3/B4','6.5–7.0 L','ATF ZF Lifeguard 8','Hidrolik (E70, 2007–2013) / EPS (F15 & G05, 2013–sekarang)','Pentosin CHF 11S (E70) — EPS tanpa fluida (F15/G05)'),

-- ── AUDI ──────────────────────────────────────────────────────────────────────
('Audi','A4','2008–sekarang (B8/B9)','Sedan','bensin','EA888 Turbo TFSI','1798–1984 cc','AT','7-speed DCT (S tronic)','5W-30 / 5W-40','VW 502.00/504.00, ACEA C3','5.0–5.5 L','VAG DSG DQ200/250 Oil, ±1.7 L (basah)','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Audi','A6','2011–sekarang (C7/C8)','Sedan Premium','bensin','EA888 Turbo TFSI / V6 3.0 TFSI','1984–2995 cc','AT','7-speed DCT / 8-speed Tiptronic','5W-30 / 5W-40','VW 502.00/504.00, ACEA C3','5.5–7.5 L','ZF 8HP ATF (Tiptronic) / DSG oil','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Audi','Q5','2009–sekarang','SUV','bensin','EA888 Turbo TFSI','1984 cc','AT','7-speed DCT (S tronic)','5W-30 / 5W-40','VW 502.00/504.00, ACEA C3','5.3 L','VAG DSG DQ500 Oil','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),

-- ── VOLKSWAGEN ────────────────────────────────────────────────────────────────
('Volkswagen','Golf (Mk6/Mk7)','2009–2021','Hatchback','bensin','EA111/EA211 TSI Turbo','1197–1395 cc','AT','7-speed DCT (DSG)','5W-30 / 5W-40','VW 502.00/504.00, ACEA C3','4.6–5.0 L','VAG DSG DQ200 Oil, ±1.7 L (basah)','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Volkswagen','Tiguan','2012–sekarang','SUV','bensin','EA888 TSI Turbo','1395–1984 cc','AT','6/7-speed DCT (DSG)','5W-30 / 5W-40','VW 502.00/504.00, ACEA C3','5.2–5.5 L','VAG DSG DQ250/381 Oil','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Volkswagen','Polo','2010–2020','Hatchback','bensin','EA111 TSI','1197–1397 cc','Manual','5-speed MT','5W-30','VW 501.01/502.00, ACEA C2/C3','3.6–4.0 L','Manual: VAG G 052 512 A2','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Volkswagen','Passat','2007–sekarang','Sedan','bensin','EA888 TSI Turbo','1798–1984 cc','AT','6-speed DCT (DSG)','5W-30 / 5W-40','VW 502.00/504.00, ACEA C3','5.2 L','VAG DSG DQ250 Oil','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),

-- ── VOLVO ─────────────────────────────────────────────────────────────────────
('Volvo','XC60','2009–sekarang','SUV','diesel','D4204T (D4) / bensin B4204T','1969 cc','AT','8-speed Torque Converter (Aisin/Geartronic)','0W-30 / 5W-30','VCC RBS0-2AE, ACEA C3','5.7–6.0 L','ATF JWS 3309 / Volvo genuine','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Volvo','XC90','2002–sekarang','SUV Premium 7-seat','diesel','D5244T (D5) / bensin B5254T','2401–2521 cc','AT','8-speed Torque Converter (Geartronic)','0W-30 / 5W-30','VCC RBS0-2AE, ACEA C3','6.5–7.0 L','ATF JWS 3309','Hidrolik (Gen 1, 2002–2014) / EPS (Gen 2, 2015–sekarang)','Pentosin CHF 11S / Volvo PSF (Gen 1) — EPS tanpa fluida (Gen 2)'),
('Volvo','S60','2010–sekarang','Sedan','bensin','B4204T Turbo','1969 cc','AT','8-speed Torque Converter (Geartronic)','0W-30 / 5W-30','VCC RBS0-2AE, ACEA C3','5.7 L','ATF JWS 3309','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),

-- ── PEUGEOT ───────────────────────────────────────────────────────────────────
('Peugeot','3008','2017–sekarang','SUV','bensin','EP6FDT (1.6 THP Turbo)','1598 cc','AT','6-speed Torque Converter (EAT6)','5W-30','PSA B71 2312, ACEA C2/C3','4.5 L','ATF PSA AW1/Dexron','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Peugeot','5008','2018–sekarang','SUV 7-seat','bensin','EP6FDT Turbo','1598 cc','AT','6-speed Torque Converter (EAT6)','5W-30','PSA B71 2312, ACEA C2/C3','4.5 L','ATF PSA AW1/Dexron','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Peugeot','508','2019–sekarang','Sedan/Liftback','bensin','EP6FDT / diesel BlueHDi','1598 cc','AT','8-speed Torque Converter (EAT8)','5W-30','PSA B71 2312, ACEA C2/C3','4.3–5.0 L','ATF PSA AW1','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Peugeot','2008','2021–sekarang','SUV Compact','bensin','EB2ADTS Turbo (1.2 PureTech)','1199 cc','AT','6-speed Torque Converter (EAT6)','0W-20 / 5W-30','PSA B71 2312, ACEA C2','3.5–4.0 L','ATF PSA AW1','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),

-- ── JEEP ──────────────────────────────────────────────────────────────────────
('Jeep','Wrangler','2007–sekarang','SUV Off-road','bensin','Pentastar V6 3.6L','3604 cc','AT','8-speed Torque Converter (ZF 8HP)','0W-20 / 5W-20','API SN, ILSAC GF-5, MS-6395','5.7 L','ATF ZF Lifeguard 8','Hidrolik (JK, 2007–2017) / EPS (JL, 2018–sekarang)','Mopar PSF+4 (JK) — EPS tanpa fluida (JL)'),
('Jeep','Grand Cherokee','2005–sekarang','SUV Premium','bensin','Pentastar V6 3.6L / diesel 3.0 CRD','3604–2987 cc','AT','8-speed Torque Converter (ZF 8HP)','0W-20 / 5W-40','MS-6395 / ACEA C3','6.0–6.6 L','ATF ZF Lifeguard 8','Hidrolik (WK, 2005–2010) / EPS (WK2, 2011–sekarang)','Mopar PSF+4 (WK) — EPS tanpa fluida (WK2)'),
('Jeep','Cherokee','2014–2020','SUV','bensin','Tigershark 2.4L / Pentastar 3.2L','2360–3239 cc','AT','9-speed Torque Converter (ZF 9HP)','0W-20','API SN, MS-6395','5.2–5.7 L','ATF ZF 9HP genuine','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Jeep','Renegade / Compass','2015–sekarang','SUV Compact','bensin','Firefly 1.3 Turbo / Tigershark 2.4L','1332–2360 cc','AT','9-speed Torque Converter (ZF 9HP) / DCT','0W-20 / 5W-30','API SN, MS-6395','4.5–5.2 L','ATF ZF 9HP / DCT450 oil','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),

-- ── MINI ──────────────────────────────────────────────────────────────────────
('MINI','Cooper (F55/F56)','2014–sekarang','Hatchback Premium','bensin','B38/B48 Turbo (basis BMW)','1499–1998 cc','AT','7-speed DCT / 6-8 speed Torque Converter','0W-20 / 5W-30','BMW LL-01 FE/LL-04, ACEA C3','4.0–4.5 L','ATF Aisin / VAG DSG oil (tergantung transmisi)','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),

-- ── FORD ──────────────────────────────────────────────────────────────────────
('Ford','Ranger','2006–2022','Pickup','diesel','P4AT / P5AT Duratorq TDCi','2198–3198 cc','Manual','6-speed MT','5W-30 / 10W-30','ACEA B4, API CJ-4, Ford WSS-M2C917-A','6.0–7.0 L','Manual: Ford WSD-M2C200-C','Hidrolik','Ford Mercon V PSF'),
('Ford','Ranger','2006–2022','Pickup','diesel','P4AT / P5AT Duratorq TDCi','2198–3198 cc','AT','6-speed Torque Converter','5W-30','ACEA B4, API CJ-4','6.0–7.0 L','ATF Ford Mercon LV','Hidrolik','Ford Mercon V PSF'),
('Ford','Everest','2007–2022','SUV','diesel','P4AT / P5AT Duratorq TDCi 2.2–3.2','2198–3198 cc','AT','6-speed Torque Converter','5W-30','ACEA B4, API CJ-4, Ford WSS-M2C917-A','7.0–7.5 L','ATF Ford Mercon LV','Hidrolik','Ford Mercon V PSF'),
('Ford','Fiesta','2010–2015','Hatchback','bensin','Ti-VCT 1.4/1.6 / EcoBoost 1.0 Turbo','1388–998 cc','AT','6-speed DCT (PowerShift)','5W-20 / 5W-30','Ford WSS-M2C913, ACEA C2','4.0–4.3 L','PowerShift DCT oil, ±1.7 L (basah)','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Ford','Focus','2005–2015','Hatchback/Sedan','bensin','Duratec 1.8/2.0 / EcoBoost 1.5 Turbo','1798–1999 cc','AT','6-speed DCT (PowerShift) / Torque Converter','5W-20 / 5W-30','Ford WSS-M2C913, ACEA C2','4.2–4.5 L','PowerShift DCT oil','Hidrolik (Mk1/Mk2, 2005–2010) / EPS (Mk3, 2011–2015)','Ford Mercon V PSF (Mk1/Mk2) — EPS tanpa fluida (Mk3)'),
('Ford','EcoSport','2013–2019','SUV Compact','bensin','Ti-VCT 1.5 / EcoBoost 1.0 Turbo','1499–998 cc','Manual','5-speed MT','5W-20 / 5W-30','Ford WSS-M2C913, ACEA C2','4.2 L','Manual: Ford WSD-M2C200-C','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),

-- ── CHEVROLET ─────────────────────────────────────────────────────────────────
('Chevrolet','Spin','2013–2019','MPV','bensin','F16D4 (1.5) / F14D4 (1.2)','1206–1498 cc','Manual','5-speed MT','5W-30 / 10W-40','API SN, GM Dexos1','3.5–3.8 L','Manual: GM Synchromesh','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Chevrolet','Spin','2013–2019','MPV','diesel','2.0L VCDi (Duramax kecil)','1998 cc','Manual','5-speed MT','5W-30','ACEA B4, API CJ-4','5.5 L','Manual: GM Synchromesh','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Chevrolet','Trailblazer / Colorado','2012–2020','SUV/Pickup','diesel','Duramax 2.5L / 2.8L VCDi','2499–2776 cc','AT','6-speed Torque Converter','5W-30 (Dexos2)','ACEA C3, GM Dexos2','7.0–8.0 L','ATF GM Dexron VI','Hidrolik','GM Power Steering Fluid / ATF Dexron VI'),
('Chevrolet','Captiva','2007–2018','SUV','bensin','F16D3 (2.0 A16XER) / diesel Z20D1','1998–1991 cc','AT','5/6-speed Torque Converter','5W-30 / 5W-40','GM Dexos2, ACEA C3','5.6–6.5 L','ATF GM Dexron VI','Hidrolik','GM Power Steering Fluid / ATF Dexron VI'),
('Chevrolet','Orlando','2011–2015','MPV','bensin','F16D4 (1.8)','1796 cc','AT','6-speed Torque Converter','5W-30','GM Dexos1','4.5 L','ATF GM Dexron VI','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Chevrolet','Cruze','2010–2016','Sedan/Hatchback','bensin','F16D4 (1.8) / diesel Z20D1','1796–1991 cc','Manual','5/6-speed MT','5W-30','GM Dexos1','4.2–4.6 L','Manual: GM Synchromesh','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),

-- ── RENAULT ───────────────────────────────────────────────────────────────────
('Renault','Duster','2014–2019','SUV','bensin','H4K (2.0) / diesel K9K (1.5 dCi)','1998–1461 cc','Manual','5/6-speed MT','5W-30 / 5W-40','ACEA A3/B4, RN0700','4.0–5.5 L','Manual: API GL-4, SAE 75W-80','Hidrolik','Renault PSF / ATF Dexron II setara'),
('Renault','Kwid','2019–2021','City Car','bensin','B4D 0.8/1.0','799–999 cc','Manual','5-speed MT / AMT','5W-30','API SN, ACEA A5/B5','2.7–3.0 L','Manual: API GL-4, SAE 75W-80','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Renault','Triber','2020–2022','LCGC MPV','bensin','B4D 1.0','999 cc','Manual','5-speed MT / AMT','5W-30','API SN, ACEA A5/B5','2.7–3.0 L','Manual: API GL-4, SAE 75W-80','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)');

-- Verifikasi jumlah data yang di-insert
SELECT COUNT(*) AS total_data_inserted FROM kendaraan;
