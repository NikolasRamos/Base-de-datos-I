-- 5. ¿Qué barcos han salido con destino a 'Mallorca'?
SELECT DISTINCT nombre, destino
FROM barcos, salidas
WHERE barcos.matricula = salidas.matricula AND destino = 'Mallorca';