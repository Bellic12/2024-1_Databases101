USE bienestar;

-- PAA - Transacciones
 /* 1. Esta transacción implementada en un procedimiento almacenado deja 
en firme las insercciones de nuevos requisitos en las convocatorias*/
DELIMITER $$
CREATE PROCEDURE agregarRequisitosAConvocatoria(
    IN p_idConvocatoria INT,
    IN p_requisitos VARCHAR(255) -- Lista de IDs de requisitos separados por comas
)
BEGIN
    START TRANSACTION;

    -- Eliminar los requisitos que ya no están en la lista de entrada
    DELETE FROM convocatoria_requisito 
    WHERE CON_IdConvocatoria = p_idConvocatoria 
    AND REQ_IdRequisito NOT IN (SELECT REQ_IdRequisito FROM requisito WHERE FIND_IN_SET(REQ_IdRequisito, p_requisitos));

    -- Insertar nuevos requisitos y mantener los existentes
    INSERT INTO convocatoria_requisito (CON_IdConvocatoria, REQ_IdRequisito) 
    SELECT p_idConvocatoria, REQ_IdRequisito 
    FROM requisito 
    WHERE FIND_IN_SET(REQ_IdRequisito, p_requisitos)
    ON DUPLICATE KEY UPDATE CON_IdConvocatoria = p_idConvocatoria;

    COMMIT;
END $$
DELIMITER ;

/*2. Controla el cambio del estado de la inscripción*/
-- Eliminar procedimiento almacenado si existe previamente
DROP PROCEDURE IF EXISTS del_inscripcion;

-- Cambiar delimitador para permitir el uso de ;
DELIMITER $$
-- Crear el procedimiento almacenado del_inscripcion
CREATE PROCEDURE del_inscripcion (IN ID INT)
BEGIN
	-- Declarar una variable para almacenar el estado de la inscripción
    DECLARE estado ENUM('P', 'A', 'R');
    -- Iniciar la transacción
    START TRANSACTION ;

    -- Obtener el estado de la inscripción según el ID proporcionado
    SELECT INS_Estado INTO estado FROM inscripcion WHERE INS_IdInscripcion = ID;

    -- Verificar si el estado es 'A' (Aprobado) o 'R' (Rechazado)
    IF estado = 'A' OR estado = 'R' THEN
        -- Lanzar una señal para indicar un error y deshacer la transacción
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La inscripción no se puede borrar, ya que indica aprobación o rechazo.';
        ROLLBACK;
    ELSE
        -- Confirmar la transacción si el estado es 'P' (Pendiente)
        COMMIT;
    END IF;
END$$
-- Restaurar el delimitador predeterminado
DELIMITER ;



-- FUNCIONES:
-- 1. FUNCTION: Retorna el número de horas de corresponsabilidad para un estudiante en un beneficio aprobado.
DROP FUNCTION IF EXISTS horas_corresponsabilidad;
DELIMITER $$
CREATE FUNCTION horas_corresponsabilidad (
    personaID INT, 
    convocatoriaID INT
) RETURNS TINYINT
-- Indica la lectura de datos y la no 
READS SQL DATA
BEGIN 
    DECLARE horas TINYINT DEFAULT 0;
    -- Usar SELECT INTO para asignar el valor a la variable horas
    SELECT BNAP_HorasRestantes 
    INTO horas
    FROM beneficio_aprobado 
    WHERE PER_DocumentoIdentidad = personaID 
      AND CON_IdConvocatoria = convocatoriaID;
    RETURN horas;
END $$
DELIMITER ;
-- Ejemplo:
SELECT * FROM beneficio_aprobado;
SET @horas_prueba=horas_corresponsabilidad(1028,2020);
SELECT @horas_prueba;


-- 2 Function: Retorna el estado de la inscripcion
DROP FUNCTION IF EXISTS obtenerEstado_Inscripcion;
DELIMITER $$
CREATE FUNCTION obtenerEstado_Inscripcion (idPersonaU INT, idConvocatoria INT)
RETURNS ENUM('P','A','R')
READS SQL DATA
BEGIN 
	-- Declaración de variable
	DECLARE estado ENUM('P','A','R');
    SELECT INS_Estado INTO estado FROM inscripcion WHERE PER_DocumentoIdentidad=idPersonaU and CON_IdConvocatoria=idConvocatoria;
    RETURN estado;
END $$
DELIMITER ;
-- Ejemplo de prueba:
SET @estado_ins= obtenerEstado_Inscripcion(1036,2028);
-- Proyección del valor retornado:
SELECT @estado_ins;