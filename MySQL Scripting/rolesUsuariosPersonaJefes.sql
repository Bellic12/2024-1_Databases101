USE bienestar; 

-- ASIGNACIÓN DE PERMISOS ROL PersonaU -- 
CREATE ROLE 'PersonaU'; 

-- Permisos tabla: Inscripcion -- 
GRANT INSERT ON bienestar.inscripcion TO  'PersonaU'; 

-- Permisos tabla: convocatoria -- 
GRANT SELECT ON bienestar.convocatoria TO  'PersonaU'; 

-- Permisos tabla: requisito -- 
GRANT SELECT ON requisito TO  'PersonaU'; 

-- Permisos tabla: beneficio -- 
GRANT SELECT ON beneficio TO  'PersonaU'; 

-- Permisos tabla: curso -- 
GRANT SELECT ON curso TO  'PersonaU'; 

-- Permisos tabla: proyecto_pgp -- 
GRANT SELECT ON proyecto_pgp TO  'PersonaU'; 

-- Permisos tabla: evento -- 
GRANT SELECT ON evento TO  'PersonaU'; 

-- Permisos tabla: area -- 
GRANT SELECT ON area TO  'PersonaU'; 

-- Permisos tabla: horario -- 
GRANT SELECT ON horario TO  'PersonaU'; 

-- Permisos tabla: oficina -- 
GRANT SELECT ON oficina TO  'PersonaU'; 

-- Permisos tabla: infraestructura_bienestar -- 
GRANT SELECT ON infraestructura_bienestar TO  'PersonaU'; 

-- Permisos tabla: infraestructura -- 
GRANT SELECT ON infraestructura TO  'PersonaU'; 

-- Permisos tabla: sede -- 
GRANT SELECT ON sede TO  'PersonaU'; 

-- Permisos PersonaU vista: Requisitos de las convocatorias -- 
GRANT SELECT ON requisitos_convocatoria TO 'PersonaU'; 

-- Permisos PersonaU vista: Empleados de bienestar e información -- 
GRANT SELECT ON empleado_persona TO 'PersonaU'; 

-- Permisos PersonaU vista: Horarios de los eventos a realizarce -- 
GRANT SELECT ON horarios_eventos TO 'PersonaU'; 

-- Permisos PersonaU vista: admitidos a proyectos-- 
GRANT SELECT ON admitidos_pgp TO 'PersonaU'; 

-- Permisos PersonaU vista: admitidos a cursos -- 
GRANT SELECT ON admitidos_cursos TO 'PersonaU'; 

-- Permisos PersonaU vista: admitidos a beneficios -- 
GRANT SELECT ON admitidos_ben TO 'PersonaU'; 

-- Permisos ejecutar:  nuevo inscripcion en curso -- 
GRANT EXECUTE ON PROCEDURE NewRegistrationCourse TO 'PersonaU'; 

-- Permisos ejecutar:  nuevo inscripcion en proyecto --
GRANT EXECUTE ON PROCEDURE NewRegistrationProject TO 'PersonaU'; 

-- Permisos ejecutar:  nuevo inscripcion en beneficio --
GRANT EXECUTE ON PROCEDURE NewRegistrationBenefit TO 'PersonaU'; 

-- Permisos ejecutar: obtener las inscripciones para un año --
GRANT EXECUTE ON PROCEDURE ObtenerInscripcionesPorCursoAnio TO 'PersonaU'; 

-- Permisos ejecutar: obtener los eventos en un año --
GRANT EXECUTE ON PROCEDURE EVENT_YEAR TO 'PersonaU';

-- Permisos ejecutar: cambiar los datos personales, que se pueden cambiar --
GRANT EXECUTE ON PROCEDURE UPDATE_GeneralData TO 'PersonaU'; 

-- Terminación permisos rol PersonaU -- 

-- ASIGNACIÓN DE PERMISOS ROL Jefes -- 

CREATE ROLE 'Jefes';

-- Permisos tabla: Persona -- 
GRANT ALL ON persona TO  'Jefes'; 

-- Permisos tabla: Empleado -- 
GRANT ALL ON empleado TO  'Jefes'; 

-- Permisos tabla: Estudiante -- 
GRANT ALL ON estudiante TO  'Jefes'; 

-- Permisos tabla: Inscripcion -- 
GRANT ALL ON inscripcion TO  'Jefes'; 

-- Permisos tabla: convocatoria -- 
GRANT ALL ON convocatoria TO  'Jefes'; 

-- Permisos tabla: requisito -- 
GRANT ALL ON requisito TO  'Jefes'; 

-- Permisos tabla: beneficio -- 
GRANT ALL ON beneficio TO  'Jefes'; 

-- Permisos tabla: curso -- 
GRANT ALL ON curso TO  'Jefes'; 

-- Permisos tabla: proyecto_pgp -- 
GRANT ALL ON proyecto_pgp TO  'Jefes'; 

-- Permisos tabla: evento -- 
GRANT ALL ON evento TO  'Jefes'; 

-- Permisos tabla: area -- 
GRANT SELECT ON area TO  'Jefes'; 

-- Permisos tabla: horario -- 
GRANT ALL ON horario TO  'Jefes'; 

-- Permisos tabla: oficina -- 
GRANT SELECT, UPDATE ON oficina TO  'Jefes'; 

-- Permisos tabla: infraestructura_bienestar -- 
GRANT SELECT ON infraestructura_bienestar TO  'Jefes'; 

-- Permisos tabla: infraestructura -- 
GRANT ALL ON infraestructura TO  'Jefes'; 

-- Permisos tabla: sede -- 
GRANT SELECT ON sede TO  'Jefes'; 

-- Permisos tabla: reunion -- 
GRANT SELECT, INSERT ON reunion TO  'Jefes'; 

-- Permisos PersonaU vista: Requisitos de las convocatorias -- 
GRANT ALL ON requisitos_convocatoria TO 'Jefes'; 

-- Permisos PersonaU vista: Empleados de bienestar e información -- 
GRANT ALL ON empleado_persona TO 'Jefes'; 

-- Permisos PersonaU vista: Horarios de los eventos a realizarce -- 
GRANT ALL ON horarios_eventos TO 'Jefes'; 

-- Permisos PersonaU vista: admitidos a proyectos-- 
GRANT ALL ON admitidos_pgp TO 'Jefes'; 

-- Permisos PersonaU vista: admitidos a cursos -- 
GRANT ALL ON admitidos_cursos TO 'Jefes'; 

-- Permisos PersonaU vista: admitidos a beneficios -- 
GRANT ALL ON admitidos_ben TO 'Jefes'; 

-- Permisos PersonaU vista: número de cursos estudiantes que tiene un estudiante -- 
GRANT ALL ON NUM_CursosEstudiante TO 'Jefes'; 

-- Permisos PersonaU vista: empleados e info si su salario es mayor al promedio -- 
GRANT ALL ON vw_EMPAVgSalary TO 'Jefes'; 

-- Permisos ejecutar:  actualizar el estado de inscripcion -- 
GRANT EXECUTE ON PROCEDURE actualizarEstadoInscripcionPorNombre TO 'Jefes'; 

-- Permisos ejecutar:  nuevo fecha para evento --
GRANT EXECUTE ON PROCEDURE NewDateEvent TO 'Jefes'; 

-- Permisos ejecutar:  actualizar un horario --
GRANT EXECUTE ON PROCEDURE UpdateHorary TO 'Jefes'; 

-- Permisos ejecutar: actualizar información empleado (cargo y salario) --
GRANT EXECUTE ON PROCEDURE Info_empleado TO 'Jefes'; 

-- Permisos ejecutar : agregar requisitos a convocatoria--
GRANT EXECUTE ON PROCEDURE AgregarRequisitosAConvocatoria TO 'Jefes';

-- Permisos ejecutar : insertar asistencia a reuniones --
GRANT EXECUTE ON PROCEDURE insrt_asistenciaReuniones TO 'Jefes';

-- Permisos ejecutar : eliminar una inscripcion --
GRANT EXECUTE ON PROCEDURE EliminarInscripcion TO 'Jefes';

-- Permisos ejecutar : eliminar empleado--
GRANT EXECUTE ON PROCEDURE EliminarEmpleado TO 'Jefes';

-- Permisos ejecutar :  eliminar curso--
GRANT EXECUTE ON PROCEDURE DeleteCourse TO 'Jefes';

-- Permisos ejecutar : eliminar beneficio--
GRANT EXECUTE ON PROCEDURE del_beneficio TO 'Jefes';

-- Permisos ejecutar :eliminar proyecto --
GRANT EXECUTE ON PROCEDURE del_proyectopgp TO 'Jefes';

-- Permisos ejecutar : inscripciones de un curso en un año--
GRANT EXECUTE ON PROCEDURE ObtenerInscripcionesPorCursoAnio TO 'Jefes';

-- Permisos ejecutar : estudiantes de un profesor especifico --
GRANT EXECUTE ON PROCEDURE StudentsTeacher TO 'Jefes';

-- Permisos ejecutar : los eventos que se realizaron o realizaran en un año --
GRANT EXECUTE ON PROCEDURE EVENT_YEAR TO 'Jefes';

-- Permisos ejecutar : actualizar cierta info de personas--
GRANT EXECUTE ON PROCEDURE UPDATE_SpecificData TO 'Jefes';

-- PERMISOS ROL empleados -- 

CREATE ROLE 'Empleados'; 

-- Permisos tabla: persona --
GRANT SELECT ON persona to  'Empleados';
GRANT UPDATE ON persona to  'Empleados';

-- Permisos tabla: empleado --
GRANT SELECT ON empleado to  'Empleados';

-- Permisos tabla: estudiante --
GRANT SELECT ON estudiante to  'Empleados';
GRANT UPDATE ON estudiante to  'Empleados';

-- Permisos tabla: inscripcion -- 
GRANT INSERT ON inscripcion TO  'Empleados'; 
GRANT UPDATE ON inscripcion to  'Empleados';

-- Permisos tabla: convocatoria -- 
GRANT SELECT ON convocatoria TO  'Empleados';
GRANT UPDATE ON convocatoria to  'Empleados'; 

-- Permisos tabla: requisito -- 
GRANT SELECT ON requisito TO  'Empleados'; 
GRANT UPDATE ON requisito to  'Empleados';

-- Permisos tabla: beneficio -- 
GRANT SELECT ON beneficio TO  'Empleados'; 

-- Permisos tabla: curso -- 
GRANT SELECT ON curso TO  'Empleados'; 
GRANT UPDATE ON curso to  'Empleados';

-- Permisos tabla: proyecto_pgp -- 
GRANT SELECT ON proyecto_pgp TO  'Empleados'; 
GRANT UPDATE ON proyecto_pgp to  'Empleados';
GRANT INSERT ON proyecto_pgp to  'Empleados';

-- Permisos tabla: evento -- 
GRANT SELECT ON evento TO  'Empleados'; 

-- Permisos tabla: area -- 
GRANT SELECT ON area TO  'Empleados'; 

-- Permisos tabla: horario -- 
GRANT SELECT ON horario TO  'Empleados'; 
GRANT UPDATE ON horario to  'Empleados';
GRANT INSERT ON horario to  'Empleados';

-- Permisos tabla: oficina -- 
GRANT SELECT ON oficina TO  'Empleados'; 
GRANT UPDATE ON oficina to  'Empleados';

-- Permisos tabla: infraestructura_bienestar -- 
GRANT SELECT ON infraestructura_bienestar TO  'Empleados'; 

-- Permisos tabla: infraestructura -- 
GRANT SELECT ON infraestructura TO  'Empleados'; 

-- Permisos tabla: sede -- 
GRANT SELECT ON sede TO  'Empleados'; 

-- Permisos PersonaU vista: Requisitos de las convocatorias -- 
GRANT ALL PRIVILEGES ON requisitos_convocatoria TO 'Empleados'; 

-- Permisos PersonaU vista: Empleados de bienestar e información -- 
GRANT SELECT ON empleado_persona TO 'Empleados'; 

-- Permisos PersonaU vista: Horarios de los eventos a realizarce -- 
GRANT SELECT ON horarios_eventos TO 'Empleados'; 
GRANT UPDATE ON horarios_eventos to  'Empleados';

-- Permisos PersonaU vista: admitidos a proyectos-- 
GRANT SELECT ON admitidos_pgp TO 'Empleados';
GRANT UPDATE ON admitidos_pgp to  'Empleados';
GRANT INSERT ON admitidos_pgp to  'Empleados';

-- Permisos PersonaU vista: admitidos a cursos -- 
GRANT SELECT ON admitidos_cursos TO 'Empleados';
GRANT UPDATE ON admitidos_cursos to  'Empleados';
GRANT INSERT ON admitidos_cursos to  'Empleados'; 

-- Permisos PersonaU vista: admitidos a beneficios -- 
GRANT SELECT ON admitidos_ben TO 'Empleados'; 
GRANT UPDATE ON admitidos_ben to  'Empleados';
GRANT INSERT ON admitidos_ben to  'Empleados';

-- Permisos PersonaU vista: numero de cursos inscritos por estudiante -- 
GRANT SELECT ON NUM_CursosEstudiante TO 'Empleados'; 
GRANT UPDATE ON NUM_CursosEstudiante to  'Empleados';
GRANT INSERT ON NUM_CursosEstudiante to  'Empleados';

-- Permisos ejecutar:  actualización estado inscripción -- 
GRANT EXECUTE ON PROCEDURE actualizarEstadoInscripcionPorNombre TO 'Empleados'; 

-- Permisos ejecutar:  actualización horario -- 
GRANT EXECUTE ON PROCEDURE UpdateHorary TO 'Empleados'; 

-- Permisos ejecutar:  eliminar una inscripción -- 
GRANT EXECUTE ON PROCEDURE EliminarInscripcion TO 'Empleados'; 

-- Permisos ejecutar:  eliminar curso --
GRANT EXECUTE ON PROCEDURE DeleteCourse TO 'Empleados'; 

-- Permisos ejecutar:  eliminar beneficio --
GRANT EXECUTE ON PROCEDURE del_beneficio TO 'Empleados'; 

-- Permisos ejecutar:  eliminar proyecto_pgp --
GRANT EXECUTE ON PROCEDURE del_proyectopgp TO 'Empleados'; 

-- Permisos ejecutar: obtener las inscripciones para un año --
GRANT EXECUTE ON PROCEDURE ObtenerInscripcionesPorCursoAnio TO 'Empleados'; 

-- Permisos ejecutar: estudiantes por profesor --
GRANT EXECUTE ON PROCEDURE StudentsTeacher TO 'Empleados';

-- Permisos ejecutar: obtener los eventos en un año --
GRANT EXECUTE ON PROCEDURE EVENT_YEAR TO 'Empleados';