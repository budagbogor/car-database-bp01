-- =============================================================================
-- 023_add_mini_models.sql
-- Menambahkan varian lengkap MINI Cooper di Indonesia (R-series dan F-series)
-- =============================================================================

-- Hapus data MINI yang lama karena data rem dan bannya hasil fallback yang tidak akurat
DELETE FROM kendaraan WHERE merek ILIKE 'MINI';

-- =============================================================================
-- GENERASI 1 (R50 / R52 / R53) 2001 - 2006
-- =============================================================================
INSERT INTO kendaraan (merek, model, tahun, kategori, bahan_bakar, kode_mesin, kapasitas_cc, tipe_transmisi, detail_transmisi, viskositas_oli, standar_oli, kapasitas_oli, oli_transmisi, tipe_power_steering, fluida_power_steering, tipe_sistem_rem, minyak_rem, ukuran_ban, merek_ban_oem, tekanan_ban)
VALUES
('MINI', 'Cooper / Cooper S (R50/R53)', '2001–2006', 'Hatchback', 'bensin', '1.6L Tritec (W10 / W11 Supercharged)', '1598 cc', 'AT', 'CVT (R50) / 6-speed Aisin (R53)', '5W-30 / 5W-40', 'BMW LL-01 / ACEA A3/B4', '4.5 - 4.8 L', 'CVTF / Aisin JWS 3309', 'Hidrolik Elektrik (EHPS)', 'Pentosin CHF 11S', 'Depan: Ventilated Disc, Belakang: Solid Disc', 'DOT 4', '195/55 R16 / 205/45 R17', 'Pirelli / Dunlop', 'Depan: 35 PSI, Belakang: 35 PSI');

-- =============================================================================
-- GENERASI 2 (R56 / R55 / R57 / R60) 2007 - 2013/2016
-- =============================================================================
-- 3-Door (R56)
INSERT INTO kendaraan (merek, model, tahun, kategori, bahan_bakar, kode_mesin, kapasitas_cc, tipe_transmisi, detail_transmisi, viskositas_oli, standar_oli, kapasitas_oli, oli_transmisi, tipe_power_steering, fluida_power_steering, tipe_sistem_rem, minyak_rem, ukuran_ban, merek_ban_oem, tekanan_ban)
VALUES
('MINI', 'Cooper / Cooper S 3-Door (R56)', '2007–2013', 'Hatchback', 'bensin', '1.6L Prince (N12 / N14 / N16 / N18 Turbo)', '1598 cc', 'AT', '6-speed Aisin', '5W-30 / 5W-40', 'BMW LL-01 / ACEA A3/B4', '4.2 - 4.5 L', 'Aisin JWS 3309 (ATF-TIV)', 'Elektrik (EPS)', 'Tidak menggunakan fluida (sistem elektrik)', 'Depan: Ventilated Disc, Belakang: Solid Disc', 'DOT 4', '205/45 R17', 'Continental / Pirelli RFT', 'Depan: 35 PSI, Belakang: 35 PSI');

-- Clubman (R55)
INSERT INTO kendaraan (merek, model, tahun, kategori, bahan_bakar, kode_mesin, kapasitas_cc, tipe_transmisi, detail_transmisi, viskositas_oli, standar_oli, kapasitas_oli, oli_transmisi, tipe_power_steering, fluida_power_steering, tipe_sistem_rem, minyak_rem, ukuran_ban, merek_ban_oem, tekanan_ban)
VALUES
('MINI', 'Clubman Cooper / S (R55)', '2008–2014', 'Station Wagon / Estate', 'bensin', '1.6L Prince (N12 / N14 / N16 / N18)', '1598 cc', 'AT', '6-speed Aisin', '5W-30 / 5W-40', 'BMW LL-01 / ACEA A3/B4', '4.2 - 4.5 L', 'Aisin JWS 3309', 'Elektrik (EPS)', 'Tidak menggunakan fluida (sistem elektrik)', 'Depan: Ventilated Disc, Belakang: Solid Disc', 'DOT 4', '205/45 R17', 'Continental / Pirelli RFT', 'Depan: 35 PSI, Belakang: 35 PSI');

-- Countryman (R60)
INSERT INTO kendaraan (merek, model, tahun, kategori, bahan_bakar, kode_mesin, kapasitas_cc, tipe_transmisi, detail_transmisi, viskositas_oli, standar_oli, kapasitas_oli, oli_transmisi, tipe_power_steering, fluida_power_steering, tipe_sistem_rem, minyak_rem, ukuran_ban, merek_ban_oem, tekanan_ban)
VALUES
('MINI', 'Countryman Cooper / S (R60)', '2010–2016', 'SUV / Crossover', 'bensin', '1.6L Prince (N16 / N18)', '1598 cc', 'AT', '6-speed Aisin', '5W-30 / 5W-40', 'BMW LL-01 / ACEA A3/B4', '4.2 - 4.5 L', 'Aisin JWS 3309', 'Elektrik (EPS)', 'Tidak menggunakan fluida (sistem elektrik)', 'Depan: Ventilated Disc, Belakang: Solid Disc', 'DOT 4', '225/45 R18', 'Pirelli Cinturato / Bridgestone', 'Depan: 32 PSI, Belakang: 32 PSI');

-- =============================================================================
-- GENERASI 3 (F56 / F55 / F54 / F60) 2014 - SEKARANG (Basis BMW UKL)
-- =============================================================================
-- 3-Door (F56) & 5-Door (F55) - COOPER (1.5L)
INSERT INTO kendaraan (merek, model, tahun, kategori, bahan_bakar, kode_mesin, kapasitas_cc, tipe_transmisi, detail_transmisi, viskositas_oli, standar_oli, kapasitas_oli, oli_transmisi, tipe_power_steering, fluida_power_steering, tipe_sistem_rem, minyak_rem, ukuran_ban, merek_ban_oem, tekanan_ban)
VALUES
('MINI', 'Cooper 3-Door / 5-Door (F56/F55)', '2014–sekarang', 'Hatchback', 'bensin', '1.5L B38 3-Silinder Turbo', '1499 cc', 'AT', '7-speed Steptronic DCT / 6-speed AT', '0W-20 / 5W-30', 'BMW LL-01 FE / LL-04', '4.2 L', 'BMW ATF 6 / DCTF-1', 'Elektrik (EPS)', 'Tidak menggunakan fluida (sistem elektrik)', 'Depan: Ventilated Disc, Belakang: Solid Disc', 'DOT 4', '205/45 R17', 'Michelin / Pirelli (RFT)', 'Depan: 35 PSI, Belakang: 35 PSI');

-- 3-Door (F56) & 5-Door (F55) - COOPER S / JCW (2.0L)
INSERT INTO kendaraan (merek, model, tahun, kategori, bahan_bakar, kode_mesin, kapasitas_cc, tipe_transmisi, detail_transmisi, viskositas_oli, standar_oli, kapasitas_oli, oli_transmisi, tipe_power_steering, fluida_power_steering, tipe_sistem_rem, minyak_rem, ukuran_ban, merek_ban_oem, tekanan_ban)
VALUES
('MINI', 'Cooper S / JCW 3-Door/5-Door (F56/F55)', '2014–sekarang', 'Hatchback', 'bensin', '2.0L B48 4-Silinder Turbo', '1998 cc', 'AT', '7-speed Steptronic DCT / 8-speed Sport AT', '0W-20 / 5W-30', 'BMW LL-01 FE / LL-04', '5.2 L', 'BMW DCTF-1 / ATF 8', 'Elektrik (EPS)', 'Tidak menggunakan fluida (sistem elektrik)', 'Depan: Ventilated Disc, Belakang: Solid Disc', 'DOT 4', '205/45 R17 / 205/40 R18', 'Pirelli / Michelin (RFT)', 'Depan: 38 PSI, Belakang: 38 PSI');

-- Clubman (F54) - Cooper / S
INSERT INTO kendaraan (merek, model, tahun, kategori, bahan_bakar, kode_mesin, kapasitas_cc, tipe_transmisi, detail_transmisi, viskositas_oli, standar_oli, kapasitas_oli, oli_transmisi, tipe_power_steering, fluida_power_steering, tipe_sistem_rem, minyak_rem, ukuran_ban, merek_ban_oem, tekanan_ban)
VALUES
('MINI', 'Clubman Cooper / S (F54)', '2015–sekarang', 'Station Wagon / Estate', 'bensin', '1.5L B38 / 2.0L B48 Turbo', '1499–1998 cc', 'AT', '7-speed DCT / 8-speed AT', '0W-20 / 5W-30', 'BMW LL-01 FE / LL-04', '4.2 - 5.2 L', 'DCTF-1 / ATF 8', 'Elektrik (EPS)', 'Tidak menggunakan fluida (sistem elektrik)', 'Depan: Ventilated Disc, Belakang: Solid Disc', 'DOT 4', '225/45 R17 / 225/40 R18', 'Pirelli / Bridgestone (RFT)', 'Depan: 35 PSI, Belakang: 35 PSI');

-- Countryman (F60) - Cooper / S
INSERT INTO kendaraan (merek, model, tahun, kategori, bahan_bakar, kode_mesin, kapasitas_cc, tipe_transmisi, detail_transmisi, viskositas_oli, standar_oli, kapasitas_oli, oli_transmisi, tipe_power_steering, fluida_power_steering, tipe_sistem_rem, minyak_rem, ukuran_ban, merek_ban_oem, tekanan_ban)
VALUES
('MINI', 'Countryman Cooper / S (F60)', '2017–sekarang', 'SUV / Crossover', 'bensin', '1.5L B38 / 2.0L B48 Turbo', '1499–1998 cc', 'AT', '7-speed DCT / 8-speed AT', '0W-20 / 5W-30', 'BMW LL-01 FE / LL-04', '4.2 - 5.2 L', 'DCTF-1 / ATF 8', 'Elektrik (EPS)', 'Tidak menggunakan fluida (sistem elektrik)', 'Depan: Ventilated Disc, Belakang: Solid Disc', 'DOT 4', '225/50 R18 / 225/45 R19', 'Pirelli / Michelin (RFT)', 'Depan: 33 PSI, Belakang: 33 PSI');

-- =============================================================================
-- MOBIL LISTRIK (EV)
-- =============================================================================
INSERT INTO kendaraan (merek, model, tahun, kategori, bahan_bakar, kode_mesin, kapasitas_cc, tipe_transmisi, detail_transmisi, viskositas_oli, standar_oli, kapasitas_oli, oli_transmisi, tipe_power_steering, fluida_power_steering, tipe_sistem_rem, minyak_rem, ukuran_ban, merek_ban_oem, tekanan_ban)
VALUES
('MINI', 'Electric (Cooper SE)', '2020–sekarang', 'Hatchback', 'listrik', 'Motor Listrik (eDrive)', '0 cc (EV)', 'Single Speed', 'Reduction Gear', 'Tidak menggunakan oli mesin', '-', '-', 'EV Reduction Gear Fluid', 'Elektrik (EPS)', 'Tidak menggunakan fluida (sistem elektrik)', 'Depan: Ventilated Disc, Belakang: Solid Disc', 'DOT 4', '205/45 R17', 'Goodyear / Pirelli', 'Depan: 35 PSI, Belakang: 35 PSI');


-- Jalankan ulang generate rekomendasi aftermarket khusus MINI
UPDATE kendaraan
SET rekomendasi_aftermarket = 
  CASE WHEN bahan_bakar = 'listrik' THEN 
    '<div class="rek-item"><strong>Motor Traksi (Gardan EV):</strong> Oli Khusus BMW EV Gear Oil</div>'
  ELSE
    '<div class="rek-item"><strong>Mesin:</strong> ' ||
    CASE 
      WHEN viskositas_oli LIKE '%0W-20%' THEN 'Liqui Moly Top Tec 6600, Ravenol VSE, Fuchs Titan GT1'
      WHEN viskositas_oli LIKE '%5W-30%' OR viskositas_oli LIKE '%5W-40%' THEN 'Motul 8100 X-Clean, Liqui Moly Top Tec 4200, Mobil 1 ESP'
      ELSE 'Wajib spesifikasi Eropa (Longlife-01 / LL-04 / ACEA A3/B4)'
    END || '</div>'
  END ||
  
  CASE WHEN bahan_bakar = 'listrik' THEN ''
  ELSE
    '<div class="rek-item"><strong>Transmisi:</strong> ' ||
    CASE 
      WHEN tipe_transmisi = 'CVT' THEN 'Motul CVTF / Aisin CFEx'
      ELSE 'Motul Multi DCTF / BMW ATF 6 / ATF 8 (Cek tipe transmisi)'
    END || '</div>'
  END ||

  '<div class="rek-item"><strong>Rem:</strong> Brembo DOT 4, Pentosin DOT 4, Motul RBF 600</div>' ||

  CASE 
    WHEN tipe_power_steering ILIKE '%Hidrolik%' THEN '<div class="rek-item"><strong>Power Steering:</strong> Pentosin CHF 11S</div>'
    ELSE ''
  END ||

  '<div class="rek-item"><strong>Ban:</strong> Premium: Michelin Pilot Sport, Pirelli P-Zero, Continental UC6</div>'
WHERE merek ILIKE 'MINI';
