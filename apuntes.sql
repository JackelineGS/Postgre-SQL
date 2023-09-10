-- Eliminar un dato de la tabla tren
DELETE FROM public.tren
	WHERE id = 1;
	
-- Inserción y consulta de datos
INSERT INTO public.tren(
	capacidad, modelo)
	VALUES (100, 'Modelo 1');
	
INSERT INTO public.trayecto(
	id_estacion, id_tren, nombre)
	VALUES (1, 1, 'Ruta 1');	

INSERT INTO public.tren(
	modelo, capacidad)
	VALUES ('Modelo 2', 150);
	
INSERT INTO public.trayecto(
	id_estacion, id_tren, nombre)
	VALUES (1, 2, 'Ruta 2')

INSERT INTO public.pasajero(
	nombre, direccion_residencia, fecha_nacimiento) 
	VALUES ('San Juan de Lurigancho', 'La Curva', '2009-05-23');

-- Hacemos un update en la tabla tren 

UPDATE public.tren
	SET id=2
	WHERE id=1;

-- Consultamos el formato de fecha

SELECT current_date;
SELECT current_date; 
	
-- Hacer una consulta de tablas cruzadas 
-- Qué pasajeros han tomado al menos un viaje 

SELECT * FROM pasajero
JOIN viaje ON (viaje.id_pasajero = pasajero.id);
	
-- Quienes no han tomado ni un solo viaje 

SELECT * FROM pasajero 
LEFT JOIN viaje ON (viaje.id_pasajero = pasajero.id)
WHERE viaje.id IS NULL; 

	
	
	
	
	
	
	
	
	
	