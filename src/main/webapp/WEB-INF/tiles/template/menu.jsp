<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
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
						<li class="${pageName eq 'home' ? 'active' : ''}">
							<spring:url value="/home" var="homeUrl" htmlEscape="true" />
							<a href="${pageName eq 'home' ? '#' : homeUrl}"> <span class="glyphicon glyphicon-dashboard"></span> Dashboard
							</a>
						</li>
						<li class="${pageName eq 'report' ? 'active' : ''}" style="color: #0000ff;">
							<spring:url value="/report" var="reportUrl" htmlEscape="true" />
							<a href="${pageName eq 'report' ? '#' : reportUrl}" style="background: #ff0000;"> <span class="glyphicon glyphicon-list"></span> Отчеты
							</a>
						</li>
						<li class="${pageName eq 'goods' ? 'active' : ''}">
							<spring:url value="/goods" var="goodsUrl" htmlEscape="true" />
							<a href="${pageName eq 'goods' ? '#' : goodsUrl}" style="background: #ff0000;"> <span class="glyphicon glyphicon-camera"></span> Просмотр
							</a>
						</li>
						<li class="${pageName eq 'check' ? 'active' : ''}">
							<spring:url value="/check" var="checkUrl" htmlEscape="true" />
							<a href="${pageName eq 'check' ? '#' : checkUrl}" style="background: #ff0000;"> <span class="glyphicon glyphicon-camera"></span> Проверка
							</a>
						</li>
						<li class="${pageName eq 'tasks' ? 'active' : ''}">
							<spring:url value="/tasks/list" var="tasksUrl" htmlEscape="true" />
							<a href="${pageName eq 'tasks' ? '#' : tasksUrl}" style="background: #ff0000;"> <span class="glyphicon glyphicon-tasks"></span> Задачи
							</a>
						</li>
						<li class="${pageName eq 'users' ? 'active' : ''}">
							<spring:url value="/users/list" var="usersUrl" htmlEscape="true" />
							<a href="${pageName eq 'users' ? '#' : usersUrl}" style="background: #ff0000;"> <span class="glyphicon glyphicon-user"></span> Сотрудники
							</a>
						</li>
						<li class="${pageName eq 'template' ? 'active' : ''}">
							<spring:url value="/template/list" var="templatesUrl" htmlEscape="true" />
							<a href="${pageName eq 'template' ? '#' : templatesUrl}"> <span class="glyphicon glyphicon-duplicate"></span> Шаблоны
							</a>
						</li>
						<!-- 
						<li class="${pageName eq 'category' ? 'active' : ''}">
							<spring:url value="/category/list" var="categoriesUrl" htmlEscape="true" />
							<a href="${pageName eq 'category' ? '#' : categoriesUrl}"> <span class="glyphicon glyphicon-signal"></span> Категории
							</a>
						</li>
						 -->
					</ul>
				</div>
				<!-- /.navbar-collapse -->
			</nav>
		</div>
	</div>
</div>