CREATE EXTENSION postgis;


CREATE TABLE localidades (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    geom GEOMETRY(MULTIPOLYGON, 4326) -- Polígono de la localidad, SRID 4326 (WGS 84)
);

CREATE TABLE barrios (
    id SERIAL PRIMARY KEY,
    localidad_id INTEGER REFERENCES localidades(id),
    nombre VARCHAR(100) NOT NULL,
    geom GEOMETRY(MULTIPOLYGON, 4326) -- Polígonos de los barrios
);

CREATE TABLE incidentes (
    id SERIAL PRIMARY KEY,
    fecha TIMESTAMP WITHOUT TIME ZONE NOT NULL,
    tipo VARCHAR(100) NOT NULL,
    descripcion TEXT,
    geom GEOMETRY(POINT, 4326) -- Ubicación del incidente
);

CREATE TABLE vias (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(255),
    tipo VARCHAR(50), -- Carrera, Calle, Avenida, etc.
    geom GEOMETRY(MULTILINESTRING, 4326) -- Geometría de las vías
);

