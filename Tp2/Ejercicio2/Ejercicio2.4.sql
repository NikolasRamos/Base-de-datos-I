-- 4.Lista los números de expediente y fechas de inicio de los asuntos de los clientes que viven en Buenos Aires.
SELECT a.numero_expediente AS 'Numero de expediente', a.fecha_inicio AS 'Fecha de inicio'
FROM asuntos a
INNER JOIN clientes c ON a.dni_cliente = c.dni_cliente
WHERE c.direccion LIKE '%Buenos Aires%';