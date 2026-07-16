-- =============================================================================
-- 025_add_battery_columns.sql
-- Menambahkan kolom tipe_aki dan merek_aki_oem, mengisi datanya,
-- serta memperbarui rekomendasi aftermarket.
-- =============================================================================

-- 1. Tambah Kolom
ALTER TABLE kendaraan ADD COLUMN IF NOT EXISTS tipe_aki TEXT DEFAULT 'Bervariasi (Cek Fisik)';
ALTER TABLE kendaraan ADD COLUMN IF NOT EXISTS merek_aki_oem TEXT DEFAULT 'OEM Bawaan';

-- 2. Update Massal Data Aki
-- -----------------------------------------------------------------------------
-- MOBIL LISTRIK (EV) - Auxiliary Battery 12V
-- -----------------------------------------------------------------------------
UPDATE kendaraan SET tipe_aki = 'LN1 / LN2 (45Ah - 60Ah)', merek_aki_oem = 'Hankook / Delkor' WHERE bahan_bakar = 'listrik' AND merek IN ('Hyundai', 'Kia');
UPDATE kendaraan SET tipe_aki = 'LN2 (45Ah)', merek_aki_oem = 'BMW Group' WHERE bahan_bakar = 'listrik' AND merek = 'MINI';
UPDATE kendaraan SET tipe_aki = 'LN1 / 34B19L (12V)', merek_aki_oem = 'Camel / Giti' WHERE bahan_bakar = 'listrik' AND merek = 'Wuling';
UPDATE kendaraan SET tipe_aki = 'LN2 / LN3 (12V)', merek_aki_oem = 'BYD / Camel' WHERE bahan_bakar = 'listrik' AND merek = 'BYD';

-- -----------------------------------------------------------------------------
-- MOBIL EROPA (DIN Standard / AGM / EFB)
-- -----------------------------------------------------------------------------
UPDATE kendaraan SET tipe_aki = 'DIN 80 / LN4 AGM', merek_aki_oem = 'Varta / BMW Group' WHERE merek = 'BMW' OR merek = 'MINI';
UPDATE kendaraan SET tipe_aki = 'DIN 80 / DIN 100 AGM', merek_aki_oem = 'Varta / Mercedes-Benz' WHERE merek = 'Mercedes-Benz';
UPDATE kendaraan SET tipe_aki = 'DIN 55 / DIN 66 (LN2/LN3)', merek_aki_oem = 'Varta / Banner' WHERE merek IN ('Volkswagen', 'Audi', 'Peugeot', 'Renault', 'Volvo');
UPDATE kendaraan SET tipe_aki = 'DIN 60 / DIN 80', merek_aki_oem = 'Delkor / Hankook' WHERE merek IN ('Chevrolet', 'Ford');
UPDATE kendaraan SET tipe_aki = 'DIN 80 / LN4 AGM', merek_aki_oem = 'Varta / Mopar' WHERE merek = 'Jeep';

-- -----------------------------------------------------------------------------
-- MOBIL JEPANG (JIS Standard)
-- -----------------------------------------------------------------------------
-- DIESEL (Badak)
UPDATE kendaraan SET tipe_aki = '80D26L / N70Z (70Ah - 80Ah)', merek_aki_oem = 'GS Astra / Incoe' WHERE bahan_bakar = 'diesel' AND merek IN ('Toyota', 'Mitsubishi', 'Isuzu');
-- TOYOTA & DAIHATSU BENSIN
UPDATE kendaraan SET tipe_aki = 'NS40ZL / 34B19L (35Ah)', merek_aki_oem = 'GS Astra / Incoe' WHERE merek IN ('Toyota', 'Daihatsu') AND (model ILIKE '%Agya%' OR model ILIKE '%Ayla%' OR model ILIKE '%Sigra%' OR model ILIKE '%Calya%' OR model ILIKE '%Sirion%');
UPDATE kendaraan SET tipe_aki = 'NS60L / 46B24L (45Ah)', merek_aki_oem = 'GS Astra / Incoe' WHERE merek IN ('Toyota', 'Daihatsu') AND (model ILIKE '%Avanza%' OR model ILIKE '%Veloz%' OR model ILIKE '%Xenia%' OR model ILIKE '%Rush%' OR model ILIKE '%Terios%' OR model ILIKE '%Yaris%' OR model ILIKE '%Vios%');
UPDATE kendaraan SET tipe_aki = 'Q-85 (ISS / Idling Stop)', merek_aki_oem = 'GS Astra (ISS)' WHERE merek = 'Toyota' AND (model ILIKE '%Yaris Cross%' OR model ILIKE '%Zenix%');
UPDATE kendaraan SET tipe_aki = '55D23L (60Ah)', merek_aki_oem = 'GS Astra / Panasonic' WHERE merek = 'Toyota' AND (model ILIKE '%Camry%' OR model ILIKE '%Alphard%' OR model ILIKE '%Innova%') AND bahan_bakar = 'bensin';
-- HONDA
UPDATE kendaraan SET tipe_aki = 'NS40ZL / 34B19L (35Ah)', merek_aki_oem = 'GS Astra / Panasonic' WHERE merek = 'Honda' AND (model ILIKE '%Brio%' OR model ILIKE '%Mobilio%' OR model ILIKE '%City%' OR model ILIKE '%Jazz%');
UPDATE kendaraan SET tipe_aki = 'NS60L / 46B24L (45Ah)', merek_aki_oem = 'GS Astra / Panasonic' WHERE merek = 'Honda' AND (model ILIKE '%HR-V%' OR model ILIKE '%BR-V%' OR model ILIKE '%CR-V%' OR model ILIKE '%Civic%');
UPDATE kendaraan SET tipe_aki = '55D23L / 80D23L (60Ah)', merek_aki_oem = 'GS Astra / Panasonic' WHERE merek = 'Honda' AND model ILIKE '%Accord%';
-- MITSUBISHI, NISSAN, SUZUKI, MAZDA
UPDATE kendaraan SET tipe_aki = 'NS60L / 46B24L (45Ah)', merek_aki_oem = 'GS Astra / Yuasa' WHERE merek = 'Mitsubishi' AND (model ILIKE '%Xpander%' OR model ILIKE '%Xforce%');
UPDATE kendaraan SET tipe_aki = 'NS60L / 46B24L (45Ah)', merek_aki_oem = 'Yuasa / GS Astra' WHERE merek = 'Suzuki' AND (model ILIKE '%Ertiga%' OR model ILIKE '%XL7%' OR model ILIKE '%Ignis%' OR model ILIKE '%Baleno%');
UPDATE kendaraan SET tipe_aki = 'NS40ZL / 34B19L (35Ah)', merek_aki_oem = 'GS Astra / Yuasa' WHERE merek = 'Nissan' AND (model ILIKE '%March%' OR model ILIKE '%Grand Livina%');
UPDATE kendaraan SET tipe_aki = 'Q-85 (ISS / i-Stop)', merek_aki_oem = 'Panasonic / GS Astra' WHERE merek = 'Mazda' AND (model ILIKE '%Mazda 2%' OR model ILIKE '%Mazda 3%' OR model ILIKE '%Mazda 6%' OR model ILIKE '%CX-%');

-- -----------------------------------------------------------------------------
-- MOBIL KOREA & CHINA
-- -----------------------------------------------------------------------------
UPDATE kendaraan SET tipe_aki = 'DIN 60 / LN2 (60Ah)', merek_aki_oem = 'Delkor / Hankook' WHERE merek IN ('Hyundai', 'Kia') AND bahan_bakar != 'listrik';
UPDATE kendaraan SET tipe_aki = 'DIN 55 / LN2', merek_aki_oem = 'Camel' WHERE merek = 'Wuling' AND bahan_bakar != 'listrik';

-- -----------------------------------------------------------------------------
-- 3. PERBARUI REKOMENDASI AFTERMARKET (Menyertakan Aki)
-- -----------------------------------------------------------------------------
UPDATE kendaraan
SET rekomendasi_aftermarket = rekomendasi_aftermarket || 
  '<div class="rek-item"><strong>Aki (Battery):</strong> ' ||
  CASE 
    WHEN merek IN ('BMW', 'Mercedes-Benz', 'Audi', 'Volkswagen', 'Volvo', 'Jeep', 'Peugeot') THEN 'Varta Silver Dynamic AGM, Bosch AGM, Amaron PRO DIN'
    WHEN merek IN ('Hyundai', 'Kia', 'Chevrolet', 'Ford') THEN 'Delkor, Hankook, Amaron DIN, GS Astra DIN'
    WHEN tipe_aki ILIKE '%ISS%' OR tipe_aki ILIKE '%Q-85%' THEN 'GS Astra ISS, Amaron Q-85, Panasonic ISS'
    ELSE 'GS Astra Maintenance Free, Amaron Hi-Life, Bosch, Yuasa'
  END || '</div>';
