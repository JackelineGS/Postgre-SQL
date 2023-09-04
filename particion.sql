INSERT INTO public.bitacora_viaje(
	id_viaje, fecha)
	VALUES ( 1, '2012-02-10');

SELECT * FROM bitacora_viaje;

CREATE TABLE bitacora_viaje201001 PARTITION OF bitacora_viaje 
FOR VALUES FROM ('2010-01-01') TO ('2019-01-31');