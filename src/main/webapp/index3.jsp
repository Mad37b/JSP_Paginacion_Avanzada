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
	int paginaTotal = 10;
	// < buscar o obtener resultados por lista for ( int producto : lista productos )) o por resultSet 
	//ResultSet resultado =null;
	
	// Limite 
	
	int limite = 16;
	String limitParam = request.getParameter("limitSelect");
	//
	Mensajes.verMensaje("Parámetro limitSelect: " + limitParam);
	// Queremos que el valor por defecto de limite por parametro de la etiqueta HTML <select> sea 3   
	// el limitParam siempre tiene que estar con valor para que no de null
	if ( limitParam == null ){
		limitParam =String.valueOf(limite);
		
	}
	
	int intLimit  = Integer.parseInt(limitParam);
	// el valor de limite será el valor que le pase el parametro Limit
	limite =intLimit;
	
	// instancias 
	
	productosDao consultajsp = new productosDao();
	Productos productos = new Productos ();
	Mensajes mensajejsp = new Mensajes();
	
	
	//	con lista  se usa for-eacth	
	//List<Productos> listaProductos = productos.getProductosList();
	
	//Sin Lista 
	
	// Por Array 
	
	Productos [] productosArray = consultajsp.getProductosArray(limite, pagina);
			
    //
	
	// Paso 1 -- La instancia empieza en null
	Mensajes.verMensaje(" JSP -- la instancia a sido : " + productos);
	// Paso 1.1 Devuelve lo mismo que sin To String 
	Mensajes.verMensaje("JSP -- prueba Mensaje java  :" + productos.toString());
	
				
	%>
	


	<h1>Paginacion Avanzada</h1>
	<hr>
	<p>Vamos a hacer una consulta con Limit y Offset y que nos devuelva
		la consulta</p>


	<table class="tabla" border="1">

		<tr>
			<th>- Nº -</th>
			<th>Nombre</th>
			<th>Precio</th>
			<th>Imagen</th>
			<th></th>
			<th></th>
			<th></th>
		</tr>

		<%
		// Paso 2 : al usar un form de esta manera obtenemos los productos por el indice 
		for ( int i = 0  ; i < productosArray.length; i++){
			Productos productos2 = productosArray[i];
			
			Mensajes.verMensaje(" JSP prueba producto" + productos2);
			
			if ( productos2 !=null){
		%>

		<tr>
			<th> <%= i + 1 %></th>
			<th>
				<%=productos2.getNombre()%>
			</th>
			<th>
				<%=productos2.getPrecio() %>
			</th>
			<th>
				<%=productos2.getImagen()%>
			</th>
			<th>5</th>
			<th>6</th>
			<th>7</th>
		</tr>


	<%
			} else{out.print(" JSP -- Producto ha sido null : "+productos2.toString()+"\n"+"con el index"+i);}
		}
	
	
	%>
		</table>
	
	<!-- <<<<<<<<<<<<<<<<<<<<<<<<<<<<<< FORM >>>>>>>>>>>>>>>>>>>>>>>> -->
	<!-- FORM  -->
	<!-- Select -->

	<br>
	
	<!--  limite funciona como un filtro de elementos que se muestran en pantalla por eso no lo unimos con la paginacion s -->
	<div class ="limite">
	<form action="index3.jsp" method="POST">
		<p>limite :</p>
		<select name="limitSelect" id="nProductosVista">
			<option value="3">3</option>
			<option value="6">6</option>
			<option value="9">9</option>
			<option value="12">12</option>
		</select>
		<input type="hidden" value="limitParam">
		<input type="submit" value="Mostrar" id="datos" >
		
	</form>
	<!--  Paso 3 : el valor de limite llega a ser 3 cuando lo inicializamos en 12 en la variable por que le pasamos el valor de limitParam -->
	<%
	

	
	if (limitParam != null && !limitParam.trim().isEmpty()) {
		limite = Integer.parseInt(limitParam);
		intLimit = Integer.parseInt(limitParam);

		limite = intLimit;
		limitParam = String.valueOf(limite);

		Mensajes.verMensaje("el valor de limite es  :" + limite);

	} else {
		Mensajes.verMensaje(" JSP -- el valor por ahora es " + limite);
		Mensajes.verMensaje("JSP -- Parámetro limitSelect: " + limitParam);
		Mensajes.verMensaje("JSP -- El form por ahora es :" + limitForm);
		Mensajes.verMensaje(" JSP -- la consulta ha sido " + consultajsp.getProductos(limite, pagina));

	}
	if (limitForm != null) {
		out.println("La opción seleccionada es: " + limitForm);
	} else {
		out.print("LimitForm : la opcion no ha sido seleccionada =" + limitForm);
	}

	// convertir parametro String a int 

	// Paso 4 : el valor es 3  y se mantiene 
	if (limitParam != null) {
		intLimit = Integer.parseInt(limitParam);
		Mensajes.verMensaje("JSP -- el parametro String a int ha sido : " + intLimit);

	}
	%>
	</div>
	 	<br>
		<br>
		<!--  form para la Paginacion -->
		
		
		
		
	
		
		<div class="contenedor">
		
				<form action="index3.jsp" name="pageform2">
		 <input type="hidden" name="limitSelect" value="<%= limitParam %>">
			<input type="hidden" id="restaPagina" name="prevPage"value="<%=pagina-1%>"> 
				<input type="submit" class="boton" name="Anterior" value="Anterior">
		</form>
		
		<br>
		<%out.print("Pagina " + pagina +" || "+paginaTotal); %>
		
		<form action="index3.jsp" name="pageform" method="POST">
		
 			<input type="hidden" name="limitSelect" value="<%= limitParam %>">
			<input type="hidden" id="sumaPagina" name="NextPage"value="<%=pagina+1%>">
			 <input type="submit" class="boton"name="Siguiente" value="Siguiente" > 
			 
		</form>
		<br>
		<br>
			<% if (paginacionNext != null) {
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

		
			
</div>
</body>
</html>