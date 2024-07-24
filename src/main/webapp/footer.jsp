<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Insert title here</title>

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.1.3/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/ionicons/2.0.1/css/ionicons.min.css">
 <link rel="stylesheet" href="assets/css/style.css">

<style type="text/css">
.footer-clean {
	/*position: initial;*/
	position: inherit;
	/*position : absolute;*/
	/*position : fixed;*/
	/*min-height : 100vh;*/
	left : 0;
	right: 0;
	bottom: 0;
	display: flex;
	align-items: center;
	align-content: flex-end;
	text-align-last: auto;
	vertical-align: bottom;
	width:100%;
	border: 1px solid hwb(62 13% 3%);
	justify-content: space-between;
	background-color: rgb(33, 248, 116);
	color: rgb(243, 11, 26);
	margin : 0px;
}

.f_body {
min-height : 100vh;
top : 100%;
}

.end_footer {
	/*position : absolute;*/
	position : unset;
	top : 100%;
}

.footer-clean h3 {
	margin-top: 0;
	margin-bottom: 12px;
	font-weight: bold;
	font-size: 16px;
}

.footer-clean ul {
	padding: 0;
	list-style: none;
	line-height: 1.6;
	font-size: 14px;
	margin-bottom: 0;
}

.footer-clean ul a {
	color: inherit;
	text-decoration: none;
	opacity: 0.8;
}

.footer-clean ul a:hover {
	opacity: 1;
}

.footer-clean .item.social {
	text-align: right;
}

@media ( max-width :767px) {
	.footer-clean .item {
		text-align: center;
		padding-bottom: 20px;
	}
}

@media ( max-width : 768px) {
	.footer-clean .item.social {
		text-align: center;
	}
}

.footer-clean .item.social>a {
	font-size: 24px;
	width: 40px;
	height: 40px;
	line-height: 40px;
	display: inline-block;
	text-align: center;
	border-radius: 50%;
	border: 1px solid #ccc;
	margin-left: 10px;
	margin-top: 22px;
	color: inherit;
	opacity: 0.75;
}

.footer-clean .item.social>a:hover {
	opacity: 0.9;
}

@media ( max-width :991px) {
	.footer-clean .item.social>a {
		margin-top: 40px;
	}
}

@media ( max-width :767px) {
	.footer-clean .item.social>a {
		margin-top: 10px;
	}
}

.footer-clean .copyright {
	margin-top: 14px;
	margin-bottom: 0;
	font-size: 13px;
	opacity: 0.6;
}
</style>
</head>
<body class = "f_body">
	<div class="footer-clean">
		<footer class = "end_footer" style = "width : 100%">
			<div class="container">
				<div class="row justify-content-center">
					<div class="col-sm-4 col-md-3 item">
						<h3>Services</h3>
						<ul>
							<li><a href="#">Web design</a></li>
							<li><a href="#">Development</a></li>
							<li><a href="#">Hosting</a></li>
						</ul>
					</div>
					<div class="col-sm-4 col-md-3 item">
						<h3>About</h3>
						<ul>
							<li><a href="#">Company</a></li>
							<li><a href="#">Team</a></li>
							<li><a href="#">Legacy</a></li>
						</ul>
					</div>
					<div class="col-sm-4 col-md-3 item">
						<h3>Careers</h3>
						<ul>
							<li><a href="#">Job openings</a></li>
							<li><a href="#">Employee success</a></li>
							<li><a href="#">Benefits</a></li>
						</ul>
					</div>
					<div class="col-lg-3 item social">
						<a href="#"><i class="icon ion-social-facebook"></i></a><a
							href="#"><i class="icon ion-social-twitter"></i></a><a href="#"><i
							class="icon ion-social-snapchat"></i></a><a href="#"><i
							class="icon ion-social-instagram"></i></a>
						<p class="copyright">Company Name © 2018</p>
					</div>
				</div>
			</div>
		</footer>
	</div>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.1.3/js/bootstrap.bundle.min.js"></script>
</body>
</html>