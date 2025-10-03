-- 4. Lista los barcos que tienen una cuota mayor a 500 y sus respectivos socios.
SELECT barcos.matricula, barcos.nombre as nombre_barco, cuota, socios.nombre as nombre_socio
FROM barcos, socios
WHERE barcos.id_socio = socios.id_socio AND cuota > 500;