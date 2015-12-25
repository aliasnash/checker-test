<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://www.joda.org/joda/time/tags" prefix="joda"%>

<tiles:insertDefinition name="defaultTemplate">
	<tiles:putAttribute name="title" value="Checker Task" />
	<tiles:putAttribute name="body">
		<div class="panel panel-default">
			<div class="panel-heading">Редактор задач</div>
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
								<spring:url value="/tasks/add/form" var="addTaskUrl" htmlEscape="true" />
								<a class="btn btn-sm btn-success" href="${addTaskUrl}"> <span class="glyphicon glyphicon-plus-sign" aria-hidden="true"></span> &nbsp;Добавить
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
										<a class=" btn btn-sm btn-default" href="<spring:url value="/tasks/${task.id}/articles/list" htmlEscape="true" />"> <span
												class="glyphicon glyphicon-list" aria-hidden="true"></span> Артикулы
										</a>
										<c:choose>
											<c:when test="${empty task.user}">
												<a data-element-id="${task.id}" data-element-name="${task.caption}"
													data-element-market="${task.marketPoint.market.caption}&nbsp;(${task.marketPoint.description})" data-toggle="modal"
													data-target="#modal-assign-task" class=" btn btn-sm btn-default"> <span class="glyphicon glyphicon-list" aria-hidden="true"></span> Назначить
												</a>

												<spring:url value="/tasks/${task.id}/delete" var="taskDeleteUrl" htmlEscape="true" />
												<a class="btn btn-sm btn-danger" href="${taskDeleteUrl}"
													onclick="return confirm('Вы действительно хотите удалить задачу \'${task.caption }\' и все подкатегории')"> <span
														class="glyphicon glyphicon-remove" aria-hidden="true"></span>
												</a>
											</c:when>
											<c:otherwise>
												<a class="btn btn-sm btn-info" href="#"
													onclick="return alert('Задача \'${task.caption }\' уже назначена на пользователя ${task.user.email}&nbsp;(${task.user.title})')"> <span
														class="glyphicon glyphicon-list" aria-hidden="true"></span> Назначено
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
							<form class="form-horizontal" role="form" action="<spring:url value="/tasks/assign" htmlEscape="true" />" method="post">
								<input value="" name="id" type="hidden">
								<input value="" name="iduser" type="hidden">

								<div class="modal-body">
									<div class="form-group">
										<label for="task-name" class="col-md-4 control-label">Задача:</label>
										<div class="col-md-5">
											<input name="name" maxlength="128" class="form-control" id="task-name" placeholder="Название задачи..." type="text">
										</div>
									</div>
									<div class="form-group">
										<label for="task-market" class="col-md-4 control-label">Магазин:</label>
										<div class="col-md-5">
											<input name="name" maxlength="128" class="form-control" id="task-market" placeholder="Название сети..." type="text">
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
			</div>
		</div>
	</tiles:putAttribute>
</tiles:insertDefinition>



