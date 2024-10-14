package clasesbiblioteca;

public class Prestario extends General {
    private String direccion;
    private String telefono;
    private String ruc;

    public Prestario(int codigo, String nombre, String direccion, String telefono, String ruc) {
        super(codigo, nombre);
        this.direccion = direccion;
        this.telefono = telefono;
        this.ruc = ruc;
    }

    public Prestario() {
    }

    // Getters y setters
    public String getDireccion() {
        return direccion;
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public String getRuc() {
        return ruc;
    }

    public void setRuc(String ruc) {
        this.ruc = ruc;
    }
}

