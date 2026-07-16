-- =============================================================================
-- 022_update_aftermarket_recommendations.sql
-- Menimpa rekomendasi_aftermarket lama dengan algoritma yang jauh lebih pintar,
-- memperhitungkan Merek, Bahan Bakar (EV), dan Spesifikasi Ban.
-- =============================================================================

UPDATE kendaraan
SET rekomendasi_aftermarket = 
  -- ---------------------------------------------------------------------------
  -- 1. OLI MESIN ATAU MOTOR TRAKSI (EV)
  -- ---------------------------------------------------------------------------
  CASE WHEN bahan_bakar = 'listrik' THEN 
    '<div class="rek-item"><strong>Motor Traksi (Gardan EV):</strong> TMO EV Fluid / Nissan Matic S / Wuling EV Gear Oil / Sesuai Buku Manual</div>'
  ELSE
    '<div class="rek-item"><strong>Mesin:</strong> ' ||
    CASE 
      -- MOBIL EROPA (Ketat Standar)
      WHEN merek IN ('BMW', 'Mercedes-Benz', 'Audi', 'Volkswagen', 'Volvo', 'Peugeot', 'Renault') THEN
          CASE 
              WHEN viskositas_oli LIKE '%0W-20%' THEN 'Liqui Moly Top Tec 6600, Ravenol VSE, Fuchs Titan GT1'
              WHEN viskositas_oli LIKE '%5W-30%' OR viskositas_oli LIKE '%5W-40%' THEN 'Motul 8100 X-Clean, Liqui Moly Top Tec 4200, Mobil 1 ESP'
              ELSE 'Wajib spesifikasi Eropa (Longlife-04 / MB-Approval 229.5)'
          END
      -- TOYOTA, DAIHATSU, LEXUS
      WHEN merek IN ('Toyota', 'Daihatsu', 'Lexus') THEN
          CASE 
              WHEN viskositas_oli LIKE '%0W-20%' THEN 'TMO 0W-20, Fastron Eco 0W-20, Shell Helix Eco'
              WHEN viskositas_oli LIKE '%5W-30%' THEN 'TMO 5W-30, Fastron Gold 5W-30, Motul H-Tech'
              WHEN viskositas_oli LIKE '%10W-40%' THEN 'TMO 10W-40, Fastron Techno, Shell Helix HX7'
              ELSE 'TMO, Fastron, Shell, Motul'
          END
      -- HONDA
      WHEN merek = 'Honda' THEN
          CASE 
              WHEN viskositas_oli LIKE '%0W-20%' THEN 'Honda E-Pro Gold 0W-20, Idemitsu 0W-20, Eneos'
              WHEN viskositas_oli LIKE '%5W-30%' THEN 'Honda E-Pro Blue 5W-30, Idemitsu 5W-30, Motul'
              ELSE 'Honda Automobile Oil (HAO), Idemitsu, Eneos'
          END
      -- MITSUBISHI, NISSAN, MAZDA, SUZUKI
      WHEN merek IN ('Mitsubishi', 'Nissan', 'Mazda', 'Suzuki', 'Datsun') THEN
          CASE 
              WHEN bahan_bakar = 'diesel' THEN 'Mobil Delvac 1, Shell Rimula R4 X, Motul CRDi'
              WHEN viskositas_oli LIKE '%0W-20%' THEN 'Idemitsu 0W-20, Eneos 0W-20, Motul H-Tech'
              WHEN viskositas_oli LIKE '%5W-30%' THEN 'Idemitsu 5W-30, Eneos 5W-30, Shell Helix HX8'
              WHEN viskositas_oli LIKE '%10W-40%' THEN 'Idemitsu 10W-40, Shell Helix HX7, Fastron Techno'
              ELSE 'Idemitsu, Eneos, Shell'
          END
      -- MOBIL LAINNYA
      ELSE
          CASE 
              WHEN bahan_bakar = 'diesel' THEN 'Mobil Delvac, Shell Rimula, Fastron Diesel'
              WHEN viskositas_oli LIKE '%0W-20%' THEN 'Motul H-Tech, Shell Helix Eco'
              WHEN viskositas_oli LIKE '%5W-30%' THEN 'Fastron Gold, Shell Helix HX8'
              WHEN viskositas_oli LIKE '%10W-40%' THEN 'Fastron Techno, Shell Helix HX7'
              ELSE 'Motul, Shell, Fastron, Mobil 1'
          END
    END || '</div>'
  END ||

  -- ---------------------------------------------------------------------------
  -- 2. OLI TRANSMISI
  -- ---------------------------------------------------------------------------
  CASE WHEN bahan_bakar = 'listrik' THEN ''
  ELSE
    '<div class="rek-item"><strong>Transmisi:</strong> ' ||
    CASE 
      WHEN tipe_transmisi = 'CVT' THEN 
          CASE 
              WHEN merek = 'Honda' THEN 'Honda CVTF / HCF-2, Idemitsu CVTF, Eneos CVTF'
              WHEN merek = 'Nissan' THEN 'Nissan NS-3, Idemitsu CVTF'
              ELSE 'Aisin CFEx, Motul CVTF, Idemitsu CVTF'
          END
      WHEN tipe_transmisi = 'Manual' THEN 'Motul Motylgear 75W-90, Shell Spirax S4, Red Line MT-90'
      WHEN tipe_transmisi = 'AT' THEN 
          CASE 
              WHEN merek IN ('Toyota', 'Daihatsu', 'Lexus') THEN 'TMO ATF WS, Aisin AFW-VI, Idemitsu ATF'
              WHEN merek IN ('Mitsubishi', 'Pajero') THEN 'Mitsubishi ATF SP-III/PA, Aisin AFW+'
              ELSE 'Aisin AFW+, Motul ATF 1A, Shell Spirax S3'
          END
      WHEN tipe_transmisi = 'AMT' THEN 'Motul Motylgear 75W-90 (Cek buku manual untuk oli aktuator)'
      ELSE 'Motul Multi DCTF / ATF VI'
    END || '</div>'
  END ||

  -- ---------------------------------------------------------------------------
  -- 3. MINYAK REM
  -- ---------------------------------------------------------------------------
  '<div class="rek-item"><strong>Rem:</strong> ' ||
  CASE 
    WHEN merek IN ('BMW', 'Mercedes-Benz', 'Audi', 'Volkswagen', 'Volvo') THEN 'Brembo DOT 4, Pentosin DOT 4, Motul RBF 600'
    WHEN merek IN ('Toyota', 'Honda', 'Mitsubishi', 'Mazda') THEN 'Seiken DOT 3 / DOT 4, TCL, Prestone'
    ELSE 'Prestone DOT 4, STP Brake Fluid, Seiken'
  END || '</div>' ||

  -- ---------------------------------------------------------------------------
  -- 4. POWER STEERING (Hanya jika Hidrolik)
  -- ---------------------------------------------------------------------------
  CASE 
    WHEN tipe_power_steering ILIKE '%Elektrik%' OR tipe_power_steering ILIKE '%EPS%' THEN ''
    WHEN merek = 'Honda' AND tipe_power_steering ILIKE '%Hidrolik%' THEN '<div class="rek-item"><strong>Power Steering:</strong> Prestone Honda PSF, Idemitsu PSF</div>'
    WHEN tipe_power_steering ILIKE '%Hidrolik%' THEN '<div class="rek-item"><strong>Power Steering:</strong> STP PSF All Vehicle, Aisin AFW+</div>'
    ELSE ''
  END ||

  -- ---------------------------------------------------------------------------
  -- 5. REKOMENDASI BAN (Berdasarkan Kualitas OEM)
  -- ---------------------------------------------------------------------------
  '<div class="rek-item"><strong>Ban:</strong> ' ||
  CASE 
    WHEN merek_ban_oem ILIKE '%Michelin%' OR merek_ban_oem ILIKE '%Pirelli%' OR merek_ban_oem ILIKE '%Continental%' THEN 
      'Premium: Michelin Pilot Sport, Pirelli P-Zero, Continental UC6'
    WHEN merek_ban_oem ILIKE '%Bridgestone%' OR merek_ban_oem ILIKE '%Dunlop%' OR merek_ban_oem ILIKE '%Toyo%' THEN 
      'Middle-Up: Bridgestone Turanza/Ecopia, Dunlop Enasave, Yokohama BluEarth'
    ELSE 
      'Value/Standard: Hankook Kinergy, GT Radial Champiro, Accelera, Bridgestone Ecopia'
  END || '</div>';

SELECT 'Update sistem rekomendasi cerdas untuk semua merek dan EV selesai.' AS status;
