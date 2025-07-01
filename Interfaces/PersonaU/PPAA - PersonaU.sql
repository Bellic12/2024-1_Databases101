DELIMITER //

-- Creación de procedimientos para las sentencias SELECT
CREATE PROCEDURE obtener_convocatorias()
BEGIN
    SELECT * FROM tableConvocatorias;
END //

CREATE PROCEDURE obtener_eventos()
BEGIN
    SELECT * FROM vw_evento;
END //

CREATE PROCEDURE obtener_oficinas()
BEGIN
    SELECT * FROM vw_oficinas;
END //

CREATE PROCEDURE obtener_areas()
BEGIN
    SELECT * FROM vw_areas;
END //

CREATE PROCEDURE obtener_id_convocatoria(IN nombre VARCHAR(255), IN descripcion VARCHAR(255))
BEGIN
    SELECT CON_IdConvocatoria FROM v_convocatoria_info WHERE nombre = nombre AND descripcion = descripcion;
END //

DELIMITER ;

-- Procedimiento para extraer el ID de una convocatoria --
DELIMITER //

CREATE FUNCTION obtener_id_actividad(nombre VARCHAR(100), descripcion TEXT)
RETURNS INT
READS SQL DATA
BEGIN
    DECLARE actividad_id INT;

    -- Buscar en la tabla curso
    SELECT CON_IdConvocatoria INTO actividad_id
    FROM curso
    WHERE CUR_Nombre = nombre AND CUR_Descripcion = descripcion;

    -- Si no se encuentra en curso, buscar en la tabla beneficio
    IF actividad_id IS NULL THEN
        SELECT CON_IdConvocatoria INTO actividad_id
        FROM beneficio
        WHERE BEN_Descripcion = descripcion;
    END IF;

    -- Si no se encuentra en beneficio, buscar en la tabla proyecto_pgp
    IF actividad_id IS NULL THEN
        SELECT CON_IdConvocatoria INTO actividad_id
        FROM proyecto_pgp
        WHERE PRO_Nombre = nombre AND PRO_Descripcion = descripcion;
    END IF;

    -- Si no se encuentra en ninguna tabla, devolver NULL o manejar según tu lógica
    IF actividad_id IS NULL THEN
        SET actividad_id = -1; -- Otra señal de que no se encontró
    END IF;

    RETURN actividad_id;
END //

DELIMITER ;

-- Procedimiento para obtener los requisitos de una convocatoria
DELIMITER //

CREATE PROCEDURE obtenerRequisitos(IN nombre VARCHAR(100), IN descripcion TEXT)
BEGIN
    DECLARE actividad_id INT;
    
    -- Obtener el ID de la convocatoria utilizando la función obtener_id_actividad
    SET actividad_id = obtener_id_actividad(nombre, descripcion);

    -- Verificar si se encontró el ID de la convocatoria
    IF actividad_id = -1 THEN
        SELECT 'No se encontró la convocatoria';
    ELSE
        -- Seleccionar solo la descripción y tipo de requisitos asociados a la convocatoria
        SELECT r.REQ_Tipo, r.REQ_Descripcion 
        FROM requisito r
        JOIN convocatoria_requisito cr ON r.REQ_IdRequisito = cr.REQ_IdRequisito
        WHERE cr.CON_IdConvocatoria = actividad_id;
    END IF;
END //

DELIMITER ;

-- DOCUMENTAR, PROCEDIMIENTO PARA VER LAS INSCRIPCIONES PERSONALES  -- 

DELIMITER $$         
CREATE PROCEDURE inscripcionesPersonales(IN DocumentoIdentidad INT)
	BEGIN
		SELECT 
		INS_IdInscripcion, INS_Fecha, Nombre, INS_Estado, Descripcion 
    FROM 
		((SELECT 
    BEN_IdBeneficio, 
    CASE 
        WHEN BEN_TipoBeneficio = 'M' THEN 'Monetario' 
        WHEN BEN_TipoBeneficio = 'A' THEN 'Alimenticio' 
        WHEN BEN_TipoBeneficio = 'T' THEN 'Transporte' 
        WHEN BEN_TipoBeneficio = 'C' THEN 'Cita medica' 
    END AS 'Nombre', 
    BEN_Descripcion AS 'Descripcion', 
    CON_IdConvocatoria 
	FROM 
    beneficio) UNION 
        (SELECT CUR_IdCurso, CUR_Nombre AS 'Nombre', CUR_Descripcion AS 'Descripcion', CON_IdConvocatoria FROM curso) UNION 
        (SELECT PRO_IdProyectoPGP, PRO_Nombre AS 'Nombre', PRO_Descripcion, CON_IdConvocatoria FROM proyecto_pgp)) AS programasEstudiantes NATURAL JOIN 
        convocatoria NATURAL JOIN 
        (SELECT 
        INS_IdInscripcion,
        PER_DocumentoIdentidad,
        INS_Fecha,
    CASE 
        WHEN INS_Estado = 'A' THEN 'Aprobado' 
        WHEN INS_Estado = 'P' THEN 'Pendiente' 
        WHEN INS_Estado = 'R' THEN 'Rechazado' 
    END AS 'INS_Estado', 
    CON_IdConvocatoria 
	FROM inscripcion) AS Inscripciones
        WHERE PER_DocumentoIdentidad = DocumentoIdentidad; 
	END $$ 
DELIMITER ; 


DELIMITER $$

CREATE PROCEDURE buscarConvocatorias (IN busqueda VARCHAR(255))
BEGIN 
    SELECT 
        CON_Tipo, 
        Nombre, 
        CON_FechaInicio, 
        CON_FechaFin, 
        Descripcion
    FROM 
        tableConvocatorias 
    WHERE 
        CONVERT(Nombre USING utf8mb4) COLLATE utf8mb4_unicode_ci LIKE CONCAT('%', CONVERT(busqueda USING utf8mb4) COLLATE utf8mb4_unicode_ci, '%') OR
        CONVERT(Descripcion USING utf8mb4) COLLATE utf8mb4_unicode_ci LIKE CONCAT('%', CONVERT(busqueda USING utf8mb4) COLLATE utf8mb4_unicode_ci, '%');
END $$

DELIMITER ;

-- procedimiento busqueda eventos -- 
DELIMITER //
CREATE PROCEDURE buscarEventos(IN busqueda VARCHAR(255))
BEGIN
    SELECT 
        EVE_Nombre,
        HOR_Fecha,
        HOR_HoraInicio,
        HOR_HoraFinal,
        INF_Nombre
    FROM evento 
    NATURAL JOIN horario 
    NATURAL JOIN infraestructura
    WHERE CONVERT(EVE_Nombre USING utf8mb4) COLLATE utf8mb4_unicode_ci LIKE CONCAT('%', CONVERT(busqueda USING utf8mb4) COLLATE utf8mb4_unicode_ci, '%');
END //

DELIMITER $$


DELIMITER //
CREATE PROCEDURE EliminarInscripcion(
    IN p_InsId INT
)
BEGIN
    DELETE FROM inscripcion WHERE INS_IdInscripcion = p_InsId;
END //
DELIMITER ;

DELIMITER //

CREATE PROCEDURE obtener_persona_por_documento(IN documento_identidad INT)
BEGIN
    SELECT * 
    FROM persona 
    WHERE PER_DocumentoIdentidad = documento_identidad;
END //

DELIMITER ;

DELIMITER $$ 
CREATE PROCEDURE NewRegistration(IN IdConvocatoria VARCHAR(45) , IN IdentityDocument INT )
	BEGIN  
    INSERT INTO inscripcion (PER_DocumentoIdentidad,CON_IdConvocatoria, INS_Estado,INS_Fecha) 
    VALUES (IdentityDocument, IdConvocatoria, 'P',current_date()); 
    END $$ 
DELIMITER ;

DELIMITER //
CREATE PROCEDURE obtener_detalles_convocatoria(IN input_IdConvocatoria INT)
BEGIN
    SELECT 
        IFNULL(c.CUR_Nombre, p.PRO_Nombre) AS Nombre,
        h.HOR_Fecha,
        h.HOR_HoraInicio,
        h.HOR_HoraFinal,
        i.INF_Nombre
    FROM 
        convocatoria conv
        LEFT JOIN curso c ON conv.CON_IdConvocatoria = c.CON_IdConvocatoria
        LEFT JOIN curso_horario ch ON c.CUR_IdCurso = ch.CUR_IdCurso
        LEFT JOIN proyecto_pgp p ON conv.CON_IdConvocatoria = p.CON_IdConvocatoria
        LEFT JOIN horario h ON ch.HOR_IdHorario = h.HOR_IdHorario OR p.HOR_IdHorario = h.HOR_IdHorario
        LEFT JOIN infraestructura i ON h.INF_IdInfraestructura = i.INF_IdInfraestructura
    WHERE 
        conv.CON_IdConvocatoria = input_IdConvocatoria;
END //
DELIMITER ;

FLUSH PRIVILEGES;
