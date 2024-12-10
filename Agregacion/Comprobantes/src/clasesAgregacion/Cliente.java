package clasesAgregacion;
public class Cliente {
    private int codigo;
    private String razonSocial;

    public Cliente(int c, String r){
            setCodigo(c);
            setRazonSocial(r);
    }

    public int getCodigo(){
        return codigo;
    }

    public String getRazonSocial(){
        return razonSocial;
    }

    public void setRazonSocial(String raz){
        this.razonSocial = raz;
    }

    public void setCodigo(int cod){
        this.codigo = cod;
    }

}
