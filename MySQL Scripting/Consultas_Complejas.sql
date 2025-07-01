-- Consultas Complejas MySQL | Grupo 12 --

/*
1. Consulta para visualizar el número de cursos que ha cursado cada estudiante,
   conociendo además su Documento de identidad, nombre y pregrado.
*/
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
GROUP BY PER_DocumentoIdentidad;


/*
2. Listar todos los eventos programados para el año 2024, con información de la
   infraestructura y el área correspondiente.
*/
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
YEAR(HOR_Fecha) = '2024' ;


/*
3. Nombre e información de los empleados, así como los cursos que han dictado y la
   convocatoria en que lo hicieron, tal que su salario es mayor al salario promedio (aún si
   no han dictado cursos).
*/
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


/*
4. Número de inscritos a cada uno de los cursos del año 2024.
*/
SELECT
CUR_Nombre AS 'Nombre curso',
COUNT(PER_DocumentoIdentidad) AS 'Personas inscritas'
FROM
(SELECT * FROM inscripcion WHERE INS_Estado = 'A') AS aprobados
NATURAL JOIN
convocatoria
NATURAL JOIN
curso

WHERE
YEAR(CON_FechaInicio)='2024'
GROUP BY
CUR_Nombre ;


/*
5. Estudiantes de un profesor que dicta un curso.
*/
SELECT
PER_Nombre,
PER_Apellido,
PER_CorreoElectronico,
PER_Telefono
FROM
persona
NATURAL JOIN
(SELECT
*
FROM
inscripcion
WHERE
INS_Estado = 'A') AS aprobados
NATURAL JOIN
convocatoria
NATURAL JOIN
curso
WHERE
(SELECT
CUR_IdCurso
FROM
persona
NATURAL JOIN
empleado
NATURAL JOIN
empleado_curso
NATURAL JOIN
curso
WHERE
PER_Nombre = 'Andrea'
AND PER_Apellido = 'Pérez') = CUR_IdCurso;


/*
6. Curso con más de un empleado y que son de cierta área en un año específico.
*/
SELECT
CUR_Nombre,
ARE_Nombre,
COUNT(PER_DocumentoIdentidad) AS 'Número de empleados'
FROM
empleado_curso
NATURAL JOIN
curso
NATURAL JOIN
area
NATURAL JOIN
convocatoria
WHERE
ARE_Nombre= 'Área de Actividad física y Deporte' AND
CON_FechaInicio >= '2024-01-01' AND
CON_FechaFin <= '2024-06-30'
GROUP BY
CUR_Nombre
HAVING
COUNT(PER_DocumentoIdentidad) > 1;


/*
7. Beneficio monetario con más beneficiados registrados.
*/
SELECT
BEN_IdBeneficio, BEN_TipoBeneficio, BEN_Descripcion
FROM
persona
NATURAL JOIN
beneficio_aprobado
NATURAL JOIN
convocatoria
NATURAL JOIN
beneficio
WHERE
BEN_TipoBeneficio = 'M'
GROUP BY BEN_IdBeneficio , BEN_Descripcion
HAVING COUNT(BEN_IdBeneficio) = (SELECT
MAX(Numero_benef)
FROM
(SELECT
COUNT(PER_DocumentoIdentidad) AS Numero_benef
FROM
persona
NATURAL JOIN beneficio_aprobado
NATURAL JOIN convocatoria
NATURAL JOIN beneficio
WHERE
BEN_TipoBeneficio = 'M'
GROUP BY BEN_IdBeneficio) AS S);


/*
8. Infraestructuras de bienestar ocupadas por áreas específicas.
*/
SELECT i.INF_Nombre AS 'Nombre de la infraestructura',
i.INF_Locacion AS 'Ubicación',
i.INF_Capacidad AS 'Capacidad'
FROM infraestructura i
JOIN infraestructura_bienestar ib ON i.INF_IdInfraestructura = ib.INF_IdInfraestructura
JOIN area a ON ib.ARE_IdArea = a.ARE_IdArea
WHERE a.ARE_IdArea IN (SELECT ARE_IdArea FROM area WHERE ARE_Nombre LIKE
'%Acompañamiento%')
GROUP BY i.INF_Nombre, i.INF_Locacion, i.INF_Capacidad, a.ARE_Nombre;


/*
9. Empleados que participaron en menos de 2 reuniones entre las fechas '2024-01-01' y
   '2024-05-25'.
*/
SELECT e.PER_DocumentoIdentidad AS 'Documento de identidad',
p.PER_Nombre AS 'Nombre',
p.PER_Apellido AS 'Apellido',
COUNT(a.REU_IdReunion) AS 'Reuniones asistidas'
FROM empleado e
JOIN persona p ON e.PER_DocumentoIdentidad = p.PER_DocumentoIdentidad
JOIN asistencia a ON e.PER_DocumentoIdentidad = a.PER_DocumentoIdentidad
JOIN reunion r ON a.REU_IdReunion = r.REU_IdReunion
WHERE r.REU_Fecha BETWEEN '2024-01-01' AND '2024-05-25'
GROUP BY e.PER_DocumentoIdentidad, p.PER_Nombre, p.PER_Apellido
HAVING COUNT(a.REU_IdReunion) < 2;


/*
10. Consulta de Horarios y Actividades en el Polideportivo para el 23 de marzo de 2024.
*/
SELECT horario.HOR_IdHorario AS Id_Horario,
horario.HOR_HoraInicio AS Hora_de_Inicio,
horario.HOR_HoraFinal AS Hora_de_finalizacion,
horario.HOR_Fecha AS Fecha,
CASE
WHEN curso.CUR_IdCurso IS NOT NULL THEN 'Curso'
WHEN evento.EVE_IdEvento IS NOT NULL THEN 'Evento'
WHEN proyecto_pgp.PRO_IdProyectoPGP IS NOT NULL THEN
'Proyecto'
ELSE 'N/A'
END AS Tipo_de_actividad
FROM horario
LEFT JOIN curso_horario ON horario.HOR_IdHorario =
curso_horario.HOR_IdHorario
LEFT JOIN curso ON curso_horario.CUR_IdCurso = curso.CUR_IdCurso
LEFT JOIN evento ON horario.HOR_IdHorario = evento.HOR_IdHorario
LEFT JOIN proyecto_pgp ON horario.HOR_IdHorario =
proyecto_pgp.HOR_IdHorario
INNER JOIN infraestructura ON horario.INF_IdInfraestructura =
infraestructura.INF_IdInfraestructura
WHERE infraestructura.INF_Nombre = 'Polideportivo'
AND horario.HOR_Fecha = '2024-03-23';