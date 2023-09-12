-- FUNCTION: public.importantepl()

-- DROP FUNCTION IF EXISTS public.importantepl();

CREATE OR REPLACE FUNCTION public.impl(
	)
    RETURNS trigger
	-- cambiamos integer por trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
 
DECLARE 
	rec record;
	contador integer := 0; 
BEGIN 
	FOR rec IN SELECT * FROM pasajero LOOP 
	RAISE NOTICE 'Un pasjero se llama %', rec.nombre;
	contador := contador + 1;
	END LOOP;
	INSERT INTO cont_pasajero (total, tiempo)
	-- Deseamos insertar el total de pasajeros en un tiempo indicado
	VALUES (contador, now());
	-- con esto tenemos la insercion en la tabla de pasajeros cada vez que se ejecuta la PL  
	contador := contador + 1;
	RETURN contador;
END
$BODY$;

ALTER FUNCTION public.impl()
    OWNER TO postgres;

-- Primero crearemos el trigger y luego hacemos la inserción 
-- Vamos a modificar la PL que tenemos para que en vez que nos muestre
-- la cantidad de pasajeros haga un INSERT en la tabla de pasajeros.

-- Cambiamos el retorno de RAISE NOTICE 
-- Deseamos que la tabla tome el valor actual desde el momento de la inserción

-- Ejecutamos la pl 

SELECT impl()

-- Comprobamos que nos da la cantidad y hora eliminando un pasajero 
DELETE FROM pasajero WHERE id=10;

-- Ejecutamos nuevamente la PL y observamos que perdimos uno 
SELECT impl()




















