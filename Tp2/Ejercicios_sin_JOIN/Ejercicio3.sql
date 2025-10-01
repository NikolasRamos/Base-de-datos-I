-- 3.¿Cuántas salidas ha realizado el barco con matrícula 'ABC123'?
SELECT matricula, count(*) as total_salidas
FROM salidas
WHERE matricula = 'ABC123';