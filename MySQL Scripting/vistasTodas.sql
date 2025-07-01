-- VISTA PARA LAS CONVOCATORIAS --
CREATE VIEW tableConvocatorias AS 
    SELECT 
        CON_Tipo, Nombre, CON_FechaInicio, CON_FechaFin, Descripcion
    FROM 
        ((SELECT 
            BEN_IdBeneficio, 
            CASE 
                WHEN BEN_TipoBeneficio = 'M' THEN 'Monetario' 
                WHEN BEN_TipoBeneficio = 'A' THEN 'Alimenticio' 
                WHEN BEN_TipoBeneficio = 'T' THEN 'Transporte' 
                WHEN BEN_TipoBeneficio = 'C' THEN 'Cita medica' 
            END AS Nombre, 
            BEN_Descripcion AS Descripcion, 
            CON_IdConvocatoria 
        FROM 
            beneficio) 
        UNION 
        (SELECT 
            CUR_IdCurso, CUR_Nombre AS Nombre, CUR_Descripcion AS Descripcion, CON_IdConvocatoria 
        FROM 
            curso) 
        UNION 
        (SELECT 
            PRO_IdProyectoPGP, PRO_Nombre AS Nombre, PRO_Descripcion AS Descripcion, CON_IdConvocatoria 
        FROM 
            proyecto_pgp)) AS programasEstudiantes 
    NATURAL JOIN 
        convocatoria;

-- VISTA PARA EVENTOS -- 
CREATE VIEW vw_evento AS 
    SELECT  
        EVE_Nombre ,
        HOR_Fecha ,
        HOR_HoraInicio ,
        HOR_HoraFinal,
        INF_Nombre 
    FROM 
        evento 
    NATURAL JOIN 
        horario 
    NATURAL JOIN 
        infraestructura;

-- VISTA PARA CRONOGRAMA EMPLEADO -- 
CREATE VIEW vw_cronograma AS 
    SELECT 
        EVE_Nombre COLLATE utf8mb4_unicode_ci AS Nombre, 
        CONCAT(CAST(HOR_Fecha AS CHAR), ' ', CAST(HOR_HoraInicio AS CHAR)) COLLATE utf8mb4_unicode_ci AS FechaInicio, 
        CONCAT(CAST(HOR_Fecha AS CHAR), ' ', CAST(HOR_HoraFinal AS CHAR)) COLLATE utf8mb4_unicode_ci AS FechaFin,
        EVE_Tipo COLLATE utf8mb4_unicode_ci AS Descripcion
    FROM 
        evento 
    NATURAL JOIN 
        horario 
    NATURAL JOIN 
        infraestructura
    UNION 
    SELECT 
        Nombre COLLATE utf8mb4_unicode_ci, 
        CAST(CON_FechaInicio AS CHAR) COLLATE utf8mb4_unicode_ci AS FechaInicio, 
        CAST(CON_FechaFin AS CHAR) COLLATE utf8mb4_unicode_ci AS FechaFin,
        Descripcion COLLATE utf8mb4_unicode_ci
    FROM 
        tableConvocatorias;

-- VISTA PARA ÁREAS -- 
CREATE VIEW vw_areas AS
    SELECT 
        ARE_Nombre, 
        ARE_Telefono, 
        ARE_CorreoElectronico 
    FROM 
        area;

-- VISTA PARA OFICINAS -- 
CREATE VIEW vw_oficinas AS
    SELECT 
        OFI_Nombre, 
        INF_Locacion, 
        OFI_Telefono,
        OFI_CorreoElectronico
    FROM
        oficina 
    NATURAL JOIN 
        infraestructura;

-- VISTA PARA REUNIONES DE EMPLEADO -- 
CREATE VIEW vw_reuniones AS 
    SELECT 
        REU_Fecha, 
        REU_Objetivo, 
        CASE 
            WHEN REU_Modalidad = 'VI' THEN 'Virtual'
            WHEN REU_Modalidad = 'MIX' THEN 'Mixta'
            WHEN REU_Modalidad = 'PR' THEN 'Presencial'
            ELSE REU_Modalidad
        END AS REU_Modalidad, 
        REU_Relatoria 
    FROM 
        reunion;

-- VISTA PARA INSCRIPCIONES DE EMPLEADO -- 
CREATE VIEW vw_inscripcion AS
    SELECT 
        INS_Fecha AS 'Fecha inscripción',
        CONCAT(PER_Nombre,' ',PER_Apellido) AS Nombre,
        CUR_Nombre AS Convocatoria,
        INS_ESTADO AS 'Estado Inscripción' 
    FROM 
        inscripcion 
    NATURAL JOIN 
        Persona 
    INNER JOIN 
        curso USING(CON_IdConvocatoria) 
    UNION
    SELECT 
        INS_Fecha AS 'Fecha inscripción',
        CONCAT(PER_Nombre,' ',PER_Apellido) AS Nombre,
        PRO_Nombre,
        INS_ESTADO 
    FROM 
        inscripcion 
    NATURAL JOIN 
        Persona 
    INNER JOIN 
        proyecto_pgp USING(CON_IdConvocatoria) 
    UNION 
    SELECT 
        INS_Fecha AS 'Fecha inscripción',
        CONCAT(PER_Nombre,' ',PER_Apellido) AS Nombre,
        BEN_Descripcion,
        INS_ESTADO 
    FROM 
        inscripcion 
    NATURAL JOIN 
        Persona 
    INNER JOIN 
        beneficio USING(CON_IdConvocatoria);
        
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

-- Seleccionar todas las vistas creadas --
-- SELECT * FROM tableConvocatorias;
-- SELECT * FROM vw_evento;
-- SELECT * FROM vw_cronograma;
-- SELECT * FROM vw_areas;
-- SELECT * FROM vw_oficinas;
-- SELECT * FROM vw_reuniones;
-- SELECT * FROM vw_inscripcion;
-- select * from vista_empleado_detalle; 
