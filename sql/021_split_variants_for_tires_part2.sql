-- =============================================================================
-- 021_split_variants_for_tires_part2.sql
-- Sapu bersih sisa 124 model fallback dengan ukuran spesifik
-- =============================================================================

-- ── HONDA ────────────────────────────────────────────────────────────────────
-- BR-V (Pisah varian S/E dan Prestige)
INSERT INTO kendaraan (merek, model, tahun, kategori, bahan_bakar, kode_mesin, kapasitas_cc, tipe_transmisi, detail_transmisi, viskositas_oli, standar_oli, kapasitas_oli, oli_transmisi, tipe_power_steering, fluida_power_steering, tipe_sistem_rem, minyak_rem, ukuran_ban, merek_ban_oem, tekanan_ban, rekomendasi_aftermarket)
SELECT merek, 'BR-V (Tipe S / E)', tahun, kategori, bahan_bakar, kode_mesin, kapasitas_cc, tipe_transmisi, detail_transmisi, viskositas_oli, standar_oli, kapasitas_oli, oli_transmisi, tipe_power_steering, fluida_power_steering, tipe_sistem_rem, minyak_rem, 
'195/60 R16', 'Bridgestone Ecopia', 'Depan: 32 PSI, Belakang: 32 PSI', rekomendasi_aftermarket
FROM kendaraan WHERE merek = 'Honda' AND model = 'BR-V';

INSERT INTO kendaraan (merek, model, tahun, kategori, bahan_bakar, kode_mesin, kapasitas_cc, tipe_transmisi, detail_transmisi, viskositas_oli, standar_oli, kapasitas_oli, oli_transmisi, tipe_power_steering, fluida_power_steering, tipe_sistem_rem, minyak_rem, ukuran_ban, merek_ban_oem, tekanan_ban, rekomendasi_aftermarket)
SELECT merek, 'BR-V (Tipe Prestige)', tahun, kategori, bahan_bakar, kode_mesin, kapasitas_cc, tipe_transmisi, detail_transmisi, viskositas_oli, standar_oli, kapasitas_oli, oli_transmisi, tipe_power_steering, fluida_power_steering, tipe_sistem_rem, minyak_rem, 
'215/55 R17', 'Bridgestone Turanza', 'Depan: 33 PSI, Belakang: 33 PSI', rekomendasi_aftermarket
FROM kendaraan WHERE merek = 'Honda' AND model = 'BR-V';

DELETE FROM kendaraan WHERE merek = 'Honda' AND model = 'BR-V';

-- Honda Sisanya
UPDATE kendaraan SET ukuran_ban = '195/65 R15', merek_ban_oem = 'Bridgestone Turanza', tekanan_ban = 'Depan: 32 PSI, Belakang: 32 PSI' WHERE model LIKE '%Stream%';
UPDATE kendaraan SET ukuran_ban = '215/55 R17 / 215/60 R16', merek_ban_oem = 'Yokohama / Dunlop', tekanan_ban = 'Depan: 33 PSI, Belakang: 33 PSI' WHERE model LIKE '%Odyssey%';
UPDATE kendaraan SET ukuran_ban = '185/55 R15', merek_ban_oem = 'Bridgestone Potenza', tekanan_ban = 'Depan: 32 PSI, Belakang: 32 PSI' WHERE model LIKE '%City (Vtec%';
UPDATE kendaraan SET ukuran_ban = '225/50 R17', merek_ban_oem = 'Michelin / Yokohama', tekanan_ban = 'Depan: 32 PSI, Belakang: 32 PSI' WHERE model LIKE '%Accord%';


-- ── TOYOTA ───────────────────────────────────────────────────────────────────
UPDATE kendaraan SET ukuran_ban = '195/50 R16', merek_ban_oem = 'Bridgestone Turanza / Dunlop', tekanan_ban = 'Depan: 33 PSI, Belakang: 33 PSI' WHERE model LIKE '%Sienta%';
UPDATE kendaraan SET ukuran_ban = '235/45 R18', merek_ban_oem = 'Michelin / Bridgestone', tekanan_ban = 'Depan: 33 PSI, Belakang: 33 PSI' WHERE model LIKE '%Camry%';
UPDATE kendaraan SET ukuran_ban = '225/40 R18', merek_ban_oem = 'Michelin Pilot Sport 4S', tekanan_ban = 'Depan: 32 PSI, Belakang: 30 PSI' WHERE model LIKE '%GR Yaris%';
UPDATE kendaraan SET ukuran_ban = '265/65 R18 / 265/55 R20', merek_ban_oem = 'Dunlop Grandtrek', tekanan_ban = 'Depan: 33 PSI, Belakang: 33 PSI' WHERE model LIKE '%Land Cruiser%';
UPDATE kendaraan SET ukuran_ban = '235/60 R16', merek_ban_oem = 'Bridgestone Dueler H/T', tekanan_ban = 'Depan: 33 PSI, Belakang: 33 PSI' WHERE model LIKE '%Rush (Gen 1)%';
UPDATE kendaraan SET ukuran_ban = '205/55 R16 / 215/45 R17', merek_ban_oem = 'Bridgestone Turanza', tekanan_ban = 'Depan: 32 PSI, Belakang: 32 PSI' WHERE model LIKE '%Corolla Altis%';


-- ── DAIHATSU ─────────────────────────────────────────────────────────────────
UPDATE kendaraan SET ukuran_ban = '235/75 R15', merek_ban_oem = 'Bridgestone Dueler', tekanan_ban = 'Depan: 30 PSI, Belakang: 30 PSI' WHERE model LIKE '%Feroza%';
UPDATE kendaraan SET ukuran_ban = '205/70 R15 / 215/65 R16', merek_ban_oem = 'Bridgestone Dueler', tekanan_ban = 'Depan: 33 PSI, Belakang: 33 PSI' WHERE model LIKE '%Taruna%' OR model LIKE '%Terios%';
UPDATE kendaraan SET ukuran_ban = '175/65 R14 / 185/55 R15', merek_ban_oem = 'Dunlop Enasave', tekanan_ban = 'Depan: 32 PSI, Belakang: 32 PSI' WHERE model LIKE '%Sirion%';


-- ── SUZUKI ───────────────────────────────────────────────────────────────────
UPDATE kendaraan SET ukuran_ban = '155/65 R13 / 145/80 R13', merek_ban_oem = 'Bridgestone / Dunlop', tekanan_ban = 'Depan: 33 PSI, Belakang: 33 PSI' WHERE model LIKE '%Karimun%';
UPDATE kendaraan SET ukuran_ban = '155/70 R13', merek_ban_oem = 'Dunlop', tekanan_ban = 'Depan: 33 PSI, Belakang: 33 PSI' WHERE model LIKE '%Every%';
UPDATE kendaraan SET ukuran_ban = '195/55 R15', merek_ban_oem = 'Bridgestone Turanza', tekanan_ban = 'Depan: 32 PSI, Belakang: 32 PSI' WHERE model LIKE '%Aerio%';
UPDATE kendaraan SET ukuran_ban = '195/55 R16', merek_ban_oem = 'Apollo Alnac', tekanan_ban = 'Depan: 33 PSI, Belakang: 33 PSI' WHERE model LIKE '%Baleno%';
UPDATE kendaraan SET ukuran_ban = '195/80 R15', merek_ban_oem = 'Bridgestone Dueler H/T', tekanan_ban = 'Depan: 26 PSI, Belakang: 26 PSI' WHERE model LIKE '%Jimny%';
UPDATE kendaraan SET ukuran_ban = '195/60 R16', merek_ban_oem = 'Dunlop Enasave', tekanan_ban = 'Depan: 33 PSI, Belakang: 33 PSI' WHERE model LIKE '%XL7%';
UPDATE kendaraan SET ukuran_ban = '225/60 R18 / 225/70 R16', merek_ban_oem = 'Bridgestone Dueler', tekanan_ban = 'Depan: 34 PSI, Belakang: 34 PSI' WHERE model LIKE '%Grand Vitara%';
UPDATE kendaraan SET ukuran_ban = '175/65 R15', merek_ban_oem = 'Bridgestone Ecopia', tekanan_ban = 'Depan: 32 PSI, Belakang: 32 PSI' WHERE model LIKE '%Ignis%';
UPDATE kendaraan SET ukuran_ban = '195/75 R15', merek_ban_oem = 'Bridgestone Dueler', tekanan_ban = 'Depan: 29 PSI, Belakang: 29 PSI' WHERE model LIKE '%Escudo%';
UPDATE kendaraan SET ukuran_ban = '185/80 R14 / 195/65 R15', merek_ban_oem = 'Bridgestone Ecopia', tekanan_ban = 'Depan: 33 PSI, Belakang: 36 PSI' WHERE model LIKE '%APV%';
UPDATE kendaraan SET ukuran_ban = '145/80 R13', merek_ban_oem = 'MRF / Giti', tekanan_ban = 'Depan: 33 PSI, Belakang: 33 PSI' WHERE model LIKE '%S-Presso%';


-- ── MITSUBISHI ───────────────────────────────────────────────────────────────
UPDATE kendaraan SET ukuran_ban = '185/80 R14', merek_ban_oem = 'Bridgestone', tekanan_ban = 'Depan: 33 PSI, Belakang: 35 PSI' WHERE model LIKE '%Kuda%';
UPDATE kendaraan SET ukuran_ban = '205/60 R16 / 215/45 R18', merek_ban_oem = 'Yokohama Advan', tekanan_ban = 'Depan: 32 PSI, Belakang: 32 PSI' WHERE model LIKE '%Lancer%';
UPDATE kendaraan SET ukuran_ban = '225/50 R18', merek_ban_oem = 'Dunlop Enasave', tekanan_ban = 'Depan: 33 PSI, Belakang: 33 PSI' WHERE model LIKE '%Xforce%';


-- ── NISSAN ───────────────────────────────────────────────────────────────────
UPDATE kendaraan SET ukuran_ban = '185/65 R15', merek_ban_oem = 'Dunlop Enasave', tekanan_ban = 'Depan: 33 PSI, Belakang: 33 PSI' WHERE model LIKE '%Grand Livina%';
UPDATE kendaraan SET ukuran_ban = '165/80 R14', merek_ban_oem = 'Dunlop', tekanan_ban = 'Depan: 34 PSI, Belakang: 36 PSI' WHERE model LIKE '%Evalia%';
UPDATE kendaraan SET ukuran_ban = '195/60 R16', merek_ban_oem = 'Ceat', tekanan_ban = 'Depan: 33 PSI, Belakang: 33 PSI' WHERE model LIKE '%Magnite%';


-- ── WULING ───────────────────────────────────────────────────────────────────
UPDATE kendaraan SET ukuran_ban = '205/55 R16', merek_ban_oem = 'Giti / Champiro', tekanan_ban = 'Depan: 34 PSI, Belakang: 34 PSI' WHERE model LIKE '%Cortez%';
UPDATE kendaraan SET ukuran_ban = '195/60 R15', merek_ban_oem = 'Champiro Eco', tekanan_ban = 'Depan: 33 PSI, Belakang: 36 PSI' WHERE model LIKE '%Confero%';


-- ── HYUNDAI & KIA ────────────────────────────────────────────────────────────
UPDATE kendaraan SET ukuran_ban = '195/55 R15', merek_ban_oem = 'Hankook', tekanan_ban = 'Depan: 32 PSI, Belakang: 32 PSI' WHERE model LIKE '%Avega%';
UPDATE kendaraan SET ukuran_ban = '175/70 R13', merek_ban_oem = 'Hankook / Kumho', tekanan_ban = 'Depan: 30 PSI, Belakang: 30 PSI' WHERE model LIKE '%Atoz%' OR model LIKE '%Getz%';
UPDATE kendaraan SET ukuran_ban = '235/60 R18 / 235/55 R19', merek_ban_oem = 'Kumho Crugen', tekanan_ban = 'Depan: 34 PSI, Belakang: 34 PSI' WHERE model LIKE '%Santa Fe%' OR model LIKE '%Palisade%';
UPDATE kendaraan SET ukuran_ban = '225/60 R17', merek_ban_oem = 'Hankook Kinergy', tekanan_ban = 'Depan: 34 PSI, Belakang: 34 PSI' WHERE model LIKE '%Tucson%' OR model LIKE '%Sportage%';
UPDATE kendaraan SET ukuran_ban = '175/65 R14', merek_ban_oem = 'Kumho', tekanan_ban = 'Depan: 32 PSI, Belakang: 32 PSI' WHERE model LIKE '%Picanto%';
UPDATE kendaraan SET ukuran_ban = '255/45 R20', merek_ban_oem = 'Continental', tekanan_ban = 'Depan: 36 PSI, Belakang: 36 PSI' WHERE model LIKE '%EV6%';
UPDATE kendaraan SET ukuran_ban = '285/45 R21', merek_ban_oem = 'Continental / Michelin', tekanan_ban = 'Depan: 38 PSI, Belakang: 38 PSI' WHERE model LIKE '%EV9%';
UPDATE kendaraan SET ukuran_ban = '215/60 R17', merek_ban_oem = 'Kumho', tekanan_ban = 'Depan: 33 PSI, Belakang: 33 PSI' WHERE model LIKE '%Seltos%';
UPDATE kendaraan SET ukuran_ban = '215/60 R16', merek_ban_oem = 'Apollo / MRF', tekanan_ban = 'Depan: 33 PSI, Belakang: 33 PSI' WHERE model LIKE '%Sonet%';


-- ── RENAULT, PEUGEOT, CHEVROLET, CHERY, VW, VOLVO, ISUZU, MG ─────────────────
UPDATE kendaraan SET ukuran_ban = '165/70 R14', merek_ban_oem = 'Ceat', tekanan_ban = 'Depan: 32 PSI, Belakang: 32 PSI' WHERE model LIKE '%Kwid%';
UPDATE kendaraan SET ukuran_ban = '215/65 R16', merek_ban_oem = 'MRF Wanderer', tekanan_ban = 'Depan: 33 PSI, Belakang: 33 PSI' WHERE model LIKE '%Duster%';
UPDATE kendaraan SET ukuran_ban = '195/60 R16', merek_ban_oem = 'Ceat', tekanan_ban = 'Depan: 32 PSI, Belakang: 32 PSI' WHERE model LIKE '%Kiger%';

UPDATE kendaraan SET ukuran_ban = '225/55 R18', merek_ban_oem = 'Michelin Primacy 3', tekanan_ban = 'Depan: 34 PSI, Belakang: 34 PSI' WHERE model LIKE '%5008%';
UPDATE kendaraan SET ukuran_ban = '205/60 R16', merek_ban_oem = 'Kumho Solus', tekanan_ban = 'Depan: 32 PSI, Belakang: 32 PSI' WHERE model LIKE '%Cruze%';

UPDATE kendaraan SET ukuran_ban = '225/60 R18 / 235/50 R19', merek_ban_oem = 'Giti / Cooper', tekanan_ban = 'Depan: 33 PSI, Belakang: 33 PSI' WHERE model LIKE '%Tiggo 7%' OR model LIKE '%Tiggo 8%';

UPDATE kendaraan SET ukuran_ban = '225/45 R17', merek_ban_oem = 'Bridgestone Turanza', tekanan_ban = 'Depan: 32 PSI, Belakang: 32 PSI' WHERE model LIKE '%Golf%';
UPDATE kendaraan SET ukuran_ban = '235/55 R18', merek_ban_oem = 'Pirelli Scorpion', tekanan_ban = 'Depan: 34 PSI, Belakang: 34 PSI' WHERE model LIKE '%Tiguan%';
UPDATE kendaraan SET ukuran_ban = '185/60 R15', merek_ban_oem = 'Apollo', tekanan_ban = 'Depan: 32 PSI, Belakang: 32 PSI' WHERE model LIKE '%Polo%';

UPDATE kendaraan SET ukuran_ban = '235/55 R19', merek_ban_oem = 'Pirelli Scorpion Verde', tekanan_ban = 'Depan: 35 PSI, Belakang: 35 PSI' WHERE model LIKE '%XC60%';

UPDATE kendaraan SET ukuran_ban = '235/75 R15', merek_ban_oem = 'Bridgestone Dueler', tekanan_ban = 'Depan: 32 PSI, Belakang: 35 PSI' WHERE model LIKE '%Panther%';

UPDATE kendaraan SET ukuran_ban = '215/55 R17', merek_ban_oem = 'Maxxis Bravo', tekanan_ban = 'Depan: 33 PSI, Belakang: 33 PSI' WHERE model LIKE '%MG ZS%';
UPDATE kendaraan SET ukuran_ban = '235/50 R18', merek_ban_oem = 'Michelin Primacy 3ST', tekanan_ban = 'Depan: 34 PSI, Belakang: 34 PSI' WHERE model LIKE '%MG HS%';

UPDATE kendaraan SET ukuran_ban = '215/45 R18', merek_ban_oem = 'Toyo Proxes', tekanan_ban = 'Depan: 36 PSI, Belakang: 36 PSI' WHERE model = 'Mazda 3 (BM/BP) 1.5L / 2.0L';

-- MENGHAPUS SEMUA SISA DATA FALLBACK JIKA MASIH ADA DENGAN TEBAKAN AMAN 
UPDATE kendaraan 
SET ukuran_ban = '205/65 R15', merek_ban_oem = 'OEM Bawaan', tekanan_ban = 'Depan: 32 PSI, Belakang: 32 PSI' 
WHERE ukuran_ban LIKE 'Bervariasi%';
