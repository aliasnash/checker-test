<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>

<tiles:insertDefinition name="defaultTemplate">
	<tiles:putAttribute name="title" value="Checker Task Add" />
	<tiles:putAttribute name="body">
		<div class="panel panel-default">
			<div class="panel-heading">
				<div class="row">
					<div class="col-md-6">Создать задачу</div>
					<div class="col-md-6 text-right">
						<a class="btn btn-default btn-sm" href="<spring:url value="/tasks/list" htmlEscape="true" />"> <span class="glyphicon glyphicon-arrow-left"></span>
							&nbsp;Назад
						</a>
					</div>
				</div>
			</div>

			<form class="form-horizontal" role="form" action="<spring:url value="/tasks/upload" htmlEscape="true" />" method="post">
				<div class="panel-body">
					<div class="form-group">
						<label for="select-template-name" class="col-md-4 control-label">Выбрать шаблон:</label>
						<div class="col-md-7">
							<select name="template_id" class="selectpicker form-control" id="select-template-name" title="Выберите шаблон" data-show-subtext="true">
								<c:forEach items="${templateList}" var="template">
									<option value="${template.id}">${template.caption}</option>
								</c:forEach>
							</select>
						</div>
					</div>

					<div class="form-group">
						<label for="market-point" class="col-md-4 control-label">Выбрать сеть:</label>
						<div class="col-md-7">
							<select name="marketpoint_id[]" class="selectpicker form-control" id="market-point" title="Выберите сеть" multiple data-show-subtext="true">
								<c:forEach items="${marketPointMap}" var="map">
									<optgroup label="${map.key}">
										<c:forEach items="${map.value}" var="marketpoint">
											<option data-subtext="${marketpoint.market.owner?'своя сеть':''}" value="${marketpoint.id}">${marketpoint.market.caption}&nbsp;(${marketpoint.description})</option>
										</c:forEach>
									</optgroup>
								</c:forEach>
							</select>
						</div>
					</div>

					<div class="form-group">
						<label for="select-user-name" class="col-md-4 control-label">Назначить на пользователя:</label>
						<div class="col-md-7 text-left">
							<input name="useuser" class="form-control" id="select-user-name" placeholder="..." type="checkbox">
						</div>
					</div>

					<div class="form-group" id="block-user-name" style="display: none;">
						<label for="select-user-name" class="col-md-4 control-label">Выбрать пользователя:</label>
						<div class="col-md-7">
							<select name="user_id" class="selectpicker form-control" id="user-name" title="Выберите пользователя">
								<c:forEach items="${userList}" var="user">
									<option value="${user.id}">${user.email}&nbsp;(${user.title})</option>
								</c:forEach>
							</select>
						</div>
					</div>

					<div class="form-group">
						<label for="select-user-name" class="col-md-4 control-label"></label>
						<div class="col-md-7">
							<button type="submit" class="btn btn-primary btn-sm" id="save-task">Сохранить</button>
						</div>
					</div>

					<div class="col-md-12" style="margin-top: 10px; ${results.hasError?'':'display: none;'}">
						<div class="panel panel-danger fade in">
							<div class="panel-heading">
								<h3 class="panel-title">В ходе создания задачи произошли ошибки</h3>
							</div>
							<table class="table">
								<c:if test="${results.templateError}">
									<tr>
										<td class="text-right" style="width: 40%;"><strong></strong></td>
										<td class="text-left">Ошибка выбора шаблона</td>
									</tr>
								</c:if>
								<c:if test="${results.marketError}">
									<tr>
										<td class="text-right" style="width: 40%;"><strong></strong></td>
										<td class="text-left">Ошибка выбора сети</td>
									</tr>
								</c:if>
								<c:if test="${results.userError}">
									<tr>
										<td class="text-right" style="width: 40%;"><strong></strong></td>
										<td class="text-left">Ошибка выбора пользователя</td>
									</tr>
								</c:if>
							</table>
						</div>
					</div>

					<div class="col-md-12" style="margin-top: 10px; ${empty results.taskStatus?'display: none;':''}">
						<c:forEach items="${results.taskStatus}" var="taskStatus" varStatus="status">
							<div class="panel ${empty taskStatus.error ? 'panel-success' : 'panel-danger' } fade in">
								<div class="panel-heading">
									<h3 class="panel-title">
										#${status.index + 1}&nbsp;
										<c:if test="${not empty taskStatus.taskTemplate}">   
                                          Шаблон: ${taskStatus.taskTemplate.caption}
                                        </c:if>
									</h3>
								</div>
								<table class="table">
									<c:if test="${not empty taskStatus.marketPoint}">
										<tr>
											<td class="text-right" style="width: 40%;"><strong>Сеть:</strong></td>
											<td class="text-left">${taskStatus.marketPoint.market.caption}&nbsp;(${taskStatus.marketPoint.description})</td>
										</tr>
									</c:if>
									<c:if test="${not empty taskStatus.user}">
										<tr>
											<td class="text-right" style="width: 40%;"><strong>Пользователь:</strong></td>
											<td class="text-left">${taskStatus.user.email}&nbsp;(${taskStatus.user.title})</td>
										</tr>
									</c:if>
									<c:if test="${not empty taskStatus.error}">
										<tr>
											<td class="text-right alert-warning"><strong>Ошибка: </strong></td>
											<td class="text-left alert-warning">${taskStatus.error}</td>
										</tr>
									</c:if>
								</table>
							</div>
						</c:forEach>
					</div>

				</div>
				<div class="panel-footer">
					<span></span>
				</div>
			</form>
		</div>
	</tiles:putAttribute>
</tiles:insertDefinition>



