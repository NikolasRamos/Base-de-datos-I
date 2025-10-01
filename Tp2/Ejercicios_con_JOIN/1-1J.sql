-- ¿Qué socios tienen barcos amarrados en un número de amarre mayor que 10?
SELECT numero_amarre, Barcos.id_socio, Socios.id_socio
FROM Barcos inner join Socios
on barcos.Id_Socio = socios.id_socio where numero_amarre > 10;