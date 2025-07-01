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
                user='PersonaU',
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
            sql = "CALL obtener_convocatorias()"
            cursor.execute(sql)
            registro = cursor.fetchall()
        finally:
            cursor.close()
        return registro

    def buscarEventos(self):
        self.verificar_conexion()
        cursor = self.conexion.cursor()
        try:
            sql = "CALL obtener_eventos()"
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
            sql = "CALL obtener_oficinas()"
            cursor.execute(sql)
            oficinas = cursor.fetchall()
        finally:
            cursor.close()
        return oficinas

    def buscarAreas(self):
        self.verificar_conexion()
        cursor = self.conexion.cursor()
        try:
            sql = "CALL obtener_areas()"
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
            sql = "CALL obtener_id_convocatoria(%s, %s)"
            cursor.execute(sql, (nombre,descripcion,))
            nomEventos = cursor.fetchall()
        finally:
            cursor.close()
        return nomEventos
    
    def borrarInscripcion(self, id_Inscripcion): 
        self.verificar_conexion()
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
            print(nombre, descripcion)
            cursor.execute("SELECT obtener_id_actividad(%s, %s)", (nombre, descripcion,))
            self.actividad_id = cursor.fetchone()[0]
            sql = "CALL obtenerRequisitos(%s, %s)"
            cursor.execute(sql, (nombre, descripcion,))
            requisitos = cursor.fetchall()
        finally:
            print(self.actividad_id)
            cursor.close()
        return requisitos
    
    def devolverIdActividad(self): return self.actividad_id
    
    def buscarPersona(self, documentoIdentidad):
        self.verificar_conexion()
        cursor = self.conexion.cursor()
        try:
            sql = "CALL obtener_persona_por_documento(%s)"
            cursor.execute(sql, (documentoIdentidad,))
            persona = cursor.fetchone()
        finally:
            cursor.close()

        if persona is None:
            return None

        # Suponiendo que sabes el orden de las columnas en la tabla 'persona'
        keys = ['clave1', 'clave2', 'clave3', 'clave4', 'clave5', 'clave6', 'clave7']
        return dict(zip(keys, persona))
    
    def nuevaInscripcion(self, idConvocatoria, documento_identidad):
        self.verificar_conexion()
        cursor = self.conexion.cursor()
        try:
            sql = "CALL NewRegistration(%s, %s)"
            cursor.execute(sql, (idConvocatoria, documento_identidad))
            self.conexion.commit()
        finally:
            cursor.close()

    def buscarInformacion(self):
        self.verificar_conexion()
        cursor = self.conexion.cursor()
        try:
            sql = "CALL obtener_detalles_convocatoria(%s)"
            cursor.execute(sql, (self.actividad_id,))
            informacion = cursor.fetchall()
        finally:
            cursor.close()
        return informacion