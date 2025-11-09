-- Crea un procedimiento almacenado Extraer(IN cuenta, IN monto) que
-- registra la extracción de dinero de la cuenta, si es que cuenta con fondos para cubrir
-- el retiro.

DELIMITER $$

CREATE PROCEDURE Extraer(IN p_numero_cuenta INT,IN p_monto DECIMAL(10,2))
BEGIN
    DECLARE v_saldo_anterior DECIMAL(10,2);
    DECLARE v_saldo_actual DECIMAL(10,2);
    DECLARE v_num_mov INT;
    IF (SELECT COUNT(*) FROM cuentas WHERE numero_cuenta = p_numero_cuenta) = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'La cuenta no existe';
    ELSE
        SELECT saldo INTO v_saldo_anterior
        FROM cuentas
        WHERE numero_cuenta = p_numero_cuenta;
        IF v_saldo_anterior < p_monto THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Fondos insuficientes para realizar la extracción';
        ELSE
            SET v_saldo_actual = v_saldo_anterior - p_monto;
            UPDATE cuentas
            SET saldo = v_saldo_actual
            WHERE numero_cuenta = p_numero_cuenta;
            INSERT INTO movimientos (numero_cuenta, fecha, tipo, importe)
            VALUES (p_numero_cuenta, CURDATE(), 'DEBITO', p_monto);
            SET v_num_mov = LAST_INSERT_ID();
            INSERT INTO historial_movimientos (numero_cuenta, numero_movimiento, saldo_anterior, saldo_actual)
            VALUES (p_numero_cuenta, v_num_mov, v_saldo_anterior, v_saldo_actual);
        END IF;
    END IF;
END $$

DELIMITER ;
CALL Extraer(1001, 200.00);
CALL Extraer(1003, 10000.00);