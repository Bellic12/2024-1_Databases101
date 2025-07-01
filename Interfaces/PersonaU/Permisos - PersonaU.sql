USE bienestar; 

-- ASIGNACIÓN DE PERMISOS USUARIO PersonaU -- 

CREATE USER 'PersonaU'@'localhost' IDENTIFIED BY 'password';

-- Permite a 'PersonaU' ejecutar el procedimiento obtener_convocatorias
GRANT EXECUTE ON PROCEDURE bienestar.obtener_convocatorias TO 'PersonaU'@'localhost';

-- Permite a 'PersonaU' ejecutar el procedimiento obtener_eventos
GRANT EXECUTE ON PROCEDURE bienestar.obtener_eventos TO 'PersonaU'@'localhost';

-- Permite a 'PersonaU' ejecutar el procedimiento obtener_oficinas
GRANT EXECUTE ON PROCEDURE bienestar.obtener_oficinas TO 'PersonaU'@'localhost';

-- Permite a 'PersonaU' ejecutar el procedimiento obtener_areas
GRANT EXECUTE ON PROCEDURE bienestar.obtener_areas TO 'PersonaU'@'localhost';

-- Permite a 'PersonaU' ejecutar el procedimiento obtener_id_convocatoria
GRANT EXECUTE ON PROCEDURE bienestar.obtener_id_convocatoria TO 'PersonaU'@'localhost';

-- Permite a 'PersonaU' ejecutar la función obtener_id_actividad
GRANT EXECUTE ON FUNCTION bienestar.obtener_id_actividad TO 'PersonaU'@'localhost';

-- Permite a 'PersonaU' ejecutar el procedimiento inscripcionesPersonales
GRANT EXECUTE ON PROCEDURE bienestar.inscripcionesPersonales TO 'PersonaU'@'localhost';

-- Permite a 'PersonaU' ejecutar el procedimiento buscarConvocatorias
GRANT EXECUTE ON PROCEDURE bienestar.buscarConvocatorias TO 'PersonaU'@'localhost';

-- Permite a 'PersonaU' ejecutar el procedimiento buscarEventos
GRANT EXECUTE ON PROCEDURE bienestar.buscarEventos TO 'PersonaU'@'localhost';

-- Permite a 'PersonaU' ejecutar el procedimiento EliminarInscripcion
GRANT EXECUTE ON PROCEDURE bienestar.EliminarInscripcion TO 'PersonaU'@'localhost';

-- Permite a 'PersonaU' ejecutar el procedimiento obtenerRequisitos
GRANT EXECUTE ON PROCEDURE bienestar.obtenerRequisitos TO 'PersonaU'@'localhost';

-- Permite a 'PersonaU' ejecutar el procedimiento obtener_persona_por_documento
GRANT EXECUTE ON PROCEDURE bienestar.obtener_persona_por_documento TO 'PersonaU'@'localhost';

-- Permite a 'PersonaU' ejecutar el procedimiento NewRegistration
GRANT EXECUTE ON PROCEDURE bienestar.NewRegistration TO 'PersonaU'@'localhost';

-- Permite a 'PersonaU' ejecutar el procedimiento obtener_detalles_convocatoria
GRANT EXECUTE ON PROCEDURE bienestar.obtener_detalles_convocatoria TO 'PersonaU'@'localhost';

FLUSH PRIVILEGES;
-- Terminación permisos PersonaU -- 