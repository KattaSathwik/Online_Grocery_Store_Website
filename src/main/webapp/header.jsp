<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>header</title>
<!-- link for font -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script>
$(document).ready(function(){
  $("#search_btn").click(function(){
    //$(".search_form").css("background-color", "yellow");
    $("form").toggleClass("active");
  });
});
</script>

<style type="text/css">
@import
	url('https://fonts.googleapis.com/css2?family=Poppins:wght@300&display=swap')
	;

:root { -
	-green: rgb(87, 238, 180); -
	-black: black; -
	-light-col: rgb(241, 170, 47); -
	-box-shadow: 0 0.35rem 0.1rem gray; -
	-border: 2rem solid yellowgreen; -
	-outline: 0.5rem solid rgb(242, 71, 4);
}

* {
	font-family: 'Poppins', sans-serif;
	margin: 0;
	padding: 0;
	box-sizing: border-box;
	outline: none;
	border: none;
	text-decoration: none;
	text-transform: capitalize;
	transition: none .05s linear;
}

html {
	font-size: 55%;
	overflow-x: hidden;
	scroll-behavior: smooth;
	scroll-padding-top: 7rem;
}

.h_body {
	background-image:
		url("https://img.freepik.com/free-vector/white-transparent-hexagonal-shapes-banner_1017-20590.jpg?w=2000");
	background-size: auto;
	background-position: top;
	height: 100%;
	width: 100%;
	/*height: 100vh;*/
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: right;
	text-align: center;
	padding: 0;
	background-color: burlywood;
	background-repeat: inherit;
	opacity: 0.91;
}

.header {
	position: sticky;
	top: 0;
	right: 0;
	bottom: 0;
	display: flex;
	align-items: center;
	border: 1px solid coral;
	justify-content: space-between;
	padding: 2rem 10%;
	background-color: burlywood;
	box-shadow: var(- -box-shadow);
}

.header .logo {
	font-size: 4rem;
	font-weight: bold;
}

.header .logo i {
	color: var(- -green);
	font-size: 5rem;
}

.header .navbar a {
	font-size: 2.5rem;
	margin: 0 2rem;
	color: rgb(220, 99, 13);
}

.header .navbar a:hover {
	color: rgb(175, 242, 6);
}

.header .icons div {
	border: 1px solid brown;
	height: 4.5rem;
	width: 4.5rem;
	line-height: 4.5rem;
	margin: 0 0.2rem;
	border-radius: 0.5rem;
	background-color: rgb(240, 153, 40);
	color: brown;
	font-size: 2rem;
	margin-right: .3rem;
	text-align: center;
	cursor: pointer;
}

.header .icons div:hover {
	background-color: aqua;
	color: rgb(93, 5, 181);
}

#menu_btn {
	display: none;
}

.header .search_form {
	border: 1px solid goldenrod;
	position: absolute;
	top: 110%;
	right: 110%;
	width: 50rem;
	height: 4.5rem;
	background-color: blanchedalmond;
	border-radius: 0.5rem;
	overflow: hidden;
	display: flex;
	align-items: center;
	box-shadow: var(- -box-shadow);
}

.header .new_search_form {
	border: 1px solid goldenrod;
	position: absolute;
	top: 200%;
	right: 110%;
	width: 50rem;
	height: 4.5rem;
	background-color: blanchedalmond;
	border-radius: 0.5rem;
	overflow: hidden;
	display: flex;
	align-items: center;
	box-shadow: var(- -box-shadow);
}

.header .search_form.active {
	right: 2rem;
	transition: .05s linear;
}

.header .new_search_form.active {
	right: 2rem;
	transition: .05s linear;
}

.header .search_form input[type="search"] {
	height: 100%;
	width: 100%;
	background: none;
	/*text-transform: none;*/
	font-size: 1.5rem;
	color: brown;
	padding: 0 1.5rem;
}

.header .new_search_form input[type="search"] {
	height: 100%;
	width: 100%;
	background: none;
	/*text-transform: none;*/
	font-size: 1.5rem;
	color: brown;
	padding: 0 1.5rem;
}

.header .search_form label {
	font-size: 2.5rem;
	padding-right: 1.5rem;
	color: black;
	cursor: pointer;
}

.header .new_search_form label {
	font-size: 2.5rem;
	padding-right: 1.5rem;
	color: black;
	cursor: pointer;
}

.header .search_form label:hover {
	color: rgb(240, 89, 7);
}

.header .new_search_form label:hover {
	color: rgb(240, 89, 7);
}

input[id="sub"] {
	font-family: "Brush Script MT", cursive;
	font-size: 1.5rem;
	width: auto;
	background-color: greenyellow;
	color: mediumvioletred;
	border: 2px solid darkgray;
	border-radius: 10px;
	margin: 2px;
	outline: none;
	padding: 5px;
	box-sizing: border-box;
	transition: 0.1s;
}

input[id="sub"]:focus {
	border-color: deeppink;
	box-shadow: 0px 0px 20px 0px rgb(51, 226, 245);
}

</style>

</head>
<body class = "h_body">
	<!-- header -->
	<header class="header">
		<a href="#" class="logo"> <i class="fa fa-shopping-basket"
			aria-hidden="true"></i> Grocery
		</a>

		<nav class="navbar">
		<% if (session.getAttribute("name") != null) {%>
			<a href=<%
				if (session.getAttribute("p_pos").equals("shopkeeper") ) {
					out.print("shopkeeper_home.jsp");
				} else if ( session.getAttribute("p_pos").equals("customer") ) {
					out.print("person_profile.jsp");
				}
				%>>Home</a> 
		<%} else { %>
			<a href="login.jsp">Login</a> 
		<%} %>
		<% if (session.getAttribute("name") != null) {%>
			<a href="logout_servlet_page">Logout</a>
			<a href=<%
				if (session.getAttribute("p_pos").equals("shopkeeper") ) {
					out.print("shopkeeper_order_cond.jsp");
				} else if ( session.getAttribute("p_pos").equals("customer") ) {
					out.print("cust_orders.jsp");
				}
				%>>Orders</a>
			<a href=<%
				if (session.getAttribute("p_pos").equals("shopkeeper") ) {
					out.print("shopkeeper_items.jsp");
				} else if ( session.getAttribute("p_pos").equals("customer") ) {
					out.print("customer_items.jsp");
				}
				%>>Products</a> 
			<a href="#">
				<%
				if (session.getAttribute("name") != null) {
					out.print("welcome to grocery website " + " " + session.getAttribute("name"));
				}
				%>
			</a>
		<%} %>
		</nav>

		<div class="icons">
			<div class="fa fa-bars" id="menu_btn"></div>
			<% if (session.getAttribute("name") != null) {%>
			<div class="fa fa-search" id="search_btn"></div>
			
			<% if ( session.getAttribute("p_pos").equals("customer") ) { %>
			<a href="show_cart_items.jsp"> <div class="fa fa-shopping-cart" id="cart_btn"></div> </a> 
			<%} %>
			
			<a href=<%
					out.print("person_profile.jsp");
				%>> <div class="fa fa-user-o" id="user_btn"></div> </a> 
			<%} %>
		</div>
		
		<% if (session.getAttribute("name") != null) {%>
		<form method = "get" action=<%
				if (session.getAttribute("p_pos").equals("shopkeeper") ) {
					out.print("search_shopk_items.jsp");
				} else if ( session.getAttribute("p_pos").equals("customer") ) {
					out.print("search_cust_items.jsp");
				}
				%> class="search_form">
			<input type="search" name = "search_box_items" id="search_box_item" placeholder="search here for items" > &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
			<label for="search_box" class="fa fa-search"></label>
			<input type="submit" id="sub" name="Submit" value="search">
		</form>
		
		<form method = "get" action="pagenation_search_cust.jsp" class="new_search_form">
			<input type="search" name = "search_box_no_items" id="search_box_no_item" placeholder="search here number of items" > &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
			<label for="search_box" class="fa fa-search"></label>
			<input type="submit" id="sub" name="Submit" value="search">
		</form>
		<%} %>

	</header>
	
	<!--  <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.1/jquery.min.js" ></script>

	<script>
        let searchfrom = document.querySelector(".search_form");

        document.querySelector("#search_btn").onclick() = () => {
        	searchfrom.style.right = "2rem";
            //searchfrom.classList.toggle("active");
        }
    </script> -->

</body>
</html>