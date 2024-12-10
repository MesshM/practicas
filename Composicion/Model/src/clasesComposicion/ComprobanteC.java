package clasesComposicion;

public class ComprobanteC {
    private char tipo;
    private int numero;
    private FechaC fecha;

    public ComprobanteC(int dia, int mes, int anio) {
        fecha = new FechaC(dia, mes, anio);
    }


    public void setTipo(char tipo) {
        this.tipo = tipo;
    }

    public char getTipo() {
        return tipo;
    }

    public void setNumero(int numero) {
        this.numero = numero;
    }

    public int getNumero() {
        return numero;
    }

    public FechaC getFecha() {
        return fecha;
    }

    public void setFecha(FechaC fecha) {
        this.fecha = fecha;
    }


}
