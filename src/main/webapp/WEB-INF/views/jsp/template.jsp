<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="/WEB-INF/tld/customTaglib.tld" prefix="tag"%>

<tiles:insertDefinition name="defaultTemplate">
	<tiles:putAttribute name="title" value="Checker Template" />
	<tiles:putAttribute name="body">
		<div class="panel panel-default">
			<div class="panel-heading clearfix">
				Фильтр
				<span class="pull-right">
					<a class="btn btn-default collapse-button collapsed" href="#filter-template-build" data-toggle="collapse" aria-expanded="true">
						<span class="glyphicon glyphicon-chevron-up"></span>
						<span class="glyphicon glyphicon-chevron-down"></span>
					</a>
				</span>
			</div>
			<div class="panel-body collapse" id="filter-template-build">
				<form class="form-inline" role="form" action="<spring:url value="/template" htmlEscape="true" />" method="post">
					<div class="modal-body">
						<div class="row">
							<div class="form-group col-md-3">
								<label for="date" class="col-md-12  control-label">Дата создания:</label>
								<div class="col-md-12">
									<input readonly="readonly" name="filtered_template_date" maxlength="50" class="form-control" id="date" placeholder="ГГГГ-ММ-ДД" value="${templateDate}" type="text">
								</div>
							</div>
							<div class="form-group col-md-3">
								<label for="filtered_template_city" class="col-md-12  control-label">Город:</label>
								<div class="col-md-12">
									<select name="filtered_template_city" class="selectpicker form-control" id="filtered_template_city" title="Выберите город" data-size="15">
										<c:choose>
											<c:when test="${empty cityMap}">
												<option selected value="">Данные отсутствуют</option>
											</c:when>
											<c:otherwise>
												<c:forEach items="${cityMap}" var="map">
													<optgroup label="${map.key}">
														<c:forEach items="${map.value}" var="city">
															<option ${templateIdCity == city.id ? 'selected' : ''} value="${city.id}">${city.caption}</option>
														</c:forEach>
													</optgroup>
												</c:forEach>
											</c:otherwise>
										</c:choose>
									</select>
								</div>
							</div>
						</div>

						<div class="form-group">
							<!-- too keep empty space -->
						</div>
					</div>
					<div class="modal-footer">
						<div class="btn-group">
							<a href="<spring:url value="/template/reset" htmlEscape="true" />" class="btn btn-default btn-sm">Сбросить</a>
							<button type="submit" class="btn btn-primary btn-sm">Применить</button>
						</div>
					</div>
				</form>
			</div>
		</div>

		<div class="panel panel-default">
			<div class="panel-heading">
				Редактор шаблонов&nbsp;
				<span class="badge">${recordsCount}</span>
			</div>
			<div class="panel-body" id="template-listing">
				<table class="table">
					<thead>
						<tr>
							<th style="vertical-align: middle" class="col-md-1">#</th>
							<th style="vertical-align: middle" class="col-md-1">Дата создания</th>
							<th style="vertical-align: middle" class="col-md-3">Город</th>
							<th style="vertical-align: middle" class="col-md-4">Название шаблона</th>
							<th class="text-right col-md-3">
								<a data-element-id="" data-element-name="" data-toggle="modal" data-target="#modal-edit-template" class="btn btn-sm btn-success">
									<span class="glyphicon glyphicon-plus-sign" aria-hidden="true"></span>
									&nbsp;Шаблон
								</a>
								<spring:url value="/template/file/add/form" var="addTemplateFileUrl" htmlEscape="true" />
								<a class="btn btn-sm btn-success" href="${addTemplateFileUrl}">
									<span class="glyphicon glyphicon-plus-sign" aria-hidden="true"></span>
									&nbsp;Файл
								</a>
							</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${templateList}" var="template" varStatus="status">
							<tr class="template-data">
								<td>${status.index + 1}</td>
								<td>${template.currentDate}</td>
								<td>${empty template.city ? ' - ' : template.city.region.caption}&nbsp;/&nbsp;${empty template.city ? ' - ' : template.city.caption}</td>
								<td>${fn:replace(template.caption, '_', ' ')}</td>
								<td>
									<div class="btn-group pull-right" role="group" aria-label="...">
										<spring:url value="/template/${template.id}/list" var="templateUrl" htmlEscape="true" />
										<a class=" btn btn-sm btn-default" href="${templateUrl}">
											<span class="glyphicon glyphicon-list" aria-hidden="true"></span>
											Артикулы
										</a>
										<a data-element-id="${template.id}" data-element-name="${template.caption}" data-element-date="${template.currentDate}" data-element-file="${template.fileName}"
											data-element-idcity="${empty template.idCity ? -1 : template.idCity}" data-toggle="modal" data-target="#modal-edit-template" class=" btn btn-sm btn-primary">
											<span class="glyphicon glyphicon-edit" aria-hidden="true"></span>
										</a>
										<spring:url value="/template/${template.id}/delete?page=${page}" var="templateDeleteUrl" htmlEscape="true" />
										<a class="btn btn-sm btn-danger" href="${templateDeleteUrl}"
											onclick="return confirm('Вы действительно хотите удалить шаблон \'${template.caption}\' со всеми артикулами?')">
											<span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
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
							<form class="form-horizontal" role="form" action="<spring:url value="/template/update?page=${page}" htmlEscape="true" />" method="post">
								<input value="" name="id" type="hidden">
								<input value="" name="date-template-filtered" type="hidden">

								<div class="modal-body">

									<div class="form-group" id="template-save-city-block">
										<label for="template-save-city" class="col-md-3 control-label">Город:</label>
										<div class="col-md-9">
											<select name="template-save-city" class="selectpicker form-control" id="template-save-city" title="Выберите город" data-size="15">
												<c:forEach items="${cityMap}" var="map">
													<optgroup label="${map.key}">
														<c:forEach items="${map.value}" var="city">
															<option value="${city.id}">${city.caption}</option>
														</c:forEach>
													</optgroup>
												</c:forEach>
											</select>
										</div>
									</div>

									<div class="form-group">
										<label for="template-name" class="col-md-3 control-label">Название:</label>
										<div class="col-md-9">
											<input name="name" maxlength="50" class="form-control" id="template-name" placeholder="Название шаблона..." type="text">
										</div>
									</div>
									<div class="form-group">
										<label for="template-date" class="col-md-3 control-label">Дата создания:</label>
										<div class="col-md-9">
											<input name="date" maxlength="50" class="form-control" id="template-date" placeholder="Дата шаблона..." type="text">
										</div>
									</div>
									<div class="form-group">
										<label for="template-file" class="col-md-3 control-label">Файл:</label>
										<div class="col-md-9">
											<input name="file" class="form-control" id="template-file" placeholder="Файл шаблона..." type="text">
										</div>
									</div>
								</div>
								<div class="modal-footer">
									<button type="button" class="btn btn-default btn-sm" data-dismiss="modal">Закрыть</button>
									<button type="submit" class="btn btn-primary btn-sm" id="template-save">Сохранить</button>
								</div>
							</form>
						</div>
						<!-- /.modal-content -->
					</div>
					<!-- /.modal-dialog -->
				</div>
				<!-- /.modal -->
			</div>
			<div class="text-center">
				<spring:url value="/template" htmlEscape="true" var="pUrl" />
				<tag:paginate page="${page}" pageCount="${pageCount}" paginatorSize="10" uri="${pUrl}" next="&raquo;" previous="&laquo;" />
			</div>
		</div>
	</tiles:putAttribute>
</tiles:insertDefinition>



