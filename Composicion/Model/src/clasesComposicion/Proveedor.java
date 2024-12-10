package clasesComposicion;

public class Proveedor {
    private int codigo;
    private String razonSocial;

    public Proveedor(String razonSocial, int codigo) {
        setRazonSocial(razonSocial);
        setCodigo(codigo);
    }

    public void setCodigo(int codigo) {
        this.codigo = codigo;
    }

    public int getCodigo() {
        return codigo;
    }

    public void setRazonSocial(String razonSocial) {
        this.razonSocial = razonSocial;
    }

    public String getRazonSocial() {
        return razonSocial;
    }
}
