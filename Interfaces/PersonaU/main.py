import sys
from PyQt5.QtWidgets import QApplication, QMainWindow, QHeaderView, QMessageBox
from PyQt5 import QtCore, QtWidgets
from PyQt5.uic import loadUi
from connectionSQL import principal

class VentanaPrincipal(QMainWindow):
    def __init__(self):
        super(VentanaPrincipal, self).__init__()
        loadUi('/home/bellic12/Documentos/PRUEBA/proyectoBases/interfazPersonaU.ui', self)

        self.datosTotal = principal()

        # Conexión del botón de borrar
        self.burttonInscripcion.clicked.connect(lambda: self.borrarInscripcionSeleccionada())


        # Conexión de botones
        self.pushMisDatos.clicked.connect(lambda: self.stackedWidget.setCurrentWidget(self.pageMisDatos))
        self.pushMisInscripciones.clicked.connect(lambda: self.stackedWidget.setCurrentWidget(self.pageMisInscripciones))
        self.pushMisInscripciones.clicked.connect(lambda: self.mostrarInscripciones())
        self.pushConvocatorias.clicked.connect(lambda: self.mostrarConvocatorias())
        self.pushConvocatorias.clicked.connect(lambda: self.stackedWidget.setCurrentWidget(self.pageConvocatorias))
        self.pushEventos.clicked.connect(lambda: self.stackedWidget.setCurrentWidget(self.pageEventos))
        self.pushEventos.clicked.connect(lambda: self.mostrarEventos())
        self.pushContactanos.clicked.connect(lambda: self.stackedWidget.setCurrentWidget(self.pageContactanos))
        self.pushDevolverInscripcion.clicked.connect(lambda: self.stackedWidget.setCurrentWidget(self.pageConvocatorias))
        self.pushInscribirse.clicked.connect(lambda: self.inscribirActividad())
        self.pushAtrasBienestar.clicked.connect(lambda: self.stackedWidget.setCurrentWidget(self.pageConvocatorias))
        self.pushInscribirse_2.clicked.connect(lambda: self.inscribirActividad())

        self.stackedWidget.setCurrentWidget(self.pageMisDatos)

        self.tableConvocatorias.cellDoubleClicked.connect(self.irInscripcion)

        self.datosPersonales()

        # Inicializar tablas
        self.mostrarConvocatorias()
        self.mostrarEventos()
        self.mostrarInscripciones()
        self.mostrarAreas()
        self.mostrarOficinas()

        # Buscar eventos por nombre
        self.buttonBuscar.clicked.connect(self.buscarPorNombreEvento)
        self.pushBuscarConvocatorias.clicked.connect(self.buscarPorNombreConvocatoria)

        # Fija las columnas de las tabla eventos, oficinas y areas de bienestar 
        self.tableEventos.horizontalHeader().setSectionResizeMode(QHeaderView.Stretch)
        self.tableOficinas.horizontalHeader().setSectionResizeMode(QHeaderView.Stretch)
        self.tableAreasBienestar.horizontalHeader().setSectionResizeMode(QHeaderView.Stretch)

    def borrarInscripcionSeleccionada(self):
        # Obtén la fila seleccionada
        row = self.tableInscripciones.currentRow()

        # Si no hay fila seleccionada, simplemente retorna
        if row == -1:
            return

        # Obtén los datos de la fila seleccionada
        cell1 = self.tableInscripciones.item(row, 0).text()

        # Llama a la función de borrar inscripción con los datos de la fila seleccionada
        self.datosTotal.borrarInscripcion(cell1)

        # Actualiza la tabla de inscripciones
        self.mostrarInscripciones()

    def inscribirActividad(self):
        try:
            # Disable the button
            self.pushInscribirse.setEnabled(False)

            id_actividad = self.datosTotal.devolverIdActividad()
            self.datosTotal.nuevaInscripcion(id_actividad, 1005)

            # Muestra un mensaje de éxito
            QMessageBox.information(self, "Inscripción", "Inscripción realizada con éxito")

            # Cambia a la ventana anterior
            self.stackedWidget.setCurrentWidget(self.pageConvocatorias)
        except Exception as e:
            # Muestra un mensaje de error
            QMessageBox.critical(self, "Error", f"Error al inscribirse: {e}")
        finally:
            # Re-enable the button
            self.pushInscribirse.setEnabled(True)

    def irInscripcion(self,row,column):  
        cell1 = self.tableConvocatorias.item(row, 0).text()
        cell2 = self.tableConvocatorias.item(row, 1).text()
        cell3 = self.tableConvocatorias.item(row, 2).text()
        cell4 = self.tableConvocatorias.item(row, 3).text()
        cell5 = self.tableConvocatorias.item(row, 4).text()
        print(f"Cell 1: {cell1}, Cell 2: {cell2}, Cell 3: {cell3}, Cell 4: {cell4}, Cell 5: {cell5}")
        if cell1 == "B" :
            self.stackedWidget.setCurrentWidget(self.pageBeneficio)
            self.mostrarRequisitosBeneficio(cell2, cell5)
        else: 
            self.stackedWidget.setCurrentWidget(self.pageInscripcion)
            self.mostrarRequisitos(cell2, cell5)
            self.mostrarInformacion()

        
    def mostrarConvocatorias(self):
        datos = self.datosTotal.buscarConvocatorias()
        self.cargarDatosEnTabla(self.tableConvocatorias, datos)

    def mostrarEventos(self):
        datos = self.datosTotal.buscarEventos()
        self.cargarDatosEnTabla(self.tableEventos, datos)

    def mostrarInscripciones(self):
        datos = self.datosTotal.buscaInscripcionesPersonaU(1005)
        self.cargarDatosEnTabla(self.tableInscripciones, datos)

    def mostrarAreas(self):
        datos = self.datosTotal.buscarAreas()
        self.cargarDatosEnTabla(self.tableAreasBienestar, datos)

    def mostrarOficinas(self):
        datos = self.datosTotal.buscarOficinas()
        self.cargarDatosEnTabla(self.tableOficinas, datos)

    def mostrarRequisitos(self, nombre, descripcion):
        datos = self.datosTotal.buscarRequisitos(nombre, descripcion)
        self.cargarDatosEnTabla(self.tableRequisitos, datos)

    def mostrarInformacion(self):
        datos = self.datosTotal.buscarInformacion()
        self.cargarDatosEnTabla(self.tableInformacion, datos)

    def mostrarRequisitosBeneficio(self, nombre, descripcion):
        datos = self.datosTotal.buscarRequisitos(nombre, descripcion)
        self.cargarDatosEnTabla(self.tableRequisitosBeneficio, datos)

    def cargarDatosEnTabla(self, tabla, datos):
        tabla.setRowCount(len(datos))
        for i, row in enumerate(datos):
            for j, val in enumerate(row):
                tabla.setItem(i, j, QtWidgets.QTableWidgetItem(str(val)))

    def buscarPorNombreEvento(self):
        nomEve = self.buscarEventos.text().strip()  # Obtener y limpiar el texto ingresado
        if nomEve:  # Solo buscar si hay texto ingresado
            datos = self.datosTotal.buscarEventosNombre(nomEve)
            self.cargarDatosEnTabla(self.tableEventos, datos)
        else:
            self.mostrarEventos()  # Mostrar todos los eventos si no hay texto ingresado

    def buscarPorNombreConvocatoria(self):
        nomCon = self.buscarConvocatorias.text().strip()
        if nomCon: 
            datos = self.datosTotal.buscarConvocatoriaNombre(nomCon)
            self.cargarDatosEnTabla(self.tableConvocatorias, datos)
        else: 
            self.mostrarEventos()

    def datosPersonales(self):
        datos_persona = self.datosTotal.buscarPersona(1005)
        print (datos_persona)
        if datos_persona is None:
            print("No se encontró ninguna persona con ese documento de identidad.")
        else:
            self.DocumentoL.setPlainText(datos_persona['clave2']+" "+str(datos_persona['clave1']))
            self.NombreL.setPlainText(datos_persona['clave3']+" "+datos_persona['clave4'])
            self.EdadL.setPlainText(datos_persona['clave5'])
            self.CorreoL.setPlainText(str(datos_persona['clave6']))
            self.TelefonoL.setPlainText(str(datos_persona['clave7']))


if __name__ == '__main__':
    app = QApplication(sys.argv)
    mi_app = VentanaPrincipal()
    mi_app.show()
    sys.exit(app.exec_())