<%
if (session.getAttribute("name") != null) {
	response.sendRedirect("home.jsp");
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>log in form for groceries</title>

<!-- Font Icon -->
<link rel="stylesheet"
	href="fonts/material-icon/css/material-design-iconic-font.min.css">

<!-- Main css -->
<link rel="stylesheet" href="css/style.css">

<style>
input[type=text]:focus, input[type=password]:focus, select[name=select_pos]:focus {
				border-color: deeppink;
				box-shadow: 0px 0px 20px 20px greenyellow;
		}
</style>

</head>
<body>

	<%@include file="header.jsp" %>
	
	<input type = "hidden" id = "status" value = "<%= request.getAttribute("log_status") %>">
	<input type = "hidden" id = "delete_all_status" value = "<%= request.getAttribute("delete_all_cart_item_status") %>">

	<div class="main">

		<!-- Sing in  Form -->
		<section class="sign-in">
			<div class="container">
				<div class="signin-content" style = " padding-top: 47px;
    	padding-bottom: 58px;
    	padding-left: -41px;
    	padding-right: 50px;
    	margin: 150px auto;">
					<div class="signin-image">
						<figure>
							<img
								src="https://image.shutterstock.com/image-vector/family-shopping-cartoon-vector-illustration-260nw-1207934605.jpg"
								alt="grocery image" title="Grocery image" width="250"
								height="700">
						</figure>
						<a href="registration.jsp" class="signup-image-link">Create an
							account</a>
					</div>

					<div class="signin-form" style = "font-size: initial;">
						<h2 class="form-title">Login</h2>
						<form method="post" action="login_servlet_page" class="register-form" id="login-form">
							<div class="form-group">
								<label for="userposition"><i style="padding: 5px 10px;"
									class="zmdi zmdi-account material-icons-name"></i></label> <select
									style="padding: 7px 35px; border: 2px solid darkgray; border-radius: 10px; margin: 1px;"
									name="select_pos" id="userposition" class="form-select"
									aria-label="Default select example" placeholder="select name" >
									<option selected>select the position</option>
									<option value="customer">customer</option>
									<option value="shopkeeper">shopkeeper</option>
								</select>
							</div>
							<div class="form-group">
								<label for="username"><i
									class="zmdi zmdi-account material-icons-name"></i></label> <input
									type="text" name="username" id="username"
									placeholder="Your Name" />
							</div>
							<div class="form-group">
								<label for="password"><i class="zmdi zmdi-lock"></i></label> <input
									type="password" name="password" id="password"
									placeholder="Password" />
							</div>
							<div class="form-group">
								<input type="checkbox" name="remember-me" id="remember-me"
									class="agree-term" /> <label for="remember-me"
									class="label-agree-term"><span><span></span></span>Remember
									me</label>
							</div>
							<div class="form-group form-button">
								<input type="submit" name="signin" id="signin"
									class="form-submit" value="Log in" />
							</div>
						</form>
						<div class="social-login">
							<span class="social-label">Or login with</span>
							<ul class="socials">
								<li><a href="#"><i
										class="display-flex-center zmdi zmdi-facebook"></i></a></li>
								<li><a href="#"><i
										class="display-flex-center zmdi zmdi-twitter"></i></a></li>
								<li><a href="#"><i
										class="display-flex-center zmdi zmdi-google"></i></a></li>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</section>

	</div>
	
	<br><br>

	<!-- JS -->
	<script src="vendor/jquery/jquery.min.js"></script>
	<script src="js/main.js"></script>
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	<link rel="stylesheet" href="alert/dist/sweetalert.css">
	
	<script type="text/javascript">
		var new_status_code = document.getElementById("status").value; 
		var delete_all_status_code = document.getElementById("delete_all_status").value;
		
		if ( delete_all_status_code == "success") {
			swal("congratulations", "All the cart items were deleted and you are loged out sucessfully, Thanks for cisiting our website", "success");
		}
		
		if ( delete_all_status_code == "shopk_success") {
			swal("congratulations", "Shopkeeper you are loged out successfully", "success");
		}
		
		if ( delete_all_status_code == "new_success") {
			swal("congratulations", "You are loged out sucessfully, Thanks for cisiting our website", "success");
		}
		
		if ( delete_all_status_code == "failed") {
			swal("Sorry", "please check the username or password", "error");
		} 
		
		if ( new_status_code == "failed") {
			swal("Sorry", "please check the username or password", "error");
		} 
		
		if ( new_status_code == "invalid_username" ) {
			//alert ("please enter the user name");
			swal("Sorry", "please enter the user name", "error");
		}
		
		if ( new_status_code == "invalid_password") {
			//alert ("please enter the password");
			swal("Sorry", "please enter the password", "error");
		}
		
		if ( new_status_code == "invalid_position") {
			swal("Sorry", "please enter the position", "error");
		}
		
		document.getElementById("status").value = "";
	</script>
	
	<%@include file="footer.jsp" %>
	
</body>
<!-- This templates was made by Colorlib (https://colorlib.com) -->
</html>