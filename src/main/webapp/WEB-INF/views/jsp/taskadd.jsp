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
						<a class="btn btn-default btn-sm" href="<spring:url value="/tasks/list" htmlEscape="true" />">
							<span class="glyphicon glyphicon-arrow-left"></span>
							&nbsp;Назад
						</a>
					</div>
				</div>
			</div>

			<form class="form-horizontal" role="form" action="<spring:url value="/tasks/upload" htmlEscape="true" />" method="post">
				<div class="panel-body" id="data-for-generate-task">
					<div class="form-group">
						<label for="id_task_name" class="col-md-4 control-label">Название задачи:</label>
						<div class="col-md-7">
							<input name="task_name" maxlength="50" class="form-control" id="id_task_name" placeholder="Название задачи..." type="text">
						</div>
					</div>

					<div class="form-group">
						<label for="select-city-name" class="col-md-4 control-label">Город:</label>
						<div class="col-md-6">
							<select name="select-city-name" class="selectpicker form-control" id="select-city-name" title="Выберите город" data-size="15">
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

					<div class="form-group" id="select-template-name-block" style="display: none;">
						<label for="select-template-name" class="col-md-4 control-label">Выбрать шаблон:</label>
						<div class="col-md-6">
							<select name="template_id" class="selectpicker form-control" id="select-template-name" title="Выберите шаблон" data-show-subtext="true" data-size="15">
								<option selected value="">Данные отсутствуют</option>
							</select>
						</div>
					</div>

					<div class="form-group" id="select-market-own-template-block" style="display: none;">
						<label for="market-point-own" class="col-md-4 control-label">Выбрать свою сеть:</label>
						<div class="col-md-6">
							<select name="marketpoint_own_id" class="selectpicker form-control" id="market-point-own" title="Выберите сеть" data-show-subtext="true" data-size="15"
								data-actions-box="true">
								<option selected value="">Данные отсутствуют</option>
							</select>
						</div>
					</div>
					<div class="form-group" id="select-market-other-template-block" style="display: none;">
						<label for="market-point-other" class="col-md-4 control-label">Выбрать сеть конкурента:</label>
						<div class="col-md-6">
							<select name="marketpoint_other_id[]" class="selectpicker form-control" id="market-point-other" title="Выберите сеть" multiple data-show-subtext="true" data-size="15"
								data-actions-box="true">
								<option selected value="">Данные отсутствуют</option>
							</select>
						</div>
					</div>

					<div class="form-group" id="block-user-name-checker" style="display: none;">
						<label for="select-user-name" class="col-md-4 control-label">Назначить на пользователя:</label>
						<div class="col-md-6 text-left">
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
								<c:if test="${results.taskNameError}">
									<tr>
										<td class="text-right" style="width: 40%;"><strong></strong></td>
										<td class="text-left">Не введено название задачи</td>
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



