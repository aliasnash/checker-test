<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.joda.org/joda/time/tags" prefix="joda"%>
<%@ taglib uri="/WEB-INF/tld/customTaglib.tld" prefix="tag"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<tiles:insertDefinition name="defaultTemplate">
	<tiles:putAttribute name="title" value="Checker Task" />
	<tiles:putAttribute name="body">
		<script>
			contexPath = "${pageContext.servletContext.contextPath}";
		</script>
		<div class="panel panel-default">
			<div class="panel-heading clearfix">
				Фильтр
				<span class="pull-right">
					<a class="btn btn-default collapse-button" href="#filter-for-tasks-list" data-toggle="collapse" aria-expanded="true">
						<span class="glyphicon glyphicon-chevron-up"></span>
						<span class="glyphicon glyphicon-chevron-down"></span>
					</a>
				</span>
			</div>
			<div class="panel-body collapse in" id="filter-for-tasks-list">
				<form class="form-inline" role="form" action="<spring:url value="/tasks/list" htmlEscape="true" />" method="post">
					<div class="modal-body">
						<div class="row">
							<div class="form-group col-md-3">
								<label for="filter_city" class="col-md-12  control-label">Город:</label>
								<div class="col-md-12">
									<select name="filter_city_id" class="selectpicker form-control" id="filter_city" title="Выберите город" data-size="15">
										<c:forEach items="${cityMap}" var="map">
											<optgroup label="${map.key}">
												<c:forEach items="${map.value}" var="city">
													<option ${idCityTaskSaved == city.id ? 'selected' : ''} value="${city.id}">${city.caption}</option>
												</c:forEach>
											</optgroup>
										</c:forEach>
									</select>
								</div>
							</div>
							<div class="form-group col-md-3">
								<label for="filter_market_point" class="col-md-12  control-label" id="filter_market_point_label">Сеть:</label>
								<div class="col-md-12">
									<select name="filter_market_point_id" class="selectpicker form-control" id="filter_market_point" title="Выберите сеть" data-size="15" data-show-subtext="true">
										<c:choose>
											<c:when test="${empty marketPointMap}">
												<option selected value="">Сеть отсутствует</option>
											</c:when>
											<c:otherwise>
												<c:forEach items="${marketPointMap}" var="map">
													<optgroup label="${map.key}">
														<c:forEach items="${map.value}" var="marketpoint">
															<option ${idMarketPointTaskSaved == marketpoint.id ? 'selected' : ''} data-subtext="${marketpoint.market.owner?'своя сеть':''}" value="${marketpoint.id}">${marketpoint.market.caption}&nbsp;(${marketpoint.description})</option>
														</c:forEach>
													</optgroup>
												</c:forEach>
											</c:otherwise>
										</c:choose>
									</select>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="form-group col-md-3">
								<label for="filter_user" class="col-md-12  control-label">Пользователь:</label>
								<div class="col-md-12">
									<select name="filter_user_id" class="selectpicker form-control" id="filter_user" data-size="15">
										<option ${empty idUserTaskSaved ? 'selected' : ''} value="">задачи без пользователя</option>
										<option ${idUserTaskSaved == -1 ? 'selected' : ''} value="-1">все</option>
										<c:forEach items="${userList}" var="user">
											<option ${idUserTaskSaved == user.id ? 'selected' : ''} value="${user.id}">${user.email}&nbsp;(${user.title})</option>
										</c:forEach>
									</select>
								</div>
							</div>
							<div class="form-group col-md-3">
								<label for="filter_task_status" class="col-md-12  control-label">Статус:</label>
								<div class="col-md-12">
									<select name="filter_task_status_id" class="selectpicker form-control" id="filter_task_status">
										<option ${empty idTaskStatusSaved ? 'selected' : ''} value="">любой статус</option>
										<c:forEach items="${taskStatusList}" var="taskStatus">
											<option ${idTaskStatusSaved == taskStatus.id ? 'selected' : ''} value="${taskStatus.id}">${taskStatus.status }</option>
										</c:forEach>
									</select>
								</div>
							</div>
							<div class="form-group col-md-3">
								<label for="filter_task_template" class="col-md-12  control-label">Шаблон:</label>
								<div class="col-md-12">
									<select name="filter_task_template_id" class="selectpicker form-control" id="filter_task_template">
										<option ${empty idTaskTemplateSaved ? 'selected' : ''} value="">все</option>
										<c:forEach items="${templateList}" var="taskTemplate">
											<option ${idTaskTemplateSaved == taskTemplate.id ? 'selected' : ''} value="${taskTemplate.id}">${taskTemplate.caption }</option>
										</c:forEach>
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
							<a href="<spring:url value="/tasks/reset" htmlEscape="true" />" class="btn btn-default btn-sm">Сбросить</a>
							<button type="submit" class="btn btn-primary btn-sm">Применить</button>
						</div>
					</div>
				</form>
			</div>
		</div>

		<div class="panel panel-default">
			<div class="panel-heading">
				Редактор задач&nbsp;
				<span class="badge">${recordsCount}</span>
			</div>
			<div class="panel-body">
				<table class="table">
					<thead>
						<tr>
							<th style="vertical-align: middle">Шаблон</th>
							<th style="vertical-align: middle">Дата</th>
							<th style="vertical-align: middle">Название</th>
							<th style="vertical-align: middle">Магазин</th>
							<th style="vertical-align: middle">Статус</th>
							<th class="text-right">
								<spring:url value="/tasks/add/form" var="addTaskUrl" htmlEscape="true" />
								<a class="btn btn-sm btn-success" href="${addTaskUrl}">
									<span class="glyphicon glyphicon-plus-sign" aria-hidden="true"></span>
									&nbsp;Добавить
								</a>
							</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${taskList}" var="task">
							<tr class="${ not empty task.user ? 'active' : '' }">
								<td><div data-toggle="tooltip" title="${fn:replace(task.template.caption, '_', ' ')}">&nbsp;${empty task.idTemplate ? '-' : task.idTemplate}</div></td>
								<td><joda:format value="${task.dateAdded}" style="SM" /></td>
								<td>${task.caption}</td>
								<td>${task.marketPoint.market.caption}&nbsp;(${task.marketPoint.description})</td>
								<td>${task.taskStatus.status}</td>
								<td>
									<div class="btn-group pull-right" role="group" aria-label="...">
										<a class=" btn btn-sm btn-default" href="<spring:url value="/tasks/${task.id}/articles/list" htmlEscape="true" />">
											<span class="glyphicon glyphicon-list" aria-hidden="true"></span>
											Инфо
										</a>
										<c:choose>
											<c:when test="${empty task.user}">
												<a data-element-id="${task.id}" data-element-name="${task.caption}" data-element-market="${task.marketPoint.market.caption}&nbsp;(${task.marketPoint.description})"
													data-toggle="modal" data-target="#modal-assign-task" class=" btn btn-sm btn-default">
													<span class="glyphicon glyphicon-list" aria-hidden="true"></span>
													Назначить
												</a>

												<spring:url value="/tasks/${task.id}/delete?page=${page}" var="taskDeleteUrl" htmlEscape="true" />
												<a class="btn btn-sm btn-danger" href="${taskDeleteUrl}" onclick="return confirm('Вы действительно хотите удалить задачу \'${task.caption }\' и все подкатегории')">
													<span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
												</a>
											</c:when>
											<c:otherwise>
												<a class="btn btn-sm btn-info" href="#" onclick="return alert('Задача \'${task.caption }\' уже назначена на пользователя ${task.user.email}&nbsp;(${task.user.title})')">
													<span class="glyphicon glyphicon-list" aria-hidden="true"></span>
													Назначено
												</a>
												<a class="btn btn-sm btn-info" href="#"
													onclick="return alert('Задачу \'${task.caption }\' удалить нельзя, т.к. она назначена на пользователя ${task.user.email}&nbsp;(${task.user.title})')">
													<span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
												</a>
											</c:otherwise>
										</c:choose>
									</div>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			<div class="text-center">
				<spring:url value="/tasks/list" htmlEscape="true" var="pUrl" />
				<tag:paginate page="${page}" pageCount="${pageCount}" paginatorSize="10" uri="${pUrl}" next="&raquo;" previous="&laquo;" />
			</div>
		</div>

		<!-- modal -->
		<div class="modal fade" id="modal-assign-task">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">×</span>
						</button>
						<h4 class="modal-title">Назначение</h4>
					</div>
					<form class="form-horizontal" role="form" action="<spring:url value="/tasks/assign?page=${page}" htmlEscape="true" />" method="post">
						<input value="" name="id" type="hidden">
						<input value="" name="iduser" type="hidden">

						<div class="modal-body">
							<div class="form-group">
								<label for="task-name" class="col-md-4 control-label">Задача:</label>
								<div class="col-md-5">
									<input name="name-task" maxlength="128" class="form-control" id="task-name" placeholder="Название задачи..." type="text">
								</div>
							</div>
							<div class="form-group">
								<label for="task-market" class="col-md-4 control-label">Магазин:</label>
								<div class="col-md-5">
									<input name="name-market" maxlength="128" class="form-control" id="task-market" placeholder="Название сети..." type="text">
								</div>
							</div>
							<div class="form-group">
								<label for="task-user" class="col-md-4 control-label">Пользователь:</label>
								<div class="col-md-5">
									<select name="user-id" class="selectpicker form-control" id="task-user" title="Выберите пользователя">
										<c:forEach items="${userList}" var="user">
											<option value="${user.id}">${user.email}&nbsp;(${user.title})</option>
										</c:forEach>
									</select>
								</div>
							</div>
						</div>

						<div class="modal-footer">
							<button type="button" class="btn btn-default btn-sm" data-dismiss="modal">Закрыть</button>
							<button type="submit" class="btn btn-primary btn-sm" id="save-assign-user">Сохранить</button>
						</div>
					</form>
				</div>
				<!-- /.modal-content -->
			</div>
			<!-- /.modal-dialog -->
			<!-- /.modal-dialog -->
		</div>
		<!-- /.modal -->
	</tiles:putAttribute>
</tiles:insertDefinition>



