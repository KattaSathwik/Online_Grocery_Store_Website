
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
<title>home page</title>
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
@import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300&display=swap');

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
	transition: all .5s linear;
}

html {
	font-size: 50%;
	overflow-x: hidden;
	scroll-behavior: smooth;
	scroll-padding-top: 7rem;
}

body {
	background-image:
		url("https://img.freepik.com/free-vector/white-transparent-hexagonal-shapes-banner_1017-20590.jpg?w=2000");
	background-size: cover;
	background-position: center;
	height: 100%;
	width: 100%;
	/*height: 100vh;*/
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: right;
	text-align: center;
	padding: 0 2px;
	background-color: burlywood;
}

.header {
	position: relative;
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

.header .search_form.active {
	right: 2rem;
	transition: .1s linear;
}

.header .search_form input {
	height: 100%;
	width: 100%;
	background: none;
	text-transform: none;
	font-size: 1.5rem;
	color: black;
	padding: 0 1.5rem;
}

.header .search_form label {
	font-size: 2.5rem;
	padding-right: 1.5rem;
	color: black;
	cursor: pointer;
}

.header .search_form label:hover {
	color: rgb(240, 89, 7);
}

</style>

<!-- <script>
        let searchfrom = document.querySelector('.search_form');

        document.querySelector('#search_btn').onclick() = () => {
            searchfrom.classList.toggle('active');
        }
</script> -->

</head>
<body>
	<!-- header -->
	<header class="header">
		<a href="#" class="logo"> <i class="fa fa-shopping-basket"
			aria-hidden="true"></i> Grocery
		</a>

		<nav class="navbar">
			<a href="#Home">Home</a> 
			<a href="#Login">Login</a> 
			<a href="logout_servlet_page">Logout</a>
			<a href="#Products">Products</a> 
			<a href="#Products">
				<%
				if (session.getAttribute("name") != null) {
					out.print("welcome" + " " + session.getAttribute("name"));
				}
				%>
			</a>
		</nav>

		<div class="icons">
			<div class="fa fa-bars" id="menu_btn"></div>
			<div class="fa fa-search" id="search_btn"></div>
			<div class="fa fa-shopping-cart" id="cart_btn"></div>
			<div class="fa fa-user-o" id="user_btn"></div>
		</div>

		<form action="" class="search_form">
			<input type="search" id="search_box" placeholder="search here .....">
			<label for="search_box" class="fa fa-search"></label>
		</form>

	</header>

</body>
</html>