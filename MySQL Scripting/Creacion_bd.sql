DROP SCHEMA IF EXISTS bienestar; 
CREATE SCHEMA bienestar; 
USE bienestar; 

CREATE TABLE persona (
	PER_DocumentoIdentidad INT NOT NULL UNIQUE,
    PER_TipoDocumento ENUM('CC','TI','CE','DNI') NOT NULL,
    PER_Nombre VARCHAR(45) NOT NULL,
    PER_Apellido VARCHAR(45) NOT NULL, 
    PER_CorreoElectronico VARCHAR(45) NOT NULL, 
    PER_Edad TINYINT NOT NULL,  
    PER_Telefono BIGINT,
    PRIMARY KEY (PER_DocumentoIdentidad)
);

CREATE TABLE estudiante (
	PER_DocumentoIdentidad INT NOT NULL,
	EST_Avance FLOAT NOT NULL, 
    EST_PAES_PEAMA ENUM('PAES','PEAMA','NA') NOT NULL DEFAULT('NA'),
    EST_PAPA FLOAT NOT NULL, 
    EST_Pregrado VARCHAR(45) NOT NULL, 
    EST_PBM TINYINT NOT NULL, 
    FOREIGN KEY(PER_DocumentoIdentidad) REFERENCES persona(PER_DocumentoIdentidad),
    PRIMARY KEY(PER_DocumentoIdentidad)
);

CREATE TABLE area (
	ARE_IdArea INT NOT NULL AUTO_INCREMENT,
    ARE_Nombre VARCHAR(45) NOT NULL,
    ARE_Descripcion LONGTEXT NOT NULL, 
    ARE_CorreoElectronico VARCHAR(45) NOT NULL, 
    ARE_Telefono BIGINT,
    PRIMARY KEY(ARE_IdArea)
);

CREATE TABLE convocatoria (
	CON_IdConvocatoria INT NOT NULL, 
    CON_FechaInicio DATE NOT NULL, 
    CON_FechaFin DATE NOT NULL,
    CON_Tipo ENUM('B','C','P'),
    PRIMARY KEY (CON_IdConvocatoria)
); 

CREATE TABLE sede (
	SED_IdSede INT AUTO_INCREMENT NOT NULL, 
    SED_Nombre VARCHAR(45) NOT NULL, 
    SED_Ciudad VARCHAR(45) NOT NULL, 
    PRIMARY KEY(SED_IdSede)
);

CREATE TABLE inscripcion (
	INS_IdInscripcion INT NOT NULL auto_increment,
	PER_DocumentoIdentidad INT NOT NULL, 
    CON_IdConvocatoria INT NOT NULL,
    INS_Estado ENUM('A','P', 'R') NOT NULL DEFAULT('P'),
    INS_Fecha VARCHAR(45) NOT NULL, 
    FOREIGN KEY(PER_DocumentoIdentidad) REFERENCES persona(PER_DocumentoIdentidad),
    FOREIGN KEY(Con_IdConvocatoria) REFERENCES convocatoria(Con_IdConvocatoria),
	PRIMARY KEY(INS_IdInscripcion, CON_IdConvocatoria,PER_DocumentoIdentidad)
); 

CREATE TABLE requisito (
	REQ_IdRequisito INT AUTO_INCREMENT NOT NULL, 
    REQ_Descripcion LONGTEXT NOT NULL, 
    REQ_Tipo VARCHAR(60) NOT NULL, 
    PRIMARY KEY(REQ_IdRequisito)
);

CREATE TABLE convocatoria_requisito (
	CON_IdConvocatoria INT NOT NULL, 
    REQ_IdRequisito INT NOT NULL, 
    FOREIGN KEY (CON_IdConvocatoria) REFERENCES convocatoria(CON_IdConvocatoria),
    FOREIGN KEY (REQ_IdRequisito) REFERENCES requisito(REQ_IdRequisito),
    PRIMARY KEY(CON_IdConvocatoria,REQ_IdRequisito)
);

CREATE TABLE infraestructura(
	INF_IdInfraestructura INT AUTO_INCREMENT NOT NULL ,
    SED_IdSede INT NOT NULL, 
	INF_Nombre VARCHAR(45) NOT NULL, 
    INF_Locacion VARCHAR(127) NOT NULL, 
    INF_Capacidad SMALLINT, 
    FOREIGN KEY(SED_IdSede) REFERENCES sede(SED_IdSede),
    PRIMARY KEY(INF_IdInfraestructura)
);

CREATE TABLE infraestructura_bienestar(
	INF_IdInfraestructura INT NOT NULL ,
    INFBI_Ocupacion VARCHAR(80) NOT NULL, 
    ARE_IdArea INT NOT NULL,
    FOREIGN KEY (INF_IdInfraestructura) REFERENCES infraestructura(INF_IdInfraestructura),
    FOREIGN KEY (ARE_IdArea) REFERENCES area (ARE_IdArea),
    PRIMARY KEY(INF_IdInfraestructura)
);


CREATE TABLE oficina(
	INF_IdInfraestructura INT AUTO_INCREMENT NOT NULL,
    OFI_CorreoElectronico VARCHAR(45) NOT NULL, 
    OFI_Telefono BIGINT NOT NULL, 
    OFI_Nombre VARCHAR(45) NOT NULL, 
    FOREIGN KEY (INF_IdInfraestructura) REFERENCES infraestructura(INF_IdInfraestructura), 
    PRIMARY KEY(INF_IdInfraestructura)
);

CREATE TABLE empleado(
	PER_DocumentoIdentidad INT NOT NULL ,
    INF_IdInfraestructura INT NOT NULL, 
    ARE_IdArea INT NOT NULL, 
    EMP_Cargo VARCHAR(45) NOT NULL,
    EMP_Sueldo FLOAT NOT NULL, 
    EMP_TipoContrato VARCHAR(45) NOT NULL,
    FOREIGN KEY(PER_DocumentoIdentidad) REFERENCES persona(PER_DocumentoIdentidad),
    FOREIGN KEY (INF_IdInfraestructura) REFERENCES infraestructura(INF_IdInfraestructura), 
    FOREIGN KEY (ARE_IdArea ) REFERENCES area (ARE_IdArea),
    PRIMARY KEY (PER_DocumentoIdentidad)
);

CREATE TABLE reunion(
	REU_IdReunion INT NOT NULL, 
    REU_Objetivo VARCHAR(255) NOT NULL, 
    REU_Relatoria LONGTEXT NOT NULL, 
    REU_Fecha DATE NOT NULL, 
    REU_Modalidad ENUM('PR','VI','MIX') NOT NULL DEFAULT('PR'), 
    PRIMARY KEY(REU_IdReunion)
);

CREATE TABLE asistencia(
	REU_IdReunion INT NOT NULL, 
    PER_DocumentoIdentidad INT NOT NULL, 
    FOREIGN KEY (REU_IdReunion) REFERENCES reunion(REU_IdReunion),
    FOREIGN KEY (PER_DocumentoIdentidad) REFERENCES  empleado(PER_DocumentoIdentidad),
    PRIMARY KEY(REU_IdReunion,PER_DocumentoIdentidad)
);

CREATE TABLE beneficio(
	BEN_IdBeneficio INT NOT NULL AUTO_INCREMENT, 
    ARE_IdArea INT NOT NULL default 2, 
    CON_IdConvocatoria INT NOT NULL, 
    BEN_Cupos SMALLINT NOT NULL, 
    BEN_Descripcion LONGTEXT NOT NULL,
    BEN_Inicio DATE NOT NULL, 
    BEN_Finalizacion DATE NOT NULL,
    BEN_TipoBeneficio ENUM('M','A','T','C') NOT NULL, 
    FOREIGN KEY (CON_IdConvocatoria) REFERENCES convocatoria(CON_IdConvocatoria),
    FOREIGN KEY (ARE_IdArea) REFERENCES area (ARE_IdArea),
    PRIMARY KEY(BEN_IdBeneficio, ARE_IdArea)
);

CREATE TABLE beneficio_aprobado(
	PER_DocumentoIdentidad INT NOT NULL,
    CON_IdConvocatoria INT NOT NULL,
    BNAP_HorasRestantes VARCHAR(45),
    FOREIGN KEY (PER_DocumentoIdentidad) REFERENCES persona(PER_DocumentoIdentidad),
    FOREIGN KEY (CON_IdConvocatoria) REFERENCES convocatoria(CON_IdConvocatoria),
    PRIMARY KEY(CON_IdConvocatoria, PER_DocumentoIdentidad)
);

CREATE TABLE horario (
	HOR_IdHorario INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	INF_IdInfraestructura INT NOT NULL,
	HOR_HoraInicio TIME NOT NULL ,
	HOR_HoraFinal TIME NOT NULL ,
	HOR_Fecha DATE NOT NULL ,
    FOREIGN KEY (INF_IdInfraestructura) REFERENCES infraestructura(INF_IdInfraestructura)
); 

CREATE TABLE evento(
	EVE_IdEvento INT AUTO_INCREMENT NOT NULL, 
    ARE_IdArea INT NOT NULL, 
    HOR_IdHorario INT NOT NULL, 
    EVE_Asistencia INT NOT NULL, 
    EVE_Nombre VARCHAR(45) NOT NULL, 
    EVE_Tipo VARCHAR(45) NOT NULL, 
    FOREIGN KEY (ARE_IdArea) REFERENCES area (ARE_IdArea),
    FOREIGN KEY (HOR_IdHorario) REFERENCES horario(HOR_IdHorario),
    PRIMARY KEY( EVE_IdEvento, ARE_IdArea) 
);

CREATE TABLE proyecto_pgp(
	PRO_IdProyectoPGP INT AUTO_INCREMENT NOT NULL , 
	ARE_IdArea INT NOT NULL default 2 , 
	HOR_IdHorario INT NOT NULL, 
	CON_IdConvocatoria INT NOT NULL, 
	PRO_Descripcion LONGTEXT NOT NULL, 
	PRO_Nombre VARCHAR(45) NOT NULL, 
	PRO_TipoProyecto ENUM('Sem', 'Gru', 'Ini') NOT NULL,
    FOREIGN KEY (ARE_IdArea) REFERENCES area (ARE_IdArea),
    FOREIGN KEY (HOR_IdHorario) REFERENCES horario(HOR_IdHorario),
    FOREIGN KEY (CON_IdConvocatoria) REFERENCES convocatoria(CON_IdConvocatoria),
    PRIMARY KEY (PRO_IdProyectoPGP,ARE_IdArea ) 
);

CREATE TABLE curso(
	CUR_IdCurso INT NOT NULL AUTO_INCREMENT UNIQUE, 
    ARE_IdArea INT NOT NULL, 
    CON_IdConvocatoria INT NOT NULL,
    CUR_Cupos INT NOT NULL, 
    CUR_Nombre VARCHAR(45) NOT NULL,    
    CUR_Descripcion LONGTEXT,
    FOREIGN KEY (ARE_IdArea) REFERENCES area(ARE_IdArea),
    FOREIGN KEY (CON_IdConvocatoria) REFERENCES convocatoria(CON_IdConvocatoria),
    PRIMARY KEY (CUR_IdCurso, ARE_IdArea) 
);

CREATE TABLE empleado_curso(
	PER_DocumentoIdentidad INT NOT NULL, 
    CUR_IdCurso INT NOT NULL, 
     FOREIGN KEY (PER_DocumentoIdentidad) REFERENCES empleado(PER_DocumentoIdentidad),
	 FOREIGN KEY (CUR_IdCurso) REFERENCES curso(CUR_IdCurso),
     PRIMARY KEY (CUR_IdCurso, PER_DocumentoIdentidad)
);

CREATE TABLE curso_horario (
	CUR_IdCurso INT NOT NULL,
    HOR_IdHorario INT NOT NULL, 
	FOREIGN KEY (CUR_IdCurso) REFERENCES curso(CUR_IdCurso),
    FOREIGN KEY (HOR_IdHorario) REFERENCES horario(HOR_IdHorario),
    PRIMARY KEY (CUR_IdCurso, HOR_IdHorario)
);