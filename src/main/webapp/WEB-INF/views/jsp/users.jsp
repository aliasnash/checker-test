<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>

<tiles:insertDefinition name="defaultTemplate">
	<tiles:putAttribute name="title" value="Checker User" />
	<tiles:putAttribute name="body">
		<div class="panel panel-default">
			<div class="panel-heading clearfix">
				Фильтр
				<span class="pull-right">
					<a class="btn btn-default collapse-button" href="#filter-for-user-list" data-toggle="collapse" aria-expanded="true"> <span
							class="glyphicon glyphicon-chevron-up"></span> <span class="glyphicon glyphicon-chevron-down"></span>
					</a>
				</span>
			</div>
			<div class="panel-body collapse in" id="filter-for-user-list">
				<form class="form-inline" role="form" action="<spring:url value="/users/list" htmlEscape="true" />" method="post">
					<div class="modal-body">
						<div class="row">
							<div class="form-group col-md-3">
								<label for="filter_city" class="col-md-12  control-label">Город:</label>
								<div class="col-md-12">
									<select name="filter_city_user" class="selectpicker form-control" id="filter_city_user" title="Выберите город" data-size="15">
										<c:forEach items="${cityMap}" var="map">
											<optgroup label="${map.key}">
												<c:forEach items="${map.value}" var="city">
													<option ${idCityUserSaved == city.id ? 'selected' : ''} value="${city.id}">${city.caption}</option>
												</c:forEach>
											</optgroup>
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
							<a href="<spring:url value="/users/reset" htmlEscape="true" />" class="btn btn-default btn-sm">Сбросить</a>
							<button type="submit" class="btn btn-primary btn-sm">Применить</button>
						</div>
					</div>
				</form>
			</div>
		</div>

		<div class="panel panel-default">
			<div class="panel-heading">Сотрудники</div>
			<div class="panel-body">
				<table class="table">
					<thead>
						<tr>
							<th style="vertical-align: middle" class="col-md-1">#</th>
							<th style="vertical-align: middle" class="col-md-1">Пользователь</th>
							<th style="vertical-align: middle" class="col-md-2">Email</th>
							<th style="vertical-align: middle" class="col-md-3">Город</th>
							<th style="vertical-align: middle" class="col-md-1">Задачи</th>
							<th style="vertical-align: middle" class="col-md-1">Артикулы</th>
							<th class="text-right col-md-3">
								<a data-element-id="" data-element-name="" data-element-email="" data-element-pwd="" data-toggle="modal" data-target="#modal-edit-user"
									class="btn btn-sm btn-success"> <span class="glyphicon glyphicon-plus-sign" aria-hidden="true"></span> &nbsp;Добавить
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
								<td>${empty userInfo.user.city ? ' - ' : userInfo.user.city.region.caption}&nbsp;/&nbsp;${empty userInfo.user.city ? ' - ' : userInfo.user.city.caption}</td>
								<td>${userInfo.tasks}</td>
								<td>${userInfo.articles}</td>
								<td>
									<div class="btn-group pull-right" role="group" aria-label="...">
										<spring:url value="/users/${userInfo.user.id}/tasks/list" var="userTaskUrl" htmlEscape="true" />
										<a class=" btn btn-sm btn-default" href="${userTaskUrl}"> <span class="glyphicon glyphicon-list" aria-hidden="true"></span> Задачи
										</a> <a data-element-id="${userInfo.user.id}" data-element-name="${userInfo.user.title}" data-element-email="${userInfo.user.email}"
											data-element-pwd="${userInfo.user.pwd}" data-element-idcity="${userInfo.user.idCity}" data-toggle="modal" data-target="#modal-edit-user"
											class=" btn btn-sm btn-primary"> <span class="glyphicon glyphicon-edit" aria-hidden="true"></span>

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
								<input value="" name="idcity-user-filtered" type="hidden">

								<div class="modal-body">
									<div class="form-group" id="user-save-city-block">
										<label for="user-save-city" class="col-md-4 control-label">Город:</label>
										<div class="col-md-5">
											<select name="user-save-city" class="selectpicker form-control" id="user-save-city" title="Выберите город" data-size="15">
												<c:forEach items="${cityMapForFilter}" var="map">
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
									<button type="submit" class="btn btn-primary btn-sm" id="user-save">Сохранить</button>
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



