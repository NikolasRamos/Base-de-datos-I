-- 5.¿Qué barcos han salido con destino a 'Mallorca'?
SELECT barcos.matricula AS 'Matricula', nombre AS 'Nombre del barco', salidas.destino AS 'Destino'
FROM barcos INNER JOIN salidas ON
	barcos.matricula = salidas.matricula AND destino = 'Mallorca';