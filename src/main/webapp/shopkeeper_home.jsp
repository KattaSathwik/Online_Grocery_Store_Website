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
<title>Shop Keeper home page</title>

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
			margin: 25px auto;
			font-size: 20px;
			width : 90%;
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
		
		input[type=submit] {
			font-family: "Brush Script MT", cursive;
			font-size: 20px;
			width: auto;
			background-color: greenyellow;
			color: mediumvioletred;
			border: 2px solid darkgray;
			border-radius: 10px;
			margin: 5px;
			outline: none;
			padding: 10px;
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
</style>
</head>
<body>

<%@include file="header.jsp" %>

<div class="grid_container">	
		<div class="cell" id="container_title">
			<h1 class="title"> Shop Keeper home page where you can changes in the data base </h1>
		</div>
		
		<h1 class="heading">Operations</h1>
		
		<div style="font-family: 'Brush Script MT', cursive; font-size: 20px; align-item : center">
					<table class="table_content">
						 <!-- <caption style="color: darkorange; font-size: 30px;">Operations</caption> -->
  						<tr>
    						<th><a class="text_link" href="#">Description</a></th>
    						<th><a class="text_link" href="#">Action</a></th>
  						</tr>
  						<tr>
    						<td>Inorder to add an product in the groceries</td>
    						<td><a href = "add_item.jsp"><input type="submit" name="Add Item" value = "Add Item"></a></td>
  						</tr>
  						<tr>
    						<td>Inorder to update an product in the groceries</td>
    						<td><a href = "update_item.jsp"><input type="submit" name="Update Item" value = "Update Item"></a></td>
  						</tr>
  						<tr>
    						<td>Inorder to delete an product in the groceries</td>
    						<td><a href = "item_delete.jsp"><input type="submit" name="delete Item" value = "delete Item"></a></td>
  						</tr>
					</table>
				</div>
</div>

<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>

<%@include file="footer.jsp" %>

</body>
</html>