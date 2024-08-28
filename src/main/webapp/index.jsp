<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="clases.conexion"%>
<%@ page import="clases.Consulta"%>
<%@ page import="clases.productosDao"%>
<%@ page import="clases.Mensajes"%>
<%@ page import="java.sql.*"%>
<%@ page import ="clases.Productos" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="style.css">
<title>index</title>
</head>
<body>
	
<!--  hago la consulta desde una clase java  -->
<!--  Me conecto a la base de datos -->
	<%
	//Paginacion 
	
	String paginacionPrev = request.getParameter("prevPage");
	String paginacionNext = request.getParameter("NextPage");
	
	//Limit Select ,inicia en null limitSelect 
	
	String limitParam = request.getParameter("limitSelect");
	Mensajes.verMensaje("Parámetro limitSelect: " + limitParam);
	
	//Limit Form
	
	String limitForm = request.getParameter ("formLimit");
	Mensajes.verMensaje("Parametro Form Limit : " + limitForm);
	
	//SQL 

	String nombreSQL = request.getParameter("Nombre");
	String precioSQL = request.getParameter("Precio");
	String imagenSQL = request.getParameter("Imagen");
	
	// Variables por defecto 
    int contador = 1;
	int pagina = 1;
	
	
	
	// Queremos que el valor por defecto de limite por parametro de la etiqueta HTML <select> sea 3   
	if ( limitParam == null ){
		limitParam = "3";
		
	}
	
	int intLimit  = Integer.parseInt(limitParam);
	int limite = 6;
	// instancias 
	
	productosDao consultajsp = new productosDao();
	Productos productos = new Productos ();
	Mensajes mensajejsp = new Mensajes();
	
	productos = consultajsp.getProductos(limite, pagina);
	//		
	List<Productos> listaProductos = productos.getProductosList();
	
	Mensajes.verMensaje("la instancia a sido : " + productos);
	
	Mensajes.verMensaje("prueba Mensaje java  :" + productos.toString());
	
	// verificar que si la paginacion es -1 siempre sea 0 
			
				if (paginacionNext != null) {
			pagina = Integer.parseInt(paginacionNext);
		
			Mensajes.verMensaje("valor de la pagina ++: " + pagina);
				}

				if (paginacionPrev != null) {
			pagina = Integer.parseInt(paginacionPrev);
		
			Mensajes.verMensaje("valor de la pagina --: " + pagina);
			
			if (pagina < 1) {
				pagina = 1; 
			}
				}
				
				int offset = (pagina - 1) * limite;
				
	%>

	<h1>Paginacion Avanzada</h1>
	<hr>
	<p>Vamos a hacer una consulta con Limit y Offset y que nos devuelva
		la consulta</p>


	<table class="tabla" border="1">

		<tr>
			<th>-</th>
			<th>Nombre</th>
			<th>Precio</th>
			<th>Imagen</th>
			<th></th>
			<th></th>
			<th></th>
		</tr>

		<%
		for ( Productos producto : listaProductos){
			Mensajes.verMensaje("prueba producto" + producto);
		%>

		<tr>
			<th>-</th>
			<th>
				<%=producto.getNombre()%>
			</th>
			<th>
				<%=producto.getPrecio() %>
			</th>
			<th>
				<%= producto.getImagen()%>
			</th>
			<th>5</th>
			<th>6</th>
			<th>7</th>
		</tr>

	</table>
	<!-- <<<<<<<<<<<<<<<<<<<<<<<<<<<<<< FORM >>>>>>>>>>>>>>>>>>>>>>>> -->
	<!-- FORM  -->
	<!-- Select -->

	<br>
	
	<!--  limite funciona como un filtro de elementos que se muestran en pantalla por eso no lo unimos con la paginacion s -->
	<div class ="limite">
	<form action="index.jsp"  name="limitForm" method="POST">
		<p>limite :</p>
		<select name="limitSelect" id="nProductosVista">
			<option value="3">3</option>
			<option value="6">6</option>
			<option value="9">9</option>
			<option value="12">12</option>
		</select>
		<input type="submit" value="Mostrar" id="datos" >
		
		
	</form>
	
	<%	if (limitParam != null && !limitParam.trim().isEmpty()){
		limite = Integer.parseInt(limitParam);
		Mensajes.verMensaje("el valor de limite es  :" +limite);
		
	}else{
	Mensajes.verMensaje("el valor por ahora es " + limite);
	Mensajes.verMensaje("Parámetro limitSelect: " + limitParam);} 
	Mensajes.verMensaje("El form por ahora es :" + limitForm);
	Mensajes.verMensaje("la consulta ha sido "+ consultajsp.getProductos(limite, pagina));
	
		}if (limitForm !=null){
		 out.println("La opción seleccionada es: " + limitForm);
	}else{
		out.print("LimitForm : la opcion no ha sido seleccionada =" + limitForm);
	}
	
	
	// convertir parametro String a int 
	
	
	if( limitParam !=null){
		 intLimit  = Integer.parseInt(limitParam);
		Mensajes.verMensaje("el parametro String a int ha sido : " + intLimit);
	}

	%>
	</div>
	 	<br>
		<br>
		<!--  form para la Paginacion -->
		<div class="contenedor">
		<form action="index.jsp" name="pageform" method="POST">

			<input type="hidden" id="sumaPagina" name="NextPage"value=<%=pagina+1%>>
			 <input type="submit" class="boton"name="Siguiente" value="Siguiente" value=> 
		</form>
		<br>
		<%
	

		out.print("Offset : " + offset + "\n"+" | "+"Paginas : "+pagina);

		
		
		Mensajes.verMensaje("resultado total : " + limitForm + "-"+limitParam +"-"+limite+"-"+pagina+"-"+ productos);
		out.print("resultado total: " + limitForm + "-"+limitParam +"-"+limite+"-"+pagina+"-"+ productos);
		%>
		<form action="index.jsp" name="pageform2">

			<input type="hidden" id="restaPagina" name="prevPage"value=<%=pagina-1%>> 
				<input type="submit" class="boton" name="Anterior" value="Anterior">
		</form>
</div>
</body>
</html>