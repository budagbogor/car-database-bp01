-- =============================================================================
-- 012_add_suzuki_fronx.sql
-- Menambahkan Suzuki Fronx beserta varian mesinnya
-- =============================================================================

INSERT INTO kendaraan
  (merek, model, tahun, kategori, bahan_bakar, kode_mesin, kapasitas_cc,
   tipe_transmisi, detail_transmisi, viskositas_oli, standar_oli, kapasitas_oli,
   oli_transmisi, tipe_power_steering, fluida_power_steering)
VALUES
('Suzuki','Fronx (1.2L)','2023–sekarang','SUV Compact','bensin','K12N Dual Jet','1197 cc','Manual','5-speed MT','0W-16 / 0W-20','API SN / SP','3.1 L','Manual: API GL-4, SAE 75W','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Suzuki','Fronx (1.2L)','2023–sekarang','SUV Compact','bensin','K12N Dual Jet','1197 cc','AMT','5-speed AGS (Auto Gear Shift)','0W-16 / 0W-20','API SN / SP','3.1 L','Suzuki Gear Oil 75W (Manual / AGS aktuator fluid)','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Suzuki','Fronx (1.0L Turbo)','2023–sekarang','SUV Compact','bensin','K10C Boosterjet Turbo','998 cc','AT','6-speed Torque Converter','0W-20','API SN / SP','3.1 L','Suzuki ATF AW-1','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)'),
('Suzuki','Fronx (1.5L) Smart Hybrid','2023–sekarang','SUV Compact','hybrid','K15C Dual Jet Smart Hybrid','1462 cc','AT','6-speed Torque Converter','0W-16 / 0W-20','API SP','3.1 L','Suzuki ATF AW-1','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)');
