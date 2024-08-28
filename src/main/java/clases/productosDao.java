package clases;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import clases.Mensajes;
import clases.conexion;
import clases.Productos;

public class productosDao {
	
	// Metodo por Lista 
		
// SQL 
Statement estado = null	;
ResultSet resultado = null ;
Connection conexion=null;
// variables 
String usuario ;
String contraseña ;
String url;

String sql ;
public productosDao() {
	
	usuario = "Admin";
	contraseña = "11111";
	url = "jdbc:mysql://localhost:3307/pagina";
	
	
    try {
        // Cargar el driver JDBC de MySQL
        Class.forName("com.mysql.cj.jdbc.Driver");
        Mensajes.verMensaje("Driver MySQL cargado correctamente.");
    } catch (ClassNotFoundException e) {
        System.out.println("Fallo al cargar el controlador MySQL: " + e.getMessage());
        Mensajes.verMensaje("Error al cargar el controlador: " + e.getMessage());
        e.printStackTrace();
        
    }
    
    try {
        // Establecer conexión con la base de datos
        conexion = DriverManager.getConnection(url, usuario, contraseña);
 
        Mensajes.verMensaje("Java : Conexión establecida :" + conexion.toString());
       
    } catch (SQLException e) {
       
        Mensajes.verMensaje("Java - Error en la conexión a la base de datos: " + e.getMessage());
        e.printStackTrace();
    }
    
    
    try {
    	
    	 estado = conexion.createStatement();
    	Mensajes.verMensaje("Java - Statement creado."+ estado);
    } catch(SQLException event){
    	System.out.println("Fail to estado" + event);
    	
    }
    
}


public Productos getProductos(int limite, int pagina) {

    Productos obtenerProductos = null;
    

   
    int offset = (pagina - 1) * limite;
    String nombres;
    double precio;
    String imagenes;
    
    String queryLimit = "SELECT * FROM productos LIMIT " + limite + " OFFSET " + offset;

    try {
        // Consulta SQL con LIMIT y OFFSET
       
        resultado = estado.executeQuery(queryLimit);
     
      
        
        // Procesar resultados
      while (resultado.next()) {
    	  
    	  obtenerProductos = new Productos();
    	  
            nombres = resultado.getString("nombre");
            precio = resultado.getDouble("precio");
            imagenes = resultado.getString("imagen");
            //
            
            obtenerProductos.setImagen(imagenes);
            obtenerProductos.setNombre(nombres);
            obtenerProductos.setPrecio(precio);
            
           
      
            // resultado 
            
            Mensajes.verMensaje("Java = "+"Nombre"+nombres+"-"+"Precio"+precio+"-"+"imagenes"+imagenes);
   
      } 
    } catch (SQLException e) {
    	e.printStackTrace();
    	Mensajes.verMensaje("java error resultado" +e );
    }
 
    finally {
        // Cerrar ResultSet, Statement y Connection de forma segura
        try {
            if (resultado != null) {
                resultado.close();
                
            }
            if (estado != null) {
                estado.close();
            }
            if (conexion != null) {
                conexion.close();
            }
            Mensajes.verMensaje("Java - Sesion Cerrada" + resultado +"_"+ estado +"_"+ conexion);
        } catch (SQLException e) {
            Mensajes.verMensaje("Java - Error al cerrar los recursos: " + e.getMessage());
            e.printStackTrace();
        }
    }
Mensajes.verMensaje("java resultado final : "+ obtenerProductos);
    return obtenerProductos;
}


public Productos [ ] getProductosArray(int limite, int pagina) {
	Productos obtenerProductos =null;
	Productos [] arrayProductos = new Productos[limite];
	
	  int offset = (pagina - 1) * limite;
	    String nombres;
	    double precio;
	    String imagenes;
	    int i =0;
	    
	    String queryLimit = "SELECT * FROM productos LIMIT " + limite + " OFFSET " + offset;

	    try {
	        // Consulta SQL con LIMIT y OFFSET
	       
	        resultado = estado.executeQuery(queryLimit);
	     
	      
	        
	        // Procesar resultados
	      while (resultado.next()&&  i < limite) {
	    	  
	    	  obtenerProductos = new Productos();
	    	  
	            nombres = resultado.getString("nombre");
	            precio = resultado.getDouble("precio");
	            imagenes = resultado.getString("imagen");
	            //
	            
	            obtenerProductos.setImagen(imagenes);
	            obtenerProductos.setNombre(nombres);
	            obtenerProductos.setPrecio(precio);
	            
	           arrayProductos[i] = obtenerProductos;
	      
	            // resultado 
	            
	            Mensajes.verMensaje("Java = "+"Nombre"+nombres+"-"+"Precio"+precio+"-"+"imagenes"+imagenes);
	   
	      } 
	    } catch (SQLException e) {
	    	e.printStackTrace();
	    	Mensajes.verMensaje("java error resultado" +e );
	    }
	 
	    finally {
	        // Cerrar ResultSet, Statement y Connection de forma segura
	        try {
	            if (resultado != null) {
	                resultado.close();
	                
	            }
	            if (estado != null) {
	                estado.close();
	            }
	            if (conexion != null) {
	                conexion.close();
	            }
	            Mensajes.verMensaje("Java - Sesion Cerrada" + resultado +"_"+ estado +"_"+ conexion);
	        } catch (SQLException e) {
	            Mensajes.verMensaje("Java - Error al cerrar los recursos: " + e.getMessage());
	            e.printStackTrace();
	        }
	    }
	
	
	Mensajes.verMensaje("Java -- Sesion Finalizada :" + arrayProductos[i].toString() +" -- " +"indice = " +i);
	return arrayProductos;
	
}

public List<Productos> getProductosAll(int limite, int pagina) {
		    List<Productos> listaConsultas = new ArrayList<>();
		    
		    
		    
		    
		    
		    
		    return listaConsultas;
		}
	
public String toString() {
		   Mensajes.verMensaje("Java - To String  - Conexion [url=" + url + ", usuario=" + usuario + ", conexion=" + conexion + "]");
	        return "Conexion [url=" + url + ", usuario=" + usuario + ", conexion=" + conexion + "]";
	    }
	   
	   
	


}
