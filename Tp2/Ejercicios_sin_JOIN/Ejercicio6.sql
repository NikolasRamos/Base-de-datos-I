-- 6.¿Qué patrones (nombre y dirección) han llevado un barco cuyo socio vive en 'Barcelona'?
SELECT salidas.patron_nombre, salidas.patron_direccion
FROM salidas, barcos, socios
WHERE salidas.matricula = barcos.matricula
  AND barcos.id_socio = socios.id_socio
  AND socios.direccion LIKE '%Barcelona%';