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
   
 -- Un trigger puede ser adjuntado a las acciones sobre una tabla
 -- Las funciones sobre las que se puede adjuntar son: INSERT, UPDATE, DELETE y TRUNCATE 
 -- Lo adjuntaremos sobre INSERT 
 -- De esta forma realizamos la integración de un trigger a una tabla usando una pl   
 -- Debe crearse una conección entre el trigger, la pl y la tabla
 CREATE TRIGGER mitrigeer 
 AFTER INSERT
 ON pasajero
 FOR EACH ROW
 EXECUTE PROCEDURE impl(); 
   
-- Para probar que si funciona crearemos un nuevo dato en la tabla de pasajeros
-- Veremos como cambia la tabla de conteo_pasajero
   
INSERT INTO pasajero (nombre, direccion_residencia, fecha_nacimiento) 
VALUES ('Nombre Trigger', 'Dir', '2000-01-01'); 
   
-- Modificamos el trigger, ya que debemos confirmarle al motor de base de datos si el cambio se hace o no
-- Si no retornamos información o retornamos un void, estamos diciendo que lo haga el motor de base de datos no se va a poder guardar en la tabla
-- por no darle la confirmación
-- Los triggers tienen las variables globales OLD: es lo que estaba antes del cambio y NEW: es el cambio
-- Si queremos que el trigger retorne el valor correctamente, debemos retornar NEW 
-- Con NEW le estamos confirmando al motor que el cambio puede proceder 
-- Si no queremos un cambio y se quede tal como está colocamos OLD 
-- OLD y NEW tienen sentido cuando estamos haciendo un UPDATE 
-- Para ejecutar lo desarrollado, eliminamos primero el trigger y la función


DROP FUNCTION public.impl(); 

CREATE OR REPLACE FUNCTION public.impl(
	)
    RETURNS TRIGGER
    LANGUAGE 'plpgsql'
AS $BODY$
 
DECLARE 
	rec record;
	contador integer := 0; 
BEGIN 
	FOR rec IN SELECT * FROM pasajero LOOP 
	contador := contador + 1;
	END LOOP;
	INSERT INTO cont_pasajero (total, tiempo)
	VALUES (contador, now());
-- Lo que aceptamos es lo que estamos insertando  
	RETURN NEW; 
END
$BODY$;


 CREATE TRIGGER mitrigeer 
 AFTER INSERT
 ON pasajero
 FOR EACH ROW
 EXECUTE PROCEDURE impl(); 
   
 -- En la tabla de pasajeros insertamos un valor 
 
 INSERT INTO public.pasajero (
	 nombre, direccion_residencia, fecha_nacimiento) 
 VALUES ('Nombre Triggerv2', 'Direccion real', '2000-02-01'); 
   
 -- Segunda prueba
 
  INSERT INTO public.pasajero (
	 nombre, direccion_residencia, fecha_nacimiento) 
 VALUES ('Nombre Triggerv2', 'Direccion realv2', '2000-03-01'); 
   
   
   
   