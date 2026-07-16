-- =============================================================================
-- 019_add_tire_columns.sql
-- Menambahkan struktur tabel dan menyisipkan spesifikasi ban bawaan pabrik
-- =============================================================================

-- 1. Tambahkan Kolom Baru
ALTER TABLE kendaraan ADD COLUMN IF NOT EXISTS ukuran_ban VARCHAR(100) DEFAULT '-';
ALTER TABLE kendaraan ADD COLUMN IF NOT EXISTS merek_ban_oem VARCHAR(200) DEFAULT '-';
ALTER TABLE kendaraan ADD COLUMN IF NOT EXISTS tekanan_ban VARCHAR(100) DEFAULT '-';

-- =============================================================================
-- 2. INJEKSI DATA BAN - KENDARAAN POPULER
-- =============================================================================

-- ── LCGC (Agya, Ayla, Brio, Calya, Sigra) ────────────────────────────────────
UPDATE kendaraan 
SET ukuran_ban = '175/65 R14', 
    merek_ban_oem = 'Bridgestone Ecopia EP150 / GT Radial Champiro Eco', 
    tekanan_ban = 'Depan: 33 PSI, Belakang: 33 PSI (36 PSI max load)' 
WHERE model LIKE '%Agya%' OR model LIKE '%Ayla%' OR model LIKE '%Calya%' OR model LIKE '%Sigra%';

UPDATE kendaraan 
SET ukuran_ban = '175/65 R14 (Satya) / 185/55 R15 (RS)', 
    merek_ban_oem = 'Dunlop Enasave EC300+ / Bridgestone Ecopia EP150', 
    tekanan_ban = 'Depan: 29-32 PSI, Belakang: 29-30 PSI' 
WHERE model LIKE '%Brio%';

-- ── Low MPV (Avanza, Veloz, Xenia, Ertiga, Xpander) ──────────────────────────
UPDATE kendaraan 
SET ukuran_ban = '185/65 R15 (Tipe Bawah) / 195/60 R16 (Tipe Atas)', 
    merek_ban_oem = 'Dunlop Enasave / Bridgestone Ecopia', 
    tekanan_ban = 'Depan: 33 PSI, Belakang: 33 PSI' 
WHERE model LIKE '%Avanza%' OR model LIKE '%Xenia%' OR model LIKE '%Ertiga%' OR model LIKE '%Stargazer%' OR model LIKE '%Mobilio%';

UPDATE kendaraan 
SET ukuran_ban = '195/60 R16 / 205/50 R17', 
    merek_ban_oem = 'Bridgestone Turanza T005A / GT Radial', 
    tekanan_ban = 'Depan: 33 PSI, Belakang: 33 PSI' 
WHERE model LIKE '%Veloz%' OR model LIKE '%Xpander%';

-- ── Medium MPV (Innova, Voxy, Serena, Biante) ────────────────────────────────
UPDATE kendaraan 
SET ukuran_ban = '205/65 R16 / 215/55 R17', 
    merek_ban_oem = 'Dunlop Enasave / Bridgestone Turanza', 
    tekanan_ban = 'Depan: 33 PSI, Belakang: 33 PSI' 
WHERE model LIKE '%Innova%';

UPDATE kendaraan 
SET ukuran_ban = '205/60 R16', 
    merek_ban_oem = 'Yokohama BluEarth / Dunlop', 
    tekanan_ban = 'Depan: 34 PSI, Belakang: 34 PSI' 
WHERE model LIKE '%Voxy%' OR model LIKE '%Serena%' OR model LIKE '%Biante%';

-- ── Ladder Frame SUV (Fortuner, Pajero Sport, MU-X) ──────────────────────────
UPDATE kendaraan 
SET ukuran_ban = '265/60 R18', 
    merek_ban_oem = 'Dunlop Grandtrek AT20 / Bridgestone Dueler H/T', 
    tekanan_ban = 'Depan: 29-32 PSI, Belakang: 32 PSI' 
WHERE model LIKE '%Fortuner%' OR model LIKE '%Pajero Sport%' OR model LIKE '%MU-X%';

-- ── SUV Compact / Crossover (HR-V, Creta, CX-3, Raize) ───────────────────────
UPDATE kendaraan 
SET ukuran_ban = '215/60 R17 / 225/50 R18', 
    merek_ban_oem = 'Bridgestone Turanza T005A / Dunlop', 
    tekanan_ban = 'Depan: 32 PSI, Belakang: 32 PSI' 
WHERE model LIKE '%HR-V%' OR model LIKE '%Creta%' OR model LIKE '%Omoda%';

UPDATE kendaraan 
SET ukuran_ban = '205/60 R16 / 205/65 R17', 
    merek_ban_oem = 'Dunlop Enasave / Bridgestone Turanza', 
    tekanan_ban = 'Depan: 33 PSI, Belakang: 33 PSI' 
WHERE model LIKE '%Raize%' OR model LIKE '%Rocky%';

UPDATE kendaraan 
SET ukuran_ban = '215/60 R16 / 215/50 R18', 
    merek_ban_oem = 'Toyo Proxes', 
    tekanan_ban = 'Depan: 33 PSI, Belakang: 33 PSI' 
WHERE model LIKE '%CX-3%';

-- ── SUV Medium (CR-V, CX-5, X-Trail, Almaz) ──────────────────────────────────
UPDATE kendaraan 
SET ukuran_ban = '235/60 R18 / 225/55 R19', 
    merek_ban_oem = 'Toyo Proxes R46 / Bridgestone Dueler', 
    tekanan_ban = 'Depan: 34 PSI, Belakang: 34 PSI' 
WHERE model LIKE '%CR-V%' OR model LIKE '%CX-5%' OR model LIKE '%CX-8%' OR model LIKE '%X-Trail%' OR model LIKE '%Almaz%';

-- ── Mobil Premium & Mewah Eropa (BMW & Mercedes-Benz) ────────────────────────
UPDATE kendaraan 
SET ukuran_ban = 'Depan: 225/45 R18, Belakang: 245/40 R18 (Staggered)', 
    merek_ban_oem = 'Pirelli Cinturato P7 RFT / Michelin Pilot Sport', 
    tekanan_ban = 'Depan: 32 PSI, Belakang: 35 PSI' 
WHERE (merek = 'BMW' AND model LIKE '%3 Series%') 
   OR (merek = 'Mercedes-Benz' AND model LIKE '%C-Class%');

UPDATE kendaraan 
SET ukuran_ban = 'Depan: 245/45 R18, Belakang: 275/40 R18 (Staggered)', 
    merek_ban_oem = 'Goodyear Eagle F1 RFT / Pirelli Cinturato', 
    tekanan_ban = 'Depan: 33 PSI, Belakang: 36 PSI' 
WHERE (merek = 'BMW' AND model LIKE '%5 Series%') 
   OR (merek = 'Mercedes-Benz' AND model LIKE '%E-Class%');

UPDATE kendaraan 
SET ukuran_ban = '225/50 R18 (RFT)', 
    merek_ban_oem = 'Bridgestone Turanza T001 RFT / Continental', 
    tekanan_ban = 'Depan: 32 PSI, Belakang: 32 PSI' 
WHERE (merek = 'BMW' AND model LIKE '%X1%') 
   OR (merek = 'Mercedes-Benz' AND (model LIKE '%GLA%' OR model LIKE '%GLB%'));

UPDATE kendaraan 
SET ukuran_ban = '275/45 R20 / 315/35 R20 (Staggered RFT)', 
    merek_ban_oem = 'Pirelli P-Zero RFT / Continental SportContact', 
    tekanan_ban = 'Depan: 35 PSI, Belakang: 38 PSI' 
WHERE (merek = 'BMW' AND (model LIKE '%X5%' OR model LIKE '%X6%')) 
   OR (merek = 'Mercedes-Benz' AND (model LIKE '%GLE%' OR model LIKE '%GLS%'));

-- ── Pickup Double Cabin (Hilux, Triton, BT-50) ───────────────────────────────
UPDATE kendaraan 
SET ukuran_ban = '265/65 R17 / 265/60 R18', 
    merek_ban_oem = 'Dunlop Grandtrek AT / Bridgestone Dueler A/T', 
    tekanan_ban = 'Depan: 29 PSI, Belakang: 29 PSI (Kosong), 42 PSI (Beban Penuh)' 
WHERE kategori LIKE '%Pickup%';

-- ── Fallback (Model yang tidak terjaring di atas) ────────────────────────────
UPDATE kendaraan 
SET ukuran_ban = 'Bervariasi (Umumnya R15-R17)', 
    merek_ban_oem = 'Cek Standar Pabrik (Bridgestone/Dunlop/GT Radial)', 
    tekanan_ban = 'Depan: 32 PSI, Belakang: 32 PSI' 
WHERE ukuran_ban = '-';
