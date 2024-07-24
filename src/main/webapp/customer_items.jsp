<%
if (session.getAttribute("name") == null) {
	response.sendRedirect("login.jsp");
} 
%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Products of the customer</title> 
<style type="text/css">
.title {
	font-family: "Trebuchet MS", Helvetica, sans-serif;
	text-align: center;
	font-size: 50px;
	font-style: italic;
	color: firebrick;
	text-decoration: underline gray;
	text-shadow: 3px 3px 3px hotpink;
	margin-top: 50px;
}

table, th, td {
	border: 3px solid;
}

.table_content {
	margin: 20px auto;
	font-size: 20px;
	width: 90%;
	text-align: center;
	align-content: center;
	align-items: center;
	border-radius: 10px 10px 10px 10px;
	overflow: hidden;
	box-shadow: 5px 5px 15px orangered;
}

.table_content th, .table_content td {
	padding: 10px 10px;
	text-align: center;
}

.table_content th a {
	text-decoration: none;
}

.table_content tr {
	border-bottom: 2px solid rosybrown;
}

.table_content tr:nth-of-type(even) {
	background-color: lightgray;
}

.table_content tr:nth-of-type(odd) {
	background-color: lightgoldenrodyellow;
}

.table_content tr:nth-of-type(1) {
	background-color: lightcoral;
}

a.text_link {
	color: darkviolet;
	text-decoration: none;
}

/*a.text_link:link {
	color: mediumvioletred;
}

a.text_link:visited {
	color: mediumvioletred;
}*/

a.text_link:hover {
	color: darkorange;
	background-color: yellow;
}

a.text_link:active {
	color: orangered;
	background-color: lightpink;
}

input[type=number] {
			font-family: "Brush Script MT", cursive;
			font-size: 20px;
			width: 10%;
			border: 2px solid darkgray;
			border-radius: 10px;
			margin: 2px;
			outline: none;
			padding: 5px;
			box-sizing: border-box;
			transition: 0.2s;
		}

input[type=submit] {
	font-family: "Brush Script MT", cursive;
	font-size: 20px;
	width: auto;
	background-color: greenyellow;
	color: mediumvioletred;
	border: 2px solid darkgray;
	border-radius: 10px;
	margin: 2px;
	outline: none;
	padding: 5px;
	box-sizing: border-box;
	transition: 0.2s;
}

input[type=submit]:focus {
	border-color: deeppink;
	box-shadow: 0px 0px 20px 0px rgb(51, 226, 245);
}

.heading {
	font-family: "Brush Script MT", cursive;
	padding-bottom: 15px;
	text-align: center;
	font-size: 30px;
	font-style: italic;
	color: blueviolet;
	text-decoration: underline wavy darkgray;
	text-shadow: 3px 3px 3px darkcyan;
}

.image {
    vertical-align: middle;
    border-style: inset;
    border-width: 5px;
    border-color: turquoise;
    border-radius: 20px;
}
</style>
</head>
<body>

	<%@ page import="java.sql.Connection"%>
	<%@ page import="java.sql.DriverManager"%>
	<%@ page import="java.sql.SQLException"%>
	<%@ page import="java.sql.ResultSet"%>
	<%@ page import="java.sql.Statement"%>
	<%@ page import="java.sql.PreparedStatement"%>
	<%@ page import="servlet_java.JdbcMySQLVersion"%>
	<%@ page import="java.util.logging.Level"%>
	<%@ page import="java.util.logging.Logger"%>
	
	<%@include file="header.jsp"%>
	
	<input type = "hidden" id = "status" value = "<%= request.getAttribute("cart_item_status") %>"> 
	<input type = "hidden" id = "new_status" value = "<%= request.getAttribute("search_item_status") %>"> 
	<input type = "hidden" id = "page_status" value = "<%= request.getAttribute("pagetn_item_status") %>"> 
	
	<div class="grid_container">
		<div class="cell" id="container_title">
			<h1 class="title">These products are added by the Shop Keeper</h1>
		</div>

		<h1 class="heading">Products</h1>

		<div
			style="font-family: 'Brush Script MT', cursive; font-size: 20px; align-item: center; align-self: center;">
			<table class="table_content">
				<!-- <caption style="color: darkorange; font-size: 30px;">Operations</caption> -->
				<tr>
					<th><a class="text_link" href="#">Item_Image</a></th>
					<th><a class="text_link" href="#">Item_Name</a></th>
					<th><a class="text_link" href="#">Item_Price</a></th>
					<th><a class="text_link" href="#">Item_Stock</a></th>
					<th><a class="text_link" href="#">Item_Description</a></th>
					<th><a class="text_link" href="#">Cart_Action</a></th>
				</tr>

				<%
				RequestDispatcher req_Dispatcher = null;
				int row_count = 0;
				
				int i_id;
				String i_name = "";
				String i_price = "";
				String i_stock = "";
				String i_description = "";
				String i_image = "";

				String url = "jdbc:mysql://localhost:3306/grocery_project?useSSL=false&useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC";
				String user = "root";
				String password = "katta@123";

				String select_query_for_table = "SELECT * FROM products_table";

				try {

					Class.forName("com.mysql.jdbc.Driver");
					Connection con = DriverManager.getConnection(url, user, password);

					Statement st_item_table = con.createStatement();

					// now we need the set the values of the parameters

					ResultSet res_set = st_item_table.executeQuery(select_query_for_table);

					if (!res_set.next()) {
						request.setAttribute("list_item_status", "no_items_exists");
						req_Dispatcher = request.getRequestDispatcher("customer_items.jsp");
						req_Dispatcher.forward(request, response);
					} else { 
						//row_count = prepst_emp_table.executeUpdate(); 
						i_id = res_set.getInt(1);
					i_name = res_set.getString(2);
					i_price = res_set.getString(3);
					i_stock = res_set.getString(4);
					i_description = res_set.getString(5);
					i_image = res_set.getString(6);
						%>
						
						<tr>
					<td><img class = "image" src=<%=i_image%> alt="Grocery image"
						title="Grocery Image" width="100" height="100"></td>
					<td><b style="color: brown;"> <%=i_name%>
					</b></td>
					<td><b style="color: brown;"> <%=i_price%>
					</b></td>
					<td><b style="color: brown;"> <%=i_stock%>
					</b></td>
					<td><b style="color: brown;"> <%=i_description%>
					</b></td>

					<td>
						<form style="color: blueviolet; font-size: 20px;" method="get"
							action="add_cart_item">

							<div>
								<input type = "hidden" id = "custname" name = "cust_name" value = "<%= session.getAttribute("name") %>">
								<input type = "hidden" id = "itemid" name = "item_id" value = "<%=i_id%>">
								<input type = "hidden" id = "itemname" name = "item_name" value = "<%=i_name%>">
								<label style="color: brown;" for="items"> Number of Items : </label> 
								<input type="number" name="no_of_items" id="items" placeholder="item to add to cart" required = "required">
							</div>

							<div>
								<input type="submit" id="sub" name="Submit" value="Add_to_cart"> <label for="sub" class="fa fa-shopping-cart"></label> 
							</div>
						</form>
					</td>
				</tr>

					<%	while (res_set.next()) {
					i_id = res_set.getInt(1);
					i_name = res_set.getString(2);
					i_price = res_set.getString(3);
					i_stock = res_set.getString(4);
					i_description = res_set.getString(5);
					i_image = res_set.getString(6);
				%>

				<tr>
					<td><img class = "image" src=<%=i_image%> alt="Grocery image"
						title="Grocery Image" width="100" height="100"></td>
					<td><b style="color: brown;"> <%=i_name%>
					</b></td>
					<td><b style="color: brown;"> <%=i_price%>
					</b></td>
					<td><b style="color: brown;"> <%=i_stock%>
					</b></td>
					<td><b style="color: brown;"> <%=i_description%>
					</b></td>

					<td>
						<form style="color: blueviolet; font-size: 20px;" method="get"
							action="add_cart_item">

							<div>
								<input type = "hidden" id = "custname" name = "cust_name" value = "<%= session.getAttribute("name") %>">
								<input type = "hidden" id = "itemid" name = "item_id" value = "<%=i_id%>">
								<input type = "hidden" id = "itemname" name = "item_name" value = "<%=i_name%>">
								<label style="color: brown;" for="items"> Number of Items : </label> 
								<input type="number" name="no_of_items" id="items" value = "" placeholder="item to add to cart" required = "required">
							</div>

							<div>
								<input type="submit" id="sub" name="Submit" value="Add_to_cart"> <label for="sub" class="fa fa-shopping-cart"></label> 
							</div>
						</form>
					</td>
				</tr>

				<%
				}
				}

				con.close();

				} catch (Exception ex) {
				// outpt.println("Welcome to the it_ass_8_database database where you can get
				// the selcted information based on the conditions \n Now, here are your
				// conditions : " + ex);
				
				Logger lgr = Logger.getLogger(JdbcMySQLVersion.class.getName());
				lgr.log(Level.SEVERE, ex.getMessage(), ex);
				}
				%>

			</table>
		</div>
	</div>
	
	<!-- JS -->
	<script src="vendor/jquery/jquery.min.js"></script>
	<script src="js/main.js"></script>
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	<link rel="stylesheet" href="alert/dist/sweetalert.css">
	
	<script type="text/javascript">
		var cart_status_code = document.getElementById("status").value; 
		var search_status = document.getElementById("new_status").value; 
		var page_status_code = document.getElementById("page_status").value;
		
		if ( cart_status_code == "invalid_qua") {
			swal("Sorry", "please enter the quantity of the item", "error");
		} 
		
		if ( cart_status_code == "no_item_exists") {
			swal("Sorry", "no item exits with this customer" + " <%= session.getAttribute("name") %>", "error");
		}
		
		if ( page_status_code == "no_item_exists") {
			swal("Sorry", "no item exits with this customer" + " <%= session.getAttribute("name") %>", "error");
		}
		
		if ( search_status == "invalid_search") {
			swal("Sorry", "Please enter something in the search input field", "error");
		} 
		
		if ( page_status_code == "invalid_search") {
			swal("Sorry", "Please enter something in the search input field", "error");
		} 
		
		if ( search_status == "no_item_exists") {
			swal("Sorry", "no item exits with this", "error");
		} 
		
		if ( cart_status_code == "added_sucessfully") {
			swal("congratulations", "The product inserted was to the cart successfully", "success");
		}
		
		if ( cart_status_code == "i_cart_qua" ) {
			swal("congratulations", "The number of products was added to the cart successfully", "success");
		} 
		
		if ( cart_status_code == "failed") {
			swal("Sorry", "please check the connection", "error");
		} 
		
		if ( cart_status_code == "user_not_exist") {
			swal("Sorry", "The customer does not exist", "error");
		} 
		
		if ( cart_status_code == "item_out_stock") {
			swal("Sorry", "you entered the items out of stock", "error");
		} 
		
		//document.getElementById("status").value = "";
	</script>

	<%@include file="footer.jsp"%>

</body>
</html>