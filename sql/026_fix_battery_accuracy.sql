-- =============================================================================
-- 026_fix_battery_accuracy.sql
-- Memperbaiki akurasi spesifikasi tipe aki dan OEM untuk sisa model
-- yang sebelumnya masih 'Bervariasi (Cek Fisik)'
-- =============================================================================

-- =============================================================================
-- 1. TOYOTA & DAIHATSU (Platform TNGA, ISS, & Sisa Model)
-- =============================================================================
-- TNGA (Corolla Cross, C-HR, Corolla Altis) - Menggunakan standar DIN (LN2)
UPDATE kendaraan 
SET tipe_aki = 'LN2 (DIN 55 / 345LN2)', merek_aki_oem = 'GS Astra / Yuasa' 
WHERE merek = 'Toyota' AND (model ILIKE '%C-HR%' OR model ILIKE '%Corolla%');

-- Raize / Rocky (Menggunakan ISS)
UPDATE kendaraan 
SET tipe_aki = 'Q-85 (ISS)', merek_aki_oem = 'GS Astra (ISS)' 
WHERE merek IN ('Toyota', 'Daihatsu') AND (model ILIKE '%Raize%' OR model ILIKE '%Rocky%');

-- MPV Pintu Geser (Sienta, Voxy, NAV1) - Biasanya Q-85 atau S-95 (ISS)
UPDATE kendaraan 
SET tipe_aki = 'Q-85 / S-95 (ISS)', merek_aki_oem = 'GS Astra / Panasonic' 
WHERE merek = 'Toyota' AND (model ILIKE '%Sienta%' OR model ILIKE '%Voxy%' OR model ILIKE '%NAV1%');

-- Alphard / Vellfire (Pastikan semua model)
UPDATE kendaraan 
SET tipe_aki = 'S-95 / 80D26L (60Ah - 70Ah)', merek_aki_oem = 'GS Astra / Panasonic' 
WHERE merek = 'Toyota' AND (model ILIKE '%Alphard%' OR model ILIKE '%Vellfire%') AND tipe_aki ILIKE '%Bervariasi%';

-- Sisa Toyota/Daihatsu kecil (Etios, Sirion lama)
UPDATE kendaraan 
SET tipe_aki = 'NS40ZL / 34B19L (35Ah)', merek_aki_oem = 'GS Astra / Incoe' 
WHERE merek IN ('Toyota', 'Daihatsu') AND (model ILIKE '%Etios%' OR model ILIKE '%Sirion%') AND tipe_aki ILIKE '%Bervariasi%';

-- Toyota SUV Bensin Besar (Fortuner Bensin, Land Cruiser bensin)
UPDATE kendaraan 
SET tipe_aki = '80D26L / 55D23L', merek_aki_oem = 'GS Astra / Panasonic' 
WHERE merek = 'Toyota' AND (model ILIKE '%Fortuner%' OR model ILIKE '%Land Cruiser%') AND bahan_bakar = 'bensin' AND tipe_aki ILIKE '%Bervariasi%';

-- =============================================================================
-- 2. SUZUKI
-- =============================================================================
-- Jimny & Katana (Bentuk kotak, kutub kanan R)
UPDATE kendaraan 
SET tipe_aki = 'NS60 / 46B24R (45Ah)', merek_aki_oem = 'Yuasa / GS Astra' 
WHERE merek = 'Suzuki' AND (model ILIKE '%Jimny%' OR model ILIKE '%Katana%');

-- City Car (Splash, Karimun, S-Presso, Celerio, Aerio)
UPDATE kendaraan 
SET tipe_aki = 'NS40ZL / 34B19L (35Ah)', merek_aki_oem = 'Yuasa / GS Astra' 
WHERE merek = 'Suzuki' AND (model ILIKE '%Splash%' OR model ILIKE '%Karimun%' OR model ILIKE '%S-Presso%' OR model ILIKE '%Celerio%' OR model ILIKE '%Aerio%');

-- Hatchback & SUV Medium (Swift, SX4, S-Cross, Grand Vitara Bensin lama)
UPDATE kendaraan 
SET tipe_aki = '55D23L (60Ah)', merek_aki_oem = 'Yuasa / GS Astra' 
WHERE merek = 'Suzuki' AND (model ILIKE '%Swift%' OR model ILIKE '%SX4%' OR model ILIKE '%S-Cross%' OR model ILIKE '%Grand Vitara%') AND tipe_aki ILIKE '%Bervariasi%';

-- Grand Vitara Hybrid / Fronx Hybrid (Mild Hybrid)
UPDATE kendaraan 
SET tipe_aki = 'N-55 (ISS / Mild Hybrid)', merek_aki_oem = 'Yuasa / GS Astra' 
WHERE merek = 'Suzuki' AND bahan_bakar ILIKE '%hybrid%' AND tipe_aki ILIKE '%Bervariasi%';

-- =============================================================================
-- 3. MITSUBISHI
-- =============================================================================
-- Pajero Sport & Triton (Diesel)
UPDATE kendaraan 
SET tipe_aki = '80D26L / N70Z (70Ah - 80Ah)', merek_aki_oem = 'GS Astra / Incoe' 
WHERE merek = 'Mitsubishi' AND (model ILIKE '%Pajero%' OR model ILIKE '%Triton%');

-- Outlander Sport, Lancer, Delica
UPDATE kendaraan 
SET tipe_aki = '55D23L (60Ah)', merek_aki_oem = 'GS Astra / Yuasa' 
WHERE merek = 'Mitsubishi' AND (model ILIKE '%Outlander%' OR model ILIKE '%Lancer%' OR model ILIKE '%Delica%');

-- Mirage
UPDATE kendaraan 
SET tipe_aki = 'NS40ZL / 34B19L (35Ah)', merek_aki_oem = 'GS Astra / Yuasa' 
WHERE merek = 'Mitsubishi' AND model ILIKE '%Mirage%';

-- =============================================================================
-- 4. NISSAN
-- =============================================================================
-- X-Trail, Serena, Juke (Beberapa pakai ISS / Q-85, standar 55D23L)
UPDATE kendaraan 
SET tipe_aki = '55D23L / Q-85 (ISS)', merek_aki_oem = 'GS Astra / Panasonic' 
WHERE merek = 'Nissan' AND (model ILIKE '%X-Trail%' OR model ILIKE '%Serena%' OR model ILIKE '%Juke%');

-- Terra, Navara (Diesel)
UPDATE kendaraan 
SET tipe_aki = '80D26L / N70Z (70Ah - 80Ah)', merek_aki_oem = 'GS Astra / Incoe' 
WHERE merek = 'Nissan' AND (model ILIKE '%Terra%' OR model ILIKE '%Navara%');

-- Kicks e-Power, Leaf (EV / Series Hybrid - Auxiliary Battery)
UPDATE kendaraan 
SET tipe_aki = 'LN1 / LN2 (Auxiliary)', merek_aki_oem = 'Panasonic / Varta' 
WHERE merek = 'Nissan' AND (model ILIKE '%Kicks%' OR model ILIKE '%Leaf%');

-- Livina (Kembaran Xpander)
UPDATE kendaraan 
SET tipe_aki = 'NS60L / 46B24L (45Ah)', merek_aki_oem = 'GS Astra / Yuasa' 
WHERE merek = 'Nissan' AND model ILIKE '%Livina%' AND model NOT ILIKE '%Grand Livina%';

-- =============================================================================
-- 5. MAZDA
-- =============================================================================
-- Mazda non-skyactiv atau SUV besar lawas (Biante, CX-7, CX-9 lama)
UPDATE kendaraan 
SET tipe_aki = 'S-95 / 55D23L (ISS)', merek_aki_oem = 'Panasonic / GS Astra' 
WHERE merek = 'Mazda' AND tipe_aki ILIKE '%Bervariasi%';

-- =============================================================================
-- 6. HONDA (Sisa Model)
-- =============================================================================
-- Odyssey, Stream, Freed
UPDATE kendaraan 
SET tipe_aki = 'NS60L / 46B24L (45Ah)', merek_aki_oem = 'GS Astra / Panasonic' 
WHERE merek = 'Honda' AND (model ILIKE '%Odyssey%' OR model ILIKE '%Stream%' OR model ILIKE '%Freed%') AND tipe_aki ILIKE '%Bervariasi%';

-- =============================================================================
-- 7. PEMBERSIHAN (Sisa yang benar-benar tidak terpetakan, agar informatif)
-- =============================================================================
UPDATE kendaraan 
SET tipe_aki = 'Cek Manual (Standar 45Ah - 60Ah)', merek_aki_oem = 'OEM' 
WHERE tipe_aki ILIKE '%Bervariasi%';
