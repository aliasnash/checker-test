<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>

<tiles:insertDefinition name="defaultTemplate">
	<tiles:putAttribute name="title" value="Checker Template" />
	<tiles:putAttribute name="body">
		<div class="panel panel-default">
			<div class="panel-heading">Редактор шаблонов</div>
			<div class="panel-body">
				<table class="table">
					<thead>
						<tr>
							<th style="vertical-align: middle" class="col-md-1">#</th>
							<th style="vertical-align: middle" class="col-md-1">Дата создания</th>
							<th style="vertical-align: middle" class="col-md-2">Название шаблона</th>
							<th style="vertical-align: middle" class="col-md-5">Имя загруженного файла</th>
							<th class="text-right col-md-3">
								<a data-element-id="" data-element-name="" data-toggle="modal" data-target="#modal-edit-template" class="btn btn-sm btn-success"> <span
										class="glyphicon glyphicon-plus-sign" aria-hidden="true"></span> &nbsp;Добавить шаблон
								</a>
								<spring:url value="/template/file/add/form" var="addTemplateFileUrl" htmlEscape="true" />
								<a class="btn btn-sm btn-success" href="${addTemplateFileUrl}"> <span class="glyphicon glyphicon-plus-sign" aria-hidden="true"></span>&nbsp;Добавить
									файл
								</a>
							</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${templateList}" var="template" varStatus="status">
							<tr>
								<td>${status.index + 1}</td>
								<td>${template.currentDate}</td>
								<td>${template.caption}</td>
								<td>${template.fileName}</td>
								<td>
									<div class="btn-group pull-right" role="group" aria-label="...">
										<spring:url value="/template/${template.id}/list" var="templateUrl" htmlEscape="true" />
										<a class=" btn btn-sm btn-default" href="${templateUrl}"> <span class="glyphicon glyphicon-list" aria-hidden="true"></span> Артикулы
										</a> <a data-element-id="${template.id}" data-element-name="${template.caption}" data-element-date="${template.currentDate}"
											data-element-file="${template.fileName}" data-toggle="modal" data-target="#modal-edit-template" class=" btn btn-sm btn-primary"> <span
												class="glyphicon glyphicon-edit" aria-hidden="true"></span>
										</a>
										<spring:url value="/template/${template.id}/delete" var="templateDeleteUrl" htmlEscape="true" />
										<a class="btn btn-sm btn-danger" href="${templateDeleteUrl}"
											onclick="return confirm('Вы действительно хотите удалить шаблон \'${template.caption}\' со всеми артикулами?')"> <span
												class="glyphicon glyphicon-remove" aria-hidden="true"></span>
										</a>
									</div>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<!-- modal -->
				<div class="modal fade" id="modal-edit-template">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal" aria-label="Close">
									<span aria-hidden="true">×</span>
								</button>
								<h4 class="modal-title">Шаблон</h4>
							</div>
							<form class="form-horizontal" role="form" action="<spring:url value="/template/update" htmlEscape="true" />" method="post">
								<input value="" name="id" type="hidden">

								<div class="modal-body">
									<div class="form-group">
										<label for="template-name" class="col-md-4 control-label">Название:</label>
										<div class="col-md-5">
											<input name="name" maxlength="50" class="form-control" id="template-name" placeholder="Название шаблона..." type="text">
										</div>
									</div>
									<div class="form-group">
										<label for="template-date" class="col-md-4 control-label">Дата создания:</label>
										<div class="col-md-5">
											<input name="date" maxlength="50" class="form-control" id="template-date" placeholder="Дата шаблона..." type="text">
										</div>
									</div>
									<div class="form-group">
										<label for="template-file" class="col-md-2 control-label">Файл:</label>
										<div class="col-md-10">
											<input name="file" class="form-control" id="template-file" placeholder="Файл шаблона..." type="text">
										</div>
									</div>
								</div>
								<div class="modal-footer">
									<button type="button" class="btn btn-default btn-sm" data-dismiss="modal">Закрыть</button>
									<button type="submit" class="btn btn-primary btn-sm">Сохранить</button>
								</div>
							</form>
						</div>
						<!-- /.modal-content -->
					</div>
					<!-- /.modal-dialog -->
				</div>
				<!-- /.modal -->
			</div>
		</div>
	</tiles:putAttribute>
</tiles:insertDefinition>



