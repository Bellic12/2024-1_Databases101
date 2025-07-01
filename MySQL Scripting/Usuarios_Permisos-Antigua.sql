USE bienestar; 

-- ASIGNACIÓN DE PERMISOS USUARIO PersonaU -- 

CREATE USER 'PersonaU'@'localhost' IDENTIFIED BY 'Exotico1298$.';

-- Permisos tabla: Inscripcion -- 
GRANT INSERT ON inscripcion TO  'PersonaU'@'localhost'; 

-- Permisos tabla: convocatoria -- 
GRANT SELECT ON convocatoria TO  'PersonaU'@'localhost'; 

-- Permisos tabla: requisito -- 
GRANT SELECT ON requisito TO  'PersonaU'@'localhost'; 

-- Permisos tabla: beneficio -- 
GRANT SELECT ON beneficio TO  'PersonaU'@'localhost'; 

-- Permisos tabla: curso -- 
GRANT SELECT ON curso TO  'PersonaU'@'localhost'; 

-- Permisos tabla: proyecto_pgp -- 
GRANT SELECT ON proyecto_pgp TO  'PersonaU'@'localhost'; 

-- Permisos tabla: evento -- 
GRANT SELECT ON evento TO  'PersonaU'@'localhost'; 

-- Permisos tabla: area -- 
GRANT SELECT ON area TO  'PersonaU'@'localhost'; 

-- Permisos tabla: horario -- 
GRANT SELECT ON horario TO  'PersonaU'@'localhost'; 

-- Permisos tabla: oficina -- 
GRANT SELECT ON oficina TO  'PersonaU'@'localhost'; 

-- Permisos tabla: infraestructura_bienestar -- 
GRANT SELECT ON infraestructura_bienestar TO  'PersonaU'@'localhost'; 

-- Permisos tabla: infraestructura -- 
GRANT SELECT ON infraestructura TO  'PersonaU'@'localhost'; 

-- Permisos tabla: sede -- 
GRANT SELECT ON sede TO  'PersonaU'@'localhost'; 

-- Permisos PersonaU vista: Requisitos de las convocatorias -- 
GRANT SELECT ON requisitos_convocatoria TO 'PersonaU'@'localhost'; 

-- Permisos PersonaU vista: Empleados de bienestar e información -- 
GRANT SELECT ON empleado_persona TO 'PersonaU'@'localhost'; 

-- Permisos PersonaU vista: Horarios de los eventos a realizarce -- 
GRANT SELECT ON horarios_eventos TO 'PersonaU'@'localhost'; 

-- Permisos PersonaU vista: admitidos a proyectos-- 
GRANT SELECT ON admitidos_pgp TO 'PersonaU'@'localhost'; 

-- Permisos PersonaU vista: admitidos a cursos -- 
GRANT SELECT ON admitidos_cursos TO 'PersonaU'@'localhost'; 

-- Permisos PersonaU vista: admitidos a beneficios -- 
GRANT SELECT ON admitidos_ben TO 'PersonaU'@'localhost'; 

-- Permisos ejecutar:  nuevo inscripcion en curso -- 
GRANT EXECUTE ON PROCEDURE NewRegistrationCourse TO 'PersonaU'@'localhost'; 

-- Permisos ejecutar:  nuevo inscripcion en proyecto --
GRANT EXECUTE ON PROCEDURE NewRegistrationProject TO 'PersonaU'@'localhost'; 

-- Permisos ejecutar:  nuevo inscripcion en beneficio --
GRANT EXECUTE ON PROCEDURE NewRegistrationBenefit TO 'PersonaU'@'localhost'; 

-- Permisos ejecutar: obtener las inscripciones para un año --
GRANT EXECUTE ON PROCEDURE ObtenerInscripcionesPorCursoAnio TO 'PersonaU'@'localhost'; 

-- Permisos ejecutar: obtener los eventos en un año --
GRANT EXECUTE ON PROCEDURE EVENT_YEAR TO 'PersonaU'@'localhost';

-- Permisos ejecutar: cambiar los datos personales, que se pueden cambiar --
GRANT EXECUTE ON PROCEDURE UPDATE_GeneralData TO 'PersonaU'@'localhost'; 

-- Terminación permisos PersonaU -- 

-- ASIGNACIÓN DE PERMISOS USUARIO Jefes -- 

CREATE USER 'Jefes'@'localhost' IDENTIFIED BY 'Exotico1298$.';

-- Permisos tabla: Persona -- 
GRANT ALL ON persona TO  'Jefes'@'localhost'; 

-- Permisos tabla: Empleado -- 
GRANT ALL ON empleado TO  'Jefes'@'localhost'; 

-- Permisos tabla: Estudiante -- 
GRANT ALL ON estudiante TO  'Jefes'@'localhost'; 

-- Permisos tabla: Inscripcion -- 
GRANT ALL ON inscripcion TO  'Jefes'@'localhost'; 

-- Permisos tabla: convocatoria -- 
GRANT ALL ON convocatoria TO  'Jefes'@'localhost'; 

-- Permisos tabla: requisito -- 
GRANT ALL ON requisito TO  'Jefes'@'localhost'; 

-- Permisos tabla: beneficio -- 
GRANT ALL ON beneficio TO  'Jefes'@'localhost'; 

-- Permisos tabla: curso -- 
GRANT ALL ON curso TO  'Jefes'@'localhost'; 

-- Permisos tabla: proyecto_pgp -- 
GRANT ALL ON proyecto_pgp TO  'Jefes'@'localhost'; 

-- Permisos tabla: evento -- 
GRANT ALL ON evento TO  'Jefes'@'localhost'; 

-- Permisos tabla: area -- 
GRANT SELECT ON area TO  'Jefes'@'localhost'; 

-- Permisos tabla: horario -- 
GRANT ALL ON horario TO  'Jefes'@'localhost'; 

-- Permisos tabla: oficina -- 
GRANT SELECT, UPDATE ON oficina TO  'Jefes'@'localhost'; 

-- Permisos tabla: infraestructura_bienestar -- 
GRANT SELECT ON infraestructura_bienestar TO  'Jefes'@'localhost'; 

-- Permisos tabla: infraestructura -- 
GRANT ALL ON infraestructura TO  'Jefes'@'localhost'; 

-- Permisos tabla: sede -- 
GRANT SELECT ON sede TO  'Jefes'@'localhost'; 

-- Permisos tabla: reunion -- 
GRANT SELECT, INSERT ON reunion TO  'Jefes'@'localhost'; 

-- Permisos PersonaU vista: Requisitos de las convocatorias -- 
GRANT ALL ON requisitos_convocatoria TO 'Jefes'@'localhost'; 

-- Permisos PersonaU vista: Empleados de bienestar e información -- 
GRANT ALL ON empleado_persona TO 'Jefes'@'localhost'; 

-- Permisos PersonaU vista: Horarios de los eventos a realizarce -- 
GRANT ALL ON horarios_eventos TO 'Jefes'@'localhost'; 

-- Permisos PersonaU vista: admitidos a proyectos-- 
GRANT ALL ON admitidos_pgp TO 'Jefes'@'localhost'; 

-- Permisos PersonaU vista: admitidos a cursos -- 
GRANT ALL ON admitidos_cursos TO 'Jefes'@'localhost'; 

-- Permisos PersonaU vista: admitidos a beneficios -- 
GRANT ALL ON admitidos_ben TO 'Jefes'@'localhost'; 

-- Permisos PersonaU vista: número de cursos estudiantes que tiene un estudiante -- 
GRANT ALL ON NUM_CursosEstudiante TO 'Jefes'@'localhost'; 

-- Permisos PersonaU vista: empleados e info si su salario es mayor al promedio -- 
GRANT ALL ON vw_EMPAVgSalary TO 'Jefes'@'localhost'; 

-- Permisos ejecutar:  actualizar el estado de inscripcion -- 
GRANT EXECUTE ON PROCEDURE actualizarEstadoInscripcionPorNombre TO 'Jefes'@'localhost'; 

-- Permisos ejecutar:  nuevo fecha para evento --
GRANT EXECUTE ON PROCEDURE NewDateEvent TO 'Jefes'@'localhost'; 

-- Permisos ejecutar:  actualizar un horario --
GRANT EXECUTE ON PROCEDURE UpdateHorary TO 'Jefes'@'localhost'; 

-- Permisos ejecutar: actualizar información empleado (cargo y salario) --
GRANT EXECUTE ON PROCEDURE Info_empleado TO 'Jefes'@'localhost'; 

-- Permisos ejecutar : agregar requisitos a convocatoria--
GRANT EXECUTE ON PROCEDURE AgregarRequisitosAConvocatoria TO 'Jefes'@'localhost';

-- Permisos ejecutar : insertar asistencia a reuniones --
GRANT EXECUTE ON PROCEDURE insrt_asistenciaReuniones TO 'Jefes'@'localhost';

-- Permisos ejecutar : eliminar una inscripcion --
GRANT EXECUTE ON PROCEDURE EliminarInscripcion TO 'Jefes'@'localhost';

-- Permisos ejecutar : eliminar empleado--
GRANT EXECUTE ON PROCEDURE EliminarEmpleado TO 'Jefes'@'localhost';

-- Permisos ejecutar :  eliminar curso--
GRANT EXECUTE ON PROCEDURE DeleteCourse TO 'Jefes'@'localhost';

-- Permisos ejecutar : eliminar beneficio--
GRANT EXECUTE ON PROCEDURE del_beneficio TO 'Jefes'@'localhost';

-- Permisos ejecutar :eliminar proyecto --
GRANT EXECUTE ON PROCEDURE del_proyectopgp TO 'Jefes'@'localhost';

-- Permisos ejecutar : inscripciones de un curso en un año--
GRANT EXECUTE ON PROCEDURE ObtenerInscripcionesPorCursoAnio TO 'Jefes'@'localhost';

-- Permisos ejecutar : estudiantes de un profesor especifico --
GRANT EXECUTE ON PROCEDURE StudentsTeacher TO 'Jefes'@'localhost';

-- Permisos ejecutar : los eventos que se realizaron o realizaran en un año --
GRANT EXECUTE ON PROCEDURE EVENT_YEAR TO 'Jefes'@'localhost';

-- Permisos ejecutar : actualizar cierta info de personas--
GRANT EXECUTE ON PROCEDURE UPDATE_SpecificData TO 'Jefes'@'localhost';

-- PERMISOS USUARIO empleados -- 

CREATE USER 'Empleados'@'localhost' IDENTIFIED BY 'Exotico1298$.';

-- Permisos tabla: persona --
GRANT SELECT ON persona to  'Empleados'@'localhost';
GRANT UPDATE ON persona to  'Empleados'@'localhost';

-- Permisos tabla: empleado --
GRANT SELECT ON empleado to  'Empleados'@'localhost';

-- Permisos tabla: estudiante --
GRANT SELECT ON estudiante to  'Empleados'@'localhost';
GRANT UPDATE ON estudiante to  'Empleados'@'localhost';

-- Permisos tabla: inscripcion -- 
GRANT INSERT ON inscripcion TO  'Empleados'@'localhost'; 
GRANT UPDATE ON inscripcion to  'Empleados'@'localhost';

-- Permisos tabla: convocatoria -- 
GRANT SELECT ON convocatoria TO  'Empleados'@'localhost';
GRANT UPDATE ON convocatoria to  'Empleados'@'localhost'; 

-- Permisos tabla: requisito -- 
GRANT SELECT ON requisito TO  'Empleados'@'localhost'; 
GRANT UPDATE ON requisito to  'Empleados'@'localhost';

-- Permisos tabla: beneficio -- 
GRANT SELECT ON beneficio TO  'Empleados'@'localhost'; 

-- Permisos tabla: curso -- 
GRANT SELECT ON curso TO  'Empleados'@'localhost'; 
GRANT UPDATE ON curso to  'Empleados'@'localhost';

-- Permisos tabla: proyecto_pgp -- 
GRANT SELECT ON proyecto_pgp TO  'Empleados'@'localhost'; 
GRANT UPDATE ON proyecto_pgp to  'Empleados'@'localhost';
GRANT INSERT ON proyecto_pgp to  'Empleados'@'localhost';

-- Permisos tabla: evento -- 
GRANT SELECT ON evento TO  'Empleados'@'localhost'; 

-- Permisos tabla: area -- 
GRANT SELECT ON area TO  'Empleados'@'localhost'; 

-- Permisos tabla: horario -- 
GRANT SELECT ON horario TO  'Empleados'@'localhost'; 
GRANT UPDATE ON horario to  'Empleados'@'localhost';
GRANT INSERT ON horario to  'Empleados'@'localhost';

-- Permisos tabla: oficina -- 
GRANT SELECT ON oficina TO  'Empleados'@'localhost'; 
GRANT UPDATE ON oficina to  'Empleados'@'localhost';

-- Permisos tabla: infraestructura_bienestar -- 
GRANT SELECT ON infraestructura_bienestar TO  'Empleados'@'localhost'; 

-- Permisos tabla: infraestructura -- 
GRANT SELECT ON infraestructura TO  'Empleados'@'localhost'; 

-- Permisos tabla: sede -- 
GRANT SELECT ON sede TO  'Empleados'@'localhost'; 

-- Permisos PersonaU vista: Requisitos de las convocatorias -- 
GRANT ALL PRIVILEGES ON requisitos_convocatoria TO 'Empleados'@'localhost'; 

-- Permisos PersonaU vista: Empleados de bienestar e información -- 
GRANT SELECT ON empleado_persona TO 'Empleados'@'localhost'; 

-- Permisos PersonaU vista: Horarios de los eventos a realizarce -- 
GRANT SELECT ON horarios_eventos TO 'Empleados'@'localhost'; 
GRANT UPDATE ON horarios_eventos to  'Empleados'@'localhost';

-- Permisos PersonaU vista: admitidos a proyectos-- 
GRANT SELECT ON admitidos_pgp TO 'Empleados'@'localhost';
GRANT UPDATE ON admitidos_pgp to  'Empleados'@'localhost';
GRANT INSERT ON admitidos_pgp to  'Empleados'@'localhost';

-- Permisos PersonaU vista: admitidos a cursos -- 
GRANT SELECT ON admitidos_cursos TO 'Empleados'@'localhost';
GRANT UPDATE ON admitidos_cursos to  'Empleados'@'localhost';
GRANT INSERT ON admitidos_cursos to  'Empleados'@'localhost'; 

-- Permisos PersonaU vista: admitidos a beneficios -- 
GRANT SELECT ON admitidos_ben TO 'Empleados'@'localhost'; 
GRANT UPDATE ON admitidos_ben to  'Empleados'@'localhost';
GRANT INSERT ON admitidos_ben to  'Empleados'@'localhost';

-- Permisos PersonaU vista: numero de cursos inscritos por estudiante -- 
GRANT SELECT ON NUM_CursosEstudiante TO 'Empleados'@'localhost'; 
GRANT UPDATE ON NUM_CursosEstudiante to  'Empleados'@'localhost';
GRANT INSERT ON NUM_CursosEstudiante to  'Empleados'@'localhost';

-- Permisos ejecutar:  actualización estado inscripción -- 
GRANT EXECUTE ON PROCEDURE actualizarEstadoInscripcionPorNombre TO 'Empleados'@'localhost'; 

-- Permisos ejecutar:  actualización horario -- 
GRANT EXECUTE ON PROCEDURE UpdateHorary TO 'Empleados'@'localhost'; 

-- Permisos ejecutar:  eliminar una inscripción -- 
GRANT EXECUTE ON PROCEDURE EliminarInscripcion TO 'Empleados'@'localhost'; 

-- Permisos ejecutar:  eliminar curso --
GRANT EXECUTE ON PROCEDURE DeleteCourse TO 'Empleados'@'localhost'; 

-- Permisos ejecutar:  eliminar beneficio --
GRANT EXECUTE ON PROCEDURE del_beneficio TO 'Empleados'@'localhost'; 

-- Permisos ejecutar:  eliminar proyecto_pgp --
GRANT EXECUTE ON PROCEDURE del_proyectopgp TO 'Empleados'@'localhost'; 

-- Permisos ejecutar: obtener las inscripciones para un año --
GRANT EXECUTE ON PROCEDURE ObtenerInscripcionesPorCursoAnio TO 'Empleados'@'localhost'; 

-- Permisos ejecutar: estudiantes por profesor --
GRANT EXECUTE ON PROCEDURE StudentsTeacher TO 'Empleados'@'localhost';

-- Permisos ejecutar: obtener los eventos en un año --
GRANT EXECUTE ON PROCEDURE EVENT_YEAR TO 'Empleados'@'localhost';