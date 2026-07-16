-- =============================================================================
-- 024_add_camry_models.sql
-- Menambahkan varian lengkap Toyota Camry di Indonesia (XV30 hingga XV70)
-- =============================================================================

-- Hapus data Camry lama agar tidak duplikat
DELETE FROM kendaraan WHERE merek = 'Toyota' AND model ILIKE '%Camry%';

-- =============================================================================
-- GENERASI XV30 (2002 - 2006)
-- =============================================================================
INSERT INTO kendaraan (merek, model, tahun, kategori, bahan_bakar, kode_mesin, kapasitas_cc, tipe_transmisi, detail_transmisi, viskositas_oli, standar_oli, kapasitas_oli, oli_transmisi, tipe_power_steering, fluida_power_steering, tipe_sistem_rem, minyak_rem, ukuran_ban, merek_ban_oem, tekanan_ban)
VALUES
('Toyota', 'Camry 2.4 G (XV30)', '2002–2006', 'Sedan', 'bensin', '2AZ-FE 4-Silinder', '2362 cc', 'AT', '4-speed Super ECT', '10W-40 / 5W-30', 'API SN/SL', '4.3 L', 'ATF Type T-IV', 'Hidrolik', 'TMO ATF / Dexron III', 'Depan: Ventilated Disc, Belakang: Solid Disc', 'DOT 3', '205/65 R15', 'Bridgestone Turanza / Dunlop', 'Depan: 32 PSI, Belakang: 32 PSI'),
('Toyota', 'Camry 3.0 V (XV30)', '2002–2006', 'Sedan', 'bensin', '1MZ-FE V6', '2994 cc', 'AT', '4-speed Super ECT', '10W-40 / 5W-30', 'API SN/SL', '4.7 L', 'ATF Type T-IV', 'Hidrolik', 'TMO ATF / Dexron III', 'Depan: Ventilated Disc, Belakang: Solid Disc', 'DOT 3', '215/60 R16', 'Bridgestone Turanza / Dunlop', 'Depan: 32 PSI, Belakang: 32 PSI');

-- =============================================================================
-- GENERASI XV40 (2006 - 2012)
-- =============================================================================
INSERT INTO kendaraan (merek, model, tahun, kategori, bahan_bakar, kode_mesin, kapasitas_cc, tipe_transmisi, detail_transmisi, viskositas_oli, standar_oli, kapasitas_oli, oli_transmisi, tipe_power_steering, fluida_power_steering, tipe_sistem_rem, minyak_rem, ukuran_ban, merek_ban_oem, tekanan_ban)
VALUES
('Toyota', 'Camry 2.4 G / V (XV40)', '2006–2012', 'Sedan', 'bensin', '2AZ-FE 4-Silinder', '2362 cc', 'AT', '5-speed Super ECT', '10W-40 / 5W-30', 'API SN/SL', '4.3 L', 'ATF WS', 'Hidrolik', 'TMO ATF / Dexron III', 'Depan: Ventilated Disc, Belakang: Solid Disc', 'DOT 3', '215/60 R16', 'Bridgestone Turanza / Dunlop', 'Depan: 33 PSI, Belakang: 33 PSI'),
('Toyota', 'Camry 3.5 Q (XV40)', '2006–2012', 'Sedan', 'bensin', '2GR-FE V6', '3456 cc', 'AT', '6-speed Super ECT', '5W-30', 'API SN', '6.1 L', 'ATF WS', 'Hidrolik', 'TMO ATF / Dexron III', 'Depan: Ventilated Disc, Belakang: Solid Disc', 'DOT 3', '215/55 R17', 'Yokohama / Bridgestone', 'Depan: 33 PSI, Belakang: 33 PSI');

-- =============================================================================
-- GENERASI XV50 (2012 - 2018)
-- =============================================================================
INSERT INTO kendaraan (merek, model, tahun, kategori, bahan_bakar, kode_mesin, kapasitas_cc, tipe_transmisi, detail_transmisi, viskositas_oli, standar_oli, kapasitas_oli, oli_transmisi, tipe_power_steering, fluida_power_steering, tipe_sistem_rem, minyak_rem, ukuran_ban, merek_ban_oem, tekanan_ban)
VALUES
('Toyota', 'Camry 2.5 G / V (XV50)', '2012–2018', 'Sedan', 'bensin', '2AR-FE 4-Silinder Dual VVT-i', '2494 cc', 'AT', '6-speed Super ECT', '5W-30 / 0W-20', 'API SN, ILSAC GF-5', '4.4 L', 'ATF WS', 'Elektrik (EPS)', 'Tidak menggunakan fluida (sistem elektrik)', 'Depan: Ventilated Disc, Belakang: Solid Disc', 'DOT 3 / DOT 4', '215/55 R17', 'Yokohama / Bridgestone', 'Depan: 33 PSI, Belakang: 33 PSI'),
('Toyota', 'Camry 2.5 Hybrid (XV50)', '2012–2018', 'Sedan', 'hybrid', '2AR-FXE 4-Silinder Hybrid', '2494 cc', 'CVT', 'E-CVT', '0W-20', 'API SN, ILSAC GF-5', '4.4 L', 'ATF WS', 'Elektrik (EPS)', 'Tidak menggunakan fluida (sistem elektrik)', 'Depan: Ventilated Disc, Belakang: Solid Disc', 'DOT 3 / DOT 4', '215/55 R17', 'Yokohama / Bridgestone', 'Depan: 33 PSI, Belakang: 33 PSI');

-- =============================================================================
-- GENERASI XV70 (2019 - SEKARANG) TNGA
-- =============================================================================
INSERT INTO kendaraan (merek, model, tahun, kategori, bahan_bakar, kode_mesin, kapasitas_cc, tipe_transmisi, detail_transmisi, viskositas_oli, standar_oli, kapasitas_oli, oli_transmisi, tipe_power_steering, fluida_power_steering, tipe_sistem_rem, minyak_rem, ukuran_ban, merek_ban_oem, tekanan_ban)
VALUES
('Toyota', 'Camry 2.5 G / V (XV70)', '2019–sekarang', 'Sedan', 'bensin', '2AR-FE / A25A-FKS 4-Silinder', '2494 cc', 'AT', '6-speed / 8-speed Direct Shift AT', '0W-20 / 5W-30', 'API SN/SP, ILSAC GF-6', '4.4 - 4.5 L', 'ATF WS', 'Elektrik (EPS)', 'Tidak menggunakan fluida (sistem elektrik)', 'Depan: Ventilated Disc, Belakang: Solid Disc', 'DOT 3 / DOT 4', '235/45 R18 / 215/55 R17', 'Michelin / Bridgestone Turanza', 'Depan: 33 PSI, Belakang: 33 PSI'),
('Toyota', 'Camry 2.5 Hybrid (XV70)', '2019–sekarang', 'Sedan', 'hybrid', 'A25A-FXS 4-Silinder Hybrid', '2487 cc', 'CVT', 'E-CVT', '0W-20 / 0W-16', 'API SP, ILSAC GF-6B', '4.5 L', 'ATF WS', 'Elektrik (EPS)', 'Tidak menggunakan fluida (sistem elektrik)', 'Depan: Ventilated Disc, Belakang: Solid Disc', 'DOT 3 / DOT 4', '235/45 R18', 'Michelin / Bridgestone Turanza', 'Depan: 34 PSI, Belakang: 34 PSI');

-- =============================================================================
-- JALANKAN ULANG LOGIKA REKOMENDASI AFTERMARKET UNTUK CAMRY
-- =============================================================================
UPDATE kendaraan
SET rekomendasi_aftermarket = 
  '<div class="rek-item"><strong>Mesin:</strong> ' ||
  CASE 
      WHEN viskositas_oli LIKE '%0W-20%' THEN 'TMO 0W-20, Fastron Eco 0W-20, Shell Helix Eco'
      WHEN viskositas_oli LIKE '%5W-30%' THEN 'TMO 5W-30, Fastron Gold 5W-30, Motul H-Tech'
      WHEN viskositas_oli LIKE '%10W-40%' THEN 'TMO 10W-40, Fastron Techno, Shell Helix HX7'
      ELSE 'TMO, Fastron, Shell, Motul'
  END || '</div>' ||

  '<div class="rek-item"><strong>Transmisi:</strong> TMO ATF WS, Aisin AFW-VI, Idemitsu ATF</div>' ||

  '<div class="rek-item"><strong>Rem:</strong> Seiken DOT 3 / DOT 4, TCL, Prestone</div>' ||

  CASE 
    WHEN tipe_power_steering ILIKE '%Hidrolik%' THEN '<div class="rek-item"><strong>Power Steering:</strong> TMO ATF, STP PSF All Vehicle, Aisin AFW+</div>'
    ELSE ''
  END ||

  '<div class="rek-item"><strong>Ban:</strong> ' ||
  CASE 
    WHEN merek_ban_oem ILIKE '%Michelin%' THEN 'Premium: Michelin Pilot Sport, Continental UC6'
    ELSE 'Middle-Up: Bridgestone Turanza/Ecopia, Dunlop Enasave, Yokohama BluEarth'
  END || '</div>'
WHERE merek = 'Toyota' AND model ILIKE '%Camry%';
