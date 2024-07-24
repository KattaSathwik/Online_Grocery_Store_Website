<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>shopkeeper can update item</title>
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
		
		input[type=text], input[type=number] {
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
			margin-left: 800px;
			outline: none;
			padding: 10px;
			box-sizing: border-box;
			transition: 0.2s;
		}

		input[type=text]:focus, input[type=number]:focus, input[type=submit]:focus {
				border-color: deeppink;
				box-shadow: 0px 0px 5px 4px greenyellow;
		}
</style>
</head>
<body>

<%@include file="header.jsp" %>
	
	<input type = "hidden" id = "status" value = "<%= request.getAttribute("update_item_status") %>">

	<div class="cell" id="comments">
			<h1 class="heading">Form inorder to update the item in the table</h1>
			<hr style="margin-bottom: 10px;">

			<div>
				<fieldset style="border: 5px groove deeppink; border-radius: 20px; padding: 10px; width: 80%; justify-content: center; align-items: center; margin: 10px 100px;">
					<legend style="color: blueviolet; font-size: 30px;">Update Form</legend>
					<form style="color: blueviolet; font-size: 20px;" method="get" action="update_item_servlet">
					
					<div>
						<label style="color: brown;" for="id"> Item Id : </label>
						<input type="number" name="item_id" id="id" placeholder="Enter the id of the item">
					</div><br>

					<div>
						<label style="color: brown;" for="name"> Item Name : </label>
						<input type="text" name="item_name" id="name" placeholder="Enter the item name">
					</div><br>

					<div>
						<label style="color: brown;" for="price"> Item price : </label>
						<input type="text" name="item_price" id="price" placeholder="Enter the item price">
					</div><br>

					<div>
						<label style="color: brown;" for="stock"> Item Quantity : </label>
						<input type="text" name="item_stock" id="stock" placeholder="Enter the item stock">
					</div><br>
					
					<div>
						<label style="color: brown;" for="desc"> Item description : </label>
						<input type="text" name="item_desc" id="desc" placeholder="Enter the item description">
					</div><br>
					
					<div>
						<label style="color: brown;" for="img"> Item Image : </label>
						<input type="text" name="item_img" id="img" placeholder="Enter the item image">
					</div><br>

					<!-- <div>
						<label style="color: brown;" for="Select"> Which category are you : </label>
						<select name="Select" id="Select">
							<option value="Student">Student</option>
							<option value="TA">TA</option>
							<option value="Professor">Professor</option>
						</select>
					</div><br>

					<label style="color: brown;" for="Comments"> Please enter the comments : </label>
					<div>
						<textarea name="Comments" id="Comments" rows="20" cols="30" placeholder="Enter the comments"></textarea>
					</div><br> -->

					<div>
						<input type="submit" name="Submit" value = "Update Item">
					</div>
				</form>
				</fieldset>
			</div>
		</div>
		
		<br><br><br><br><br>
		
		<!-- JS -->
	<script src="vendor/jquery/jquery.min.js"></script>
	<script src="js/main.js"></script>
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	<link rel="stylesheet" href="alert/dist/sweetalert.css">
	
	<script type="text/javascript">
		var update_status_code = document.getElementById("status").value; 
		
		if ( update_status_code == "success") {
			swal("congratulations", "The product was updated successfully", "success");
		} 
		
		if ( update_status_code == "failed") {
			swal("Sorry", "please check the name of the item", "error");
		} 
		
		/*if ( update_status_code == "already_exixts") {
			swal("Sorry", "The item already exists", "error");
		}*/
		
		if ( update_status_code == "invalid_id" ) {
			//alert ("please enter the user name");
			swal("Sorry", "please enter the id of the item", "error");
		}
		
		if ( update_status_code == "id_not_exist" ) {
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
		
		update_status_code = "";
		document.getElementById("status").value = "";
	</script>

<%@include file="footer.jsp" %>

</body>
</html>