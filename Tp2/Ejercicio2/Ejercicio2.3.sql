-- 3.¿Cuántos asuntos ha gestionado cada procurador?
SELECT p.nombre AS 'Nombre del procurador', 
	(
		SELECT count(*)
        FROM asuntos_procuradores ap
        INNER JOIN asuntos ON ap.numero_expediente = asuntos.numero_expediente
        WHERE p.id_procurador = ap.id_procurador
	) AS 'Cantidad de asuntos'
FROM procuradores p;