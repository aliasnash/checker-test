<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>

<tiles:insertDefinition name="defaultTemplate">
	<tiles:putAttribute name="title" value="Checker Template Add" />
	<tiles:putAttribute name="body">
		<div class="panel panel-default">
			<div class="panel-heading">
				<div class="row">
					<div class="col-md-6">Добавление файла шаблона</div>
					<div class="col-md-6 text-right">
						<a class="btn btn-default btn-sm" href="<spring:url value="/template/list" htmlEscape="true" />"><span class="glyphicon glyphicon-arrow-left"></span>
							&nbsp;Назад</a>
					</div>
				</div>
			</div>

			<form class="form-horizontal" role="form" action="<spring:url value="/template/file/upload" htmlEscape="true" />" method="post" enctype="multipart/form-data">
				<div class="panel-body">
					<div class="form-group">
						<label for="template-name" class="col-md-2 control-label">Название:</label>
						<div class="col-md-3">
							<input name="name" maxlength="50" class="form-control" id="template-name" placeholder="Название шаблона..." type="text">
						</div>
					</div>
					<div class="form-group">
						<label for="template-upload" class="col-md-2 control-label">Файл:</label>
						<div class="col-md-6">
							<input name="templates" class="file-loading" id="template-upload" placeholder="Файл шаблона..." type="file">
							<div id="errorBlock" class="help-block"></div>
						</div>
					</div>

					<div class="col-md-12" style="margin-top: 10px; ${empty result?'display: none;':''}">
						<div class="panel panel-success fade in">
							<div class="panel-heading">
								<h3 class="panel-title">Файл успешно загружен</h3>
							</div>
							<table class="table">
								<tr>
									<td class="text-right"><strong>Всего добавлено:</strong></td>
									<td class="">${result.totalAdded}</td>
								</tr>
								<tr>
									<td class="text-right"><strong>В том числе без цены:</strong></td>
									<td class="">${result.withoutPriceAdded}</td>
								</tr>
								<tr>
									<td class="text-right"><strong>Создано категорий:</strong></td>
									<td class="">${result.categoryAdded}</td>
								</tr>
								<tr>
									<td class=" text-right"><strong>Создано продуктов:</strong></td>
									<td class="">${result.goodAdded}</td>
								</tr>
								<tr>
									<td class="text-right"><strong>Создано артикулов:</strong></td>
									<td class="">${result.articleAdded}</td>
								</tr>
								<tr>
									<td class=" text-right"><strong>Необработанные строки: </strong></td>
									<td class=""><c:forEach items="${result.notAdded}" var="notAdded">
											<div>${notAdded}</div>
										</c:forEach></td>
								</tr>
							</table>
						</div>
					</div>


				</div>
				<div class="panel-footer">
					<span></span>
				</div>
			</form>
		</div>
	</tiles:putAttribute>
</tiles:insertDefinition>



