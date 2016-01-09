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
							<a href="${pageName eq 'home' ? '#' : homeUrl}">
								<span class="glyphicon glyphicon-dashboard"></span>
								Dashboard
							</a>
						</li>
						<li class="${pageName eq 'dynamic' ? 'active' : ''}">
							<spring:url value="/dynamic" var="dynamicUrl" htmlEscape="true" />
							<a href="${pageName eq 'dynamic' ? '#' : dynamicUrl}">
								<span class="glyphicon glyphicon-signal"></span>
								Динамика
							</a>
						</li>
						<li class="${pageName eq 'report' ? 'active' : ''}">
							<spring:url value="/report" var="reportUrl" htmlEscape="true" />
							<a href="${pageName eq 'report' ? '#' : reportUrl}">
								<span class="glyphicon glyphicon-info-sign"></span>
								Отчеты
							</a>
						</li>
						<li class="${pageName eq 'template' ? 'active' : ''}">
							<spring:url value="/template/list" var="templatesUrl" htmlEscape="true" />
							<a href="${pageName eq 'template' ? '#' : templatesUrl}">
								<span class="glyphicon glyphicon-duplicate"></span>
								Шаблоны
							</a>
						</li>
						<li class="${pageName eq 'task' ? 'active' : ''}">
							<spring:url value="/tasks/list" var="tasksUrl" htmlEscape="true" />
							<a href="${pageName eq 'task' ? '#' : tasksUrl}">
								<span class="glyphicon glyphicon-tasks"></span>
								Задачи
							</a>
						</li>
						<li class="${pageName eq 'taskcheck' ? 'active' : ''}">
							<spring:url value="/taskcheck/list" var="taskCheckUrl" htmlEscape="true" />
							<a href="${pageName eq 'taskcheck' ? '#' : taskCheckUrl}">
								<span class="glyphicon glyphicon-question-sign"></span>
								Проверка задач
							</a>
						</li>
						<li class="${pageName eq 'taskfail' ? 'active' : ''}">
							<spring:url value="/tasksfail/list" var="taskFailUrl" htmlEscape="true" />
							<a href="${pageName eq 'taskfail' ? '#' : taskFailUrl}">
								<span class="glyphicon glyphicon-remove-sign"></span>
								Задачи на переделку
							</a>
						</li>
						<li class="${pageName eq 'taskcomplete' ? 'active' : ''}">
							<spring:url value="/taskcomplete/list" var="taskCompleteUrl" htmlEscape="true" />
							<a href="${pageName eq 'taskcomplete' ? '#' : taskCompleteUrl}">
								<span class="glyphicon glyphicon-ok-sign"></span>
								Проверенные задачи
							</a>
						</li>
						<li class="${pageName eq 'users' ? 'active' : ''}">
							<spring:url value="/users/list" var="usersUrl" htmlEscape="true" />
							<a href="${pageName eq 'users' ? '#' : usersUrl}">
								<span class="glyphicon glyphicon-user"></span>
								Сотрудники
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