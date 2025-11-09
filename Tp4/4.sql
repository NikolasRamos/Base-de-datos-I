-- Crea el procedimiento CuentasConSaldoMayorQue(IN limite
-- DECIMAL(10,2)) que muestra las cuentas con saldo mayor al valor recibido.

DELIMITER $$

CREATE PROCEDURE CuentasConSaldoMayorQue(IN limite DECIMAL(10,2))
BEGIN
    SELECT numero_cuenta as 'Numero de la cuenta', numero_cliente as 'Numero del cliente', saldo as 'Saldo de la cuenta'
    FROM cuentas
    WHERE saldo > limite;
END $$

DELIMITER ;

call CuentasConSaldoMayorQue(3000);
select CuentasConSaldoMayorQue(3000);