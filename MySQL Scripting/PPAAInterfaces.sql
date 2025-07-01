-- DOCUMENTACIÓN DE PROCEDIMIENTOS Y FUNCIONES --

/*
Procedimiento: obtener_convocatorias
Descripción: Obtiene todas las convocatorias desde la tabla tableConvocatorias.
*/
DELIMITER //
CREATE PROCEDURE obtener_convocatorias()
BEGIN
    SELECT * FROM tableConvocatorias;
END //
DELIMITER ;

/*
Procedimiento: obtener_eventos
Descripción: Obtiene todos los eventos desde la vista vw_evento.
*/
DELIMITER //
CREATE PROCEDURE obtener_eventos()
BEGIN
    SELECT * FROM vw_evento;
END //
DELIMITER ;

/*
Procedimiento: obtener_oficinas
Descripción: Obtiene todas las oficinas desde la vista vw_oficinas.
*/
DELIMITER //
CREATE PROCEDURE obtener_oficinas()
BEGIN
    SELECT * FROM vw_oficinas;
END //
DELIMITER ;

/*
Procedimiento: obtener_areas
Descripción: Obtiene todas las áreas desde la vista vw_areas.
*/
DELIMITER //
CREATE PROCEDURE obtener_areas()
BEGIN
    SELECT * FROM vw_areas;
END //
DELIMITER ;

/*
Procedimiento: obtener_id_convocatoria
Descripción: Obtiene el ID de convocatoria dado un nombre y una descripción.
Parámetros:
- nombre: Nombre de la convocatoria.
- descripcion: Descripción de la convocatoria.
*/
DELIMITER //
CREATE PROCEDURE obtener_id_convocatoria(IN nombre VARCHAR(255), IN descripcion VARCHAR(255))
BEGIN
    SELECT CON_IdConvocatoria FROM v_convocatoria_info WHERE nombre = nombre AND descripcion = descripcion;
END //
DELIMITER ;

/*
Función: obtener_id_actividad
Descripción: Devuelve el ID de una actividad (curso, beneficio o proyecto) dado un nombre y descripción.
Parámetros:
- nombre: Nombre de la actividad.
- descripcion: Descripción de la actividad.
*/
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

    -- Si no se encuentra en ninguna tabla, devolver -1 como señal de no encontrado
    IF actividad_id IS NULL THEN
        SET actividad_id = -1;
    END IF;

    RETURN actividad_id;
END //
DELIMITER ;

/*
Procedimiento: obtenerRequisitos
Descripción: Obtiene los requisitos asociados a una convocatoria dado su nombre y descripción.
Parámetros:
- nombre: Nombre de la convocatoria.
- descripcion: Descripción de la convocatoria.
*/
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

/*
Procedimiento: inscripcionesPersonales
Descripción: Obtiene las inscripciones asociadas a una persona dado su documento de identidad.
Parámetros:
- DocumentoIdentidad: Documento de identidad de la persona.
*/
DELIMITER //
CREATE PROCEDURE inscripcionesPersonales(IN DocumentoIdentidad INT)
BEGIN
    SELECT 
        INS_IdInscripcion, 
        INS_Fecha, 
        Nombre, 
        INS_Estado, 
        Descripcion 
    FROM (
        (SELECT BEN_IdBeneficio, 
                CASE 
                    WHEN BEN_TipoBeneficio = 'M' THEN 'Monetario' 
                    WHEN BEN_TipoBeneficio = 'A' THEN 'Alimenticio' 
                    WHEN BEN_TipoBeneficio = 'T' THEN 'Transporte' 
                    WHEN BEN_TipoBeneficio = 'C' THEN 'Cita medica' 
                END AS 'Nombre', 
                BEN_Descripcion AS 'Descripcion', 
                CON_IdConvocatoria 
         FROM beneficio) 
        
        UNION 
        
        (SELECT CUR_IdCurso, 
                CUR_Nombre AS 'Nombre', 
                CUR_Descripcion AS 'Descripcion', 
                CON_IdConvocatoria 
         FROM curso) 
        
        UNION 
        
        (SELECT PRO_IdProyectoPGP, 
                PRO_Nombre AS 'Nombre', 
                PRO_Descripcion AS 'Descripcion', 
                CON_IdConvocatoria 
         FROM proyecto_pgp)
    ) AS programasEstudiantes 
    NATURAL JOIN convocatoria 
    NATURAL JOIN (
        SELECT 
            INS_IdInscripcion, 
            PER_DocumentoIdentidad, 
            INS_Fecha,
            CASE 
                WHEN INS_Estado = 'A' THEN 'Aprobado' 
                WHEN INS_Estado = 'P' THEN 'Pendiente' 
                WHEN INS_Estado = 'R' THEN 'Rechazado' 
            END AS 'INS_Estado', 
            CON_IdConvocatoria 
        FROM inscripcion
    ) AS Inscripciones
    WHERE PER_DocumentoIdentidad = DocumentoIdentidad; 
END //
DELIMITER ;

/*
Procedimiento: buscarEventos
Descripción: Busca eventos por nombre.
Parámetros:
- busqueda: Cadena de búsqueda para el nombre del evento.
*/
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

/*
Procedimiento: buscarConvocatorias
Descripción: Busca convocatorias por nombre o descripción.
Parámetros:
- busqueda: Cadena de búsqueda para el nombre o descripción de la convocatoria.
*/
DELIMITER //
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
END //
DELIMITER ;

/*
Procedimiento: obtener_persona_por_documento
Descripción: Obtiene los datos de una persona por su documento de identidad.
Parámetros:
- documento_identidad: Documento de identidad de la persona.
*/
DELIMITER //
CREATE PROCEDURE obtener_persona_por_documento(IN documento_identidad INT)
BEGIN
    SELECT * 
    FROM persona 
    WHERE PER_DocumentoIdentidad = documento_identidad;
END //
DELIMITER ;

/*
Procedimiento: NewRegistration
Descripción: Registra una nueva inscripción a una convocatoria.
Parámetros:
- IdConvocatoria: ID de la convocatoria a la que se va a inscribir.
- IdentityDocument: Documento de identidad de la persona que se inscribe.
*/
DELIMITER //
CREATE PROCEDURE NewRegistration(IN IdConvocatoria VARCHAR(45), IN IdentityDocument INT)
BEGIN  
    INSERT INTO inscripcion (PER_DocumentoIdentidad, CON_IdConvocatoria, INS_Estado, INS_Fecha) 
    VALUES (IdentityDocument, IdConvocatoria, 'P', CURRENT_DATE()); 
END //
DELIMITER ;

/*
Procedimiento: obtener_detalles_convocatoria
Descripción: Obtiene detalles específicos de una convocatoria por su ID.
Parámetros:
- input_IdConvocatoria: ID de la convocatoria.
*/
DELIMITER //
CREATE PROCEDURE obtener_detalles_convocatoria(IN input_Id)
-- DOCUMENTACIÓN DE PROCEDIMIENTOS Y FUNCIONES --

/*
Procedimiento: obtener_convocatorias
Descripción: Obtiene todas las convocatorias desde la tabla tableConvocatorias.
*/
DELIMITER //
CREATE PROCEDURE obtener_convocatorias()
BEGIN
    SELECT * FROM tableConvocatorias;
END //
DELIMITER ;

/*
Procedimiento: obtener_eventos
Descripción: Obtiene todos los eventos desde la vista vw_evento.
*/
DELIMITER //
CREATE PROCEDURE obtener_eventos()
BEGIN
    SELECT * FROM vw_evento;
END //
DELIMITER ;

/*
Procedimiento: obtener_oficinas
Descripción: Obtiene todas las oficinas desde la vista vw_oficinas.
*/
DELIMITER //
CREATE PROCEDURE obtener_oficinas()
BEGIN
    SELECT * FROM vw_oficinas;
END //
DELIMITER ;

/*
Procedimiento: obtener_areas
Descripción: Obtiene todas las áreas desde la vista vw_areas.
*/
DELIMITER //
CREATE PROCEDURE obtener_areas()
BEGIN
    SELECT * FROM vw_areas;
END //
DELIMITER ;

/*
Procedimiento: obtener_id_convocatoria
Descripción: Obtiene el ID de convocatoria dado un nombre y una descripción.
Parámetros:
- nombre: Nombre de la convocatoria.
- descripcion: Descripción de la convocatoria.
*/
DELIMITER //
CREATE PROCEDURE obtener_id_convocatoria(IN nombre VARCHAR(255), IN descripcion VARCHAR(255))
BEGIN
    SELECT CON_IdConvocatoria FROM v_convocatoria_info WHERE nombre = nombre AND descripcion = descripcion;
END //
DELIMITER ;

/*
Función: obtener_id_actividad
Descripción: Devuelve el ID de una actividad (curso, beneficio o proyecto) dado un nombre y descripción.
Parámetros:
- nombre: Nombre de la actividad.
- descripcion: Descripción de la actividad.
*/
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

    -- Si no se encuentra en ninguna tabla, devolver -1 como señal de no encontrado
    IF actividad_id IS NULL THEN
        SET actividad_id = -1;
    END IF;

    RETURN actividad_id;
END //
DELIMITER ;

/*
Procedimiento: obtenerRequisitos
Descripción: Obtiene los requisitos asociados a una convocatoria dado su nombre y descripción.
Parámetros:
- nombre: Nombre de la convocatoria.
- descripcion: Descripción de la convocatoria.
*/
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

/*
Procedimiento: inscripcionesPersonales
Descripción: Obtiene las inscripciones asociadas a una persona dado su documento de identidad.
Parámetros:
- DocumentoIdentidad: Documento de identidad de la persona.
*/
DELIMITER //
CREATE PROCEDURE inscripcionesPersonales(IN DocumentoIdentidad INT)
BEGIN
    SELECT 
        INS_IdInscripcion, 
        INS_Fecha, 
        Nombre, 
        INS_Estado, 
        Descripcion 
    FROM (
        (SELECT BEN_IdBeneficio, 
                CASE 
                    WHEN BEN_TipoBeneficio = 'M' THEN 'Monetario' 
                    WHEN BEN_TipoBeneficio = 'A' THEN 'Alimenticio' 
                    WHEN BEN_TipoBeneficio = 'T' THEN 'Transporte' 
                    WHEN BEN_TipoBeneficio = 'C' THEN 'Cita medica' 
                END AS 'Nombre', 
                BEN_Descripcion AS 'Descripcion', 
                CON_IdConvocatoria 
         FROM beneficio) 
        
        UNION 
        
        (SELECT CUR_IdCurso, 
                CUR_Nombre AS 'Nombre', 
                CUR_Descripcion AS 'Descripcion', 
                CON_IdConvocatoria 
         FROM curso) 
        
        UNION 
        
        (SELECT PRO_IdProyectoPGP, 
                PRO_Nombre AS 'Nombre', 
                PRO_Descripcion AS 'Descripcion', 
                CON_IdConvocatoria 
         FROM proyecto_pgp)
    ) AS programasEstudiantes 
    NATURAL JOIN convocatoria 
    NATURAL JOIN (
        SELECT 
            INS_IdInscripcion, 
            PER_DocumentoIdentidad, 
            INS_Fecha,
            CASE 
                WHEN INS_Estado = 'A' THEN 'Aprobado' 
                WHEN INS_Estado = 'P' THEN 'Pendiente' 
                WHEN INS_Estado = 'R' THEN 'Rechazado' 
            END AS 'INS_Estado', 
            CON_IdConvocatoria 
        FROM inscripcion
    ) AS Inscripciones
    WHERE PER_DocumentoIdentidad = DocumentoIdentidad; 
END //
DELIMITER ;

/*
Procedimiento: buscarEventos
Descripción: Busca eventos por nombre.
Parámetros:
- busqueda: Cadena de búsqueda para el nombre del evento.
*/
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

/*
Procedimiento: buscarConvocatorias
Descripción: Busca convocatorias por nombre o descripción.
Parámetros:
- busqueda: Cadena de búsqueda para el nombre o descripción de la convocatoria.
*/
DELIMITER //
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
END //
DELIMITER ;

/*
Procedimiento: obtener_persona_por_documento
Descripción: Obtiene los datos de una persona por su documento de identidad.
Parámetros:
- documento_identidad: Documento de identidad de la persona.
*/
DELIMITER //
CREATE PROCEDURE obtener_persona_por_documento(IN documento_identidad INT)
BEGIN
    SELECT * 
    FROM persona 
    WHERE PER_DocumentoIdentidad = documento_identidad;
END //
DELIMITER ;

/*
Procedimiento: NewRegistration
Descripción: Registra una nueva inscripción a una convocatoria.
Parámetros:
- IdConvocatoria: ID de la convocatoria a la que se va a inscribir.
- IdentityDocument: Documento de identidad de la persona que se inscribe.
*/
DELIMITER //
CREATE PROCEDURE NewRegistration(IN IdConvocatoria VARCHAR(45), IN IdentityDocument INT)
BEGIN  
    INSERT INTO inscripcion (PER_DocumentoIdentidad, CON_IdConvocatoria, INS_Estado, INS_Fecha) 
    VALUES (IdentityDocument, IdConvocatoria, 'P', CURRENT_DATE()); 
END //
DELIMITER ;

/*
Procedimiento: obtener_detalles_convocatoria
Descripción: Obtiene detalles específicos de una convocatoria por su ID.
Parámetros:
- input_IdConvocatoria: ID de la convocatoria.
*/
DELIMITER //
CREATE PROCEDURE obtener_detalles_convocatoria(IN input_Id int) 
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

/*
Procedimiento: buscarCronograma
Descripción: Busca entradas en el cronograma por nombre o descripción.
Parámetros:
- busqueda: Cadena de búsqueda para el nombre o descripción del cronograma.
*/
DELIMITER //
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
END //
DELIMITER ;

/*
Procedimiento: busquedaIns
Descripción: Busca inscripciones por nombre o convocatoria.
Parámetros:
- busqueda: Cadena de búsqueda para el nombre de la inscripción o convocatoria.
*/
DELIMITER //
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
END //
DELIMITER ;

/*
Procedimiento: estado_aprobado_ins
Descripción: Cambia el estado de una inscripción a 'Aprobado'.
Parámetros:
- id: ID de la inscripción a aprobar.
*/
DELIMITER //
CREATE PROCEDURE estado_aprobado_ins (id INT)
BEGIN
    UPDATE inscripcion SET INS_Estado='A' WHERE INS_IdInscripcion = id;
END //
DELIMITER ;

/*
Procedimiento: estado_rechazado_ins
Descripción: Cambia el estado de una inscripción a 'Rechazado'.
Parámetros:
- id: ID de la inscripción a rechazar.
*/
DELIMITER //
CREATE PROCEDURE estado_rechazado_ins (id INT)
BEGIN
    UPDATE inscripcion SET INS_Estado='R' WHERE INS_IdInscripcion = id;
END //
DELIMITER ;

/* 
Procedimientos de Obtención de Datos:

obtener_convocatorias():

Obtiene todas las convocatorias desde la tabla tableConvocatorias.
obtener_eventos(), obtener_oficinas(), obtener_areas():

Estos procedimientos obtienen datos desde las vistas vw_evento, vw_oficinas y vw_areas, respectivamente.
obtener_id_convocatoria(nombre, descripcion):

Obtiene el ID de convocatoria dado el nombre y la descripción desde la vista v_convocatoria_info.
obtener_id_actividad(nombre, descripcion):

Esta función devuelve el ID de una actividad (curso, beneficio o proyecto) basándose en su nombre y descripción, buscando primero en la tabla curso, luego en beneficio, y finalmente en proyecto_pgp.
Procedimientos Relacionados con Convocatorias:

obtenerRequisitos(nombre, descripcion):

Obtiene los requisitos asociados a una convocatoria especificada por su nombre y descripción, seleccionando la descripción y tipo de requisitos desde la tabla requisito mediante una join con convocatoria_requisito.
obtener_detalles_convocatoria(input_IdConvocatoria):

Recupera detalles específicos de una convocatoria identificada por su ID desde la tabla convocatoria, utilizando joins con las tablas curso, curso_horario, proyecto_pgp, horario e infraestructura.
buscarConvocatorias(busqueda):

Busca convocatorias que coincidan con una cadena de búsqueda especificada en los campos Nombre o Descripción en la tabla tableConvocatorias.
NewRegistration(IdConvocatoria, IdentityDocument):

Registra una nueva inscripción asociando un documento de identidad y el ID de una convocatoria en la tabla inscripcion, estableciendo automáticamente el estado como 'Pendiente' y la fecha actual.
Otros Procedimientos y Funciones:

inscripcionesPersonales(DocumentoIdentidad):

Muestra las inscripciones asociadas a una persona identificada por su documento de identidad, obteniendo detalles como el ID de inscripción, fecha, nombre del programa, estado de la inscripción y descripción del programa desde las tablas inscripcion, beneficio, curso, proyecto_pgp y convocatoria.
buscarEventos(busqueda):

Busca eventos que coincidan con una cadena de búsqueda especificada en el nombre del evento desde la tabla evento, utilizando joins con horario e infraestructura.
Observaciones y Comentarios:

Colisión de Nombres: Se identificó una potencial colisión de nombres entre el procedimiento inscripcionesPersonales y uno de los nuevos procedimientos propuestos con el mismo nombre. Se recomienda renombrar uno de ellos para evitar conflictos.

Características de Búsqueda: Se emplea COLLATE utf8mb4_unicode_ci en las consultas de búsqueda para asegurar que las comparaciones sean insensibles a mayúsculas/minúsculas y a acentos, mejorando la flexibilidad de las búsquedas.

Manejo de Estados: Los procedimientos estado_aprobado_ins y estado_rechazado_ins permiten actualizar el estado de las inscripciones, facilitando la gestión de datos y el seguimiento del estado de las inscripciones en el sistema.
*/
