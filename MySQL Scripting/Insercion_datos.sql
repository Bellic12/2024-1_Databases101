-- Habilita la opción local_infile para permitir la carga de archivos locales en MySQL
SET GLOBAL local_infile = true;

USE bienestar; 

LOAD DATA LOCAL INFILE '/home/bellic12/Documentos/Proyecto/ARCHIVOS EXCEL/persona.csv' 
INTO TABLE persona 
CHARACTER SET utf8mb4 
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n' 
IGNORE 1 LINES ;


LOAD DATA LOCAL INFILE '/home/bellic12/Documentos/Proyecto/ARCHIVOS EXCEL/estudiante.csv' 
INTO TABLE estudiante
CHARACTER SET utf8mb4 
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n' 
IGNORE 1 LINES ;

insert into area  (ARE_Nombre, ARE_Descripcion, ARE_CorreoElectronico, ARE_Telefono) values 
('Área de Gestión y Fomento Socioeconómico','Mejoramiento del aspecto socioeconómico del cuerpo estudiantil.' , 'agfse_bog@unal.edu.co' ,316500010655),
('Área de Acompañamiento Integral','Seguimiento de problemáticas individuales y colectivas.' ,'aaintegral@unal.edu.co',316500017171),
('Área de Salud','Importancia de la calidad de vida y hábitos saludables.','areasalud_bog@unal.edu.co',316500021061),
('Área de Cultura','Expresión y fortalecimiento de habilidades físicas y estéticas.','culturabien_bog@unal.edu.co',316500017248),
('Área de Actividad física y Deporte','Recreación y uso sano del tiempo libre por medio de la actividad física.','deportes_bog@unal.edu.co',316500017214);

insert into convocatoria(CON_IdConvocatoria,CON_FechaInicio,CON_FechaFin,CON_Tipo) values
(2001,'2024-01-31','2024-02-28','C'),
(2002,'2024-01-31','2024-02-28','C'),
(2003,'2024-02-02','2024-02-28','C'),
(2004,'2024-01-31','2024-02-28','C'),
(2005,'2024-02-02','2024-02-28','C'),
(2006,'2024-01-31','2024-02-28','C'),
(2007,'2024-01-31','2024-02-28','C'),
(2008,'2024-01-31','2024-02-28','C'),
(2010,'2024-01-31', '2024-02-28','C' ),
(2009,'2024-01-31','2024-02-28','C'),
(2011,'2024-01-31','2024-02-28','B'),
(2012,'2024-02-02','2024-02-28','B'),
(2013,'2024-01-31','2024-02-28','B'),
(2014,'2024-01-31','2024-02-28','B'),
(2015,'2024-01-31','2024-02-28','B'),
(2016,'2024-01-31','2024-02-28','B'),
(2017,'2024-02-02','2024-02-28','B'),
(2018,'2024-01-31','2024-02-28','B'),
(2019,'2024-01-31','2024-02-28','B'),
(2020,'2024-01-31','2024-02-28','B'),
(2021,'2024-02-02','2024-02-28','P'),
(2022,'2024-01-31','2024-02-28','P'),
(2023,'2024-02-02','2024-02-28','P'),
(2024,'2024-01-31','2024-02-28','P'),
(2025,'2024-01-31','2024-02-28','P'),
(2026,'2024-02-02','2024-02-28','P'),
(2027,'2024-01-31','2024-02-28','P'),
(2028,'2024-01-31','2024-02-28','P'),
(2029,'2024-02-02','2024-02-28','P'),
(2030,'2024-01-31','2024-02-28','P'),
(2031,'2024-01-31','2024-02-28','C');


insert into sede(SED_Nombre, SED_Ciudad) values
('Sede Bogotá','Bogotá'),
('Sede Medellín', 'Medellín'),
('Sede Manizales', 'Manizales'),
('Sede Amazonía', 'Leticia'),
('Sede Caribe', 'San Andrés Isla'),
('Sede De la Paz', 'La Paz'),
('Sede Orinoquía', 'Arauca'),
('Sede Palmira', 'Palmira'),
('Sede Tumaco', 'San Andrés de Tumaco');


INSERT INTO inscripcion(PER_DocumentoIdentidad, CON_IdConvocatoria, INS_Estado, INS_Fecha) VALUES
(1001, 2001, 'A', '2024-02-19'),
(1002, 2002, 'P', '2024-02-04'),
(1003, 2003, 'R', '2024-02-28'),
(1004, 2004, 'R', '2024-02-16'),
(1005, 2005, 'P', '2024-02-09'),
(1006, 2006, 'R', '2024-02-18'),
(1007, 2007, 'A', '2024-02-23'),
(1008, 2008, 'A', '2024-02-07'),
(1009, 2009, 'P', '2024-02-12'),
(1010, 2010, 'A', '2024-02-22'),
(1011, 2011, 'A', '2024-02-02'),
(1012, 2012, 'R', '2024-02-19'),
(1013, 2013, 'A', '2024-02-02'),
(1014, 2001, 'R', '2024-02-10'),
(1015, 2002, 'P', '2024-01-31'),
(1016, 2003, 'A', '2024-02-03'),
(1017, 2004, 'P', '2024-02-28'),
(1018, 2005, 'A', '2024-02-10'),
(1019, 2011, 'P', '2024-02-02'),
(1020, 2012, 'R', '2024-02-10'),
(1021, 2013, 'A', '2024-02-07'),
(1022, 2014, 'R', '2024-02-12'),
(1023, 2015, 'P', '2024-02-11'),
(1024, 2016, 'A', '2024-02-28'),
(1025, 2017, 'P', '2024-02-13'),
(1026, 2018, 'A', '2024-02-18'),
(1027, 2019, 'R', '2024-02-17'),
(1028, 2020, 'A', '2024-02-22'),
(1029, 2021, 'A', '2024-02-19'),
(1030, 2022, 'R', '2024-02-19'),
(1031, 2023, 'P', '2024-02-04'),
(1032, 2024, 'A', '2024-02-08'),
(1033, 2025, 'P', '2024-02-12'),
(1034, 2026, 'A', '2024-02-07'),
(1035, 2027, 'P', '2024-02-27'),
(1036, 2028, 'R', '2024-02-12'),
(1037, 2029, 'A', '2024-02-25'),
(1038, 2030, 'R', '2024-02-11'),
(1039, 2031, 'P', '2024-02-02');

insert into requisito(REQ_Descripcion, REQ_Tipo) values
('Tener P.A.P.A mayor o igual a 3.0', 'Requisito general'),
('Acreditar calidad de estudiante activo de la Universidad Nacional.', 'Requisito general'),
('No tener antecedentes médicos que impidan la realización de actividad física con frecuencia', 'Participación Área de Actividad física y Deporte'),
('Reunir tres o más estudiantes pertenecientes a una o varias facultades.', 'Programa de Gestión de proyectos'),
('Inscribir o actualizar su información en la Dirección de Bienestar de Facultad, de acuerdo con el cronograma definido en la convocatoria en cada período académico.', 'Programa de Gestión de proyectos'),
('Presentar ante el Director de Bienestar de la facultad el proyecto de actividades a desarrollar por el grupo.', 'Programa de Gestión de proyectos'),
('Para los talleres, ser estudiante activo de pregrado de 6 a 9 semestre.','Programa de Gestión de proyectos'),
('Para apoyo económico, asistir al 100% de los talleres.','Programa de Gestión de proyectos'),
('Presentar el proyecto elaborado durante el proceso en las fechas establecidas.','Programa de Gestión de proyectos'),
('No haber cancelado el periodo académico en el que solicita apoyo.', 'Beneficios Área de Gestión y Fomento socioeconómico'),
('No recibir apoyos económicos con recursos de la Universidad o con recursos externos obtenidos a través de donaciones, patrocinios o de convenios con entidades externas cuyo promedio mensual, por semestre, sean iguales o superiores a un (1) salario mínimo mensual legal vigente.', 'Beneficios Área de Gestión y Fomento socioeconómico'),
('No ser beneficiario de más de dos (2) apoyos socioeconómicos.', 'Beneficios Área de Gestión y Fomento socioeconómico'),
('Inscribirse a la convocatoria pública realizada por la Dirección de Bienestar Universitario de Sede o de Facultad o quien haga sus veces.', 'Beneficios Área de Gestión y Fomento socioeconómico' );

insert into convocatoria_requisito(CON_IdConvocatoria, REQ_IdRequisito) values
(2001,1),
(2001,2),
(2001,3),
(2002,1),
(2002,2),
(2002,3),
(2003,1),
(2003,2),
(2003,3),
(2004,1),
(2004,2),
(2004,3),
(2005,1),
(2005,2),
(2005,3),
(2006,1),
(2006,2),
(2006,3),
(2007,1),
(2007,2),
(2007,3),
(2008,1),
(2008,2),
(2008,3),
(2009,1),
(2009,2),
(2009,3),
(2010,1),
(2010,2),
(2010,3),
(2011,11),
(2011,12),
(2011,13),
(2012,11),
(2012,12),
(2012,13),
(2012,10),
(2013,10),
(2013,11),
(2013,12),
(2013,13),
(2014,10),
(2014,11),
(2014,12),
(2014,13),
(2015,10),
(2015,11),
(2015,12),
(2015,13),
(2016,10),
(2016,11),
(2016,12),
(2016,13),
(2011,10),
(2017,11),
(2018,12),
(2018,13),
(2019,10),
(2019,11),
(2019,12),
(2020,13),
(2020,10),
(2020,11),
(2020,12),
(2021,4),
(2021,5),
(2021,6),
(2021,7),
(2021,8),
(2021,9),
(2022,4),
(2022,5),
(2022,6),
(2022,7),
(2022,8),
(2022,9),
(2023,4),
(2023,5),
(2023,6),
(2023,7),
(2023,8),
(2023,9),
(2024,4),
(2024,5),
(2024,6),
(2024,7),
(2024,8),
(2024,9),
(2025,4),
(2025,5),
(2025,6),
(2025,7),
(2025,8),
(2025,9),
(2026,4),
(2026,5),
(2026,6),
(2026,7),
(2026,8),
(2026,9),
(2027,4),
(2027,5),
(2027,6),
(2027,7),
(2027,8),
(2027,9),
(2028,4),
(2028,5),
(2028,6),
(2029,7),
(2029,8),
(2029,9),
(2030,4),
(2030,5),
(2030,6),
(2030,7),
(2030,8),
(2030,9);

insert into infraestructura(INF_IdInfraestructura, SED_IdSede , INF_Nombre , INF_Locacion, INF_Capacidad )  values 
(1, 1,'Polideportivo','Cerca a la Biblioteca Central',NULL),
(2, 1,'Cancha de Fútbol','Detrás del edificio CyT y cerca del Estadio',20),
(3, 1,'Cancha de Tenis', 'Cerca del Estadio',5),
(4, 1,'Concha acústica', 'En frente del Estadio',100),
(5, 1,'Estadio Alfonso López', 'Por la ruta hacia la hemeroteca',NULL),
(6, 1,'Biblioteca Central Gabriel García Márquez', 'En la plaza Ché',NULL),
(7, 1,'Hemeroteca','Por la salida de la Carrera 45',NULL),
(8, 1,'Capilla','Cerca de la salida por la Carrera 30 o Avenida NQS', 300),
(9, 1,'Edificio Ciencia y Tecnología(CyT)', 'En la Facultad de Ingeniería',NULL),
(10, 1,'León de Greiff', 'En frente de la Biblioteca Central',NULL),
(11, 1, 'Gimnasio', 'Dentro del Estadio Alfonso López', 50),
(12, 1, 'Instituto Geográfico Agustín Codazzi', 'Extremo conincidiente con Avenida NQS', 150),
(13, 1, 'Tienda Universitaria', 'Cerca a la plaza Ché o plaza central, en el búnker', 60),
(14, 1, 'Observatorio Astronómico', 'Cerca los Labs de Ingeniería con acceso al Anillo vial', 80),
(15, 1, 'Yu Takeuchi', 'En frente del edificio Julio Garavito', 50),
(16, 1, 'Colegio IPARM', 'Costado Oeste de la Universidad', 100),
(17, 1, 'Laboratorio de Química', 'Edificio 412 departamento Ing. Química y Ambiental', 60),
(18, 1, 'ICA', 'Costado Sur de la Universidad. Frontera Avenida El Dorado', 150),
(19, 1, 'Salas de Estudio GEA', 'Al frente del polideportivo', 120),
(20, 1, 'Áreas Verdes(La Playita)', 'Detrás del Edificio insignia de Ingeniería Julio Garavito', 200),
(21, 1,'Plaza central o plaza Ché', 'frente al Auditorio León de Greiff y la Biblioteca Central',500),
(22, 1,'Rogelio Salmona','Edificio 225 - Posgrados de la Facultad de Ciencias Humanas. Sobre el anillo vial exterior',200),
(23, 1, 'Oficina de Orientación Psicológica', 'Edificio Ciencia y Tecnología(CyT)', 10),
(24, 1, 'Oficina de Orientación Académica', 'Biblioteca Central Gabriel García Márquez', 15),
(25, 1, 'Oficina de Servicio Social', 'Hemeroteca', 12),
(26, 1, 'Oficina de Actividades Culturales', 'Concha acústica', 8),
(27, 1, 'Oficina de Deporte Universitario', 'Gimnasio', 10),
(28, 1, 'Oficina de Promoción de la Salud', 'Áreas Verdes(La Playita)', 8),
(29, 1, 'Oficina de Bienestar Estudiantil', 'Plaza central o plaza Ché', 20),
(30, 1, 'Oficina de Apoyo Socioeconómico', 'Observatorio Astronómico', 10),
(31, 1, 'Oficina de Asuntos Internacionales', 'León de Greiff', 15),
(32, 1, 'Oficina de Inclusión y Diversidad', 'Edificio Ciencia y Tecnología(CyT)', 12),
(33, 1, 'Oficina de Desarrollo Profesional', 'Tienda Universitaria', 10),
(34, 1, 'Oficina de Relaciones Estudiantiles', 'Colegio IPARM', 8),
(35, 1, 'Oficina de Desarrollo Sostenible', 'ICA', 12),
(36, 1, 'Oficina de Arte y Cultura', 'Yu Takeuchi', 10),
(37, 1, 'Oficina de Innovación Educativa', 'Instituto Geográfico Agustín Codazzi', 15),
(38, 1, 'Oficina de Tecnologías Educativas', 'Laboratorio de Química', 10),
(39, 1, 'Oficina de Investigación Estudiantil', 'Polideportivo', 8),
(40, 1, 'Oficina de Emprendimiento', 'Cancha de Tenis', 12),
(41, 1, 'Oficina de Vida Estudiantil', 'Salas de Estudio GEA', 10),
(42, 1, 'Oficina de Activismo Estudiantil', 'Estadio Alfonso López', 8);



insert into infraestructura_bienestar(INF_IdInfraestructura,INFBI_Ocupacion, ARE_IdArea)values
(2,'Desarrollo de actividades deportivas',5),
(1,'Edificio principal de bienestar del Área de actividad física y deporte',5),
(3,'En uso para la práctica de tenis de campo (curso libre y selección).',5),
(4,'Implementado para llevar a cabo las activdades artísticas y deportivas.',4),
(5,'Lugar principal para la práctica deportiva',5),
(10,'Destinado para actividades artíticas, eventos musicales.',4),
(13,'Venta de productos universitarios',2),
(21,'Realización de actividades culturales',4),
(23, 'Atención psicológica y emocional a estudiantes', 1),
(24, 'Asesoramiento académico y seguimiento estudiantil', 1),
(25, 'Apoyo y coordinación de programas de servicio social', 1),
(26, 'Organización y gestión de eventos culturales', 4),
(27, 'Coordinación y promoción de actividades deportivas', 5),
(28, 'Promoción de hábitos saludables y prevención de enfermedades', 3),
(29, 'Gestión y atención integral a estudiantes', 2),
(30, 'Apoyo socioeconómico y gestión de becas', 1),
(31, 'Fomento de la interculturalidad y atención a la diversidad', 2),
(32, 'Desarrollo de competencias profesionales y orientación laboral', 1),
(33, 'Gestión y apoyo a las relaciones estudiantiles', 2),
(34, 'Promoción de prácticas sostenibles y cuidado del medio ambiente', 3),
(35, 'Fomento y difusión de expresiones artísticas y culturales', 4),
(36, 'Innovación en métodos de enseñanza y aprendizaje', 1),
(37, 'Integración de tecnología en procesos educativos', 1),
(38, 'Estímulo y apoyo a la investigación estudiantil', 2),
(39, 'Promoción del espíritu emprendedor y desarrollo de proyectos', 1),
(40, 'Promoción de un ambiente de bienestar y calidad de vida', 2),
(41, 'Participación y representación estudiantil en la vida universitaria', 2);

LOAD DATA LOCAL INFILE '/home/bellic12/Documentos/Proyecto/ARCHIVOS EXCEL/oficina.csv' 
INTO TABLE oficina
CHARACTER SET utf8mb4 
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n' 
IGNORE 1 LINES ;


LOAD DATA LOCAL INFILE '/home/bellic12/Documentos/Proyecto/ARCHIVOS EXCEL/empleado.csv' 
INTO TABLE empleado
CHARACTER SET utf8mb4 
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n' 
IGNORE 1 LINES ;

INSERT INTO reunion(REU_IdReunion,REU_Objetivo,REU_Relatoria,REU_Fecha,REU_Modalidad) values 
(1,'Planificación de Actividades Semestrales','Se definieron las actividades y responsables para el Próximo semestre.','2024-01-15','VI'),
(2,'Evaluación del Programa de Apoyo Estudiantil','Se revisaron los resultados y se Propusieron mejoras al Programa.','2024-02-10','MIX'),
(3,'Organización de la Semana de la Salud','Se asignaron tareas para la organización del evento.','2024-03-05','PR'),
(4,'Capacitación en Atención Psicológica','Se llevá a cabo una capacitación para mejorar la atención a estudiantes.','2024-04-12','MIX'),
(5,'Revisión del Presupuesto Anual','Se discutieron las necesidades Presupuestarias y se ajustaron partidas.','2024-05-20','PR'),
(6,'Coordinación con Servicios de Salud Locales','Se establecieron acuerdos de colaboración con centros de salud locales.','2024-06-18','VI'),
(7,'Encuesta de Satisfacción Estudiantil','Se analizaron los resultados de la encuesta y se plantearon acciones correctivas.','2024-07-08','VI'),
(8,'Plan de Emergencia y Evacuación','Se actualizá el plan de emergencia y se Programaron simulacros.','2024-08-22','PR'),
(9,'Desarrollo de Programas de Inclusión','Se discutieron estrategias para fomentar la inclusión en el campus.','2024-09-14','PR'),
(10,'Evaluación de Actividades Recreativas','Se revisaron las actividades recreativas realizadas y se planificaron nuevas.','2024-10-30','MIX');

LOAD DATA LOCAL INFILE '/home/bellic12/Documentos/Proyecto/ARCHIVOS EXCEL/asistencia.csv' 
INTO TABLE asistencia
CHARACTER SET utf8mb4 
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n' 
IGNORE 1 LINES ;

INSERT INTO beneficio(BEN_IdBeneficio,ARE_IdArea,CON_IdConvocatoria,BEN_cupos,BEN_Descripcion,BEN_Inicio,BEN_Finalizacion,BEN_tipoBeneficio) values
(1	,1	,2011	,100	,'Descuento en matrícula',	'2024-02-28'	, '2024-06-02',	'M' ) ,
(2	,1	,2012	,101	,'Descuento en transporte',	'2024-02-28'	, '2024-06-02'	,'T' ) ,
(3	,2	,2013	,102	,'Descuento en residencia universitaria',	'2024-02-28'	, '2024-06-02', 'M' ) ,
(4	,2	,2014	,103	,'Subsidio de alimentos',	'2024-02-28'	, '2024-06-02',	'A' ) ,
(5	,1	,2015	,104	,'Beca para deportistas',	'2024-02-28'	, '2024-06-02'	,'M' ) ,
(6	,1	,2016	,105	,'Beca por investigación',	'2024-02-28'	, '2024-06-02'	,'M' ) ,
(7	,1	,2017	,106	,'Subsidio para prácticas profesionales',	'2024-02-28'	, '2024-06-02',	'M' ) ,
(8	,1	,2018	,107	,'Beca para estudiantes de bajos recursos',	'2024-02-28'	, '2024-06-02'	,'M' ) ,
(9	,1	,2019	,108	,'Beca para estudios de posgrado',	'2024-02-28'	, '2024-06-02',	'M' ) ,
(10	,2	,2020	,109	,'Subsidio para material tecnológico',	'2024-02-28'	, '2024-06-02',	'M' );

LOAD DATA LOCAL INFILE '/home/bellic12/Documentos/Proyecto/ARCHIVOS EXCEL/beneficio_aprobado.csv' 
INTO TABLE beneficio_aprobado
CHARACTER SET utf8mb4 
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n' 
IGNORE 1 LINES ;

INSERT INTO horario (HOR_IdHorario, INF_IdInfraestructura, HOR_HoraInicio, HOR_HoraFinal, HOR_Fecha) VALUES
(1, 1, '08:00:00', '10:00:00', '2024-03-23'),
(2, 2, '11:30:00', '13:30:00', '2024-05-28'),
(3, 3, '13:30:00', '15:30:00', '2024-04-27'),
(4, 4, '08:50:00', '10:50:00', '2024-02-07'),
(5, 12, '15:00:00', '17:00:00', '2024-05-31'),
(6, 5, '11:10:00', '13:10:00', '2024-03-27'),
(7, 17, '10:47:00', '12:47:00', '2024-05-19'),
(8, 8, '15:40:00', '17:40:00', '2024-05-21'),
(9, 13, '11:30:00', '13:30:00', '2024-04-21'),
(10, 10, '09:00:00', '11:00:00', '2024-04-19'),
(11, 1, '15:10:00', '17:10:00', '2024-05-14'),
(12, 2, '07:00:00', '09:00:00', '2024-02-08'),
(13, 15, '11:35:00', '13:35:00', '2024-05-19'),
(14, 4, '13:21:00', '15:21:00', '2024-03-30'),
(15, 16, '08:54:00', '10:54:00', '2024-04-11'),
(16, 4, '10:21:00', '12:21:00', '2024-03-22'),
(17, 9, '15:26:00', '17:26:00', '2024-02-03'),
(18, 6, '09:04:00', '11:04:00', '2024-04-08'),
(19, 7, '14:22:00', '16:22:00', '2024-05-06'),
(20, 20, '15:16:00', '17:16:00', '2024-02-09'),
(21, 6, '16:00:00', '18:00:00', '2024-04-24'),
(22, 21, '11:19:00', '13:19:00', '2024-05-18'),
(23, 8, '14:34:00', '16:34:00', '2024-04-14'),
(24, 9, '13:20:00', '15:20:00', '2024-04-14'),
(25, 10, '11:30:00', '13:30:00', '2024-02-10'),
(26, 4, '15:05:00', '17:05:00', '2024-04-04'),
(27, 5, '10:40:00', '12:40:00', '2024-05-08'),
(28, 14, '11:10:00', '13:10:00', '2024-05-28'),
(29, 7, '10:00:00', '12:00:00', '2024-04-17'),
(30, 1, '13:00:00', '15:00:00', '2024-02-20'),
(31, 2, '14:00:00', '16:00:00', '2024-02-29'),
(32, 3, '15:00:00', '17:00:00', '2024-03-29'),
(33, 4, '16:00:00', '18:00:00', '2024-05-04'),
(34, 5, '10:00:00', '12:00:00', '2024-03-18'),
(35, 6, '09:00:00', '11:00:00', '2024-05-09'),
(36, 7, '07:00:00', '09:00:00', '2024-04-16'),
(37, 1, '12:00:00', '14:00:00', '2024-04-20'),
(38, 2, '10:00:00', '12:00:00', '2024-03-28'),
(39, 3, '02:00:00', '04:00:00', '2024-05-06'),
(40, 6, '03:00:00', '05:00:00', '2024-05-10');


LOAD DATA LOCAL INFILE '/home/bellic12/Documentos/Proyecto/ARCHIVOS EXCEL/evento1.csv' 
INTO TABLE evento
CHARACTER SET utf8mb4 
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n' 
IGNORE 1 LINES ;

INSERT INTO proyecto_pgp(Are_IdArea	,Con_IdConvocatoria	,Hor_IdHorario,	Pro_Nombre,	Pro_Descripcion,Pro_TipoProyecto) values
(2,2021,21,'Uqbar',	'El único grupo estudiantil de la Universidad Nacional de Colombia enfocado a la ciberseguridad. Su objetivo es la divulgación de información relacionada al tema con el fin de concientizar a la gente.',	'Gru'),
(2,2022,22,'Tlön',	'El grupo TLÖN busca plantear soluciones de integración e intercambio de información en ambientes heterogéneos y distribuidos con el fin de resolver las problemáticas planteadas por las nuevas tecnologías, generar conocimiento y aprovechar oportunidades brindadas por tecnología informática y así aumentar la competitividad de la academia y las empresas colombianas. Esto se logra por medio de la adquisición, generación, y transferencia de conocimiento en las líneas de investigación.',	'Sem'),
(2,2023,23,'JCUN 2023',	'Convocatoria Nacional de Apoyo a la Difusión del Conocimiento mediante Eventos de Investigación, Creación Artística e Innovación 2022 - 2024',	'Ini'),
(2,2024,24,'BIOT',	'Las líneas de investigación del grupo se clasifican en tres áreas principales: - Investigación en el uso de biomasa como fuente renovable de energía a través de su procesamiento termoquímico. - Generación de productos de valor agregado a partir de biomasa. - Pretratamiento de biomasa para procesamiento térmico. - Sistemas energéticos renovables. - Optimización térmica de procesos.',	'Gru'),
(2,2025,25,'UNSECURELAB'	,'El grupo de investigación se enfoca en el estudio y la generación de nuevo conocimiento en el área de la ciberseguridad. Promueve la formación de alto nivel en pregrado, maestría y doctorado en temas tales como ciberseguridad, analítica de la ciberseguridad, ingeniería de software seguro, y seguridad de la información. Con la investigación e innovación que se desarrolla en el grupo se espera contribuir a tener una sociedad digital más segura.',	'Sem'),
(2,2026,26,'CyberTech',	'Este grupo se centra en la aplicación de tecnologías emergentes para abordar problemas de seguridad cibernética. Sus áreas de interés incluyen inteligencia artificial, blockchain y análisis de big data aplicados a la protección de datos y la prevención de amenazas en línea.'	,'Ini'),
(2,2027,27,'QuantumSafe',	'QuantumSafe es un grupo de investigación que se enfoca en la seguridad cuántica, explorando métodos y algoritmos criptográficos basados en principios de física cuántica para proteger la información en un entorno de computación cuántica.',	'Gru'),
(2,2028,28,'GreenIT',	'GreenIT es una iniciativa que busca investigar y promover prácticas de tecnología de la información (TI) sostenibles y respetuosas con el medio ambiente. El grupo desarrolla soluciones para minimizar la huella de carbono y optimizar el uso de recursos en la infraestructura de TI.',	'Sem'),
(2,2029,29,'EduTech',	'EduTech es un grupo de investigación que se enfoca en el desarrollo de tecnologías educativas innovadoras. Trabajan en la creación de herramientas y plataformas digitales para mejorar la calidad y accesibilidad de la educación a través de la tecnología.','Ini'),
(2,2030,30,'BioInformatics',	'BioInformatics es un grupo de investigación interdisciplinario que aplica técnicas de informática y análisis de datos a la investigación en biología y genética. Su objetivo es desarrollar herramientas y métodos computacionales para el estudio y la interpretación de datos biológicos y genómicos.',	'Gru');

insert into curso (ARE_IdArea, CON_IdConvocatoria,  CUR_Cupos, CUR_Nombre , CUR_Descripcion) values
(4,2001,30, 'Salsa y Merengue', 'Propiciar un acercamiento a la danza - salsa a través del aprendizaje de una amplia variedad de estilos, ritmos y pasos de los subgéneros de la salsa y el merengue'),
(4,2002,15, 'Guitarra popular,', 'Desarrollar habilidades básicas para la interpretación y el acompañamiento de melodías populares, por medio de la guitarra y la voz, con técnicas de ejecución, apreciación musical, ensamble y proyección.'),
(4,2003,30, 'Técnica vocal', 'Propiciar un primer encuentro de los estudiantes con su voz y ayudarles en el reconocimiento de las características de su voz cantada a través de técnicas de postura corporal, respiración, vocalización, entonación y afinación para el canto individual y grupal.'),
(4,2004,35, 'Formación actoral', 'Introducir al conocimiento del trabajo del actor, sus herramientas, sus medios expresivos y los rudimentos técnicos de la actuación, mediante la auto observación, el acondicionamiento psico-físico y algunos de improvisación.'),
(4,2005,30, 'Danza Contemporánea', 'Permitir un acercamiento al lenguaje de la danza contemporánea a través de herramientas técnicas y de improvisación provenientes de diversas aproximaciones a la danza contemporánea y a técnicas somáticas. Se desarrollará mediante una actividad física rigurosa que permita experimentar la fluidez y entender la conexión entre las diferentes artes del cuerpo, la conexión con el espacio y la relación con el tiempo.'),
(5,2006,20, ' Escalada', 'Acercamiento y formación básica en la disciplina de Escalada. Acceso a estudiantes, administrativos, docentes e hijos de funcionarios.'),
(5,2007,15, 'Taekwondo', 'Acercamiento y formación básica en Teakwondo. Acceso a estudiantes, administrativos, docentes e hijos de funcionarios.'),
(5,2008,10, 'Tenis de campo','Enseñanza y práctica en el deport de Tenis de campo. Acceso a estudiantes, administrativos, docentes e hijos de funcionarios.'),
(5,2009,15, 'Levantamiento de pesos olímpico,', 'Práctica y desarrollo de habilidades en la disciplina de Levantamiento de pesos olímpico.'),
(5,2031,15, 'Defensa personal', 'Compresión y aplicación de conocimiento de las habilidades sobre Defensa personal.');

INSERT INTO empleado_curso (PER_DocumentoIdentidad, CUR_IdCurso) values
(1044,	9),
(1054,	10),
(1052,	8),
(1044,	7),
(1042,	1),
(1045,	2);

INSERT INTO curso_horario(CUR_IdCurso, HOR_IdHorario) VALUES 
(1,	1),
(2,	2),
(3,	3),
(4,	4),
(5,	5),
(6,	6),
(7,	7),
(8,	8),
(9,	9),
(10, 10);