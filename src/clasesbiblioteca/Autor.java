package clasesbiblioteca;

public class Autor extends General {
    private String observacion;
    private int librosPublicados;

    public Autor(int codigo, String nombre, String observacion, int librosPublicados) {
        super(codigo, nombre);
        this.observacion = observacion;
        this.librosPublicados = librosPublicados;
    }

    public Autor() {
    }

    // Getters y setters
    public String getObservacion() {
        return observacion;
    }

    public void setObservacion(String observacion) {
        this.observacion = observacion;
    }

    public int getLibrosPublicados() {
        return librosPublicados;
    }

    public void setLibrosPublicados(int librosPublicados) {
        this.librosPublicados = librosPublicados;
    }
}