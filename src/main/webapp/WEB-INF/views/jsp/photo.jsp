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

<script src="<spring:url htmlEscape="true" value="/resources/js/variables.js" />"></script>
<script src="<spring:url htmlEscape="true" value="/resources/js/components.js" />"></script>
<script>
	contexPath = "${pageContext.servletContext.contextPath}";
</script>
<style>
.new-padding {
	padding-left: 1px;
	padding-right: 1px;
	margin-left: auto;
	margin-right: auto;
}

.imgtext {
	background-color: black;
	bottom: 25px;
	color: white;
	margin: -20px 5px 0 5px;
	opacity: 0.7;
	padding: 0 0 0 6px;
	position: relative;
	text-align: left;
}
</style>
</head>

<body style="">
	<div class="navbar navbar-default navbar-static-top">
		<div class="container-fluid">
			<div class="navbar-header">
				<a class="navbar-brand" href="#"> <strong>Mobi-Flirt</strong>
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
								<a href="<spring:url value="/photo" htmlEscape="true" />">test</a>
							</li>
							<li class="divider"></li>
							<li>
								<a href="<spring:url value="/photo" htmlEscape="true" />">test</a>
							</li>
						</ul>
					</li>
				</ul>
			</div>
		</div>
	</div>
	<div class="container">
		<div class="panel panel-default">
			<div class="panel-heading">Безлимитные знакомства в твоем телефоне</div>
			<div class="panel-body">

				<div class="row">
					<div class="col-xs-6 col-md-3 new-padding">
						<a href="#" class="thumbnail"> <img src="<spring:url value="/resources/img/03.jpg"/>" alt="..."></a>
						<div class="imgtext">
							Сергей, 29
							<span style="color: #31AF40;">
								<strong>■</strong>
							</span>
						</div>
					</div>
					<div class="col-xs-6 col-md-3 new-padding">
						<a href="#" class="thumbnail"> <img src="<spring:url value="/resources/img/04.jpg"/>" alt="..."></a>
						<div class="imgtext">
							Сергей, 29
							<span style="color: #CF1A1D;">
								<strong>■</strong>
							</span>
						</div>
					</div>
					<div class="col-xs-6 col-md-3 new-padding">
						<a href="#" class="thumbnail"> <img src="<spring:url value="/resources/img/06.jpg"/>" alt="..."></a>
						<div class="imgtext">
							Сергей, 29
							<span style="color: #31AF40;">
								<strong>■</strong>
							</span>
						</div>
					</div>
					<div class="col-xs-6 col-md-3 new-padding">
						<a href="#" class="thumbnail"> <img src="<spring:url value="/resources/img/07.jpg"/>" alt="..."></a>
						<div class="imgtext">
							Сергей, 29
							<span style="color: #CF1A1D;">
								<strong>■</strong>
							</span>
						</div>
					</div>
					<div class="col-xs-6 col-md-3 new-padding">
						<a href="#" class="thumbnail"> <img src="<spring:url value="/resources/img/08.jpg"/>" alt="..."></a>
						<div class="imgtext">
							Сергей, 29
							<span style="color: #CF1A1D;">
								<strong>■</strong>
							</span>
						</div>
					</div>
					<div class="col-xs-6 col-md-3 new-padding">
						<a href="#" class="thumbnail"> <img src="<spring:url value="/resources/img/10.jpg"/>" alt="..."></a>
						<div class="imgtext">
							Сергей, 29
							<span style="color: #31AF40;">
								<strong>■</strong>
							</span>
						</div>
					</div>
				</div>

			</div>
		</div>
	</div>

	<script src="<spring:url htmlEscape="true" value="/resources/js/jquery-1.11.3.min.js" />"></script>
	<script src="<spring:url htmlEscape="true" value="/resources/js/jquery-ui.min.js" />"></script>
	<script src="<spring:url htmlEscape="true" value="/resources/js/bootstrap.min.js" />"></script>
</body>
</html>




