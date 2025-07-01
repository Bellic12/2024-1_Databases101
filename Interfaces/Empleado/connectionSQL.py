import mysql.connector
from mysql.connector import Error

class principal:
    def __init__(self):
        self.conexion = None
        self.conectar()

    def conectar(self):
        try:
            self.conexion = mysql.connector.connect(
                host='localhost',
                database='bienestar',
                user='root',
                password='password'
            )
            if self.conexion.is_connected():
                print("Conexión a la base de datos establecida")
        except Error as e:
            print(f"Error al conectar a la base de datos: {e}")
            self.conexion = None

    def verificar_conexion(self):
        if not self.conexion or not self.conexion.is_connected():
            self.conectar()

    def buscarConvocatorias(self):
        self.verificar_conexion()
        cursor = self.conexion.cursor()
        try:
            sql = "SELECT * FROM tableConvocatorias"
            cursor.execute(sql)
            registro = cursor.fetchall()
        finally:
            cursor.close()
        return registro

    def buscarEventos(self):
        self.verificar_conexion()
        cursor = self.conexion.cursor()
        try:
            sql = "SELECT * FROM vw_evento"
            cursor.execute(sql)
            registro = cursor.fetchall()
        finally:
            cursor.close()
        return registro

    def buscaInscripcionesPersonaU(self, documentoIdentidad):
        self.verificar_conexion()
        cursor = self.conexion.cursor()
        try:
            sql = "CALL inscripcionesPersonales(%s)"
            cursor.execute(sql, (documentoIdentidad,))
            inscripciones = cursor.fetchall()
        finally:
            cursor.close()
        return inscripciones

    def buscarOficinas(self):
        self.verificar_conexion()
        cursor = self.conexion.cursor()
        try:
            sql = "SELECT * FROM vw_oficinas"
            cursor.execute(sql)
            oficinas = cursor.fetchall()
        finally:
            cursor.close()
        return oficinas

    def buscarAreas(self):
        self.verificar_conexion()
        cursor = self.conexion.cursor()
        try:
            sql = "SELECT * FROM vw_areas"
            cursor.execute(sql)
            areas = cursor.fetchall()
        finally:
            cursor.close()
        return areas
    
    def buscarConvocatoriaNombre(self,nombreConvocatoria): 
        self.verificar_conexion()
        cursor=self.conexion.cursor()
        try:
            sql = "CALL buscarConvocatorias(%s)"
            cursor.execute(sql,(nombreConvocatoria,))
            nomConvocatorias = cursor.fetchall()
        finally:
            cursor.close()
        return nomConvocatorias
    
    def buscarEventosNombre(self,nombreEvento): 
        self.verificar_conexion()
        cursor=self.conexion.cursor()
        try:
            sql = "CALL buscarEventos(%s)"
            cursor.execute(sql, (nombreEvento,))
            nomEventos = cursor.fetchall()
        finally:
            cursor.close()
        return nomEventos
    
    def idConNombre_Descripcion(self,nombre,descripcion): 
        self.verificar_conexion()
        cursor=self.conexion.cursor()
        try:
            sql = "SELECT CON_IdConvocatoria FROM v_convocatoria_info WHERE nombre = '%s' AND descripcion ='%s' "
            cursor.execute(sql, (nombre,descripcion,))
            nomEventos = cursor.fetchall()
        finally:
            cursor.close()
        return nomEventos
    
    def borrarInscripcion(self, id_Inscripcion): 
        cur = self.conexion.cursor()
        sql = "CALL EliminarInscripcion(%s)"
        cur.execute(sql, (id_Inscripcion,))
        nom = cur.rowcount
        self.conexion.commit()    
        cur.close()
        return nom 
    
    def buscarRequisitos(self, nombre, descripcion):
        self.verificar_conexion()
        cursor = self.conexion.cursor()
        try:
            sql = "CALL obtenerRequisitos(%s, %s)"
            cursor.execute(sql, (nombre, descripcion,))
            requisitos = cursor.fetchall()
        finally:
            cursor.close()
        return requisitos
    
    def buscarPersona(self, documentoIdentidad):
        self.verificar_conexion()
        cursor = self.conexion.cursor()
        try:
            sql = "Select * from persona where PER_DocumentoIdentidad = %s"
            cursor.execute(sql, (documentoIdentidad,))
            persona = cursor.fetchone()
        finally:
            cursor.close()

        if persona is None:
            return None
        # Suponiendo que sabes el orden de las columnas en la tabla 'persona'
        keys = ['clave1', 'clave2', 'clave3', 'clave4', 'clave5', 'clave6', 'clave7']
        return dict(zip(keys, persona))
    
    def mostrarCronograma(self): 
        self.verificar_conexion()
        cursor=self.conexion.cursor()
        try:
            sql = "SELECT * FROM vw_cronograma"
            cursor.execute(sql)
            nomCronograma = cursor.fetchall()
        finally:
            cursor.close()
        return nomCronograma
    
    def mostrarReuniones(self): 
        self.verificar_conexion()
        cursor=self.conexion.cursor()
        try:
            sql = "SELECT * FROM vw_reuniones"
            cursor.execute(sql)
            nomReuniones = cursor.fetchall()
        finally:
            cursor.close()
        return nomReuniones
    
    def mostrarInscripciones(self): 
        self.verificar_conexion()
        cursor=self.conexion.cursor()
        try:
            sql = "SELECT * FROM vw_inscripcion"
            cursor.execute(sql)
            nomInscripciones = cursor.fetchall()
        finally:
            cursor.close()
        return nomInscripciones
    
    def buscarCronogramaNombre(self,cronograma): 
        self.verificar_conexion()
        cursor=self.conexion.cursor()
        try:
            sql = "CALL buscarCronograma(%s)"
            cursor.execute(sql,(cronograma,))
            nomInscripciones = cursor.fetchall()
        finally:
            cursor.close()
        return nomInscripciones
    
    def buscarInscripcionesNombre(self,inscripcion): 
        self.verificar_conexion()
        cursor=self.conexion.cursor()
        try:
            sql = "CALL busquedaIns(%s)"
            cursor.execute(sql,(inscripcion,))
            nomInscripciones = cursor.fetchall()
        finally:
            cursor.close()
        return nomInscripciones
    
    def rechazarInscripcion(self, IdInscripcionRC):
        cur = self.conexion.cursor()
        sql = "CALL estado_rechazado_ins(%s)"
        cur.execute(sql, (IdInscripcionRC,))
        nom = cur.rowcount
        self.conexion.commit()    
        cur.close()
        return nom 
    
    def obtenerPerfil(self, id_usuario):
        self.verificar_conexion()
        cursor = self.conexion.cursor()
        try:
            sql = "SELECT * FROM vista_empleado_detalle WHERE DocumentoCompleto LIKE %s"
            param = f"%{id_usuario}%"
            cursor.execute(sql, (param,))
            perfil = cursor.fetchone()
            print(perfil)
        finally:
            cursor.close()
        return perfil

    def aceptarInscripcion(self, IdInscripcionAC):
        cur = self.conexion.cursor()
        sql = "CALL estado_aprobado_ins(%s)"
        cur.execute(sql, (IdInscripcionAC,))
        nom = cur.rowcount
        self.conexion.commit()    
        cur.close()
        return nom 
    
    def borrarInscripcion(self, idInscripcionDE): 
        cur = self.conexion.cursor()
        sql = "CALL EliminarInscripcion(%s)"
        cur.execute(sql, (idInscripcionDE,))
        nom = cur.rowcount
        self.conexion.commit()    
        cur.close()
        return nom 