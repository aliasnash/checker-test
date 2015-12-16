<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>

<tiles:insertDefinition name="defaultTemplate">
	<tiles:putAttribute name="title" value="Checker Dashboard" />
	<tiles:putAttribute name="body">
		<div class="col-md-6">
			<div class="panel panel-danger">
				<div class="panel-heading">Ошибка во время выполнения</div>
				<div class="panel-body">
					<div class="row">
						<div class="col-md-2">Описание:</div>
						<div class="col-md-10">${detailMessage}</div>
					</div>
					<div class="row">
						<div class="col-md-2">Класс:</div>
						<div class="col-md-10">${class}</div>
					</div>
				</div>
			</div>
		</div>
	</tiles:putAttribute>
</tiles:insertDefinition>



