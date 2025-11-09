-- Crea sin utilizar cursores el procedimiento almacenado
-- TotalMovimientosDelMes(IN cuenta INT, OUT total DECIMAL(10,2))
-- que recibe una cuenta y devuelve el total de los movimientos de la cuenta en el
-- mesa actual, los créditos suman, y los débitos restan.
-- La función CURDATE() retorna la fecha actual, y la funcion MONTH(fecha) retorna
-- el mes de la fecha pasada por parámetro.


DELIMITER $$

CREATE PROCEDURE TotalMovimientosDelMes(IN cuenta INT,IN mes INT,iN anio INT,OUT total DECIMAL(10,2))
BEGIN
    DECLARE suma DECIMAL(10,2);

    SELECT 
        IFNULL(SUM(CASE WHEN UPPER(tipo) = 'CREDITO' THEN importe WHEN UPPER(tipo) = 'DEBITO' THEN -importe ELSE 0 END), 0)
    INTO suma
    FROM movimientos
    WHERE numero_cuenta = cuenta AND MONTH(fecha) = mes AND YEAR(fecha) = anio;
    SET total = suma;
END $$

DELIMITER ;
CALL TotalMovimientosDelMes(1002, 10, 2025, @total);
SELECT @total AS 'Total Octubre 2025';