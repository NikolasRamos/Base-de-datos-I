-- Crea un Trigger que actualice el saldo de la cuenta luego de cada nuevo movimiento
-- que se registra en la cuenta. Probalo ejecutando algunos depósitos/extracciones.

DELIMITER $$

CREATE TRIGGER ActualizarElSaldo
AFTER INSERT ON movimientos 
FOR EACH ROW
BEGIN
    UPDATE Cuentas c
    SET c.saldo =
        CASE
            WHEN NEW.tipo IN ('CREDITO', 'credito') THEN c.saldo + NEW.importe
            WHEN NEW.tipo IN ('DEBITO', 'debito') THEN c.saldo - NEW.importe
            ELSE c.saldo 
        END
    WHERE
        c.numero_cuenta = NEW.numero_cuenta; 
END $$

DELIMITER ;
