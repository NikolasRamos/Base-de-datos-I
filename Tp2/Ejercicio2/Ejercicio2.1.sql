-- 1.¿Cuál es el nombre y la dirección de los procuradores que han trabajado en un asunto abierto?
SELECT nombre AS 'Nombre del procurador', direccion AS 'Direccion del procurador'
FROM procuradores 
INNER JOIN asuntos_procuradores ON procuradores.id_procurador = asuntos_procuradores.id_procurador
INNER JOIN asuntos ON asuntos.numero_expediente = asuntos_procuradores.numero_expediente
WHERE estado LIKE '%Abierto%';