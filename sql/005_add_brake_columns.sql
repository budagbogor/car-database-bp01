-- ============================================================
-- 005_add_brake_columns.sql
-- Menambahkan kolom tipe_sistem_rem dan minyak_rem ke tabel kendaraan
-- dan meng-update datanya secara massal.
-- ============================================================

-- 1. Tambah Kolom
ALTER TABLE kendaraan 
  ADD COLUMN IF NOT EXISTS tipe_sistem_rem VARCHAR(250),
  ADD COLUMN IF NOT EXISTS minyak_rem VARCHAR(100);

-- 2. Nilai Default / Base (Kebanyakan mobil penumpang standar di Indonesia)
UPDATE kendaraan
SET 
  tipe_sistem_rem = 'Depan: Ventilated Disc, Belakang: Drum',
  minyak_rem = 'DOT 3';

-- 3. Update berdasarkan Kategori (Pendekatan umum)
-- Hatchback/Sedan premium, SUV menengah atas biasanya cakram semua
UPDATE kendaraan
SET tipe_sistem_rem = 'Depan: Ventilated Disc, Belakang: Solid Disc',
    minyak_rem = 'DOT 4'
WHERE kategori IN ('Sedan', 'Sedan Premium', 'Sedan/Hatchback', 'Crossover', 'SUV Premium', 'SUV 7-seat', 'SUV Premium 7-seat');

-- LCGC dan City Car lama biasanya Solid Disc depan
UPDATE kendaraan
SET tipe_sistem_rem = 'Depan: Solid Disc, Belakang: Drum',
    minyak_rem = 'DOT 3'
WHERE kategori IN ('LCGC MPV', 'LCGC Hatchback', 'City Car');

-- Mobil jadul (tahun < 2005) biasanya DOT 3, dan banyak yang belum Ventilated
UPDATE kendaraan
SET tipe_sistem_rem = 'Depan: Solid Disc, Belakang: Drum',
    minyak_rem = 'DOT 3'
WHERE tahun LIKE '19%' OR tahun LIKE '2000%' OR tahun LIKE '2001%' OR tahun LIKE '2002%' OR tahun LIKE '2003%';

-- 4. Overrides Spesifik Per Merek & Model

-- TOYOTA
UPDATE kendaraan SET tipe_sistem_rem = 'Depan: Ventilated Disc, Belakang: Drum', minyak_rem = 'DOT 3' WHERE merek = 'Toyota' AND model IN ('Avanza', 'Veloz', 'Kijang Innova (Reborn)', 'Kijang Innova (Gen 1)', 'Rush (Gen 1)', 'Rush (Gen 2)', 'Calya', 'Agya', 'Raize', 'Sienta');
UPDATE kendaraan SET tipe_sistem_rem = 'Depan: Ventilated Disc, Belakang: Solid Disc', minyak_rem = 'DOT 3 / DOT 4' WHERE merek = 'Toyota' AND model IN ('Kijang Innova Zenix', 'Yaris Cross', 'Corolla Cross', 'Corolla Altis', 'Camry', 'Voxy', 'Alphard');
-- Fortuner GR Sport dan VRZ baru pakai disc belakang, lawas pakai drum
UPDATE kendaraan SET tipe_sistem_rem = 'Depan: Ventilated Disc, Belakang: Solid Disc (Varian atas) / Drum (Varian bawah)', minyak_rem = 'DOT 3 / DOT 4' WHERE merek = 'Toyota' AND model LIKE 'Fortuner%';
UPDATE kendaraan SET tipe_sistem_rem = 'Depan: 4-pot Ventilated Disc, Belakang: 2-pot Ventilated Disc', minyak_rem = 'DOT 4 / DOT 5.1' WHERE merek = 'Toyota' AND model = 'GR Yaris';
UPDATE kendaraan SET tipe_sistem_rem = 'Depan: Ventilated Disc, Belakang: Ventilated Disc', minyak_rem = 'DOT 4' WHERE merek = 'Toyota' AND model = 'Land Cruiser Prado/300';

-- DAIHATSU
UPDATE kendaraan SET tipe_sistem_rem = 'Depan: Ventilated Disc, Belakang: Drum', minyak_rem = 'DOT 3' WHERE merek = 'Daihatsu' AND model IN ('Xenia', 'Terios', 'Rocky', 'Luxio', 'Gran Max (Bensin)', 'Gran Max (Diesel)');
UPDATE kendaraan SET tipe_sistem_rem = 'Depan: Solid Disc, Belakang: Drum', minyak_rem = 'DOT 3' WHERE merek = 'Daihatsu' AND model IN ('Ayla', 'Sigra', 'Sirion', 'Zebra', 'Espass', 'Taruna');

-- HONDA
UPDATE kendaraan SET tipe_sistem_rem = 'Depan: Ventilated Disc, Belakang: Drum', minyak_rem = 'DOT 3 / DOT 4' WHERE merek = 'Honda' AND model IN ('Brio', 'Mobilio', 'BR-V');
UPDATE kendaraan SET tipe_sistem_rem = 'Depan: Ventilated Disc, Belakang: Solid Disc', minyak_rem = 'DOT 3 / DOT 4' WHERE merek = 'Honda' AND model IN ('HR-V', 'CR-V', 'Civic', 'Accord', 'City', 'City Hatchback', 'Jazz');

-- SUZUKI
UPDATE kendaraan SET tipe_sistem_rem = 'Depan: Ventilated Disc, Belakang: Drum', minyak_rem = 'DOT 3' WHERE merek = 'Suzuki' AND model IN ('Ertiga', 'XL7', 'Ignis', 'Baleno', 'Grand Vitara', 'Jimny', 'APV', 'APV Arena');
UPDATE kendaraan SET tipe_sistem_rem = 'Depan: Solid Disc, Belakang: Drum', minyak_rem = 'DOT 3' WHERE merek = 'Suzuki' AND model IN ('Carry 1.5', 'Futura', 'Escudo', 'Karimun');

-- MITSUBISHI
UPDATE kendaraan SET tipe_sistem_rem = 'Depan: Ventilated Disc, Belakang: Drum', minyak_rem = 'DOT 3 / DOT 4' WHERE merek = 'Mitsubishi' AND model IN ('Xpander', 'Xpander Cross', 'Triton', 'L300');
-- Pajero Sport Dakar pakai disc belakang, Exceed/GLX pakai drum
UPDATE kendaraan SET tipe_sistem_rem = 'Depan: Ventilated Disc, Belakang: Solid Disc (Dakar) / Drum (Exceed)', minyak_rem = 'DOT 3 / DOT 4' WHERE merek = 'Mitsubishi' AND model LIKE '%Pajero Sport%';
UPDATE kendaraan SET tipe_sistem_rem = 'Depan: Ventilated Disc, Belakang: Solid Disc', minyak_rem = 'DOT 4' WHERE merek = 'Mitsubishi' AND model IN ('Xforce', 'Outlander');

-- NISSAN
UPDATE kendaraan SET tipe_sistem_rem = 'Depan: Ventilated Disc, Belakang: Drum', minyak_rem = 'DOT 3' WHERE merek = 'Nissan' AND model IN ('Grand Livina', 'Livina', 'Evalia', 'March');
UPDATE kendaraan SET tipe_sistem_rem = 'Depan: Ventilated Disc, Belakang: Solid Disc', minyak_rem = 'DOT 3 / DOT 4' WHERE merek = 'Nissan' AND model IN ('X-Trail', 'Serena', 'Terra', 'Navara', 'Kicks e-POWER');

-- WULING
UPDATE kendaraan SET tipe_sistem_rem = 'Depan: Ventilated Disc, Belakang: Solid Disc', minyak_rem = 'DOT 4' WHERE merek = 'Wuling' AND model IN ('Almaz', 'Cortez', 'BinguoEV', 'Cloud EV');
UPDATE kendaraan SET tipe_sistem_rem = 'Depan: Ventilated Disc, Belakang: Drum', minyak_rem = 'DOT 4' WHERE merek = 'Wuling' AND model IN ('Confero');
UPDATE kendaraan SET tipe_sistem_rem = 'Depan: Solid Disc, Belakang: Drum', minyak_rem = 'DOT 4' WHERE merek = 'Wuling' AND model IN ('Air EV');

-- HYUNDAI / KIA
UPDATE kendaraan SET tipe_sistem_rem = 'Depan: Ventilated Disc, Belakang: Solid Disc', minyak_rem = 'DOT 4' WHERE (merek = 'Hyundai' OR merek = 'Kia') AND model IN ('Ioniq 5', 'Ioniq 6', 'EV6', 'Santa Fe', 'Palisade', 'Tucson', 'Sportage', 'Creta', 'Seltos', 'Staria');
UPDATE kendaraan SET tipe_sistem_rem = 'Depan: Ventilated Disc, Belakang: Drum', minyak_rem = 'DOT 4' WHERE (merek = 'Hyundai' OR merek = 'Kia') AND model IN ('Stargazer', 'Sonet', 'H-1');

-- MAZDA
UPDATE kendaraan SET tipe_sistem_rem = 'Depan: Ventilated Disc, Belakang: Solid Disc', minyak_rem = 'DOT 3 / DOT 4' WHERE merek = 'Mazda';

-- EROPA (Mercedes-Benz, BMW, Audi, VW, Volvo)
UPDATE kendaraan SET tipe_sistem_rem = 'Depan: Ventilated Disc, Belakang: Ventilated Disc', minyak_rem = 'DOT 4 / DOT 4 LV' WHERE merek IN ('Mercedes-Benz', 'BMW', 'Audi', 'Volkswagen', 'Volvo');

-- AMERIKA (Ford, Chevrolet, Jeep)
UPDATE kendaraan SET tipe_sistem_rem = 'Depan: Ventilated Disc, Belakang: Drum', minyak_rem = 'DOT 3 / DOT 4' WHERE merek IN ('Ford', 'Chevrolet') AND model IN ('Ranger', 'Everest', 'Colorado', 'Trailblazer', 'Captiva');
UPDATE kendaraan SET tipe_sistem_rem = 'Depan: Ventilated Disc, Belakang: Solid Disc', minyak_rem = 'DOT 4' WHERE merek = 'Jeep';

-- 5. Return status
SELECT 'Kolom sistem rem dan minyak rem berhasil ditambahkan dan diinisialisasi.' AS status;
