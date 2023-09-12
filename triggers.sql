-- TRIGERS 
-- Creamos una PL y luego la convertimos en una función
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

-- Renombramos el nombre la función

ALTER FUNCTION public.importantepl()
	RENAME TO impl;

SELECT impl()
-- Creamos una tabla llamada cont_pasajero

-- Modificamos la pl para luego convertirla en un Trigger

-- La función ya ha sido insertada a la tabla conteo_pasajero
-- Para funcionar como trigger, cambiaremos return integer por trigger

-- Borramos la función para que no halla problemas
DROP FUNCTION impl(); 

CREATE OR REPLACE FUNCTION public.impl(
	)
    RETURNS TRIGGER
	-- cambiamos integer por trigger
    LANGUAGE 'plpgsql'
    -- COST 100 se quita porque es un valor predeterminado
    -- VOLATILE PARALLEL UNSAFE también es un valor predeterminado
AS $BODY$
 
DECLARE 
	rec record;
	contador integer := 0; 
BEGIN 
	FOR rec IN SELECT * FROM pasajero LOOP 
	-- No necesitamos hacer algún recorrido para mostrar las alertas porque lo hicimos como prueba
	-- RAISE NOTICE 'Un pasjero se llama %', rec.nombre;
	contador := contador + 1;
	END LOOP;
	INSERT INTO cont_pasajero (total, tiempo)
	-- Deseamos insertar el total de pasajeros en un tiempo indicado
	VALUES (contador, now());
	-- con esto tenemos la insercion en la tabla de pasajeros cada vez que se ejecuta la PL  
	contador := contador + 1;
	-- qUITAMOS RETURN contador;
END
$BODY$;

-- ALTER FUNCTION public.impl() esto sobra porque Postgrees es dueño de todo 
   -- OWNER TO postgres;

















