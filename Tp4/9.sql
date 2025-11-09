-- Modifica el trigger anterior para que, luego de actualizado el saldo, se encargue de
-- registrar el movimiento en el historial de saldos. Para modificar la implementación
-- del trigger primero hay que eliminarlo, y luego volver a crearlo.

DROP TRIGGER IF EXISTS ActualizarElSaldo;

DELIMITER $$

CREATE TRIGGER ActualizarElSaldoYHistorial
AFTER INSERT ON movimientos
FOR EACH ROW
BEGIN
    DECLARE v_saldo_anterior DECIMAL(10, 2);
    DECLARE v_saldo_actual DECIMAL(10, 2);
    DECLARE v_impacto DECIMAL(10, 2);
    SELECT saldo INTO v_saldo_anterior
    FROM Cuentas
    WHERE numero_cuenta = NEW.numero_cuenta;
    SET v_impacto =
        CASE
            WHEN NEW.tipo IN ('CREDITO', 'credito') THEN NEW.importe WHEN NEW.tipo IN ('DEBITO', 'debito') THEN -NEW.importe ELSE 0
        END;
    SET v_saldo_actual = v_saldo_anterior + v_impacto;
    UPDATE Cuentas
    SET saldo = v_saldo_actual
    WHERE numero_cuenta = NEW.numero_cuenta;
    INSERT INTO historial_movimientos (numero_cuenta,numero_movimiento,saldo_anterior,saldo_actual)
    VALUES (NEW.numero_cuenta,NEW.numero_movimiento,v_saldo_anterior,v_saldo_actual);
END $$
DELIMITER ;

