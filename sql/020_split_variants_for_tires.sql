-- =============================================================================
-- 020_split_variants_for_tires.sql
-- Memecah model menjadi varian spesifik agar data ukuran ban akurat (tanpa fallback)
-- =============================================================================

-- =============================================================================
-- 1. PEMISAHAN VARIAN (INSERT FROM SELECT lalu DELETE)
-- =============================================================================

-- ── HYUNDAI IONIQ 5 ──────────────────────────────────────────────────────────
INSERT INTO kendaraan (merek, model, tahun, kategori, bahan_bakar, kode_mesin, kapasitas_cc, tipe_transmisi, detail_transmisi, viskositas_oli, standar_oli, kapasitas_oli, oli_transmisi, tipe_power_steering, fluida_power_steering, tipe_sistem_rem, minyak_rem, ukuran_ban, merek_ban_oem, tekanan_ban, rekomendasi_aftermarket)
SELECT merek, 'Ioniq 5 (Standard Range / Prime)', tahun, kategori, bahan_bakar, kode_mesin, kapasitas_cc, tipe_transmisi, detail_transmisi, viskositas_oli, standar_oli, kapasitas_oli, oli_transmisi, tipe_power_steering, fluida_power_steering, tipe_sistem_rem, minyak_rem, 
'235/55 R19', 'Michelin Pilot Sport EV', 'Depan: 36 PSI, Belakang: 36 PSI', rekomendasi_aftermarket
FROM kendaraan WHERE merek = 'Hyundai' AND model = 'Ioniq 5';

INSERT INTO kendaraan (merek, model, tahun, kategori, bahan_bakar, kode_mesin, kapasitas_cc, tipe_transmisi, detail_transmisi, viskositas_oli, standar_oli, kapasitas_oli, oli_transmisi, tipe_power_steering, fluida_power_steering, tipe_sistem_rem, minyak_rem, ukuran_ban, merek_ban_oem, tekanan_ban, rekomendasi_aftermarket)
SELECT merek, 'Ioniq 5 (Signature Long Range)', tahun, kategori, bahan_bakar, kode_mesin, kapasitas_cc, tipe_transmisi, detail_transmisi, viskositas_oli, standar_oli, kapasitas_oli, oli_transmisi, tipe_power_steering, fluida_power_steering, tipe_sistem_rem, minyak_rem, 
'255/45 R20', 'Michelin Pilot Sport EV', 'Depan: 36 PSI, Belakang: 36 PSI', rekomendasi_aftermarket
FROM kendaraan WHERE merek = 'Hyundai' AND model = 'Ioniq 5';

DELETE FROM kendaraan WHERE merek = 'Hyundai' AND model = 'Ioniq 5';

-- ── TOYOTA YARIS CROSS (Bensin Biasa) ────────────────────────────────────────
INSERT INTO kendaraan (merek, model, tahun, kategori, bahan_bakar, kode_mesin, kapasitas_cc, tipe_transmisi, detail_transmisi, viskositas_oli, standar_oli, kapasitas_oli, oli_transmisi, tipe_power_steering, fluida_power_steering, tipe_sistem_rem, minyak_rem, ukuran_ban, merek_ban_oem, tekanan_ban, rekomendasi_aftermarket)
SELECT merek, 'Yaris Cross (1.5 G)', tahun, kategori, bahan_bakar, kode_mesin, kapasitas_cc, tipe_transmisi, detail_transmisi, viskositas_oli, standar_oli, kapasitas_oli, oli_transmisi, tipe_power_steering, fluida_power_steering, tipe_sistem_rem, minyak_rem, 
'215/60 R17', 'Bridgestone Turanza T005A / Dunlop Enasave', 'Depan: 33 PSI, Belakang: 33 PSI', rekomendasi_aftermarket
FROM kendaraan WHERE merek = 'Toyota' AND model = 'Yaris Cross';

INSERT INTO kendaraan (merek, model, tahun, kategori, bahan_bakar, kode_mesin, kapasitas_cc, tipe_transmisi, detail_transmisi, viskositas_oli, standar_oli, kapasitas_oli, oli_transmisi, tipe_power_steering, fluida_power_steering, tipe_sistem_rem, minyak_rem, ukuran_ban, merek_ban_oem, tekanan_ban, rekomendasi_aftermarket)
SELECT merek, 'Yaris Cross (1.5 S / S GR Sport)', tahun, kategori, bahan_bakar, kode_mesin, kapasitas_cc, tipe_transmisi, detail_transmisi, viskositas_oli, standar_oli, kapasitas_oli, oli_transmisi, tipe_power_steering, fluida_power_steering, tipe_sistem_rem, minyak_rem, 
'215/55 R18', 'Bridgestone Turanza T005A / Dunlop Enasave', 'Depan: 33 PSI, Belakang: 33 PSI', rekomendasi_aftermarket
FROM kendaraan WHERE merek = 'Toyota' AND model = 'Yaris Cross';

DELETE FROM kendaraan WHERE merek = 'Toyota' AND model = 'Yaris Cross';

-- Yaris Cross Hybrid bawaannya sudah S, ukurannya 215/55 R18, langsung diupdate di bagian bawah.

-- ── TOYOTA ALPHARD / VELLFIRE (Gen 3) ────────────────────────────────────────
INSERT INTO kendaraan (merek, model, tahun, kategori, bahan_bakar, kode_mesin, kapasitas_cc, tipe_transmisi, detail_transmisi, viskositas_oli, standar_oli, kapasitas_oli, oli_transmisi, tipe_power_steering, fluida_power_steering, tipe_sistem_rem, minyak_rem, ukuran_ban, merek_ban_oem, tekanan_ban, rekomendasi_aftermarket)
SELECT merek, 'Alphard (2.5 X / G)', tahun, kategori, bahan_bakar, kode_mesin, kapasitas_cc, tipe_transmisi, detail_transmisi, viskositas_oli, standar_oli, kapasitas_oli, oli_transmisi, tipe_power_steering, fluida_power_steering, tipe_sistem_rem, minyak_rem, 
'235/50 R18', 'Toyo Tranpath / Bridgestone', 'Depan: 34 PSI, Belakang: 34 PSI', rekomendasi_aftermarket
FROM kendaraan WHERE merek = 'Toyota' AND model = 'Alphard / Vellfire (Gen 3)';

INSERT INTO kendaraan (merek, model, tahun, kategori, bahan_bakar, kode_mesin, kapasitas_cc, tipe_transmisi, detail_transmisi, viskositas_oli, standar_oli, kapasitas_oli, oli_transmisi, tipe_power_steering, fluida_power_steering, tipe_sistem_rem, minyak_rem, ukuran_ban, merek_ban_oem, tekanan_ban, rekomendasi_aftermarket)
SELECT merek, 'Vellfire (2.5 G / ZG)', tahun, kategori, bahan_bakar, kode_mesin, kapasitas_cc, tipe_transmisi, detail_transmisi, viskositas_oli, standar_oli, kapasitas_oli, oli_transmisi, tipe_power_steering, fluida_power_steering, tipe_sistem_rem, minyak_rem, 
'235/50 R18', 'Toyo Tranpath / Bridgestone', 'Depan: 34 PSI, Belakang: 34 PSI', rekomendasi_aftermarket
FROM kendaraan WHERE merek = 'Toyota' AND model = 'Alphard / Vellfire (Gen 3)';

DELETE FROM kendaraan WHERE merek = 'Toyota' AND model = 'Alphard / Vellfire (Gen 3)';


-- =============================================================================
-- 2. UPDATE MASSAL KENDARAAN (Satu Model, Satu Ukuran)
-- =============================================================================

-- WULING & EV LAINNYA
UPDATE kendaraan SET ukuran_ban = '145/70 R12', merek_ban_oem = 'Giti', tekanan_ban = 'Depan: 32 PSI, Belakang: 36 PSI' WHERE model LIKE '%Air EV%';
UPDATE kendaraan SET ukuran_ban = '185/60 R15', merek_ban_oem = 'Linglong / Giti', tekanan_ban = 'Depan: 32 PSI, Belakang: 32 PSI' WHERE model LIKE '%BinguoEV%';
UPDATE kendaraan SET ukuran_ban = '215/55 R18', merek_ban_oem = 'Giti', tekanan_ban = 'Depan: 36 PSI, Belakang: 36 PSI' WHERE model LIKE '%Cloud EV%';
UPDATE kendaraan SET ukuran_ban = '205/60 R16', merek_ban_oem = 'Giti / Atlas', tekanan_ban = 'Depan: 33 PSI, Belakang: 33 PSI' WHERE model LIKE '%Alvez%';
UPDATE kendaraan SET ukuran_ban = '255/45 R20', merek_ban_oem = 'Pirelli P-Zero', tekanan_ban = 'Depan: 36 PSI, Belakang: 36 PSI' WHERE model LIKE '%Ioniq 6%';

-- BYD
UPDATE kendaraan SET ukuran_ban = '215/55 R18', merek_ban_oem = 'Atlas Batman / Continental', tekanan_ban = 'Depan: 36 PSI, Belakang: 36 PSI' WHERE model = 'Atto 3';
UPDATE kendaraan SET ukuran_ban = '195/60 R16 / 205/50 R17', merek_ban_oem = 'Linglong', tekanan_ban = 'Depan: 36 PSI, Belakang: 36 PSI' WHERE model = 'Dolphin';
UPDATE kendaraan SET ukuran_ban = '235/45 R19', merek_ban_oem = 'Continental EcoContact', tekanan_ban = 'Depan: 36 PSI, Belakang: 36 PSI' WHERE model = 'Seal';

-- NISSAN & SUZUKI
UPDATE kendaraan SET ukuran_ban = '205/55 R17', merek_ban_oem = 'Dunlop Enasave', tekanan_ban = 'Depan: 33 PSI, Belakang: 33 PSI' WHERE model LIKE '%Kicks%';
UPDATE kendaraan SET ukuran_ban = '255/60 R18', merek_ban_oem = 'Bridgestone Dueler', tekanan_ban = 'Depan: 35 PSI, Belakang: 35 PSI' WHERE model LIKE '%Terra%';
UPDATE kendaraan SET ukuran_ban = '195/60 R16', merek_ban_oem = 'Goodyear Assurance', tekanan_ban = 'Depan: 33 PSI, Belakang: 33 PSI' WHERE model LIKE '%Fronx%';
UPDATE kendaraan SET ukuran_ban = '175/60 R15', merek_ban_oem = 'Dunlop / Maxxis', tekanan_ban = 'Depan: 32 PSI, Belakang: 32 PSI' WHERE model LIKE '%March%';
UPDATE kendaraan SET ukuran_ban = '225/55 R18', merek_ban_oem = 'Toyo Proxes', tekanan_ban = 'Depan: 34 PSI, Belakang: 34 PSI' WHERE model LIKE '%Elgrand%';
UPDATE kendaraan SET ukuran_ban = '155/70 R13', merek_ban_oem = 'Strada', tekanan_ban = 'Depan: 32 PSI, Belakang: 32 PSI' WHERE model LIKE '%Datsun%';

-- LEXUS
UPDATE kendaraan SET ukuran_ban = '235/50 R21', merek_ban_oem = 'Bridgestone Alenza / Dunlop', tekanan_ban = 'Depan: 35 PSI, Belakang: 35 PSI' WHERE model LIKE '%RX350h%';
UPDATE kendaraan SET ukuran_ban = '235/50 R20', merek_ban_oem = 'Bridgestone Alenza', tekanan_ban = 'Depan: 34 PSI, Belakang: 34 PSI' WHERE model LIKE '%NX350h%';
UPDATE kendaraan SET ukuran_ban = '265/55 R22', merek_ban_oem = 'Dunlop Grandtrek', tekanan_ban = 'Depan: 33 PSI, Belakang: 33 PSI' WHERE model LIKE '%LX600%';

-- MAZDA
UPDATE kendaraan SET ukuran_ban = '185/60 R16', merek_ban_oem = 'Dunlop Enasave EC300', tekanan_ban = 'Depan: 33 PSI, Belakang: 33 PSI' WHERE merek = 'Mazda' AND model LIKE '%Mazda 2%';
UPDATE kendaraan SET ukuran_ban = '225/45 R19', merek_ban_oem = 'Bridgestone Turanza T005', tekanan_ban = 'Depan: 34 PSI, Belakang: 34 PSI' WHERE merek = 'Mazda' AND model LIKE '%Mazda 6%';
UPDATE kendaraan SET ukuran_ban = '255/50 R20', merek_ban_oem = 'Falken / Toyo Proxes', tekanan_ban = 'Depan: 34 PSI, Belakang: 34 PSI' WHERE merek = 'Mazda' AND model LIKE '%CX-9%';
UPDATE kendaraan SET ukuran_ban = '235/50 R20', merek_ban_oem = 'Toyo Proxes Sport', tekanan_ban = 'Depan: 36 PSI, Belakang: 36 PSI' WHERE merek = 'Mazda' AND model LIKE '%CX-60%';
UPDATE kendaraan SET ukuran_ban = '205/45 R17', merek_ban_oem = 'Bridgestone Potenza S001', tekanan_ban = 'Depan: 29 PSI, Belakang: 29 PSI' WHERE merek = 'Mazda' AND model LIKE '%MX-5%';

-- MERCEDES-BENZ
UPDATE kendaraan SET ukuran_ban = '205/55 R17 / 225/45 R18', merek_ban_oem = 'Pirelli / Michelin (RFT)', tekanan_ban = 'Depan: 32 PSI, Belakang: 32 PSI' WHERE model LIKE '%A-Class%' OR model LIKE '%B-Class%' OR model LIKE '%CLA-Class%';
UPDATE kendaraan SET ukuran_ban = '275/50 R20', merek_ban_oem = 'Pirelli Scorpion Zero', tekanan_ban = 'Depan: 35 PSI, Belakang: 35 PSI' WHERE model LIKE '%G-Class%';
UPDATE kendaraan SET ukuran_ban = '245/45 R19', merek_ban_oem = 'Continental SportContact', tekanan_ban = 'Depan: 35 PSI, Belakang: 38 PSI' WHERE model LIKE '%S-Class%';
UPDATE kendaraan SET ukuran_ban = '245/45 R18', merek_ban_oem = 'Goodyear / Continental', tekanan_ban = 'Depan: 34 PSI, Belakang: 34 PSI' WHERE model LIKE '%V-Class%';

-- BMW
UPDATE kendaraan SET ukuran_ban = '225/40 R18', merek_ban_oem = 'Pirelli Cinturato / Bridgestone Turanza (RFT)', tekanan_ban = 'Depan: 32 PSI, Belakang: 35 PSI' WHERE model LIKE '%1 Series%' OR model LIKE '%2 Series%';
UPDATE kendaraan SET ukuran_ban = 'Depan: 225/40 R19, Belakang: 255/35 R19 (Staggered)', merek_ban_oem = 'Pirelli P-Zero RFT', tekanan_ban = 'Depan: 34 PSI, Belakang: 38 PSI' WHERE model LIKE '%4 Series%';
UPDATE kendaraan SET ukuran_ban = '245/45 R19 / 275/40 R19 (Staggered)', merek_ban_oem = 'Pirelli P-Zero RFT', tekanan_ban = 'Depan: 33 PSI, Belakang: 36 PSI' WHERE model LIKE '%7 Series%';
UPDATE kendaraan SET ukuran_ban = '245/50 R19 (RFT)', merek_ban_oem = 'Bridgestone Alenza / Pirelli', tekanan_ban = 'Depan: 32 PSI, Belakang: 32 PSI' WHERE model LIKE '%X3%' OR model LIKE '%X4%';
UPDATE kendaraan SET ukuran_ban = '275/40 R21 / 315/35 R21 (Staggered RFT)', merek_ban_oem = 'Pirelli / Continental', tekanan_ban = 'Depan: 35 PSI, Belakang: 38 PSI' WHERE model LIKE '%X7%';

-- JEEP, FORD, CHEVROLET, AUDI, VOLVO
UPDATE kendaraan SET ukuran_ban = '255/75 R17', merek_ban_oem = 'BFGoodrich Mud-Terrain', tekanan_ban = 'Depan: 37 PSI, Belakang: 37 PSI' WHERE model LIKE '%Wrangler%';
UPDATE kendaraan SET ukuran_ban = '225/55 R18', merek_ban_oem = 'Firestone / Yokohama', tekanan_ban = 'Depan: 35 PSI, Belakang: 35 PSI' WHERE model LIKE '%Cherokee%';
UPDATE kendaraan SET ukuran_ban = '265/50 R20', merek_ban_oem = 'Pirelli Scorpion', tekanan_ban = 'Depan: 36 PSI, Belakang: 36 PSI' WHERE model LIKE '%Grand Cherokee%';
UPDATE kendaraan SET ukuran_ban = '215/60 R17', merek_ban_oem = 'Bridgestone Turanza', tekanan_ban = 'Depan: 35 PSI, Belakang: 35 PSI' WHERE model LIKE '%Renegade%';

UPDATE kendaraan SET ukuran_ban = '265/60 R18', merek_ban_oem = 'Goodyear EfficientGrip SUV', tekanan_ban = 'Depan: 35 PSI, Belakang: 35 PSI' WHERE model LIKE '%Everest%';
UPDATE kendaraan SET ukuran_ban = '235/50 R19', merek_ban_oem = 'Hankook Optimo / Dunlop', tekanan_ban = 'Depan: 34 PSI, Belakang: 34 PSI' WHERE model LIKE '%Captiva%';

UPDATE kendaraan SET ukuran_ban = '225/50 R17', merek_ban_oem = 'Pirelli Cinturato P7', tekanan_ban = 'Depan: 33 PSI, Belakang: 33 PSI' WHERE model LIKE '%A4%' OR model LIKE '%A6%';
UPDATE kendaraan SET ukuran_ban = '235/45 R18', merek_ban_oem = 'Michelin Pilot Sport 4', tekanan_ban = 'Depan: 35 PSI, Belakang: 35 PSI' WHERE model LIKE '%S60%';
UPDATE kendaraan SET ukuran_ban = '275/45 R20', merek_ban_oem = 'Pirelli Scorpion Verde', tekanan_ban = 'Depan: 38 PSI, Belakang: 38 PSI' WHERE model LIKE '%XC90%';
UPDATE kendaraan SET ukuran_ban = '215/55 R17', merek_ban_oem = 'Pirelli Cinturato P7', tekanan_ban = 'Depan: 33 PSI, Belakang: 33 PSI' WHERE model LIKE '%Passat%';

-- RENAULT
UPDATE kendaraan SET ukuran_ban = '225/60 R18', merek_ban_oem = 'Nexen N Priz', tekanan_ban = 'Depan: 33 PSI, Belakang: 33 PSI' WHERE model LIKE '%Koleos%';
UPDATE kendaraan SET ukuran_ban = '185/65 R15', merek_ban_oem = 'Ceat SecuraDrive', tekanan_ban = 'Depan: 32 PSI, Belakang: 32 PSI' WHERE model LIKE '%Triber%';
UPDATE kendaraan SET ukuran_ban = '205/55 R17', merek_ban_oem = 'Michelin Primacy 3', tekanan_ban = 'Depan: 33 PSI, Belakang: 33 PSI' WHERE model LIKE '%Captur%';
UPDATE kendaraan SET ukuran_ban = '235/40 R18', merek_ban_oem = 'Michelin Pilot Sport', tekanan_ban = 'Depan: 34 PSI, Belakang: 34 PSI' WHERE model LIKE '%Megane%';
UPDATE kendaraan SET ukuran_ban = '205/40 R18', merek_ban_oem = 'Dunlop Sport Maxx', tekanan_ban = 'Depan: 33 PSI, Belakang: 33 PSI' WHERE model LIKE '%Clio%';

-- SAPU BERSIH (Yaris Cross Hybrid, Alphard Gen2, Gen4, Nav1)
UPDATE kendaraan SET ukuran_ban = '215/55 R18', merek_ban_oem = 'Bridgestone Turanza T005A', tekanan_ban = 'Depan: 33 PSI, Belakang: 33 PSI' WHERE model = 'Yaris Cross (Hybrid)';
UPDATE kendaraan SET ukuran_ban = '235/50 R18', merek_ban_oem = 'Toyo Tranpath', tekanan_ban = 'Depan: 34 PSI, Belakang: 34 PSI' WHERE merek = 'Toyota' AND model LIKE '%Alphard%' AND ukuran_ban LIKE 'Bervariasi%';
UPDATE kendaraan SET ukuran_ban = '195/65 R15', merek_ban_oem = 'Bridgestone Ecopia', tekanan_ban = 'Depan: 33 PSI, Belakang: 33 PSI' WHERE model LIKE '%NAV1%';
UPDATE kendaraan SET ukuran_ban = '225/55 R18', merek_ban_oem = 'Dunlop Enasave', tekanan_ban = 'Depan: 33 PSI, Belakang: 33 PSI' WHERE model LIKE '%Destinator%';
