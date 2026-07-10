-- ============================================================
-- 007_fix_power_steering.sql
-- Memperbaiki data kendaraan yang salah menggunakan EPS 
-- padahal seharusnya Hidrolik (HPS)
-- ============================================================

-- 1. Update ke Hidrolik untuk model-model komersial/SUV/MPV tertentu
UPDATE kendaraan
SET 
  tipe_power_steering = 'Hidrolik (HPS)',
  fluida_power_steering = 'ATF Dexron II / III, ±1 L'
WHERE 
  (merek = 'Toyota' AND model ILIKE '%Fortuner%') OR
  (merek = 'Toyota' AND model ILIKE '%Hilux%') OR
  (merek = 'Toyota' AND model ILIKE '%Innova%' AND model NOT ILIKE '%Zenix%') OR
  (merek = 'Toyota' AND model ILIKE '%Avanza%' AND tahun ILIKE '%Gen 1%') OR
  (merek = 'Mitsubishi' AND model ILIKE '%Pajero%') OR
  (merek = 'Mitsubishi' AND model ILIKE '%Triton%') OR
  (merek = 'Mitsubishi' AND model ILIKE '%L300%') OR
  (merek = 'Isuzu' AND model ILIKE '%Panther%') OR
  (merek = 'Isuzu' AND model ILIKE '%mu-X%') OR
  (merek = 'Isuzu' AND model ILIKE '%D-Max%') OR
  (merek = 'Nissan' AND model ILIKE '%Navara%') OR
  (merek = 'Nissan' AND model ILIKE '%Terra%') OR
  (merek = 'Suzuki' AND model ILIKE '%APV%');

-- 2. Update spesifik untuk Honda yang menggunakan Hidrolik
UPDATE kendaraan
SET 
  tipe_power_steering = 'Hidrolik (HPS)',
  fluida_power_steering = 'Honda Power Steering Fluid (PSF)'
WHERE 
  (merek = 'Honda' AND model ILIKE '%CR-V%' AND (tahun ILIKE '%Gen 1%' OR tahun ILIKE '%Gen 2%' OR tahun ILIKE '%Gen 3%')) OR
  (merek = 'Honda' AND model ILIKE '%Civic%' AND (tahun ILIKE '%FD%' OR tahun ILIKE '%ES%')) OR
  (merek = 'Honda' AND model ILIKE '%Accord%' AND (tahun ILIKE '%CP2%' OR tahun ILIKE '%CM5%'));

SELECT 'Update Hidrolik selesai.' AS status;
