<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<c:url var="home" value="/" scope="request" />
<title>TITLE</title>
<link href="<spring:url htmlEscape="true" value="/resources/ico/favicon.ico" />" rel="shortcut icon">
<link href="<spring:url htmlEscape="true" value="/resources/css/jquery-ui.min.css" />" rel="stylesheet">
<link href="<spring:url htmlEscape="true" value="/resources/css/bootstrap.min.css" />" rel="stylesheet" id="bootstrap-css">
<link href="<spring:url htmlEscape="true" value="/resources/css/bootstrap-select.min.css" />" rel="stylesheet">
<link href="<spring:url htmlEscape="true" value="/resources/css/site.css" />" rel="stylesheet">
<link href="<spring:url htmlEscape="true" value="/resources/css/site2.css" />" rel="stylesheet">

<script src="<spring:url htmlEscape="true" value="/resources/js/variables.js" />"></script>
<script src="<spring:url htmlEscape="true" value="/resources/js/components.js" />"></script>
<script>
	contexPath = "${pageContext.servletContext.contextPath}";
</script>
<style type="text/css">
* {
	box-sizing: border-box;
}

body {
	font-family: sans-serif;
}

/* ---- grid ---- */
.grid {
	background: #EEE;
	max-width: 1200px;
}

/* clearfix */
.grid:after {
	content: '';
	display: block;
	clear: both;
}

/* ---- grid-item ---- */
.grid-item {
	width: 160px;
	height: 120px;
	float: left;
	background: #D26;
	border: 2px solid #333;
	border-color: hsla(0, 0%, 0%, 0.5);
	border-radius: 5px;
}

.grid-item--width2 {
	width: 320px;
}

.grid-item--width3 {
	width: 480px;
}

.grid-item--width4 {
	width: 640px;
}

.grid-item--height2 {
	height: 200px;
}

.grid-item--height3 {
	height: 260px;
}

.grid-item--height4 {
	height: 360px;
}

.grid-item--gigante {
	width: 320px;
	height: 360px;
}

.grid-item:hover {
	background: #A2C;
	border-color: white;
	cursor: pointer;
}
</style>
</head>

<body style="">
	<div class="navbar navbar-default navbar-static-top">
		<div class="container-fluid">
			<div class="navbar-header">
				<a class="navbar-brand" href="#"> <strong>[COMPANY]</strong>
				</a>
			</div>
			<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
				<ul class="nav navbar-nav navbar-right">
					<li class="dropdown ">
						<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"> Настройки <span class="caret"></span>
						</a>
						<ul class="dropdown-menu" role="menu">
							<li class="dropdown-header">Настройки</li>
							<li class=""></li>
							<li class="">
								<a href="<spring:url value="/home" htmlEscape="true" />">test</a>
							</li>
							<li class="divider"></li>
							<li>
								<a href="<spring:url value="/home" htmlEscape="true" />">test</a>
							</li>
						</ul>
					</li>
				</ul>
			</div>
		</div>
	</div>
	<div class="container-fluid main-container">
		<div class="col-md-2 sidebar">
			<div class="row">
				<!-- uncomment code for absolute positioning tweek see top comment in css -->
				<div class="absolute-wrapper"></div>
				<!-- Menu -->
				<div class="side-menu">
					<nav class="navbar navbar-default" role="navigation">
						<!-- Main Menu -->
						<div class="side-menu-container">
							<ul class="nav navbar-nav">
								<li class="">
									<spring:url value="/home" var="homeUrl" htmlEscape="true" />
									<a href="${pageName eq 'home' ? '#' : homeUrl}"> <span class="glyphicon glyphicon-dashboard"></span> Dashboard
									</a>
								</li>
								<li class="active">
									<spring:url value="/photo" var="photoUrl" htmlEscape="true" />
									<a href="${pageName eq 'photo' ? '#' : photoUrl}"> <span class="glyphicon glyphicon-signal"></span> Фото
									</a>
								</li>
							</ul>
						</div>
						<!-- /.navbar-collapse -->
					</nav>
				</div>
			</div>
		</div>
		<div class="col-md-10 content">
			<div class="panel panel-default">
				<div class="panel-heading"></div>
				<div class="panel-body">
					<h1>Masonry - layout method</h1>
					<p>Click to toggle item size</p>
					<div class="grid">
						<div class="grid-item"></div>
						<div class="grid-item grid-item--width2 grid-item--height2"></div>
						<div class="grid-item grid-item--height3"></div>
						<div class="grid-item grid-item--height2"></div>
						<div class="grid-item grid-item--width3"></div>
						<div class="grid-item"></div>
						<div class="grid-item"></div>
						<div class="grid-item grid-item--height2"></div>
						<div class="grid-item grid-item--width2 grid-item--height3"></div>
						<div class="grid-item"></div>
						<div class="grid-item grid-item--height2"></div>
						<div class="grid-item"></div>
						<div class="grid-item grid-item--width2 grid-item--height2"></div>
						<div class="grid-item grid-item--width2"></div>
						<div class="grid-item"></div>
						<div class="grid-item grid-item--height2"></div>
						<div class="grid-item"></div>
						<div class="grid-item"></div>
						<div class="grid-item grid-item--height3"></div>
						<div class="grid-item grid-item--height2"></div>
						<div class="grid-item"></div>
						<div class="grid-item"></div>
						<div class="grid-item grid-item--height2"></div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<script src="<spring:url htmlEscape="true" value="/resources/js/jquery-1.11.3.min.js" />"></script>
	<script src="<spring:url htmlEscape="true" value="/resources/js/jquery-ui.min.js" />"></script>
	<script src="<spring:url htmlEscape="true" value="/resources/js/bootstrap.min.js" />"></script>
	<script src="<spring:url htmlEscape="true" value="/resources/js/bootstrap-select.min.js" />"></script>

	<script src="//cdnjs.cloudflare.com/ajax/libs/jquery-infinitescroll/2.0b2.120519/jquery.infinitescroll.min.js"></script>
	<script src="//cdnjs.cloudflare.com/ajax/libs/masonry/3.1.2/masonry.pkgd.js"></script>
	<script src="//cdnjs.cloudflare.com/ajax/libs/jquery.imagesloaded/3.0.4/jquery.imagesloaded.min.js"></script>

	<script type="text/javascript">
		$(document).ready(function() {
			var $grid = $('.grid').masonry({
				itemSelector : '.grid-item',
				columnWidth : 160
			});

			$grid.on('click', '.grid-item', function() {
				// change size of item via class
				$(this).toggleClass('grid-item--gigante');
				// trigger layout
				$grid.masonry();
			});
		});
	</script>
</body>
</html>




