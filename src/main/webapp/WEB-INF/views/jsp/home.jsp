<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>

<tiles:insertDefinition name="defaultTemplate">
	<tiles:putAttribute name="title" value="Checker Dashboard" />
	<tiles:putAttribute name="body">
		<div class="col-md-6">
			<div class="panel panel-default">
				<div class="panel-heading">Информация</div>
				<div class="panel-body">
					<div class="row">
						<div class="col-md-6">Отчеты</div>
						<div class="col-md-6">0</div>
					</div>
					<div class="row">
						<div class="col-md-6">Задачи</div>
						<div class="col-md-6">0</div>
					</div>
					<div class="row">
						<div class="col-md-6">Артикулы</div>
						<div class="col-md-6">0</div>
					</div>
				</div>
			</div>
		</div>
		<div class="col-md-6">
			<div class="panel panel-default">
				<div class="panel-heading">Медленные сотрудники</div>
				<div class="panel-body"></div>
			</div>
		</div>
	</tiles:putAttribute>
</tiles:insertDefinition>



