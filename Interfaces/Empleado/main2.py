import sys
from PyQt5.QtWidgets import QApplication, QMainWindow, QHeaderView, QMessageBox
from PyQt5 import QtCore, QtWidgets
from PyQt5.uic import loadUi
from connectionSQL import principal

class VentanaPrincipal(QMainWindow):
    def __init__(self):
        super(VentanaPrincipal, self).__init__()
        loadUi("/home/bellic12/Documentos/Proyecto/interfazEmpleado/InterfazEmpleado.ui", self)

        self.datosTotal = principal()
        self.cargarPerfil(1041)
        
        # Conexión de botones
        self.pushCronograma.clicked.connect(lambda: self.stackedWidget.setCurrentWidget(self.pageCronograma))
        self.pushCronograma.clicked.connect(lambda: self.mostrarCronograma())
        self.pushInscripciones.clicked.connect(lambda: self.stackedWidget.setCurrentWidget(self.pageInscripciones))
        self.pushInscripciones.clicked.connect(lambda: self.mostrarInscripcionEstudiantes())
        self.pushMiPerfil.clicked.connect(lambda: self.stackedWidget.setCurrentWidget(self.pageMiPerfil))
        self.pushReuniones.clicked.connect(lambda: self.stackedWidget.setCurrentWidget(self.pageReuniones))

        #Inicializar tablas 
        self.mostrarCronograma()
        self.mostrarReuniones()
        self.mostrarInscripcionEstudiantes()

        #Buscar cosas por nombre 
        self.pushBuscarCronograma.clicked.connect(self.buscarCronograma)
        self.pushBuscarInscripcion.clicked.connect(self.buscarInscripciones)

        # Rechazar inscripción 
        self.pushRechazar.clicked.connect(lambda: self.rechazarInscripcion())
        self.pushAprobar.clicked.connect(lambda: self.aprobarInscripcion())
        self.pushEliminasInscripcion.clicked.connect(lambda: self.eliminarInscripcion())

    def rechazarInscripcion(self): 
        row = self.tableInscripciones.currentRow()
        if row == -1:
            QMessageBox.warning(self, "Error", "No se ha seleccionado ninguna inscripción")
            return
        cell1 = self.tableInscripciones.item(row, 0).text()
        self.datosTotal.rechazarInscripcion(cell1)
        self.mostrarInscripcionEstudiantes()

    def aprobarInscripcion(self):
        row = self.tableInscripciones.currentRow()
        if row == -1:
            QMessageBox.warning(self, "Error", "No se ha seleccionado ninguna inscripción")
            return
        cell1 = self.tableInscripciones.item(row, 0).text()
        self.datosTotal.aceptarInscripcion(cell1)
        self.mostrarInscripcionEstudiantes()

    def eliminarInscripcion(self): 
        row = self.tableInscripciones.currentRow()
        if row == -1:
            QMessageBox.warning(self, "Error", "No se ha seleccionado ninguna inscripción")
            return
        cell1 = self.tableInscripciones.item(row, 0).text()
        self.datosTotal.borrarInscripcion(cell1)
        self.mostrarInscripcionEstudiantes()


    def cargarDatosEnTabla(self, tabla, datos):
        tabla.setRowCount(len(datos))
        for i, row in enumerate(datos):
            for j, val in enumerate(row):
                tabla.setItem(i, j, QtWidgets.QTableWidgetItem(str(val)))


    def mostrarCronograma(self): 
        datos = self.datosTotal.mostrarCronograma()
        self.cargarDatosEnTabla(self.tableCronograma, datos)

    def mostrarReuniones(self): 
        datos = self.datosTotal.mostrarReuniones()
        self.cargarDatosEnTabla(self.tableReunion, datos)

    def mostrarInscripcionEstudiantes(self): 
        datos = self.datosTotal.mostrarInscripciones()
        self.cargarDatosEnTabla(self.tableInscripciones, datos)

    def buscarCronograma(self):
        nomCon = self.lineBuscarCronograma.text().strip()
        if nomCon: 
            datos = self.datosTotal.buscarCronogramaNombre(nomCon)
            self.cargarDatosEnTabla(self.tableCronograma, datos)
        else: 
            self.mostrarCronograma()

    def buscarInscripciones(self): 
        nomIns = self.lineBuscarInscripcion.text().strip()
        if nomIns: 
            datos = self.datosTotal.buscarInscripcionesNombre(nomIns)
            self.cargarDatosEnTabla(self.tableInscripciones, datos)
        else: 
            self.mostrarInscripcionEstudiantes()

    def cargarPerfil(self, id_usuario):
        perfil = self.datosTotal.obtenerPerfil(id_usuario)
        if perfil is not None:
            self.DocumentoL.setPlainText(perfil[0])
            self.NombreL.setPlainText(perfil[1])
            self.CorreoL.setPlainText(perfil[2])
            self.TelefonoL.setPlainText(str(perfil[3]))
            self.CargoL.setPlainText(perfil[4])
            self.OficinaL.setPlainText(perfil[5])

if __name__ == '__main__':
    app = QApplication(sys.argv)
    mi_app = VentanaPrincipal()
    mi_app.show()
    sys.exit(app.exec_())
