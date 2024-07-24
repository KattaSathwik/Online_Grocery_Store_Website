<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cart Items</title>
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
	
	<input type = "hidden" id = "status" value = "<%= request.getAttribute("delete_cart_item_status") %>">
	<input type = "hidden" id = "order_status" value = "<%= request.getAttribute("order_item_status") %>">

	<div class="grid_container">
		<div class="cell" id="container_title">
			<h1 class="title">These products are added in to cart</h1>
		</div>

		<h1 class="heading"> Cart Items </h1>

		<div
			style="font-family: 'Brush Script MT', cursive; font-size: 20px; align-item: center; align-self: center;">
			<table class="table_content">
				<!-- <caption style="color: darkorange; font-size: 30px;">Operations</caption> -->
				<tr>
					<th><a class="text_link" href="#">Item_Image</a></th>
					<th><a class="text_link" href="#">Item_Id</a></th>
					<th><a class="text_link" href="#">Item_Name</a></th>
					<th><a class="text_link" href="#">Item_Price</a></th>
					<th><a class="text_link" href="#">Item Quantity</a></th>
					<th><a class="text_link" href="#">Item_Total_Price</a></th>
					<th><a class="text_link" href="#">Customer_Id</a></th>
					<th><a class="text_link" href="#">Cart_added_date</a></th>
					<th><a class="text_link" href="#">Cart_Action</a></th>
				</tr>

				<%
				RequestDispatcher req_Dispatcher = null;
				int row_count = 0;
				
				int cart_id;
				int i_id;
				String i_name = "";
				String i_price = "";
				String i_qua = "";
				int item_total_price;
				int item_total_price_cnt = 0;
				int cust_id = -1;
				String cart_add_date = "";
				String i_image = "";
         		
				
				String url = "jdbc:mysql://localhost:3306/grocery_project?useSSL=false&useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC";
				String user = "root";
				String password = "katta@123";
				
				String select_query_for_cust_table = "SELECT * FROM loged_persons_table WHERE p_name = ?";
				String select_query_for_table = "SELECT * FROM cart_table WHERE customer_id = ?";

				try {

					Class.forName("com.mysql.jdbc.Driver");
					Connection con = DriverManager.getConnection(url, user, password);

					// now we need the set the values of the parameters
					
					PreparedStatement select_prepst_cust_table = con.prepareStatement(select_query_for_cust_table);
			
					select_prepst_cust_table.setString(1, session.getAttribute("name").toString() );
			
					ResultSet res_set_cust = select_prepst_cust_table.executeQuery();
			
					if ( res_set_cust.next() ) {
						cust_id = res_set_cust.getInt(1);
					} else {
						request.setAttribute("cart_item_status", "user_not_exist");
						req_Dispatcher = request.getRequestDispatcher("customer_items.jsp");
						req_Dispatcher.forward(request, response);
					}
					
					PreparedStatement select_prepst_cart_table = con.prepareStatement(select_query_for_table);
					
					select_prepst_cart_table.setInt(1, cust_id);

					ResultSet res_set = select_prepst_cart_table.executeQuery();

					if (!res_set.next()) {
						request.setAttribute("cart_item_status", "no_item_exists");
						req_Dispatcher = request.getRequestDispatcher("customer_items.jsp");
						req_Dispatcher.forward(request, response);
					} else { 
						//row_count = prepst_emp_table.executeUpdate(); 
						cart_id = res_set.getInt(1);
						i_id = res_set.getInt(2);
						i_name = res_set.getString(3);
						i_price = res_set.getString(4);
						i_qua = res_set.getString(5);
						item_total_price = Integer.parseInt( res_set.getString(7) );
						item_total_price_cnt += item_total_price;
						cust_id = res_set.getInt(8);
						cart_add_date = res_set.getString(9);
						i_image = res_set.getString(6);
						%>
						
						<tr>
					<td><img class = "image" src=<%=i_image%> alt="Grocery image"
						title="Grocery Image" width="100" height="100"></td>
						<td><b style="color: brown;"> <%=i_id%>
					</b></td>
					<td><b style="color: brown;"> <%=i_name%>
					</b></td>
					<td><b style="color: brown;"> <%=i_price%>
					</b></td>
					<td><b style="color: brown;"> <%=i_qua%>
					</b></td>
					<td><b style="color: brown;"> <%=item_total_price%>
					</b></td>
					<td><b style="color: brown;"> <%=cust_id%>
					</b></td>
					<td><b style="color: brown;"> <%=cart_add_date%>
					</b></td>

					<td>
						<form style="color: blueviolet; font-size: 20px;" method="get"
							action="delete_cart_item">

							<div>
								<input type = "hidden" id = "cartid" name = "cart_id" value = "<%=cart_id%>">
							</div>

							<div>
								<input type="submit" id="sub" name="Submit" value="delete_item"> <label for="sub" class="fa fa-trash"></label> 
							</div>
						</form>
					</td>
				</tr>

					<%	while (res_set.next()) {
						cart_id = res_set.getInt(1);
						i_id = res_set.getInt(2);
						i_name = res_set.getString(3);
						i_price = res_set.getString(4);
						i_qua = res_set.getString(5);
						item_total_price = Integer.parseInt( res_set.getString(7) );
						item_total_price_cnt += item_total_price;
						cust_id = res_set.getInt(8);
						cart_add_date = res_set.getString(9);
						i_image = res_set.getString(6);
				%>

				<tr>
					<td><img class = "image" src=<%=i_image%> alt="Grocery image"
						title="Grocery Image" width="100" height="100"></td>
						<td><b style="color: brown;"> <%=i_id%>
					</b></td>
					<td><b style="color: brown;"> <%=i_name%>
					</b></td>
					<td><b style="color: brown;"> <%=i_price%>
					</b></td>
					<td><b style="color: brown;"> <%=i_qua%>
					</b></td>
					<td><b style="color: brown;"> <%=item_total_price%>
					</b></td>
					<td><b style="color: brown;"> <%=cust_id%>
					</b></td>
					<td><b style="color: brown;"> <%=cart_add_date%>
					</b></td>

					<td>
						<form style="color: blueviolet; font-size: 20px;" method="get"
							action="delete_cart_item">

							<div>
								<input type = "hidden" id = "cartid" name = "cart_id" value = "<%=cart_id%>">
							</div>

							<div>
								<input type="submit" id="sub" name="Submit" value="delete_item"> <label for="sub" class="fa fa-trash"></label> 
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
			
			<h1 class="heading"> Total Price of the items : <%= item_total_price_cnt %> </h1>
			<form style="color: blueviolet; font-size: 20px;" method="post"
							action="create_order_table">

							<div>
								<input type="submit" id="sub" name="Submit" value="Order"> <label for="sub" class="fa fa-credit-card"></label> 
							</div>
						</form>
		</div>
	</div>
	
	<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
	
	<!-- JS -->
	<script src="vendor/jquery/jquery.min.js"></script>
	<script src="js/main.js"></script>
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	<link rel="stylesheet" href="alert/dist/sweetalert.css">
	
	<script type="text/javascript">
		var cart_status_code = document.getElementById("status").value; 
		var order_status_code = document.getElementById("order_status").value;
		
		if ( cart_status_code == "success") {
			swal("congratulations", "The product was deleted from the cart successfully", "success");
		}
		
		if ( order_status_code == "successfully_added") {
			swal("congratulations", "All the products was added to the orders list successfully", "success");
		} 
		
		if ( order_status_code == "prob_updated_successfully") {
			swal("congratulations", "All the products was updated in product list successfully", "success");
		} 
		
		if ( order_status_code == "updated_inserted_successfully") {
			swal("congratulations", "Some of the products were inserted and updated to the orders list successfully", "success");
		}
		
		if ( order_status_code == "updated_successfully") {
			swal("congratulations", "Some of the products were updated to the orders list successfully", "success");
		}
		
		if ( order_status_code == "inserted_successfully") {
			swal("congratulations", "Some of the products were inserted to the orders list successfully", "success");
		}
		
		if ( cart_status_code == "failed") {
			swal("Sorry", "please check the connection", "error");
		} 
		
		if ( order_status_code == "no_item_exists") {
			swal("Sorry", "No items exists in the cart", "error");
		} 
		
		if ( cart_status_code == "invalid_cart_id") {
			swal("Sorry", "please check the cart id", "error");
		}
		
		if ( order_status_code == "user_not_exist") {
			swal("Sorry", "The user not exist", "error");
		} 
		
		if ( order_status_code == "item_out_stock") {
			swal("Sorry", "The items were out of stock", "error");
		} 
		
		document.getElementById("status").value = "";
	</script>

	<%@include file="footer.jsp"%>

</body>
</html>