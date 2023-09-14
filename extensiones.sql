-- USO DE EXTENSIONES
CREATE EXTENSION fuzzystrmatch;
-- Cuantas palabras debo cambiar para que no sean diferentes 
SELECT levenshtein ('oswaldo', 'osvaldo');
-- Diferencias respecto a la letra y sonido
SELECT difference ('oswaldo', 'osvaldo');
-- Diferencias respecto a la pronunciación
SELECT difference ('bear', 'bird');
-- Listar todas las extensiones
SELECT * FROM pg_available_extensions;
