-- =============================================================================
-- 010_add_mitsubishi_destinator.sql
-- Menambahkan model terbaru Mitsubishi Destinator (2025)
-- =============================================================================

INSERT INTO kendaraan
  (merek, model, tahun, kategori, bahan_bakar, kode_mesin, kapasitas_cc,
   tipe_transmisi, detail_transmisi, viskositas_oli, standar_oli, kapasitas_oli,
   oli_transmisi, tipe_power_steering, fluida_power_steering)
VALUES
('Mitsubishi','Destinator','2025–sekarang','SUV Premium 7-seat','bensin','1.5L MIVEC Turbo','1499 cc','CVT','CVT','0W-20 / 5W-30','API SP, ILSAC GF-6A','4.0 L','Mitsubishi Motors DiaQueen CVT Fluid J4','Elektrik (EPS)','Tidak menggunakan fluida (sistem elektrik)');
