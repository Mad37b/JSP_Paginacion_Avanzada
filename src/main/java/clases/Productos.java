package clases;

import java.util.ArrayList;
import java.util.List;

public class Productos {
	
	String nombre ;
	double precio;
	String imagen;
	
	List<Productos>Productos = new ArrayList<Productos> ();

	public List<Productos> getProductosList() {
		return Productos;
	}
	public void setProductosList(List<Productos> productos) {
		Productos = productos;
	}
	public String getNombre() {
		return nombre;
	}
	public void setNombre(String nombre) {
		this.nombre = nombre;
	}
	public double getPrecio() {
		return precio;
	}
	public void setPrecio(double precio2) {
		this.precio = precio2;
	}
	public String getImagen() {
		return imagen;
	}
	public void setImagen(String imagen) {
		this.imagen = imagen;
	}
	@Override
	public String toString() {
		return "Productos [nombre=" + nombre + ", precio=" + precio + ", imagen=" + imagen + "]";
	}
	public Productos addProducto(Productos producto) {
		// TODO Auto-generated method stub
		return producto;
	}
	
	

}
