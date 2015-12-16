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

<spring:url value="/resources/ico/favicon.ico" var="ico" htmlEscape="true" />
<spring:url value="/resources/css/bootstrap.min.css" var="boostrapCss" htmlEscape="true" />
<spring:url value="/resources/css/bootstrap-select.min.css" var="bootstrapSelectCss" htmlEscape="true" />
<spring:url value="/resources/css/bootstrap-datepicker3.min.css" var="bootstrapDateCss" htmlEscape="true" />
<spring:url value="/resources/css/jquery-ui.min.css" var="jqueryCss" htmlEscape="true" />
<spring:url value="/resources/css/site.css" var="siteCss" htmlEscape="true" />
<spring:url value="/resources/css/site2.css" var="site2Css" htmlEscape="true" />

<link href="${ico}" rel="shortcut icon">
<link href="${boostrapCss}" rel="stylesheet" id="bootstrap-css">
<link href="${bootstrapSelectCss}" rel="stylesheet">
<link href="${bootstrapDateCss}" rel="stylesheet">
<link href="${jqueryCss}" rel="stylesheet">
<link href="${siteCss}" rel="stylesheet">
<link href="${site2Css}" rel="stylesheet">
</head>

<body style="">
	<tiles:insertAttribute name="header" />
	<div class="container-fluid main-container">
		<tiles:insertAttribute name="menu" />
		<div class="col-md-10 content">
			<tiles:insertAttribute name="body" />
		</div>
	</div>
	<spring:url value="/resources/js/jquery-1.11.3.min.js" var="jqueryJs" htmlEscape="true" />
	<spring:url value="/resources/js/jquery-ui.min.js" var="jqueryUiJs" htmlEscape="true" />
	<spring:url value="/resources/js/jquery.mjs.nestedSortable.js" var="jquerySortJs" htmlEscape="true" />
	<spring:url value="/resources/js/bootstrap.min.js" var="bootstrapJs" htmlEscape="true" />
	<spring:url value="/resources/js/bootstrap-datepicker.min.js" var="bootstrapDateJs" htmlEscape="true" />
	<spring:url value="/resources/js/bootstrap-datepicker.ru.min.js" var="bootstrapDateRuJs" htmlEscape="true" />
	<spring:url value="/resources/js/bootstrap-select.min.js" var="bootstrapSelectJs" htmlEscape="true" />
	<spring:url value="/resources/js/site.js" var="siteJs" />
	<spring:url value="/resources/js/script.js" var="scriptJs" />
	<script src="${jqueryJs}"></script>
	<script src="${jqueryUiJs}"></script>
	<script src="${jquerySortJs}"></script>
	<script src="${bootstrapJs}"></script>
	<script src="${bootstrapDateJs}"></script>
	<script src="${bootstrapDateRuJs}"></script>
	<script src="${bootstrapSelectJs}"></script>
	<script src="${siteJs}"></script>
	<script src="${scriptJs}"></script>
</body>
</html>