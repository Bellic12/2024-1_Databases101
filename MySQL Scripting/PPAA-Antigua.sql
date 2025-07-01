-- SCRIPT DE CONSULTAS, ACTUALIZACIONES Y BORRADOS (PPAA) | GRUPO 12 --

/* 
1. Actualizar el estado de la inscripción de una persona en una convocatoria en base a
   su nombre, apellido y el nombre asociado (curso, proyecto o beneficio).
*/
DELIMITER //
CREATE PROCEDURE actualizarEstadoInscripcionPorNombre (
    IN p_PER_Nombre VARCHAR(45),
    IN p_PER_Apellido VARCHAR(45),
    IN p_NombreAsociado VARCHAR(45),  -- Nombre del curso, proyecto, o beneficio
    IN p_INS_Estado ENUM('A', 'P', 'R')
)
BEGIN
    DECLARE v_PER_DocumentoIdentidad INT;
    DECLARE v_INS_IdInscripcion INT;

    -- Obtener Documento de Identidad de la persona (case-insensitive)
    SELECT PER_DocumentoIdentidad INTO v_PER_DocumentoIdentidad
    FROM persona
    WHERE LOWER(PER_Nombre) = LOWER(p_PER_Nombre) 
      AND LOWER(PER_Apellido) = LOWER(p_PER_Apellido)
    LIMIT 1;

    -- Obtener ID de Inscripción correspondiente y actualizar el estado en una sola operación
    UPDATE inscripcion
    JOIN (
        SELECT con.CON_IdConvocatoria
        FROM convocatoria con
        LEFT JOIN curso cur ON cur.CON_IdConvocatoria = con.CON_IdConvocatoria AND LOWER(cur.CUR_Nombre) = LOWER(p_NombreAsociado)
        LEFT JOIN proyecto_pgp pro ON pro.CON_IdConvocatoria = con.CON_IdConvocatoria AND LOWER(pro.PRO_Nombre) = LOWER(p_NombreAsociado)
        LEFT JOIN beneficio ben ON ben.CON_IdConvocatoria = con.CON_IdConvocatoria AND LOWER(ben.BEN_Descripcion) = LOWER(p_NombreAsociado)
        LEFT JOIN curso cur2 ON cur2.CON_IdConvocatoria = con.CON_IdConvocatoria AND LOWER(cur2.CUR_Descripcion) = LOWER(p_NombreAsociado)
        WHERE cur.CON_IdConvocatoria IS NOT NULL 
           OR pro.CON_IdConvocatoria IS NOT NULL 
           OR ben.CON_IdConvocatoria IS NOT NULL 
           OR cur2.CON_IdConvocatoria IS NOT NULL
        LIMIT 1
    ) AS sub ON inscripcion.CON_IdConvocatoria = sub.CON_IdConvocatoria
    SET inscripcion.INS_Estado = p_INS_Estado
    WHERE inscripcion.PER_DocumentoIdentidad = v_PER_DocumentoIdentidad;
END //
DELIMITER ;


/*
2. Actualizar la fecha de un evento en base al nombre del evento (Empleado).
*/
DELIMITER $$ 
CREATE PROCEDURE NewDateEvent (IN NewDate DATE, IN EventName VARCHAR(45))
	BEGIN 
    DECLARE IdHorary INT DEFAULT 0; 
    SET IdHorary = (SELECT HOR_IdHorario FROM evento WHERE EVE_Nombre = EventName );
    UPDATE horario SET HOR_Fecha = NewDate WHERE IdHorary= HOR_IdHorario;
    END$$ 
DELIMITER ;


/*
3. Actualizar la fecha y las horas de inicio y finalización de un evento o proyecto (Jefe).
*/
DELIMITER $$ 
CREATE PROCEDURE UpdateHorary ( IN NameChange VARCHAR(45), IN NewDate DATE, IN NewHourI TIME, IN NewHourF TIME)
	BEGIN 
    DECLARE IdHorary INT DEFAULT 0; 
    SET IdHorary = (SELECT HOR_IdHorario 
    FROM (SELECT * FROM (SELECT EVE_Nombre AS Nombre, HOR_IdHorario FROM evento) AS events_
		UNION 
	SELECT * FROM (SELECT PRO_Nombre AS Nombre, HOR_IdHorario FROM proyecto_pgp) AS projects_ ) AS unionEventsAndProjects WHERE NameChange = Nombre); 
    UPDATE horario SET HOR_Fecha = NewDate, HOR_HoraInicio= NewHourI, HOR_HoraFinal = NewHourF WHERE HOR_IdHorario = IdHorary; 
    END$$ 
DELIMITER ; 


/*
4. Actualizar el cargo y salario de un empleado por parte de los jefes.
*/
DROP PROCEDURE IF EXISTS Info_empleado;
DELIMITER $$
CREATE PROCEDURE Info_empleado(DI INT, cargo VARCHAR(40), sueldo INT)
BEGIN
	-- Actualización de los valores en las columnas referentes al cargo y sueldo del empleado
	UPDATE empleado SET EMP_CARGO=cargo , EMP_Sueldo=sueldo WHERE PER_DocumentoIdentidad=DI;
END $$
DELIMITER ;


/*
5. Crear una inscripción a un curso a partir de los datos de una persona.
*/
DELIMITER $$ 
CREATE PROCEDURE NewRegistrationCourse(IN NameCourse VARCHAR(45) , IN IdentityDocument INT )
	BEGIN 
-- variable para almacenar el id de la convocatoria del curso -- 
    DECLARE  CourseCallId INT DEFAULT 0; 
-- conocer el id de la convocatoria del curso a partir del nombre -- 
    SET CourseCallId = (SELECT CON_IdConvocatoria FROM curso WHERE CUR_Nombre = NameCourse );
-- inserción -- 
    INSERT INTO inscripcion (PER_DocumentoIdentidad,CON_IdConvocatoria, INS_Estado,INS_Fecha) 
    VALUES (IdentityDocument, CourseCallId, 'P',current_date()); 
    END $$ 
DELIMITER ;


/*
6. Crear una inscripción a un proyecto a partir de los datos reales de las personas.
*/
DELIMITER $$ 
CREATE PROCEDURE NewRegistrationProject (IN NameProject VARCHAR(45) , IN IdentityDocument INT )
	BEGIN 
    DECLARE  ProjectCallId INT DEFAULT 0; 
    SET ProjectCallId = (SELECT CON_IdConvocatoria FROM proyecto_pgp WHERE PRO_Nombre = NameProject );
    INSERT INTO inscripcion (PER_DocumentoIdentidad,CON_IdConvocatoria, INS_Estado,INS_Fecha) 
    VALUES (IdentityDocument, ProjectCallId, 'P',current_date()); 
    END $$ 
DELIMITER ;


/*
7. Crear una inscripción a un beneficio a partir de los datos reales de las personas.
*/
DELIMITER $$ 
CREATE PROCEDURE NewRegistrationBenefit (IN NameBenefit VARCHAR(45) , IN IdentityDocument INT )
	BEGIN 
    DECLARE  BenefitCallId INT DEFAULT 0; 
    SET BenefitCallId = (SELECT CON_IdConvocatoria FROM beneficio WHERE BEN_Nombre = NameBenefit );
    INSERT INTO inscripcion (PER_DocumentoIdentidad,CON_IdConvocatoria, INS_Estado,INS_Fecha) 
    VALUES (IdentityDocument, BenefitCallId, 'P',current_date()); 
    END $$ 
DELIMITER ;


/*
8. Agregar requisitos a una convocatoria.
*/
DELIMITER //
CREATE PROCEDURE AgregarRequisitosAConvocatoria(
    IN p_ConvocatoriaId INT,
    IN p_Requisitos VARCHAR(255) -- Suponiendo que los IDs de requisitos se pasen como una lista separada por comas
)
BEGIN
    -- Eliminar los requisitos que ya no están en la lista de entrada
    DELETE FROM convocatoria_requisito 
    WHERE CON_IdConvocatoria = p_ConvocatoriaId 
    AND REQ_IdRequisito NOT IN (SELECT REQ_IdRequisito FROM requisito WHERE FIND_IN_SET(REQ_IdRequisito, p_Requisitos));

    -- Insertar nuevos requisitos y mantener los existentes
    INSERT INTO convocatoria_requisito(CON_IdConvocatoria, REQ_IdRequisito) 
    SELECT p_ConvocatoriaId, REQ_IdRequisito FROM requisito WHERE FIND_IN_SET(REQ_IdRequisito, p_Requisitos)
    ON DUPLICATE KEY UPDATE CON_IdConvocatoria = p_ConvocatoriaId;

END //
DELIMITER ;


/*
9. Registrar la asistencia de los empleados a las reuniones.
*/
DROP PROCEDURE IF EXISTS insrt_asistenciaReuniones;
DELIMITER $$
CREATE PROCEDURE insrt_asistenciaReuniones(IDReunion INT, IDEmpleado INT)
BEGIN
	-- Inserción de los parámetros de entrada sobre la tabla asistencia
	INSERT INTO asistencia VALUES (IDReunion,IDEmpleado);
END $$
DELIMITER ;


/*
10. Eliminar una inscripción específica.
*/
DELIMITER //
CREATE PROCEDURE EliminarInscripcion(
    IN p_InsId INT
)
BEGIN
    DELETE FROM inscripcion WHERE INS_IdInscripcion = p_InsId;
END //
DELIMITER ;


/*
11. Eliminar un empleado de la base de datos, lo que incluye eliminar sus registros de asistencia y su información laboral.
*/
DELIMITER //
CREATE PROCEDURE EliminarEmpleado(
    IN p_DocumentoIdentidad INT
)
BEGIN
    -- Eliminar registros de asistencia del empleado
    DELETE FROM asistencia WHERE PER_DocumentoIdentidad = p_DocumentoIdentidad;

	-- Eliminar registros de cursos a dictar
	DELETE FROM empleado_curso WHERE PER_DocumentoIdentidad = p_DocumentoIdentidad;
	
    -- Eliminar al empleado
    DELETE FROM empleado WHERE PER_DocumentoIdentidad = p_DocumentoIdentidad;
END //
DELIMITER ;


/*
12. Eliminar un curso de la base de datos según su nombre.
*/
DELIMITER $$ 
CREATE PROCEDURE DeleteCourse(IN NameCourse VARCHAR(45))
	BEGIN 
    DELETE FROM curso WHERE CUR_Nombre = NameCourse; 
    END $$ 
DELIMITER ; 


/*
13. Eliminar un beneficio asociado a una convocatoria específica, identificados por sus respectivos IDs.
*/
DROP PROCEDURE IF EXISTS del_beneficio;
DELIMITER $$
CREATE PROCEDURE del_beneficio(id_benef INT, id_convo INT)
BEGIN
	-- Borrado indicado las llaves de la condición como los parámteros de entrada
	DELETE FROM beneficio WHERE BEN_IdBeneficio=id_benef AND CON_IdConvocatoria=id_convo;
END $$
DELIMITER ;


/*
14. Eliminar un proyecto de PGP especificado por su nombre y el ID de la convocatoria asociada.
*/
DROP PROCEDURE IF EXISTS del_proyectopgp;
DELIMITER %%
CREATE PROCEDURE del_proyectopgp(nom_proy VARCHAR(40), id_convo INT)
BEGIN
	-- Declaración de la variable
	DECLARE id_proy INT;
    -- Asignación del valor a la variable
    SELECT PRO_IdProyectoPGP INTO id_proy FROM proyecto_pgp WHERE PRO_Nombre=nom_proy AND CON_IdConvocatoria=id_convo;
    -- Borrado con la llave indicada
    DELETE FROM proyecto_pgp WHERE PRO_IDProyectoPGP=id_proy;
END %%
DELIMITER ;


/*
15. Obtener el número de inscritos en cada curso para el año seleccionado.
*/
DELIMITER //
CREATE PROCEDURE ObtenerInscripcionesPorCursoAnio(IN p_anio INT)
BEGIN
	SELECT
    	CUR_Nombre AS 'Nombre curso',
    	COUNT(PER_DocumentoIdentidad) AS 'Personas inscritas'
	FROM
    	(SELECT * FROM inscripcion WHERE INS_Estado = 'A') AS aprobados
    	NATURAL JOIN convocatoria NATURAL JOIN curso
	WHERE
    	YEAR(CON_FechaInicio) = p_anio
	GROUP BY
    	CUR_Nombre;
END //
DELIMITER ;


/*
16. Obtener los estudiantes de un profesor especificado por su nombre y apellido.
*/
DELIMITER $$ 
CREATE PROCEDURE StudentsTeacher(NameTeacher VARCHAR(45), LastNameTeacher VARCHAR(45)) 
	BEGIN
SELECT PER_Nombre, PER_Apellido, PER_CorreoElectronico, PER_Telefono
FROM
    persona
        NATURAL JOIN
    (SELECT * FROM inscripcion WHERE INS_Estado = 'A') AS aprobados
        NATURAL JOIN convocatoria NATURAL JOIN curso
WHERE
    (SELECT CUR_IdCurso
        FROM
            persona NATURAL JOIN empleado NATURAL JOIN empleado_curso NATURAL JOIN curso
        WHERE
            PER_Nombre = NameTeacher
                AND PER_Apellido = LastNameTeacher) = CUR_IdCurso; 
	END $$ 
DELIMITER ;


/*
17. Mostrar eventos programados para un año específico.
*/
DROP PROCEDURE IF EXISTS EVENT_YEAR;
DELIMITER %%
CREATE PROCEDURE EVENT_YEAR (year VARCHAR(4))
BEGIN
	IF length(year)=4 THEN
		SELECT 
			EV.EVE_idEvento AS 'ID del Evento',
			EV.EVE_Nombre AS 'Nombre evento',
			HOR_Fecha AS 'Fecha evento',
			INF_Nombre 'Nombre del Lugar del evento',
			INF_Locacion 'Información locación',
			ARE_Nombre 'Área líder del evento'
		FROM
			evento EV
				JOIN
			horario HOR ON EV.HOR_idHorario = HOR.HOR_idHorario
				JOIN
			area AR ON EV.ARE_IdArea = AR.ARE_IdArea
				JOIN
			infraestructura INF ON INF.INF_idInfraestructura = HOR.INF_idInfraestructura
		WHERE
			YEAR(HOR_Fecha) = year;
	END IF;
END %%
DELIMITER ;


/*
18. Actualizar los datos secundarios de las personas de la universidad (Persona U).
*/
DROP PROCEDURE IF EXISTS UPDATE_GeneralData;
DELIMITER %%
CREATE PROCEDURE UPDATE_GeneralData (DI INT, Correo_E VARCHAR(40),Telefono BIGINT)
BEGIN
	DECLARE correo VARCHAR(40);
    SET correo = Correo_E;
	IF correo LIKE '%@unal.edu.co' THEN
		UPDATE persona SET PER_CorreoElectronico=Correo_E, PER_Telefono=Telefono WHERE PER_DocumentoIdentidad=DI;
	END IF;
END %%
DELIMITER ;


/*
19. Actualizar datos primarios y fundamentales de las personas de la comunidad universitaria (Jefes).
*/
DROP PROCEDURE IF EXISTS UPDATE_SpecificData;
DELIMITER %%
CREATE PROCEDURE UPDATE_SpecificData (DI INT, Nombre VARCHAR(30), Apellido VARCHAR(30), TipoDocumento VARCHAR(3), Edad INT)
BEGIN 
	IF length(TipoDocumento)<=3 AND (TipoDocumento='CC' OR TipoDocumento='TI' OR TipoDocumento='CE' OR TipoDocumento='DNI') THEN
	UPDATE persona SET PER_Nombre=Nombre, PER_Apellido=Apellido, PER_TipoDocumento=TipoDocumento, PER_Edad=Edad WHERE PER_DocumentoIdentidad = DI;
    END IF;
END %%
DELIMITER ;