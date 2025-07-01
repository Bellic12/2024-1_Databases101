-- SCRIPT Índices:

-- 1. Índice compuesto por las llaves foráneas en la tabla inscripcion:
CREATE INDEX idx_inscripcion_documento_convocatoria ON inscripcion (PER_DocumentoIdentidad, CON_IdConvocatoria);

-- 2. Índice de tipo Fulltext sobre la columan PER_CorrreoElectronico
CREATE FULLTEXT INDEX idx_persona_email ON persona (PER_CorreoElectronico);

-- 3. Índice cumpuesto para las fechas de iniio y fin de la convocatoria
CREATE INDEX idx_convocatoria_fecha_inicio ON convocatoria (CON_FechaInicio,CON_FechaFin);

-- 4. índice compuesto sobre el período de vida de un beneficio
CREATE INDEX idx_beneficio_fecha ON beneficio (BEN_Inicio, BEN_Finalizacion);

-- 5. Índice para la mejora de búsqueda de requisiots según la convocatoria
CREATE INDEX idx_requisito ON convocatoria_requisito (REQ_idRequisito); 

-- 6. Índice implementado sobre la fecha de la inscripción
CREATE INDEX idx_inscripcion_fecha ON inscripcion (INS_Fecha);

-- 7. Índice sobre el ID de los horarios en la tabla evento.
CREATE INDEX idx_evento_horario ON evento (HOR_IdHorario);

-- 8.Índice único sobre el documento de identidad de los empleados
CREATE UNIQUE INDEX idx_empleado_documento ON empleado (PER_DocumentoIdentidad);

show indexes from EMPLEADO;