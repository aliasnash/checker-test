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
							<!--<th style="vertical-align: middle">Дата</th>-->
							<th style="vertical-align: middle">Название</th>
							<th style="vertical-align: middle">Магазин</th>
							<th class="text-right">
								<a data-element-id="" data-element-name="" data-toggle="modal" data-target="#modal-edit-task" class="btn btn-sm btn-success">
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
								<!-- <td><joda:format value="${}" style="yyyy-MM-dd" /></td> -->
								<td>${task.caption}</td>
								<td>${task.marketPoint.market.caption}&nbsp;(${task.marketPoint.description})</td>
								<td>
									<div class="btn-group pull-right" role="group" aria-label="...">
										<a class=" btn btn-sm btn-default" href="<spring:url value="/tasks/${task.id}/articles/list" htmlEscape="true" />">
											<span class="glyphicon glyphicon-list" aria-hidden="true"></span>
											Артикулы
										</a>
										<spring:url value="/tasks/${task.id}/assign" var="taskAssignUrl" htmlEscape="true" />
										<a class="btn btn-sm btn-default" href="${taskAssignUrl}" ${ not empty task.user ? 'disabled="disabled"' : '' }>
											<span class="glyphicon glyphicon-list" aria-hidden="true"></span>
											Назначить
										</a>

										<a data-element-id="${task.id}" data-element-name="${task.caption }" data-toggle="modal" data-target="#modal-edit-task" class=" btn btn-sm btn-primary">
											<span class="glyphicon glyphicon-edit" aria-hidden="true"></span>
										</a>
										<spring:url value="/category/${task.id}/delete" var="taskDeleteUrl" htmlEscape="true" />
										<a class="btn btn-sm btn-danger" href="${categoryDeleteUrl}" onclick="return confirm('Вы действительно хотите удалить задачу \'${task.caption }\' и все подкатегории')">
											<span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
										</a>
									</div>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<!-- modal -->
				<div class="modal fade" id="modal-edit-task">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal" aria-label="Close">
									<span aria-hidden="true">×</span>
								</button>
								<h4 class="modal-title">Задача</h4>
							</div>
							<form class="form-horizontal" role="form" action="<spring:url value="/task/update" htmlEscape="true" />" method="post">
								<input value="" name="id" type="hidden">

								<div class="modal-body">
									<div class="form-group">
										<label for="category-name" class="col-md-4 control-label">Наименование:</label>

										<div class="col-md-5">
											<input name="name" maxlength="50" class="form-control" id="category-name" placeholder="Название задачи..." type="text">
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



