-- ========================================
-- POSTGIS SPATIAL INDEXING EXPO - RAFAEL URIBE URIBE
-- Sistema de referencia: EPSG:3116 (MAGNA-SIRGAS / Bogotá)
-- ========================================

-- ========================================
-- 1. CREACIÓN DE ÍNDICES ESPACIALES
-- ========================================
CREATE INDEX idx_vias_geom ON vias USING GIST(geom);
CREATE INDEX idx_localidad_geom ON localidad USING GIST(geom);
CREATE INDEX idx_barrios_geom ON barrios USING GIST(geom);
CREATE INDEX idx_incidentes_geom ON incidentes USING GIST(geom);

-- ========================================
-- 2. CONSULTA 1: INCIDENTES POR BARRIO
-- ========================================

-- (A) SIN ÍNDICE
DROP INDEX IF EXISTS idx_incidentes_geom;

EXPLAIN ANALYZE
SELECT b.nombre, COUNT(i.*)
FROM barrios b
JOIN incidentes i
  ON ST_Contains(b.geom, i.geom)
GROUP BY b.nombre;

-- (B) CON ÍNDICE
CREATE INDEX idx_incidentes_geom ON incidentes USING GIST(geom);

EXPLAIN ANALYZE
SELECT b.nombre, COUNT(i.*)
FROM barrios b
JOIN incidentes i
  ON ST_Contains(b.geom, i.geom)
GROUP BY b.nombre;

-- ========================================
-- 3. CONSULTA 2: VÍAS CERCANAS A UN INCIDENTE
-- ========================================

-- Punto REAL dentro de Rafael Uribe Uribe (EPSG:3116)
-- Coordenadas: X = 996424, Y = 995641
-- Distancia: 50 metros

-- (A) SIN ÍNDICE
DROP INDEX IF EXISTS idx_vias_geom;

EXPLAIN ANALYZE
SELECT v."NAME"
FROM vias v
WHERE ST_DWithin(v.geom, ST_SetSRID(ST_MakePoint(996424, 995641), 3116), 50);

-- (B) CON ÍNDICE
CREATE INDEX idx_vias_geom ON vias USING GIST(geom);

EXPLAIN ANALYZE
SELECT v."NAME"
FROM vias v
WHERE ST_DWithin(v.geom, ST_SetSRID(ST_MakePoint(996424, 995641), 3116), 50);


-- ==============================================================================================================================
-- 4. CONSULTA 3: QUEREMOS SABER CUÁNTOS INCIDENTES TIENEN UNA BOUNDING BOX QUE SE SOLAPA CON LA BOUNDING BOX DEL BARRIO "OLAYA”.
-- ==============================================================================================================================

-- (A) USANDO EL OPERADOR &&

EXPLAIN ANALYZE
SELECT b.nombre, COUNT(i.id)
FROM barrios b
JOIN incidentes i ON b.geom && i.geom -- Aquí usamos el operador &&
WHERE b.nombre = 'OLAYA'
GROUP BY b.nombre;

-- (B) USANDO ST_Intersects

EXPLAIN ANALYZE
SELECT b.nombre, COUNT(i.id)
FROM barrios b
JOIN incidentes i ON ST_Intersects(b.geom, i.geom) -- Ahora usamos ST_Intersects
WHERE b.nombre = 'OLAYA'
GROUP BY b.nombre;
