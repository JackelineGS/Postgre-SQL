-- Insertar información en las tablas
INSERT INTO public.pasajero(
	nombre, direccion_residencia, fecha_nacimiento)
	VALUES ('Segundo pasajero', 'Dirección y', '2023-08-01');
	
SELECT current_date;

-- Crear tablas
-- Viaje
-- Estación
-- Pasajero
-- Trayecto
-- Tren

CREATE TABLE public.viaje (
	id integer NOT NULL,
	id_pasajero integer,
	id_trayecto integer,
	inicio date,  
	fin date,
	CONSTRAINT PRIMARY KEY (id)	
);

CREATE TABLE IF NOT EXISTS public.'estación' (
	id integer NOT NULL,
	nombre character varying(100) COLLATE pg_catalog.'default',
	dirección character varying(100) COLLATE pg_catalog.'default',
	CONSTRAINT estación_pkey PRIMARY KEY (id) 
); 

CREATE TABLE IF NOT EXISTS public.pasajero (
	id integer NOT NULL,
	nombre character varying(100) COLLATE pg_catalog.'default',
	direccion_residencia character varying(100) COLLATE pg_catalog.'default',
	fecha_nacimiento date,
	CONSTRAINT pasajero_pkey PRIMARY KEY (id) 
)

CREATE TABLE IF NOT EXISTS public.trayecto (
	id integer NOT NULL,
	id_estacion integer NOT NULL,
	id_tren integer NOT NULL, 
	CONSTRAINT trayecto_estacion_pkey PRIMARY KEY (id)
)

CREATE TABLE IF NOT EXISTS public.tren (
	id integer NOT NULL,
	modelo character varying(100) COLLATE pg_catalog."default",
	capacidad character varying(100) COLLATE pg_catalog."default",
	CONSTRAINT tren_pkey PRIMARY KEY (id) 
)


-- Crear llaves foraneas 
