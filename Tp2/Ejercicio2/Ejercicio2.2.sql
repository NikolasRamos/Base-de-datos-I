-- 2.¿Qué clientes han tenido asuntos en los que ha participado el procurador Carlos López?
SELECT clientes.nombre AS 'Nombre del cliente', procuradores.nombre AS 'Procurador'
FROM clientes
INNER JOIN asuntos ON clientes.dni_cliente = asuntos.dni_cliente
INNER JOIN asuntos_procuradores ON asuntos.numero_expediente = asuntos_procuradores.numero_expediente
INNER JOIN procuradores ON asuntos_procuradores.id_procurador = procuradores.id_procurador
WHERE procuradores.nombre = 'Carlos López';