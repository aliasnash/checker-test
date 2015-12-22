<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
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
<title><tiles:insertAttribute name="title" ignore="true" /></title>
<link href="<spring:url htmlEscape="true" value="/resources/ico/favicon.ico" />" rel="shortcut icon">
<link href="<spring:url htmlEscape="true" value="/resources/css/jquery-ui.min.css" />" rel="stylesheet">
<link href="<spring:url htmlEscape="true" value="/resources/css/bootstrap.min.css" />" rel="stylesheet" id="bootstrap-css">
<link href="<spring:url htmlEscape="true" value="/resources/css/bootstrap-datepicker3.min.css" />" rel="stylesheet">
<link href="<spring:url htmlEscape="true" value="/resources/css/bootstrap-select.min.css" />" rel="stylesheet">
<link href="<spring:url htmlEscape="true" value="/resources/css/bootstrap-treeview.min.css" />" rel="stylesheet">
<link href="<spring:url htmlEscape="true" value="/resources/css/fileinput.min.css" />" rel="stylesheet">
<link href="<spring:url htmlEscape="true" value="/resources/css/site.css" />" rel="stylesheet">
<link href="<spring:url htmlEscape="true" value="/resources/css/site2.css" />" rel="stylesheet">
</head>

<body style="">
	<tiles:insertAttribute name="header" />
	<div class="container-fluid main-container">
		<tiles:insertAttribute name="menu" />
		<div class="col-md-10 content">
			<tiles:insertAttribute name="body" />
		</div>
	</div>
	<script src="<spring:url htmlEscape="true" value="/resources/js/jquery-1.11.3.min.js" />"></script>
	<script src="<spring:url htmlEscape="true" value="/resources/js/jquery-ui.min.js" />"></script>
	<script src="<spring:url htmlEscape="true" value="/resources/js/jquery.mjs.nestedSortable.js" />"></script>
	<script src="<spring:url htmlEscape="true" value="/resources/js/bootstrap.min.js" />"></script>
	<script src="<spring:url htmlEscape="true" value="/resources/js/bootstrap-datepicker.min.js" />"></script>
	<script src="<spring:url htmlEscape="true" value="/resources/js/bootstrap-datepicker.ru.min.js" />"></script>
	<script src="<spring:url htmlEscape="true" value="/resources/js/bootstrap-select.min.js" />"></script>
	<script src="<spring:url htmlEscape="true" value="/resources/js/bootstrap-treeview.min.js" />"></script>
	<script src="<spring:url htmlEscape="true" value="/resources/js/fileinput.min.js" />"></script>
	<script src="<spring:url htmlEscape="true" value="/resources/js/fileinput_locale_ru.js" />"></script>
	<script src="<spring:url htmlEscape="true" value="/resources/js/site.js" />"></script>
	<script src="<spring:url htmlEscape="true" value="/resources/js/script.js" />"></script>
</body>
</html>