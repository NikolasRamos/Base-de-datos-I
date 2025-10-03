-- 6.¿Qué patrones (nombre y dirección) han llevado un barco cuyo socio vive en 'Barcelona'?
SELECT salidas.patron_nombre AS 'Nombre del patron', salidas.patron_direccion AS 'Direccion del patron'
FROM salidas
INNER JOIN barcos ON barcos.matricula = salidas.matricula
INNER JOIN socios ON socios.id_socio = barcos.id_socio
WHERE socios.direccion LIKE '%Barcelona%';