-- =============================================================================
-- 015_update_mercedes_variants.sql
-- Memperbarui nama model Mercedes-Benz agar menyertakan varian (misal C200, E300)
-- =============================================================================

-- C-Class
UPDATE kendaraan 
SET model = 'C-Class W203/W204 (C180, C200, C230, C250, C300)' 
WHERE merek = 'Mercedes-Benz' AND model = 'C-Class (W203/W204)';

UPDATE kendaraan 
SET model = 'C-Class W205/W206 (C200, C250, C300)' 
WHERE merek = 'Mercedes-Benz' AND model = 'C-Class (W205/W206)';

-- E-Class
UPDATE kendaraan 
SET model = 'E-Class W211/W212 (E200, E250, E280, E300)' 
WHERE merek = 'Mercedes-Benz' AND model = 'E-Class (W211/W212)';

UPDATE kendaraan 
SET model = 'E-Class W213 (E200, E250, E300)' 
WHERE merek = 'Mercedes-Benz' AND model = 'E-Class (W213)';

-- S-Class
UPDATE kendaraan 
SET model = 'S-Class W221/W222/W223 (S300, S350, S400, S450, S500)' 
WHERE merek = 'Mercedes-Benz' AND model = 'S-Class (W221/W222/W223)';

-- GLC
UPDATE kendaraan 
SET model = 'GLC-Class (GLC200, GLC250, GLC300)' 
WHERE merek = 'Mercedes-Benz' AND model = 'GLC';

-- A-Class
UPDATE kendaraan 
SET model = 'A-Class W176/W177 (A200, A250)' 
WHERE merek = 'Mercedes-Benz' AND model = 'A-Class (W176/W177)';

-- B-Class
UPDATE kendaraan 
SET model = 'B-Class W245 (B170, B180, B200)' 
WHERE merek = 'Mercedes-Benz' AND model = 'B-Class (W245)';

UPDATE kendaraan 
SET model = 'B-Class W246 (B200)' 
WHERE merek = 'Mercedes-Benz' AND model = 'B-Class (W246)';

-- CLA-Class
UPDATE kendaraan 
SET model = 'CLA-Class C117/C118 (CLA200, CLA250)' 
WHERE merek = 'Mercedes-Benz' AND model = 'CLA-Class (C117/C118)';

-- GLA-Class
UPDATE kendaraan 
SET model = 'GLA-Class X156/H247 (GLA200, GLA250)' 
WHERE merek = 'Mercedes-Benz' AND model = 'GLA-Class (X156/H247)';

-- GLB-Class
UPDATE kendaraan 
SET model = 'GLB-Class X247 (GLB200)' 
WHERE merek = 'Mercedes-Benz' AND model = 'GLB-Class (X247)';

-- GLE-Class / M-Class (Bensin)
UPDATE kendaraan 
SET model = 'GLE / M-Class W166/V167 (ML400, GLE250, GLE400, GLE450)' 
WHERE merek = 'Mercedes-Benz' AND model = 'GLE-Class / M-Class (W166/V167)' AND bahan_bakar = 'bensin';

-- GLE-Class (Diesel)
UPDATE kendaraan 
SET model = 'GLE-Class W166/V167 Diesel (GLE300d, GLE350d)' 
WHERE merek = 'Mercedes-Benz' AND model = 'GLE-Class (W166/V167)' AND bahan_bakar = 'diesel';

-- GLS-Class
UPDATE kendaraan 
SET model = 'GLS / GL-Class X166/X167 (GL400, GL500, GLS400, GLS450)' 
WHERE merek = 'Mercedes-Benz' AND model = 'GLS-Class / GL-Class (X166/X167)';

-- G-Class
UPDATE kendaraan 
SET model = 'G-Class W463 (G300, G500, G63 AMG)' 
WHERE merek = 'Mercedes-Benz' AND model = 'G-Class (W463)';

-- V-Class / Vito
UPDATE kendaraan 
SET model = 'V-Class / Vito W447 (V220d, V250, V260)' 
WHERE merek = 'Mercedes-Benz' AND model = 'V-Class / Vito (W447)';
