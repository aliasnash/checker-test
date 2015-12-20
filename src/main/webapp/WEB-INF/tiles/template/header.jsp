<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div class="navbar navbar-default navbar-static-top">
	<div class="container-fluid">
		<!-- Brand and toggle get grouped for better mobile display -->
		<div class="navbar-header">
			<a class="navbar-brand" href="#">
				<strong>[COMPANY]</strong>
			</a>
		</div>
		<!-- Collect the nav links, forms, and other content for toggling -->
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav navbar-right">
				<li class="${pageName eq 'home' ? 'active' : ''}">
					<spring:url value="/home" var="homeUrl" htmlEscape="true" />
					<a href="${pageName eq 'home' ? '#' : homeUrl}">Dashboard</a>
				</li>
				<li class="dropdown ">
					<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
						Настройки
						<span class="caret"></span>
					</a>
					<ul class="dropdown-menu" role="menu">
						<li class="dropdown-header">Настройки</li>
						<li class=""></li>
						<li class="">
							<a href="<spring:url value="/region/list" htmlEscape="true" />">Регионы</a>
						</li>
						<li class="">
							<a href="<spring:url value="/city/list" htmlEscape="true" />">Города</a>
						</li>
						<li class="">
							<a href="<spring:url value="/market/list" htmlEscape="true" />">Магазины</a>
						</li>
						<li class="">
							<a href="<spring:url value="/promo/list" htmlEscape="true" />">Акции</a>
						</li>
						<li class="divider"></li>
						<li>
							<a href="<spring:url value="/exit" htmlEscape="true" />">Выход</a>
						</li>
					</ul>
				</li>
			</ul>
		</div>
		<!-- /.navbar-collapse -->
	</div>
	<!-- /.container-fluid -->
</div>