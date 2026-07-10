-- ============================================================
-- 003_create_differential_table.sql
-- Tabel gardan/differential kendaraan
-- ============================================================

-- Pastikan fungsi trigger tersedia (idempoten)
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TABLE IF NOT EXISTS kendaraan_differential (
  id              SERIAL PRIMARY KEY,
  kendaraan_id    INTEGER NOT NULL REFERENCES kendaraan(id) ON DELETE CASCADE,
  posisi          VARCHAR(60)  NOT NULL,  -- 'Depan', 'Belakang', 'Transfer Case'
  jenis           VARCHAR(150),           -- 'Open Differential', 'LSD', 'Locking', dsb.
  spesifikasi_oli VARCHAR(250),           -- misal: 'Hypoid Gear Oil API GL-5 75W-90'
  kapasitas_oli   VARCHAR(60),            -- misal: '1.5 L'
  catatan         TEXT,                   -- catatan tambahan
  created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at      TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_diff_kendaraan_id ON kendaraan_differential(kendaraan_id);
CREATE INDEX IF NOT EXISTS idx_diff_posisi        ON kendaraan_differential(posisi);

-- Auto-update updated_at
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_trigger
    WHERE tgname = 'set_diff_updated_at'
  ) THEN
    CREATE TRIGGER set_diff_updated_at
    BEFORE UPDATE ON kendaraan_differential
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
  END IF;
END $$;

-- ── Verifikasi ───────────────────────────────────────────────
SELECT 'Tabel kendaraan_differential berhasil dibuat.' AS status;
