-- FUNCIONES ESPECIALES PRINCIPALES
-- ON CONFLICT DO
-- RETURNING
-- LIKE / ILIKE
-- IS / IS NOT
-- Hacemos una inserción de un dato que ya existe como ejemplo

INSERT INTO public.estacion(
	id, nombre, direccion)
	VALUES (1, 'Nombre', 'Dire');

-- Indicamos que si hay algún conflicto no hagamos nada (ON CONFLICT DO)
INSERT INTO public.estacion(
	id, nombre, direccion)
	VALUES (1, 'Nombre', 'Dire')
	ON CONFLICT DO NOTHING;

-- Podemos tener la opción de actualizar en caso haya conflicto (ON CONFLICT(id) DO)
INSERT INTO public.estacion(
	id, nombre, direccion)
	VALUES (1, 'Nombre', 'Dire')
	ON CONFLICT(id) DO UPDATE SET nombre = 'Nombre', direccion = 'Dire';

-- Creamos una nueva estación y solicitamos que nos devuelva la tabla con la información (RETURNING)
INSERT INTO public.estacion(
	nombre, direccion)
	VALUES ('REST', 'RETDRI')
RETURNING *; 

-- Buscaremos información de los datos (LIKE)
SELECT nombre
	FROM public.pasajero 
	WHERE nombre LIKE 'o%';

-- Usamos (ILIKE) ya que esta no es sensible a las mayúsculas
SELECT nombre
	FROM public.pasajero 
	WHERE nombre ILIKE 'o%';

-- Usaremos IS e IS NOT 
-- Consultamos cuales son datos nulos
SELECT * 
	FROM public.tren 
	WHERE modelo IS NULL;

-- Consultamos cuales no son datos nulos
SELECT *
	FROM public.tren
	WHERE modelo IS NOT NULL;

-- FUNCIONES ESPECIALIZADAS AVANZADAS 
-- COALESCE
-- NULLIF
-- GREATEST
-- LEAST
-- BLOQUES ANÓNIMOS

-- Para el ejemplo reemplazamos uno de los nombres de los pasajeros como nulo
-- Solicitamos información del id que tiene por nombre NULL

SELECT id, nombre, direccion_residencia, fecha_nacimiento
	FROM public.pasajero WHERE id = 1; 

-- Para que en vez que la casilla salga como NULL salga con otro valor usaremos
-- COALESCE 

SELECT id, COALESCE(nombre, 'No Aplica'), direccion_residencia, fecha_nacimiento
	FROM public.pasajero WHERE id = 1; 

-- Por otro lado la columna del nombre cambia por coalesce
-- Para que no pase eso agregamos un argumento

SELECT id, COALESCE(nombre, 'No Aplica'), nombre, direccion_residencia, fecha_nacimiento
	FROM public.pasajero WHERE id = 1; 

-- Comparamos operaciones numéricas
SELECT NULLIF (0,0);

-- Seleccionamos el número mayor con GREATEST
SELECT GREATEST (0,1,2,4,1,7,2,4)

-- Usando LEAST nos otorga el menor valor 
SELECT LEAST (0,1,2,4,1,7,2,4)

-- Creamos bloques anónimos, se crea el bloque Niño y Mayor
SELECT id, nombre, direccion_residencia, fecha_nacimiento,
CASE 
WHEN fecha_nacimiento > '2015-10-01' THEN 
'Niño'
ELSE 
'Mayor'
END 
	FROM public.pasajero;

-- CREAMOS LA VISTA VOLATIL Y VISTA MATERIALIZADA 

-- Creamos una consulta, estas pueden volver volatil o materializada
-- usando pgAdmin4 
SELECT *
CASE 
WHEN fecha_nacimiento > '2015-10-01' THEN 
'Mayor'
ELSE 
'Niño'
END AS tipo FROM pasajero ORDER BY tipo; 


--PL : PROCEDIMIENTOS ALMACENADOS
-- Cremos el siguiente bloque de código y lo encapsulamos en una función
DO $$ 
DECLARE 
	rec record;
	contador integer := 0; 
BEGIN 
	FOR rec IN SELECT * FROM pasajero LOOP 
	RAISE NOTICE 'Un pasajero se llama %', rec.nombre;
	contador := contador + 1;
	END LOOP;
	RAISE NOTICE 'Conteo es %', contador;  
END
$$ 

-- Encapsulamos la función 

CREATE FUNCTION importantePL()
 RETURNS void 
AS $$ 
DECLARE 
	rec record;
	contador integer := 0; 
BEGIN 
	FOR rec IN SELECT * FROM pasajero LOOP 
	RAISE NOTICE 'Un pasajero se llama %', rec.nombre;
	contador := contador + 1;
	END LOOP;
	RAISE NOTICE 'Conteo es %', contador;  
END
$$ 
LANGUAGE PLPGSQL;

-- Colocamos PLPGSQL porque estamos usando funciones como RAISE y FOR
-- Simulamos que llamamos a la función

SELECT importantePL();

-- No se obtienen resultados en la tabla porque establecimos que 
-- no retorne nada, pero en mensajes se observa losmensajes con los nombres

-- Haremos cambios para que la PL retorne valores
-- Como la función ya existe es necesario agregar un pequeño cambio 
-- Que es OR REPLACE
-- Al ejecutar el código sale error porque el tipo de datos 
-- no es actualizable, nos recomienda usar DROP FUNCTION importantepl(); 
-- Ejecutamos primero DROP FUNCTION y luego ejecutamos las lineas
-- de la función 

DROP FUNCTION importantepl(); 
CREATE OR REPLACE FUNCTION importantePL()
 RETURNS integer 
AS $$ 
DECLARE 
	rec record;
	contador integer := 0; 
BEGIN 
	FOR rec IN SELECT * FROM pasajero LOOP 
	RAISE NOTICE 'Un pasajero se llama %', rec.nombre;
	contador := contador + 1;
	END LOOP;
	RAISE NOTICE 'Conteo es %', contador;  
	RETURN contador;
END
$$ 
LANGUAGE PLPGSQL;

SELECT importantePL();

-- El resultado de correr SELECT es el contador

-- Código que utilizaremos usando pgAdmin 
$$ 
DECLARE 
	rec record;
	contador integer := 0; 
BEGIN 
	FOR rec IN SELECT * FROM pasajero LOOP 
	RAISE NOTICE 'Un pasajero se llama %', rec.nombre;
	contador := contador + 1;
	END LOOP;
	RAISE NOTICE 'Conteo es %', contador;  
	RETURN contador;
END
$$ 

--Borramos la funcion existente con DROP y ejecutamos la función
SELECT importantePL();
























