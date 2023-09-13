-- SIMULANDO UNA CONEXIÓN A UNA BASE DE DATOS: Usaremos db Link
-- Creamos una base de datos llamada 'remota', creamos una tabla llamada vip
-- Nos desconectamos y conectamos con la BD 'transporte' 
-- Esto lo realizamos en la base de datos 'remota'
INSERT INTO public.vip(
	id, fecha)
	VALUES (50, '2010-01-01');

-- Esto lo realizamos en la base de datos 'transporte público'
-- Tenemos que verificar la dblink está instalada 
-- Crearemos la extensión en nuestra base de datos para que postgres instale la extension

CREATE EXTENSION dblink; 

-- Realizamos una consulta

SELECT * FROM 
dblink('dbname = remota 
	   port=5432 
	   host=127.0.0.1
	   user= usuario_consulta
	   password=psqsecreto',
	   'SELECT id, fecha FROM vip')
	   AS datos_remotos (id integer, fecha date);

-- Si fuera otra pc en host iria el nombre de la IP del servicio que está en otro equipo 
-- En port iría el nombre del dominio 
-- El formato de la consulta debe ser como si fuera una tabla, por ello le llamaremos datos remotos
-- usuario_consulta no tiene permisos sobre las tablas, así que se los daremos 

-- Ahora cruzaremos los datos obtenidos con los datos locales
-- Utilizamos el JOIN para cruzar la información de los usuarios vip para saber cual es el usuario vip  
-- Con esta consulta vamos a traer la información de todos los pasajeros unida con la tabla de datos remotos q cumple con la condición del JOIN  
-- La condición es que existen en ambas tablas por lo que debe traernos solo una información
-- Hay un valor especial de las consultas que se llama USING que lo podemos usar cuando los dos campos sean iguales

SELECT * FROM pasajero
JOIN
dblink('dbname = remota 
	   port=5432 
	   host=127.0.0.1
	   user= usuario_consulta
	   password=psqsecreto',
	   'SELECT id, fecha FROM vip')
	   AS datos_remotos (id integer, fecha date)
USING (id) 
-- ON (pasajero.id = datos_remotos.id); 




 

















		