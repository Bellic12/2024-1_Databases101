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
    END AS 'Nombre', 
    BEN_Descripcion AS 'Descripcion', 
    CON_IdConvocatoria 
	FROM 
    beneficio) UNION 
        (SELECT CUR_IdCurso, CUR_Nombre AS 'Nombre', CUR_Descripcion AS 'Descripcion', CON_IdConvocatoria FROM curso) UNION 
        (SELECT PRO_IdProyectoPGP, PRO_Nombre AS 'Nombre', PRO_Descripcion, CON_IdConvocatoria FROM proyecto_pgp)) AS programasEstudiantes NATURAL JOIN 
        convocatoria;

-- VISTA PARA EVENTOS -- 
CREATE VIEW vw_evento AS 
	SELECT  EVE_Nombre ,
	HOR_Fecha ,
	HOR_HoraInicio ,
	HOR_HoraFinal,
    INF_Nombre 
	FROM evento NATURAL JOIN horario NATURAL JOIN infraestructura;

-- vista areas -- 
CREATE VIEW vw_areas AS
	SELECT ARE_Nombre, 
    ARE_Telefono, 
    ARE_CorreoElectronico 
    FROM 
    area;
    
-- vista oficinas -- 
CREATE VIEW vw_oficinas AS
	SELECT OFI_Nombre, 
    INF_Locacion, 
    OFI_Telefono,
    OFI_CorreoElectronico
    FROM
    oficina NATURAL JOIN infraestructura; 