-- ============================================================
-- 006_add_aftermarket_recommendations.sql
-- Menambahkan kolom rekomendasi_aftermarket ke tabel kendaraan
-- dan menghasilkan rekomendasinya secara dinamis.
-- ============================================================

ALTER TABLE kendaraan ADD COLUMN IF NOT EXISTS rekomendasi_aftermarket TEXT;

-- Update data secara dinamis berdasarkan nilai kolom yang ada
UPDATE kendaraan
SET rekomendasi_aftermarket = 
  '<div class="rek-item"><strong>Mesin:</strong> ' ||
  CASE 
    WHEN viskositas_oli LIKE '%0W-20%' THEN 'Motul H-Tech 100 Plus, Mobil 1, Shell Helix Eco'
    WHEN viskositas_oli LIKE '%5W-30%' OR viskositas_oli LIKE '%5W-40%' THEN 'Amsoil Signature, Motul 8100 X-Cess, Shell Helix Ultra'
    WHEN viskositas_oli LIKE '%10W-40%' THEN 'Shell Helix HX7, Fastron Techno, Motul Multipower'
    WHEN viskositas_oli LIKE '%15W-40%' THEN 'Mobil Delvac 1, Shell Rimula R4 X'
    ELSE 'Sesuaikan viskositas (Motul, Shell, Castrol, Mobil 1)'
  END || '</div>' ||

  '<div class="rek-item"><strong>Transmisi:</strong> ' ||
  CASE 
    WHEN tipe_transmisi = 'CVT' THEN 'Aisin CFEx, Motul CVTF, Eneos CVTF'
    WHEN tipe_transmisi = 'Manual' THEN 'Motul Motylgear 75W-90, Shell Spirax S4, Red Line MT-90'
    WHEN tipe_transmisi = 'AT' AND (oli_transmisi ILIKE '%WS%' OR oli_transmisi ILIKE '%Dexron VI%') THEN 'Aisin AFW-VI, Motul ATF VI, Idemitsu ATF'
    WHEN tipe_transmisi = 'AT' THEN 'Aisin AFW+, Motul ATF 1A, Shell Spirax S3'
    WHEN tipe_transmisi = 'AMT' THEN 'Motul Motylgear 75W-90 (Cek buku manual untuk aktuator)'
    ELSE 'Motul Multi DCTF (Jika Dual Clutch)'
  END || '</div>' ||

  '<div class="rek-item"><strong>Rem:</strong> ' ||
  CASE 
    WHEN minyak_rem ILIKE '%DOT 4%' THEN 'Prestone DOT 4, STP Brake Fluid DOT 4, Motul DOT 4'
    ELSE 'Prestone DOT 4 (Aman substitusi DOT 3), STP Brake Fluid'
  END || '</div>' ||

  CASE 
    WHEN tipe_power_steering ILIKE '%Elektrik%' OR tipe_power_steering ILIKE '%EPS%' THEN ''
    WHEN merek = 'Honda' AND tipe_power_steering ILIKE '%Hidrolik%' THEN '<div class="rek-item"><strong>Power Steering:</strong> Prestone Honda PSF, Idemitsu PSF</div>'
    WHEN tipe_power_steering ILIKE '%Hidrolik%' THEN '<div class="rek-item"><strong>Power Steering:</strong> STP PSF All Vehicle, Aisin AFW+</div>'
    ELSE ''
  END;

SELECT 'Rekomendasi aftermarket berhasil digenerate dan ditambahkan.' AS status;
