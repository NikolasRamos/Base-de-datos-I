-- El banco implementó un beneficio para sus clientes dándoles por única vez un 2%
-- de interés a las cuentas que posean saldo mayor a $100.000. Creá un procedimiento
-- almacenado que se encargue de aplicar un porcentaje de interés recibido por
-- parámetro a todas las cuentas con saldo mayor a un valor recibido por parámetro.
DELIMITER $$
CREATE PROCEDURE AplicarInteres(IN p_porcentaje DECIMAL(5,2),IN p_minimo DECIMAL(10,2))
BEGIN
    DECLARE v_numero_cuenta INT;
    DECLARE v_saldo_anterior DECIMAL(10,2);
    DECLARE v_saldo_actual DECIMAL(10,2);
    DECLARE v_interes DECIMAL(10,2);
    DECLARE v_num_mov INT;
    DECLARE fin_cursor BOOLEAN DEFAULT FALSE;

    DECLARE curCuentas CURSOR FOR SELECT numero_cuenta, saldo FROM cuentas WHERE saldo > p_minimo;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin_cursor = TRUE;
    OPEN curCuentas;

    leer_loop: LOOP
        FETCH curCuentas INTO v_numero_cuenta, v_saldo_anterior;
        IF fin_cursor THEN LEAVE leer_loop;
        END IF;
        SET v_interes = v_saldo_anterior * (p_porcentaje / 100);
        SET v_saldo_actual = v_saldo_anterior + v_interes;
        UPDATE cuentas SET saldo = v_saldo_actual WHERE numero_cuenta = v_numero_cuenta;
        INSERT INTO movimientos (numero_cuenta, fecha, tipo, importe)
        VALUES (v_numero_cuenta, CURDATE(), 'CREDITO', v_interes);
        SET v_num_mov = LAST_INSERT_ID();
        INSERT INTO historial_movimientos (numero_cuenta, numero_movimiento, saldo_anterior, saldo_actual)
        VALUES (v_numero_cuenta, v_num_mov, v_saldo_anterior, v_saldo_actual);
    END LOOP;
    CLOSE curCuentas;
END $$
DELIMITER ;
CALL AplicarInteres(2, 100000);
CALL AplicarInteres(5, 5000);