-- 2. ¿Cuáles son los nombres de los barcos y sus cuotas de aquellos barcos cuyo socio se llama 'Juan Pérez'?
SELECT barcos.nombre, socios.nombre, cuota, barcos.id_socio, socios.id_socio
FROM barcos, socios 
WHERE barcos.id_socio = socios.id_socio AND socios.nombre = 'Juan Pérez' ;