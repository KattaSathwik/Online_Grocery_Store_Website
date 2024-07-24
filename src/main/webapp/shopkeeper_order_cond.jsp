<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>items ordered by customers</title>

<style type="text/css">
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
		
		input[type=number], input[type=date]{
			font-family: "Brush Script MT", cursive;
			font-size: 20px;
			width: 80%;
			border: 2px solid darkgray;
			border-radius: 10px;
			margin: 5px;
			outline: none;
			padding: 10px;
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
			margin: 5px;
			margin-left: 530px;
			outline: none;
			padding: 10px;
			box-sizing: border-box;
			transition: 0.2s;
			opacity: 0.7;
		}

		input[type=number]:focus, input[type=submit]:focus {
				border-color: deeppink;
				box-shadow: 0px 0px 5px 4px greenyellow;
		}
</style>

</head>
<body>

<%@include file="header.jsp" %>
	
	<input type = "hidden" id = "status" value = "<%= request.getAttribute("delete_item_status") %>"> 
	<input type = "hidden" id = "shopk_status" value = "<%= request.getAttribute("shopk_order_item_status") %>"> 
	<input type = "hidden" id = "shopk_id_status" value = "<%= request.getAttribute("shopk_id_order_item_status") %>"> 
	<input type = "hidden" id = "shopk_date_status" value = "<%= request.getAttribute("shopk_date_order_item_status") %>">
	
	<div class="cell" id="comments">
			<h1 class="heading">Form inorder to select the orderd items between the dates : </h1>
			<hr style="margin-bottom: 10px; color: orange;"> <br> <br> <br> <br>

			<div>
				<fieldset style="border: 5px groove deeppink; border-radius: 20px; padding: 10px; width: 80%; justify-content: center; align-items: center; margin: 10px 100px;">
					<legend style="color: blueviolet; font-size: 30px;">Order Form By In Between Dates</legend>
					<form style="color: blueviolet; font-size: 20px;" method="get" action="shopkeeper_select_orders.jsp">
					
					<div>
						<label style="color: brown;" for="srt_date"> Start Date : </label>
						<input type="date" name="start_date" id="srt_date" required = "required">
					</div> <br> 
					
					<div>
						<label style="color: brown;" for="enddate"> End Date : </label>
						<input type="date" name="end_date" id="enddate" required = "required">
					</div> <br> 

					<div>
						<input type="submit" name="Submit" value = "Select Orders">
					</div>
				</form>
				</fieldset>
			</div>
			
			
			<div>
				<fieldset style="border: 5px groove deeppink; border-radius: 20px; padding: 10px; width: 80%; justify-content: center; align-items: center; margin: 10px 100px;">
					<legend style="color: blueviolet; font-size: 30px;">Order Form By Id</legend>
					<form style="color: blueviolet; font-size: 20px;" method="get" action="shopkeeper_select_orders_by_id.jsp">
					
					<div>
						<label style="color: brown;" for="custid"> Enter the customer Id : </label>
						<input type="number" name="cust_id" id="custid" required = "required">
					</div> <br>  

					<div>
						<input type="submit" name="Submit" value = "Select Orders">
					</div>
				</form>
				</fieldset>
			</div>
			
			<div>
				<fieldset style="border: 5px groove deeppink; border-radius: 20px; padding: 10px; width: 80%; justify-content: center; align-items: center; margin: 10px 100px;">
					<legend style="color: blueviolet; font-size: 30px;">Order Form By Date</legend>
					<form style="color: blueviolet; font-size: 20px;" method="get" action="shopkeeper_select_orders_by_date.jsp">
					
					<div>
						<label style="color: brown;" for="entdate"> Enter the Date : </label>
						<input type="date" name="ent_date" id="entdate" required = "required">
					</div> <br>

					<div>
						<input type="submit" name="Submit" value = "Select Orders">
					</div>
				</form>
				</fieldset>
			</div>
			
			<br> <br> <br> <br> <br> <br> <br> <br> <br> <br> <br> <br> <br> <br> <br> <br> <br> <br> <br> <br> <br> <br> <br> <br> <br> <br> <br> <br> <br> <br> <br> <br> <br> <br> <br> <br> <br> <br> <br> <br> <br> <br>
		</div>
		
		<!-- JS -->
	<script src="vendor/jquery/jquery.min.js"></script>
	<script src="js/main.js"></script>
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	<link rel="stylesheet" href="alert/dist/sweetalert.css">
	
	<script type="text/javascript">

		var delete_status_code = document.getElementById("status").value; 
		var shopk_order_status_code = document.getElementById("shopk_status").value; 
		var shopk_id_order_status_code = document.getElementById("shopk_id_status").value; 
		var shopk_date_order_status_code = document.getElementById("shopk_date_status").value;
		
		if ( shopk_id_order_status_code == "cust_invalid_id") {
			//alert("Please enter the id of the customer");
			swal("Sorry", "Please enter the id of the customer", "error");
		} 
		
		if ( shopk_order_status_code == "no_item_exists") {
			swal("Sorry", "There are no items exist in between these dates", "error");
		} 
		
		if ( shopk_id_order_status_code == "no_item_exists") {
			swal("Sorry", "No records are there with this customer id", "error");
		} 
		
		if ( shopk_date_order_status_code == "no_item_exists") {
			swal("Sorry", "No records are there with this customer id", "error");
		} 
		
		if ( delete_status_code == "success") {
			swal("congratulations", "The product was deleted successfully", "success");
		} 
		
		if ( delete_status_code == "failed") {
			swal("Sorry", "please check the id of the item", "error");
		} 
		
		/*if ( update_status_code == "already_exixts") {
			swal("Sorry", "The item already exists", "error");
		}*/
		
		if ( delete_status_code == "invalid_id" ) {
			//alert ("please enter the user name");
			swal("Sorry", "please enter the id of the item", "error");
		}
		
		if ( delete_status_code == "id_not_exist" ) {
			//alert ("please enter the user name");
			swal("Sorry", "please enter valid id of the item", "error");
		}
		
		/*if ( update_status_code == "invalid_name" ) {
			//alert ("please enter the user name");
			swal("Sorry", "please enter the name of the item", "error");
		}
		
		if ( update_status_code == "invalid_price") {
			//alert ("please enter the password");
			swal("Sorry", "please enter the price of the item", "error");
		}
		
		if ( update_status_code == "invalid_stock") {
			swal("Sorry", "please enter the stock of the item", "error");
		}
		
		if ( update_status_code == "invalid_description") {
			swal("Sorry", "please enter the description of the item", "error");
		}
		
		if ( update_status_code == "invalid_image") {
			swal("Sorry", "please enter the image of the item", "error");
		}*/
		
		delete_status_code = "";
		document.getElementById("status").value = "";
	</script>
	
	<% request.removeAttribute("delete_item_status"); %>

<%@include file="footer.jsp" %>

</body>
</html>