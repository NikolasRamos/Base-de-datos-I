-- 3.¿Cuántas salidas ha realizado el barco con matrícula 'ABC123'?
SELECT barcos.matricula, nombre, (SELECT count(*) FROM salidas INNER JOIN barcos ON
		barcos.matricula = salidas.matricula) AS 'Numero de salidas'
FROM barcos
WHERE barcos.matricula = 'ABC123';