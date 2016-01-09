<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://www.joda.org/joda/time/tags" prefix="joda"%>

<tiles:insertDefinition name="defaultTemplate">
	<tiles:putAttribute name="title" value="Checker User Task" />
	<tiles:putAttribute name="body">
		<div class="panel panel-default">
			<div class="panel-heading">
				<div class="row">
					<div class="col-md-6">Список задач пользователя ${user.title}&nbsp;(${user.email})</div>
					<div class="col-md-6 text-right">
						<a class="btn btn-default btn-sm" href="<spring:url value="/users/list" htmlEscape="true" />">
							<span class="glyphicon glyphicon-arrow-left"></span>
							&nbsp;Назад
						</a>
					</div>
				</div>
			</div>
			<div class="panel-body">
				<table class="table">
					<thead>
						<tr>
							<th style="vertical-align: middle">#</th>
							<th style="vertical-align: middle">Дата</th>
							<th style="vertical-align: middle">Название</th>
							<th style="vertical-align: middle">Магазин</th>
							<th style="vertical-align: middle">Статус</th>
							<th class="text-right">
								<a class="btn btn-sm btn-success" data-target="#modal-add-user-tasks" data-element-id="${user.id}" data-element-name="${user.title}&nbsp;(${user.email})"
									data-toggle="modal">
									<span class="glyphicon glyphicon-plus-sign" aria-hidden="true"></span>
									&nbsp;Добавить
								</a>
							</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${taskList}" var="task" varStatus="status">
							<tr class="${ not empty task.user ? 'active' : '' }">
								<td>${status.index + 1}</td>
								<td><joda:format value="${task.dateAdded}" style="SM" /></td>
								<td>${task.caption}</td>
								<td>${task.marketPoint.market.caption}&nbsp;(${task.marketPoint.description})</td>
								<td>${task.taskStatus.status}</td>
								<td>
									<div class="btn-group pull-right" role="group" aria-label="...">
										<a class=" btn btn-sm btn-default" href="<spring:url value="/tasks/${task.id}/articles/list" htmlEscape="true" />">
											<span class="glyphicon glyphicon-list" aria-hidden="true"></span>
											Артикулы
										</a>
									</div>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<!-- modal -->
				<div class="modal fade" id="modal-add-user-tasks">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal" aria-label="Close">
									<span aria-hidden="true">×</span>
								</button>
								<h4 class="modal-title" id="user-title"></h4>
							</div>
							<form class="form-horizontal" role="form" action="<spring:url value="/users/tasks/assign" htmlEscape="true" />" method="post">
								<input value="" name="id" type="hidden">

								<div class="modal-body">
									<div class="form-group">
										<label for="task-user" class="col-md-2 control-label">Задачи:</label>
										<div class="col-md-10">
											<select data-selected-text-format="count" name="idtask[]" class="selectpicker form-control" id="task-user" multiple title="Выберите задачу(и)...">
												<c:choose>
													<c:when test="${empty taskListNobody}">
														<option selected value="">Задачи отсутствуют</option>
													</c:when>
													<c:otherwise>
														<c:forEach items="${taskListNobody}" var="task">
															<option data-subtext="${task.marketPoint.market.caption}" value="${task.id}">${task.caption}</option>
														</c:forEach>
													</c:otherwise>
												</c:choose>
											</select>
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
					<!-- /.modal-dialog -->
				</div>
				<!-- /.modal -->
			</div>
		</div>
	</tiles:putAttribute>
</tiles:insertDefinition>



