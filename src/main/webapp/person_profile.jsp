<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>customer profile</title>

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

		.image {
			border: 10px groove rosybrown;
			border-radius: 20px;
			align-items: center;
            margin: 50px auto;
		}
		
		.cell {
			border: 10px Ridge darkcyan;
			border-radius: 30px;
			background-color: lightpink;
			margin : 20px auto;
			padding-left : 10px;
			width : 30%;
		}
</style>
</head>
<body>

<%@include file="header.jsp"%>

	<input type = "hidden" id = "status" value = "<%= request.getAttribute("cust_order_item_status") %>">

	<div class="grid_container">
		<div class="cell" id="photo" style="padding-bottom: 100px;">
			<h1 class="heading"> welcome <%= session.getAttribute("name") + " as " + session.getAttribute("p_pos")%> : </h1>
			<hr style="margin-bottom: 10px; color : red;">
			<div class="text">
				<img class = "image" src="https://ps.w.org/user-avatar-reloaded/assets/icon-256x256.png?rev=2540745" alt="<%= session.getAttribute("name") %>" title="<%= session.getAttribute("name") %>" width="300" height="300">
				<p class="para" id="p1" style = "text-align: center; align-items: center; font-size : 30px;"> <b style="color: brown;">User Name : </b> <br>
<a class="text_link" href="#"> <%= session.getAttribute("name") %> </a> <br>
<b style="color: brown;">Position : </b><br>
<a class="text_link" href="#"> <%= session.getAttribute("p_pos") %> </a> <br> </p>
			</div>
		</div>
	</div>
	
	<br> <br> <br> <br> <br>
	
	<!-- JS -->
	<script src="vendor/jquery/jquery.min.js"></script>
	<script src="js/main.js"></script>
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	<link rel="stylesheet" href="alert/dist/sweetalert.css">
	
	<script type="text/javascript">
		var cust_order_status_code = document.getElementById("status").value; 
		
		if ( cust_order_status_code == "user_not_exist") {
			swal("Sorry", "The customer does not exist", "error");
		} 
		
		if ( cust_order_status_code == "no_item_exists") {
			swal("Sorry", "There are no items in the ordered table", "error");
		} 
		
		//document.getElementById("status").value = "";
	</script>

<%@include file="footer.jsp"%>
</body>
</html>