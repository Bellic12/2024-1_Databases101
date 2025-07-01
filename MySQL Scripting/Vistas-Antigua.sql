USE bienestar;

-- Vista que da los requisitos de todas las convocatorias (Estudiantes, empleados y jefes) -- 
CREATE VIEW requisitos_convocatoria AS
    SELECT 
        CON_IdConvocatoria, REQ_Descripcion
    FROM
        convocatoria_requisito
            NATURAL JOIN
        requisito
    ORDER BY CON_IdConvocatoria;

SELECT 
    *
FROM
    requisitos_convocatoria;

-- Vista que da los empleados de bienestar especificando su area de bienestar (Estudiantes y empleados)-- 
CREATE VIEW empleado_persona AS
    SELECT 
        ARE_Nombre,
        PER_Nombre,
        PER_Apellido,
        PER_CorreoElectronico,
        EMP_Cargo, 
		OFI_Nombre 
    FROM
        empleado
            NATURAL JOIN
        area
            NATURAL JOIN
        persona
			NATURAL JOIN 
		oficina
    ORDER BY ARE_Nombre;
    
SELECT 
    *
FROM
    empleado_persona;

-- Vista que da los horarios de los eventos que se van a realizar -- 
CREATE VIEW horarios_eventos AS
    SELECT 
        EVE_Nombre AS 'Nombre evento',
        EVE_Tipo AS 'Tipo evento',
        INF_Nombre AS 'Nombre edificio',
        INF_Locacion AS 'Indicaciones',
        HOR_HoraInicio AS 'Hora de inicio',
        HOR_HoraFinal AS 'Hora de terminación',
        HOR_Fecha AS 'Fecha de realización'
    FROM
        infraestructura
            NATURAL JOIN
        horario
            NATURAL JOIN
        evento
    ORDER BY HOR_Fecha;

SELECT 
    *
FROM
    horarios_eventos;

-- Vista que da los estudiantes admitidos a proyectos pgp -- 

CREATE VIEW admitidos_pgp AS
    SELECT 
        PER_DocumentoIdentidad AS 'Documento identidad',
        PER_Nombre AS 'Nombre',
        PER_Apellido AS 'Apellido',
        PER_CorreoElectronico AS 'Correo electronico',
        PRO_Nombre AS 'Proyecto PGP'
    FROM
        proyecto_pgp
            NATURAL JOIN
        convocatoria
            NATURAL JOIN
        inscripcion
            NATURAL JOIN
        persona
    WHERE
        INS_Estado = 'A'
    ORDER BY PER_DocumentoIdentidad;
 
SELECT 
    *
FROM
    admitidos_pgp;

-- Vista que da los estudiantes admitidos a cursos -- 
CREATE VIEW admitidos_cursos AS
    SELECT 
        PER_DocumentoIdentidad AS 'Documento de Identidad',
        PER_Nombre AS 'Nombre',
        PER_Apellido AS 'Apellido',
        PER_CorreoElectronico AS 'Correo electrónico',
        CUR_Nombre AS 'Curso'
    FROM
        curso
            NATURAL JOIN
        convocatoria
            NATURAL JOIN
        inscripcion
            NATURAL JOIN
        persona
    WHERE
        INS_Estado = 'A'
    ORDER BY PER_DocumentoIdentidad; 

SELECT * FROM admitidos_cursos; 

-- Vista que da los estudiantes admitidos a beneficios -- 
CREATE VIEW admitidos_ben AS
    SELECT 
        PER_DocumentoIdentidad AS 'Documento identidad',
        PER_Nombre AS 'Nombre',
        PER_Apellido AS 'Apellido',
        PER_CorreoElectronico AS 'Correo electrónico',
        BEN_TipoBeneficio AS 'Tipo beneficio'
    FROM
        beneficio
            NATURAL JOIN
        convocatoria
            NATURAL JOIN
        inscripcion
            NATURAL JOIN
        persona
    WHERE
        INS_Estado = 'A'
    ORDER BY PER_DocumentoIdentidad;
 
SELECT 
    *
FROM
    admitidos_ben;

-- Vista que proyecta la cantidad de cursos a los que ha accedido un estudiante:
CREATE VIEW NUM_CursosEstudiante AS
SELECT 
    PER_DocumentoIdentidad AS 'Documento Identidad estudiante',
    CONCAT(PER_Nombre, ' ', PER_Apellido) AS 'Nombre estudiante',
    EST_Pregrado 'Pregrado',
    COUNT(CUR_IdCurso) AS 'Cantidad cursos'
FROM
    estudiante
        NATURAL JOIN
    persona
        LEFT JOIN
    inscripcion USING (PER_DocumentoIdentidad)
        LEFT JOIN
    convocatoria USING (CON_idConvocatoria)
        LEFT JOIN
    curso USING (CON_idConvocatoria)
GROUP BY PER_DocumentoIdentidad, PER_Nombre, PER_Apellido, EST_Pregrado;


-- Vista que muestra los empleados y su información general, tal que su salario es mayor al promedio
CREATE VIEW vw_EMPAVgSalary AS
SELECT 
    PER_DocumentoIdentidad 'Documento Identidad empleado',
    CONCAT(PER_Nombre, ' ', PER_Apellido) AS 'Nombre empleado',
    EMP_Cargo 'Cargo empleado',
    EMP_Sueldo AS 'Sueldo empleado',
    CON_IdConvocatoria AS 'ID Convocatoria',
    CUR_Nombre AS 'Nombre del Curso'
FROM
    empleado
        NATURAL JOIN
    persona
        LEFT JOIN
    empleado_curso USING (PER_DocumentoIdentidad)
        LEFT JOIN
    curso USING (CUR_IdCurso)
WHERE
    EMP_Sueldo > (SELECT 
            AVG(EMP_Sueldo) AS 'Sueldo promedio'
        FROM
            empleado);