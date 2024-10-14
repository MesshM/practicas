package clasesbiblioteca;

public class Libro extends General {
    private int edicion;
    private int anoPublicacion;

    public Libro(int codigo, String nombre, int edicion, int anoPublicacion) {
        super(codigo, nombre);
        this.edicion = edicion;
        this.anoPublicacion = anoPublicacion;
    }

    public Libro() {
    }

    public int getStock() {
        // Implementación simple para getStock()
        return 0;
    }

    // Getters y setters
    public int getEdicion() {
        return edicion;
    }

    public void setEdicion(int edicion) {
        this.edicion = edicion;
    }

    public int getAnoPublicacion() {
        return anoPublicacion;
    }

    public void setAnoPublicacion(int anoPublicacion) {
        this.anoPublicacion = anoPublicacion;
    }
}