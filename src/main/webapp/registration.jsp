<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>Sign Up Form by Colorlib</title>

<!-- Font Icon -->
<link rel="stylesheet"
	href="fonts/material-icon/css/material-design-iconic-font.min.css">

<!-- Main css -->
<link rel="stylesheet" href="css/style.css">

<style>
input[type=text]:focus, input[type=password]:focus, select[name=select_pos]:focus {
				border-color: deeppink;
				box-shadow: 20px 20px 20px 20px green;
		}
</style>

</head>
<body>

<%@include file="header.jsp" %>
<input type = "hidden" id = "status" value = "<%= request.getAttribute("reg_status") %>">


	<div class="main">

		<!-- Sign up form -->
		<section class="signup">
			<div class="container">
				<div class="signup-content" style = "padding : 0px; margin: 100px auto;">
					<div class="signup-form" style = "font-size: initial;">
						<h2 class="form-title">Sign up</h2>
					
						<form method="post" action="registration_servlet_page" class="register-form"
							id="register-form">
							<div class="form-group">
								<label for="userposition"><i style="padding: 5px 10px;"
									class="zmdi zmdi-account material-icons-name"></i></label> <select
									style="padding: 5px 50px; border: 2px solid darkgray; border-radius: 10px; margin: 5px;"
									name="select_pos" id="userposition" class="form-select"
									aria-label="Default select example" placeholder="select name">
									<option selected>select the position</option>
									<option value="customer">customer</option>
									<option value="shopkeeper">shopkeeper</option>
								</select>
							</div>
							<div class="form-group">
								<label for="name"><i
									class="zmdi zmdi-account material-icons-name"></i></label> <input
									type="text" name="name" id="name" placeholder="Your Name" />
							</div>
							<div class="form-group">
								<label for="email"><i class="zmdi zmdi-email"></i></label> <input
									type="email" name="email" id="email" placeholder="Your Email" />
							</div>
							<div class="form-group">
								<label for="pass"><i class="zmdi zmdi-lock"></i></label> <input
									type="password" name="pass" id="pass" placeholder="Password" />
							</div>
							<div class="form-group">
								<label for="re-pass"><i class="zmdi zmdi-lock-outline"></i></label>
								<input type="password" name="re_pass" id="re_pass"
									placeholder="Repeat your password" />
							</div>
							<div class="form-group">
								<label for="contact"><i class="zmdi zmdi-lock-outline"></i></label>
								<input type="text" name="contact" id="contact"
									placeholder="Contact no" />
							</div>
							<div class="form-group">
								<input type="checkbox" name="agree-term" id="agree-term"
									class="agree-term" /> <label for="agree-term"
									class="label-agree-term"><span><span></span></span>I
									agree all statements in <a href="#" class="term-service">Terms
										of service</a></label>
							</div>
							<div class="form-group form-button">
								<input type="submit" name="signup" id="signup"
									class="form-submit" value="Register" />
							</div>
						</form>
					</div>
					<div class="signup-image">
						<figure>
							<img src="https://i.pinimg.com/736x/5d/a4/da/5da4da1ad05663387e1c4fd0c5e1e212.jpg" title = "grocery" width="250"
								height="700" alt="grocery image" style = "margin: 150px auto;">
						</figure>
						<a href="login.jsp" class="signup-image-link">I am already
							member</a>
					</div>
				</div>
			</div>
		</section>


	</div>
	<!-- JS -->
	<script src="vendor/jquery/jquery.min.js"></script>
	<script src="js/main.js"></script>
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	<link rel="stylesheet" href="alert/dist/sweetalert.css">
	
	<script type="text/javascript">
		var status_code = document.getElementById("status").value; 
		
		if ( status_code == "success") {
			swal("congratulations", "Your account was created successfully", "success");
		} else if ( status_code == "failed") {
			swal("sorry", "There was some error", "error");
		}
		
		if ( status_code == "invalid_username") {
			swal("Sorry", "please enter the user name", "error");
		}
		
		if ( status_code == "invalid_email") {
			swal("Sorry", "please enter the email id", "error");
		}
		
		if ( status_code == "invalid_password") {
			swal("Sorry", "please enter the password", "error");
		}
		
		if ( status_code == "invalid_password_match") {
			swal("Sorry", "the password does not match", "error");
		}
		
		if ( status_code == "invalid_contact") {
			swal("Sorry", "please enter the user contact", "error");
		}
		
		if ( status_code == "invalid_contact_match") {
			swal("Sorry", "enter the correct mobile number", "error");
		}
		
		if ( status_code == "invalid_position") {
			swal("Sorry", "please enter the position", "error");
		}
		
		if ( status_code == "already_exixts") {
			swal("Sorry", "you are already registered", "error");
		}
	</script>

<%@include file="footer.jsp" %>
</body>
<!-- This templates was made by Colorlib (https://colorlib.com) -->
</html>