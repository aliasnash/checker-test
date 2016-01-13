<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<tiles:insertDefinition name="defaultTemplate">
	<tiles:putAttribute name="title" value="Checker Template Articles" />
	<tiles:putAttribute name="body">
		<script>
			templateTree = '${templateTree}';
			selectedArticles = [<c:forEach var="item" items="${templateSelected}" varStatus="status">${item}<c:if test="${!status.last}">,</c:if></c:forEach>];
		</script>

		<div class="panel panel-default">
			<div class="panel-heading">
				<div class="row">
					<div class="col-md-10" id="dataclick">Редактор артикулов в шаблоне</div>
					<div class="col-md-2 text-right">
						<a class="btn btn-default btn-sm" href="<spring:url value="/template" htmlEscape="true"/>"> <span class="glyphicon glyphicon-arrow-left"></span>
							Назад
						</a>
					</div>
				</div>
			</div>
			<div class="panel-body">
				<div class="row">
					<div class="col-md-12">
						<h3 class="h3">Шаблон "${taskTemplate.caption}"</h3>
					</div>
				</div>
				<hr>
				<div class="row">
					<div class="col-md-12">
						Файл <strong>"${taskTemplate.fileName}"</strong>
					</div>
				</div>
				<div class="row">
					<div class="col-md-12">
						Дата формирования шаблона: <strong>${taskTemplate.currentDate}</strong>
					</div>
				</div>
				<hr>

				<div class="row">
					<form class="form-horizontal" role="form" action="<spring:url value="/template/${taskTemplate.id}/articule/update" htmlEscape="true" />" method="post"
						id="template_form">
						<input value="" id="template_selected_articles" name="idarticle[]" type="hidden">
						<div class="row-fluid">
							<div class="col-md-2"></div>
							<div class="col-md-2" style="vertical-align: middle">
								Выбрано <strong><span id="selected_articul_count">${fn:length(templateSelected)}</span></strong> единиц артикула
							</div>
							<div class="col-md-6 form-group text-right">
								<div class="btn-group" role="group" aria-label="...">
									<a class="btn btn-default " id="expand_category"><i class="glyphicon glyphicon-list-alt"></i> Раскрыть категории</a> <a class="btn btn-default "
										id="collapse_category"><i class="glyphicon glyphicon-list-alt"></i> Свернуть категории</a> <a class="btn btn-primary " id="tree-submit"><i
										class="glyphicon glyphicon-floppy-save"></i> Сохранить</a>
								</div>
							</div>
							<div class="col-md-2"></div>
						</div>
					</form>
				</div>
				<div class="row">
					<div class="col-md-2"></div>
					<div class="col-md-8 panel-group">
						<div id="templatetree"></div>
					</div>
					<div class="col-md-2"></div>
				</div>
			</div>
		</div>
	</tiles:putAttribute>
</tiles:insertDefinition>



