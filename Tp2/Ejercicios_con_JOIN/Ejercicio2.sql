select Barcos.Nombre, Cuota, Barcos.Id_Socio, Socios.Id_Socio, Socios.Nombre
from Barcos inner join socios
on Barcos.Id_Socio = Socios.Id_Socio having socios.Nombre = "Juan Pérez";