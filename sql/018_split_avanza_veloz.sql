-- =============================================================================
-- 018_split_avanza_veloz.sql
-- Memisahkan Avanza dan Veloz menjadi model mandiri agar mudah dicari
-- =============================================================================

-- UPDATE Avanza lama (Gen 2 RWD)
UPDATE kendaraan 
SET model = 'Avanza (Gen 2 RWD) 1.3L / 1.5L' 
WHERE merek = 'Toyota' AND model = 'Avanza / Veloz';

-- INSERT Veloz lama (Gen 2 RWD) (Duplikasi Avanza Gen 2)
INSERT INTO kendaraan
  (merek, model, tahun, kategori, bahan_bakar, kode_mesin, kapasitas_cc,
   tipe_transmisi, detail_transmisi, viskositas_oli, standar_oli, kapasitas_oli,
   oli_transmisi, tipe_power_steering, fluida_power_steering)
VALUES
('Toyota','Veloz (Gen 2 RWD) 1.5L','2015–2021 (Gen 2 facelift, 2NR-VE)','MPV Premium','bensin','2NR-VE','1496 cc','AT','4-speed Torque Converter','5W-30 (0W-20 utk unit baru)','API SN, ILSAC GF-5','3.5 L','ATF T-IV, ±4.9 L','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)');

-- UPDATE Avanza baru (Gen 3 FWD)
UPDATE kendaraan 
SET model = 'Avanza (Gen 3 FWD) 1.3L / 1.5L' 
WHERE merek = 'Toyota' AND model = 'Avanza / Veloz FWD';

-- INSERT Veloz baru (Gen 3 FWD) (Duplikasi Avanza Gen 3)
INSERT INTO kendaraan
  (merek, model, tahun, kategori, bahan_bakar, kode_mesin, kapasitas_cc,
   tipe_transmisi, detail_transmisi, viskositas_oli, standar_oli, kapasitas_oli,
   oli_transmisi, tipe_power_steering, fluida_power_steering)
VALUES
('Toyota','Veloz (Gen 3 FWD) 1.5L','2021–sekarang (Gen 3, DNGA)','MPV Premium','bensin','2NR-VE Dual VVT-i','1496 cc','CVT','CVT dgn split gear','0W-20 / 5W-30','API SN/SP, ILSAC GF-5/GF-6A','3.5 L','Toyota CVT Fluid FE, ±6.0 L','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)');

-- Perbarui tabel rem untuk model Veloz yang baru dipecah
UPDATE kendaraan 
SET tipe_sistem_rem = 'Depan: Ventilated Disc, Belakang: Drum', minyak_rem = 'DOT 3' 
WHERE merek = 'Toyota' AND model IN ('Veloz (Gen 2 RWD) 1.5L');

-- Veloz Gen 3 menggunakan rem cakram di keempat roda (Solid Disc belakang)
UPDATE kendaraan 
SET tipe_sistem_rem = 'Depan: Ventilated Disc, Belakang: Solid Disc', minyak_rem = 'DOT 3 / DOT 4' 
WHERE merek = 'Toyota' AND model IN ('Veloz (Gen 3 FWD) 1.5L');
