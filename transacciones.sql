-- TRANSACCIONES
BEGIN;
-- SELECT true; 
-- COMMIT;
-- SELECT NOW();
-- Hacemos un insert en estacion y otro en tren 
INSERT INTO public.estacion(
	nombre, direccion)
	VALUES('Estacion Transac', 'Av.nuevo');

INSERT INTO public.tren(
	modelo, capacidad)
	VALUES('Modelo Trans', 123);
-- Si queremos que todo se ejecute como un todo tenemos que dejarlo con comilla al final
-- Antes de ejecutarlo verificamos que no este en auto commit 
-- Después de ejecutarlo no debería haber información en las tablas 
-- Ejecutamos solo COMMIT 
COMMIT; 

-- Realizaremos un INSERT con un id que sí existe, para ver que hacer cuando hay este tipo de problema
-- La idea es que el INSERT del tren funciones correctamente, pero al agregar una nueva estación falle 
-- Si solo seleccionamos el INSERT de tren y el de estación, solo se ejecutaría el de tren
-- Para que ninguno de los dos se ejecute lo encerramos en una cadena 
BEGIN;

INSERT INTO public.tren(
	modelo, capacidad)
	VALUES('Modelo Trans 2', 1234);

INSERT INTO public.estacion(
	id,nombre, direccion)
	VALUES(103, 'Estacion Transac', 'Av.nuevo');
	
COMMIT; 










