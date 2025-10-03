-- 1.¿Qué socios tienen barcos amarrados en un número de amarre mayor que 10?
SELECT numero_amarre, Barcos.id_socio, Socios.id_socio
FROM Barcos, Socios
WHERE Barcos.id_socio = Socios.id_socio AND numero_amarre > 10;