-- 4. Lista los barcos que tienen una cuota mayor a 500 y sus respectivos socios.
SELECT barcos.matricula AS 'Matricula' ,barcos.nombre AS 'Nombre barco', barcos.cuota AS 'Cuota', socios.nombre AS 'Socio', barcos.id_socio AS 'ID Socio'
FROM barcos INNER JOIN socios ON
	barcos.id_socio = socios.id_socio AND cuota > 500;