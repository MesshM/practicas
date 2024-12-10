package clasesAgregacion;

import java.util.ArrayList;
import java.util.Iterator;
//import clasesComprobantes.*;

public class Factura extends Comprobante {
    private float total;
    private Cliente mCliente;
    private ArrayList<Producto> mProducto = new ArrayList<>();

    public Factura(char tipo, int numero, Fecha fecha, Cliente cliente) {
        super(tipo, numero, fecha);
        setCliente(cliente);
    }

    public Cliente getCliente() {
        return mCliente;
    }

    public void setCliente(Cliente cliente) {
        this.mCliente = cliente;
    }

    public float getTotal() {
        return total;
    }

    public void setTotal(float total) {
        this.total = total;
    }

    public void setProducto(ArrayList<Producto> producto) {
        this.mProducto = producto;
    }

    public ArrayList<Producto> getProducto() {
        return mProducto;
    }

    public void agregarProducto(Producto p) {
        mProducto.add(p);
        setTotal(getTotal() + p.getPrecio());
    }

    public void mostrarProductos() {
        Iterator<Producto> iter = mProducto.iterator();
        while (iter.hasNext()) {
            Producto p = iter.next();
            System.out.printf("Codigo: %d Descripcion: %s Precio: %5.2f \n",
                    p.getCodigo(), p.getDescripcion(), p.getPrecio());
        }
    }

    public void mostrar() {
        System.out.printf("Tipo: %c Número: %d Fecha: %d/%d/%d \n",
                getTipo(), getNumero(),getFecha().getDia(), getFecha().getMes(), getFecha().getAnio());
                
        System.out.printf("Cliente: \n");
        System.out.printf("Codigo: %d Razon Social: %s \n",
                mCliente.getCodigo(), mCliente.getRazonSocial());

        System.out.printf("Productos: \n");
        mostrarProductos();
        System.out.printf("Total: %6.2f \n", getTotal());
    }
}
