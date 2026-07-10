-- =============================================================================
-- 001_create_table.sql
-- Schema tabel utama untuk Database Spesifikasi Kendaraan Indonesia
-- Jalankan sekali saat pertama kali setup
-- =============================================================================

CREATE TABLE IF NOT EXISTS kendaraan (
  id                    SERIAL PRIMARY KEY,
  merek                 VARCHAR(100)  NOT NULL,
  model                 VARCHAR(200)  NOT NULL,
  tahun                 VARCHAR(100),
  kategori              VARCHAR(100),
  bahan_bakar           VARCHAR(20),   -- 'bensin' atau 'diesel'
  kode_mesin            VARCHAR(200),
  kapasitas_cc          VARCHAR(50),
  tipe_transmisi        VARCHAR(50),   -- 'Manual', 'AT', 'CVT', 'AMT'
  detail_transmisi      TEXT,
  viskositas_oli        VARCHAR(200),
  standar_oli           VARCHAR(300),
  kapasitas_oli         VARCHAR(100),
  oli_transmisi         TEXT,
  tipe_power_steering   VARCHAR(300),
  fluida_power_steering TEXT,
  created_at            TIMESTAMP DEFAULT NOW(),
  updated_at            TIMESTAMP DEFAULT NOW()
);

-- Index untuk mempercepat filter & pencarian
CREATE INDEX IF NOT EXISTS idx_kendaraan_merek         ON kendaraan(merek);
CREATE INDEX IF NOT EXISTS idx_kendaraan_bahan_bakar   ON kendaraan(bahan_bakar);
CREATE INDEX IF NOT EXISTS idx_kendaraan_tipe_transmisi ON kendaraan(tipe_transmisi);
CREATE INDEX IF NOT EXISTS idx_kendaraan_kategori      ON kendaraan(kategori);

-- Full-text search index (opsional, untuk pencarian cepat)
CREATE INDEX IF NOT EXISTS idx_kendaraan_search
  ON kendaraan USING gin(to_tsvector('simple', merek || ' ' || model || ' ' || COALESCE(kode_mesin,'')));
