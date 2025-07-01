USE bienestar;
-- VISTA PARA LAS CONVOCATORIAS -- 
CREATE VIEW tableConvocatorias AS 
	SELECT 
		CON_Tipo, Nombre,  CON_FechaInicio, CON_FechaFin, Descripcion
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
        convocatoria;
        
SELECT * FROM tableConvocatorias; 

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
DROP PROCEDURE inscripcionesPersonales; 
CALL inscripcionesPersonales(1003);


-- VISTA PARA EVENTOS -- 
CREATE VIEW vw_evento AS 
	SELECT  EVE_Nombre ,
	HOR_Fecha ,
	HOR_HoraInicio ,
	HOR_HoraFinal,
    INF_Nombre 
	FROM evento NATURAL JOIN horario NATURAL JOIN infraestructura;

select * from vw_evento; 

-- vista cronograma empleado --     

CREATE VIEW vw_cronograma AS 
SELECT EVE_Nombre COLLATE utf8mb4_unicode_ci AS Nombre, 
       CONCAT(CAST(HOR_Fecha AS CHAR), ' ', CAST(HOR_HoraInicio AS CHAR)) COLLATE utf8mb4_unicode_ci AS FechaInicio, 
       CONCAT(CAST(HOR_Fecha AS CHAR), ' ', CAST(HOR_HoraFinal AS CHAR)) COLLATE utf8mb4_unicode_ci AS FechaFin,
       EVE_Tipo COLLATE utf8mb4_unicode_ci AS Descripcion
FROM evento 
NATURAL JOIN horario 
NATURAL JOIN infraestructura
UNION 
SELECT Nombre COLLATE utf8mb4_unicode_ci, 
       CAST(CON_FechaInicio AS CHAR) COLLATE utf8mb4_unicode_ci AS FechaInicio, 
       CAST(CON_FechaFin AS CHAR) COLLATE utf8mb4_unicode_ci AS FechaFin,
       Descripcion COLLATE utf8mb4_unicode_ci
FROM tableConvocatorias;

-- vista areas -- 
CREATE VIEW vw_areas AS
	SELECT ARE_Nombre, 
    ARE_Telefono, 
    ARE_CorreoElectronico 
    FROM 
    area;

select * from vw_areas;

-- vista oficinas -- 
CREATE VIEW vw_oficinas AS
	SELECT OFI_Nombre, 
    INF_Locacion, 
    OFI_Telefono,
    OFI_CorreoElectronico
    FROM
    oficina NATURAL JOIN infraestructura; 
    
SELECT * FROM vw_oficinas;

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

DELIMITER ;

CALL buscarEventos("mesa redonda");

-- procedimiento busqueda convocatoria -- 
DROP PROCEDURE IF EXISTS buscarConvocatorias;
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

CALL buscarConvocatorias("monetario"); 

ALTER DATABASE bienestar CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Cambiar la collation de todas las tablas y columnas si es necesario

-- Repetir para todas las tablas de tu base de datos


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

    -- Si no se encuentra en ninguna tabla, devolver NULL o manejar según tu logica
    IF actividad_id IS NULL THEN
        SET actividad_id = -1; -- Otra señal de que no se encontro
    END IF;

    RETURN actividad_id;
END //

DELIMITER ;


ALTER DATABASE bienestar CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
-- Procedimiento para obtener los requisitos de una convocatoria
DELIMITER //

CREATE PROCEDURE obtenerRequisitos(IN nombre VARCHAR(100), IN descripcion TEXT)
BEGIN
    DECLARE actividad_id INT;
    
    -- Obtener el ID de la convocatoria utilizando la funcion obtener_id_actividad
    SET actividad_id = obtener_id_actividad(nombre, descripcion);

    -- Verificar si se encontro el ID de la convocatoria
    IF actividad_id = -1 THEN
        SELECT 'No se encontro la convocatoria';
    ELSE
        -- Seleccionar solo la descripcion y tipo de requisitos asociados a la convocatoria
        SELECT r.REQ_Tipo, r.REQ_Descripcion 
        FROM requisito r
        JOIN convocatoria_requisito cr ON r.REQ_IdRequisito = cr.REQ_IdRequisito
        WHERE cr.CON_IdConvocatoria = actividad_id;
    END IF;
END //

DELIMITER ;

SELECT * FROM curso;

CALL obtenerRequisitos('Salsa y Merengue', 'Propiciar un acercamiento a la danza - salsa a través del aprendizaje de una amplia variedad de estilos, ritmos y pasos de los subgéneros de la salsa y el merengue');

-- vista para las reuniones de empleado -- 

CREATE VIEW vw_reuniones AS 
SELECT REU_Fecha, 
       REU_Objetivo, 
       CASE 
           WHEN REU_Modalidad = 'VI' THEN 'Virtual'
           WHEN REU_Modalidad = 'MIX' THEN 'Mixta'
           WHEN REU_Modalidad = 'PR' THEN 'Presencial'
           ELSE REU_Modalidad
       END AS REU_Modalidad, 
       REU_Relatoria 
		FROM reunion;

    
DROP VIEW vw_reuniones; 
SELECT * FROM vw_reuniones; 

-- vista inscripciones empleado -- 
CREATE VIEW vw_inscripcion AS
SELECT INS_Fecha AS 'Fecha inscripcion', concat(PER_Nombre,' ',PER_Apellido) AS Nombre, CUR_Nombre AS Convocatoria, INS_ESTADO AS 'Estado Inscripcion' FROM inscripcion Natural JOIN Persona INNER JOIN curso USING(CON_IdConvocatoria) UNION
SELECT INS_Fecha AS 'Fecha inscripcion',concat(PER_Nombre,' ',PER_Apellido) AS Nombre, PRO_Nombre, INS_ESTADO FROM inscripcion Natural JOIN Persona INNER JOIN proyecto_pgp USING(CON_IdConvocatoria) UNION
SELECT INS_Fecha AS 'Fecha inscripcion',concat(PER_Nombre,' ',PER_Apellido) AS Nombre, BEN_Descripcion, INS_ESTADO FROM inscripcion Natural JOIN Persona INNER JOIN beneficio USING(CON_IdConvocatoria);

SELECT * FROM vw_inscripcion;

-- Procedimiento de búsqeuda sobre la vista vw_cronograma
DELIMITER %%
CREATE PROCEDURE buscarCronograma(IN busqueda VARCHAR(255))
BEGIN 
    SELECT 
        Nombre, 
        FechaInicio, 
        FechaFin, 
        Descripcion
    FROM 
        vw_cronograma
    WHERE 
        Nombre LIKE CONCAT('%', busqueda, '%') OR
        Descripcion LIKE CONCAT('%', busqueda, '%');
END %%
DELIMITER ;

-- Vista: Inscripciones (Empleados)
DROP VIEW IF EXISTS vw_inscripcion;
CREATE VIEW vw_inscripcion AS
    SELECT 
		INS_IdInscripcion,
        INS_Fecha ,
        CONCAT(PER_Nombre, ' ', PER_Apellido) AS Nombre,
        CUR_Nombre AS Convocatoria,
        INS_ESTADO
    FROM
        inscripcion
            NATURAL JOIN
        Persona
            INNER JOIN
        curso USING (CON_IdConvocatoria) 
    UNION SELECT 
		INS_IdInscripcion,
        INS_Fecha AS 'Fecha inscripcion',
        CONCAT(PER_Nombre, ' ', PER_Apellido) AS Nombre,
        PRO_Nombre,
        INS_ESTADO
    FROM
        inscripcion
            NATURAL JOIN
        persona
            INNER JOIN
        proyecto_pgp USING (CON_IdConvocatoria) 
    UNION SELECT 
		INS_IdInscripcion,
        INS_Fecha AS 'Fecha inscripcion',
        CONCAT(PER_Nombre, ' ', PER_Apellido) AS Nombre,
        BEN_Descripcion,
        INS_ESTADO
    FROM
        inscripcion
            NATURAL JOIN
        persona
            INNER JOIN
        beneficio USING (CON_IdConvocatoria);
        
SELECT * FROM vw_inscripcion;
 

-- Procedimiento de búsque da de insripciones
DROP PROCEDURE IF EXISTS busquedaIns;
DELIMITER %%
CREATE PROCEDURE busquedaIns(IN busqueda VARCHAR(255))
BEGIN 
    SELECT 
		INS_IdInscripcion,
        INS_Fecha, 
        Nombre, 
        Convocatoria, 
       INS_ESTADO
    FROM 
        vw_inscripcion
    WHERE 
        Nombre LIKE CONCAT('%', busqueda, '%') OR
        Convocatoria LIKE CONCAT('%', busqueda, '%');
END %%
DELIMITER ;

-- Procedimiento de aprobado
DROP PROCEDURE IF EXISTS estado_aprobado_ins;
DELIMITER $$
CREATE PROCEDURE estado_aprobado_ins (id INT)
BEGIN
	UPDATE inscripcion SET INS_Estado='A' WHERE INS_IdInscripcion = id ;
END $$
DELIMITER ;

-- Procedimiento de rechazado
DROP PROCEDURE IF EXISTS estado_rechazado_ins;
DELIMITER $$
CREATE PROCEDURE estado_rechazado_ins (id INT)
BEGIN
	UPDATE inscripcion SET INS_Estado='R' WHERE INS_IdInscripcion = id;
END $$
DELIMITER ;

CREATE VIEW vista_empleado_detalle AS
SELECT 
    CONCAT(p.PER_TipoDocumento, ' ', p.PER_DocumentoIdentidad) AS DocumentoCompleto,
    CONCAT(p.PER_Nombre, ' ', p.PER_Apellido) AS NombreCompleto,
    p.PER_CorreoElectronico AS CorreoElectronico,
    p.PER_Telefono AS Telefono,
    e.EMP_Cargo AS Cargo,
    o.OFI_Nombre AS Oficina
FROM 
    persona p
JOIN 
    empleado e ON p.PER_DocumentoIdentidad = e.PER_DocumentoIdentidad
JOIN 
    oficina o ON e.INF_IdInfraestructura = o.INF_IdInfraestructura;


