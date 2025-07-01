DELIMITER //

-- Trigger 1: Actualiza los cupos disponibles del curso y verifica disponibilidad
CREATE TRIGGER actualizar_cupos_disponibles
BEFORE INSERT ON inscripcion
FOR EACH ROW
BEGIN
    DECLARE cursoId INT;
    DECLARE cupos INT;
    
    SELECT CUR_IdCurso INTO cursoId
    FROM curso
    WHERE CON_IdConvocatoria = NEW.CON_IdConvocatoria
    LIMIT 1;
    
    SELECT CUR_Cupos INTO cupos FROM curso WHERE CUR_idCurso = NEW.CUR_idCurso;
    IF cupos <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No hay cupos disponibles para este curso';
    END IF;
    
    UPDATE curso
    SET CUR_Cupos = CUR_Cupos - 1
    WHERE CUR_IdCurso = cursoId;
END //

-- Trigger 2: Verifica cupos disponibles para el curso
CREATE TRIGGER validar_cupo_curso
BEFORE INSERT ON inscripcion
FOR EACH ROW
BEGIN
    DECLARE cupos INT;
    
    SELECT CUR_Cupos INTO cupos
    FROM inscripcion
    JOIN convocatoria ON inscripcion.CON_IdConvocatoria = convocatoria.CON_IdConvocatoria
    JOIN curso ON inscripcion.CUR_idCurso = curso.CUR_IdCurso
    JOIN persona ON inscripcion.PER_DocumentoIdentidad = persona.PER_DocumentoIdentidad
    WHERE convocatoria.CON_IdConvocatoria = NEW.CON_IdConvocatoria
      AND persona.PER_DocumentoIdentidad = NEW.PER_DocumentoIdentidad;
    
    IF cupos <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No hay cupos disponibles para este curso';
    END IF;
END //

-- Trigger 3: Verifica cupos disponibles para el beneficio
CREATE TRIGGER validar_cupo_beneficio
BEFORE INSERT ON inscripcion
FOR EACH ROW
BEGIN
    DECLARE cupos INT;
    
    SELECT BEN_Cupos INTO cupos
    FROM inscripcion
    JOIN convocatoria ON inscripcion.CON_IdConvocatoria = convocatoria.CON_IdConvocatoria
    JOIN beneficio ON convocatoria.BEN_IdBeneficio = beneficio.BEN_IdBeneficio
    JOIN persona ON inscripcion.PER_DocumentoIdentidad = persona.PER_DocumentoIdentidad
    WHERE convocatoria.CON_IdConvocatoria = NEW.CON_IdConvocatoria
      AND persona.PER_DocumentoIdentidad = NEW.PER_DocumentoIdentidad;
    
    IF cupos <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No hay cupos disponibles para este beneficio';
    END IF;
END //

-- Trigger 4: Actualiza los cupos disponibles del beneficio
CREATE TRIGGER registro_cupos_beneficios
AFTER INSERT ON inscripcion
FOR EACH ROW
BEGIN 
    UPDATE beneficio
    SET BEN_Cupos = BEN_Cupos - 1
    WHERE BEN_IdBeneficio = (
        SELECT BEN_IdBeneficio
        FROM convocatoria
        WHERE CON_IdConvocatoria = NEW.CON_IdConvocatoria
    );
END //

-- Trigger 5: Actualiza los cupos disponibles del curso después de la inscripción
CREATE TRIGGER registro_cupos_curso
AFTER INSERT ON inscripcion
FOR EACH ROW
BEGIN 
    UPDATE curso
    SET CUR_Cupos = CUR_Cupos - 1
    WHERE CUR_IdCurso = NEW.CUR_idCurso
      AND CON_IdConvocatoria = NEW.CON_IdConvocatoria;
END //

DELIMITER ;


/* 
Descripción General:

Estos triggers están diseñados para gestionar el proceso de inscripción en un sistema educativo o similar, asegurando la integridad de los datos y la disponibilidad de cupos tanto para cursos como para beneficios dentro de las convocatorias correspondientes. Aquí está el resumen de cada trigger:

actualizar_cupos_disponibles: Verifica y actualiza los cupos disponibles de un curso al realizar una inscripción, asegurando que no se excedan los límites de capacidad.

validar_cupo_curso: Antes de insertar una inscripción, verifica si hay cupos disponibles para el curso al que se desea inscribir.

validar_cupo_beneficio: Antes de insertar una inscripción, verifica si hay cupos disponibles para el beneficio asociado a la convocatoria de inscripción.

registro_cupos_beneficios: Después de insertar una inscripción, actualiza automáticamente los cupos disponibles del beneficio asociado a la convocatoria.

registro_cupos_curso: Después de insertar una inscripción, actualiza automáticamente los cupos disponibles del curso asociado a la convocatoria y al curso específico.

Estos triggers garantizan que las operaciones de inscripción respeten los límites de cupos disponibles, asegurando un proceso de gestión de inscripciones robusto y eficiente en el sistema.
*/ 