-- Crea el procedimiento almacenado sin parámetros VerCuentas() que muestre
-- todas las cuentas con su saldo actual.

DELIMITER $$

CREATE PROCEDURE VerCuentas()
BEGIN
    SELECT Clientes.nombre as 'Nombre Cliente',Cuentas.numero_cliente as 'Numero del cliente', Cuentas.numero_cuenta as 'Numero de la cuenta', Cuentas.saldo as 'Saldo de la cuenta'
    FROM Cuentas inner join Clientes on Cuentas.numero_cliente = Clientes.numero_cliente;
END $$

DELIMITER ;
CALL VerCuentas();
select verCuentas;