package clasesbiblioteca;

public class General {
    private int codigo;
    private String nombre;

    public General(int codigo, String nombre) {
        this.codigo = codigo;
        this.nombre = nombre;
    }

    public General() {
    }

    public boolean validarDatos() {
        return codigo > 0 && nombre != null && !nombre.isEmpty();
    }

    // Getters y setters
    public int getCodigo() {
        return codigo;
    }

    public void setCodigo(int codigo) {
        this.codigo = codigo;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }
}

