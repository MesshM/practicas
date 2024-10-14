package clasesbiblioteca;

import java.util.Scanner;

public class CargarLibro {
    private Libro libro;

    public static void main(String[] args) {
        CargarLibro cargador = new CargarLibro();
        cargador.cargarLibro();
        cargador.imprimirLibro();
    }

    public void cargarLibro() {
        try (Scanner scanner = new Scanner(System.in)) {
            libro = new Libro();

            System.out.println("Ingrese el código del libro:");
            libro.setCodigo(scanner.nextInt());
            scanner.nextLine(); // Consumir el salto de línea

            System.out.println("Ingrese el nombre del libro:");
            libro.setNombre(scanner.nextLine());

            System.out.println("Ingrese la edición del libro:");
            libro.setEdicion(scanner.nextInt());

            System.out.println("Ingrese el año de publicación del libro:");
            libro.setAnoPublicacion(scanner.nextInt());
        } 
    }
     
    public void imprimirLibro() {
        System.out.println("Datos del libro:");
        System.out.println("Código: " + libro.getCodigo());
        System.out.println("Nombre: " + libro.getNombre());
        System.out.println("Edición: " + libro.getEdicion());
        System.out.println("Año de publicación: " + libro.getAnoPublicacion());
    }
}