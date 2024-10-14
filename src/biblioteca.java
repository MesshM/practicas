import clasesbiblioteca.*;

public class biblioteca {
    public static void main(String[] args) {
        System.out.println("Bienvenido al sistema de la Biblioteca");
        
        // Crear una instancia de CargarLibro y utilizarla
        CargarLibro cargador = new CargarLibro();
        cargador.cargarLibro();
        cargador.imprimirLibro();

        System.out.println("Gracias por usar el sistema de la Biblioteca");
    }
}