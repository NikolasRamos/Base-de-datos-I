-- Crea el procedimiento almacenado TotalMovimientosDelMes(IN cuenta
-- INT, OUT total DECIMAL(10,2)) que recibe una cuenta y devuelve el total de
-- los movimientos de la cuenta en el mesa actual, los créditos suman, y los débitos
-- restan.
-- La función CURDATE() retorna la fecha actual, y la funcion MONTH(fecha) retorna
-- el mes de la fecha pasada por parámetro.

DELIMITER $$

CREATE PROCEDURE TotalMovimientosDeUnMesCursor(iN p_cuenta INT,IN p_mes INT,IN p_anio INT,OUT p_total DECIMAL(10,2))
BEGIN
    DECLARE v_importe DECIMAL(10,2);
    DECLARE v_tipo VARCHAR(10);
    DECLARE v_total DECIMAL(10,2) DEFAULT 0.00;
    DECLARE fin_cursor BOOLEAN DEFAULT FALSE;
    
    DECLARE curMovimientos CURSOR FOR SELECT tipo, importe FROM movimientos WHERE numero_cuenta = p_cuenta AND MONTH(fecha) = p_mes AND YEAR(fecha) = p_anio;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin_cursor = TRUE;
    OPEN curMovimientos;
    
    leer_loop: LOOP
        FETCH curMovimientos INTO v_tipo, v_importe;
        IF fin_cursor THEN LEAVE leer_loop;
        END IF;
        IF UPPER(v_tipo) = 'CREDITO' THEN SET v_total = v_total + v_importe;
        ELSEIF UPPER(v_tipo) = 'DEBITO' THEN SET v_total = v_total - v_importe;
        END IF;
    END LOOP;
    CLOSE curMovimientos;
    SET p_total = v_total;
END $$
DELIMITER ;
SET @resultado = 0.00;
CALL TotalMovimientosDeUnMesCursor(1002, 10, 2025, @resultado);
SELECT @resultado AS 'Total De Octubre 2025';