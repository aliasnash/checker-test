<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>

<tiles:insertDefinition name="defaultTemplate">
	<tiles:putAttribute name="title" value="Checker User" />
	<tiles:putAttribute name="body">
		<div class="panel panel-default">
			<div class="panel-heading">Сотрудники</div>
			<div class="panel-body">
				<table class="table">
					<thead>
						<tr>
							<th style="vertical-align: middle" class="col-md-1">#</th>
							<th style="vertical-align: middle" class="col-md-1">Пользователь</th>
							<th style="vertical-align: middle" class="col-md-3">Email</th>
							<th style="vertical-align: middle" class="col-md-1">Задачи</th>
							<th style="vertical-align: middle" class="col-md-2">Артикулы</th>
							<th class="text-right col-md-4">
								<a data-element-id="" data-element-name="" data-element-email="" data-element-pwd="" data-toggle="modal" data-target="#modal-edit-user" class="btn btn-sm btn-success">
									<span class="glyphicon glyphicon-plus-sign" aria-hidden="true"></span>
									&nbsp;Добавить
								</a>
							</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${userInfoList}" var="userInfo" varStatus="status">
							<tr>
								<td>${status.index + 1}</td>
								<td>${userInfo.user.title}</td>
								<td>${userInfo.user.email}</td>
								<td>${userInfo.tasks}</td>
								<td>${userInfo.articles}</td>
								<td>
									<div class="btn-group pull-right" role="group" aria-label="...">
										<spring:url value="/users/${userInfo.user.id}/tasks/list" var="userTaskUrl" htmlEscape="true" />
										<a class=" btn btn-sm btn-default" href="${userTaskUrl}">
											<span class="glyphicon glyphicon-list" aria-hidden="true"></span>
											Задачи
										</a>
										<a data-element-id="${userInfo.user.id}" data-element-name="${userInfo.user.title}" data-element-email="${userInfo.user.email}" data-element-pwd="${userInfo.user.pwd}" data-toggle="modal"
											data-target="#modal-edit-user" class=" btn btn-sm btn-primary">
											<span class="glyphicon glyphicon-edit" aria-hidden="true"></span>

										</a>
									</div>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<!-- modal -->
				<div class="modal fade" id="modal-edit-user">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal" aria-label="Close">
									<span aria-hidden="true">×</span>
								</button>
								<h4 class="modal-title">Пользователь</h4>
							</div>
							<form class="form-horizontal" role="form" action="<spring:url value="/users/update" htmlEscape="true" />" method="post">
								<input value="" name="id" type="hidden">

								<div class="modal-body">
									<div class="form-group">
										<label for="user-title" class="col-md-4 control-label">Сотрудник:</label>
										<div class="col-md-5">
											<input name="title" maxlength="50" class="form-control" id="user-title" placeholder="Заголовок..." type="text">
										</div>
									</div>
									<div class="form-group">
										<label for="user-email" class="col-md-4 control-label">Email:</label>
										<div class="col-md-5">
											<input name="email" maxlength="50" class="form-control" id="user-email" placeholder="Почта..." type="email">
										</div>
									</div>
									<div class="form-group">
										<label for="user-pwd" class="col-md-4 control-label">Пароль:</label>
										<div class="col-md-5">
											<input name="pwd" maxlength="50" class="form-control" id="user-pwd" placeholder="Пароль..." type="password">
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



