<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="/WEB-INF/tld/customTaglib.tld" prefix="tag"%>

<tiles:insertDefinition name="defaultTemplate">
	<tiles:putAttribute name="title" value="Checker Dynamic" />
	<tiles:putAttribute name="body">
		<script>
			contexPath = "${pageContext.servletContext.contextPath}";
		</script>
		<div class="panel panel-default">
			<div class="panel-heading clearfix">
				Фильтр
				<span class="pull-right">
					<a class="btn btn-default collapse-button" href="#filter-for-tasks-dyn" data-toggle="collapse" aria-expanded="true">
						<span class="glyphicon glyphicon-chevron-up"></span>
						<span class="glyphicon glyphicon-chevron-down"></span>
					</a>
				</span>
			</div>
			<div class="panel-body collapse in" id="filter-for-tasks-dyn">
				<form class="form-inline" role="form" action="<spring:url value="/dynamic" htmlEscape="true" />" method="post">
					<div class="modal-body">
						<div class="row">
							<div class="form-group col-md-3">
								<label for="filter_city" class="col-md-12  control-label">Город:</label>
								<div class="col-md-12">
									<select name="filter_city_id" class="selectpicker form-control" id="filter_city" title="Выберите город" data-size="15">
										<c:forEach items="${cityMap}" var="map">
											<optgroup label="${map.key}">
												<c:forEach items="${map.value}" var="city">
													<option ${idCityDynSaved == city.id ? 'selected' : ''} value="${city.id}">${city.caption}</option>
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
															<option ${idMarketPointDynSaved == marketpoint.id ? 'selected' : ''} data-subtext="${marketpoint.market.owner?'своя сеть':''}" value="${marketpoint.id}">${marketpoint.market.caption}&nbsp;(${marketpoint.description})</option>
														</c:forEach>
													</optgroup>
												</c:forEach>
											</c:otherwise>
										</c:choose>
									</select>
								</div>
							</div>
							<div class="form-group col-md-3">
								<label for="filter_user" class="col-md-12  control-label">Ответственный пользователь:</label>
								<div class="col-md-12">
									<select name="filter_user_id" class="selectpicker form-control" id="filter_user" data-size="15">
										<option ${empty idUserDynSaved ? 'selected' : ''} value="">все</option>
										<c:forEach items="${userList}" var="user">
											<option ${idUserDynSaved == user.id ? 'selected' : ''} value="${user.id}">${user.email}&nbsp;(${user.title})</option>
										</c:forEach>
									</select>
								</div>
							</div>
							<div class="form-group col-md-3">
								<label for="date" class="col-md-12  control-label">Дата создания задачи:</label>
								<div class="col-md-12">
									<input readonly="readonly" name="filtered_task_create_date" maxlength="50" class="form-control" id="date" placeholder="ГГГГ-ММ-ДД" value="${dynTaskCreateDate}" type="text">
								</div>
							</div>
						</div>
						<div class="form-group">
							<!-- too keep empty space -->
						</div>
					</div>
					<div class="modal-footer">
						<div class="btn-group">
							<a href="<spring:url value="/dynamic/reset" htmlEscape="true" />" class="btn btn-default btn-sm">Сбросить</a>
							<button type="submit" class="btn btn-primary btn-sm">Применить</button>
						</div>
					</div>
				</form>
			</div>
		</div>

		<div class="panel panel-default">
			<div class="panel-heading">
				Динамика задач
				<span class="badge">${recordsCount}</span>
			</div>
			<div class="panel-body">
				<c:forEach items="${dynamicTasks}" var="dyn">

					<div class="col-md-4">
						<div class="thumbnail text-center">
							<div class="caption">
								<p>(#${dyn.idTask})&nbsp;${dyn.caption}</p>
								<div class="progress">
									<div class="progress-bar progress-bar-success" data-toggle="tooltip" title="закрытых задач:${dyn.completeCount}" style="width: ${dyn.completeCount * 100 / dyn.sum}%;">${dyn.completeCount}&nbsp;Complete</div>
									<!-- <div class="progress-bar progress-bar-danger" data-toggle="tooltip" title="задач на переделку:${dyn.failCount}" style="width: ${dyn.failCount * 100 / dyn.sum}%;">${dyn.failCount}&nbsp;Fail</div> -->
									<div class="progress-bar progress-bar-info" data-toggle="tooltip" title="прочеканых задач:${dyn.checkCount}" style="width: ${dyn.checkCount * 100 / dyn.sum}%;">${dyn.checkCount}&nbsp;Check</div>
									<div class="progress-bar progress-bar-warning" data-toggle="tooltip" title="не обработанных задач:${dyn.assignedCount + dyn.failCount}"
										style="width: ${(dyn.assignedCount + dyn.failCount) * 100 / dyn.sum}%;">${dyn.assignedCount + dyn.failCount}&nbsp;On&nbsp;user</div>
								</div>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
			<div class="text-center">
				<spring:url value="/dynamic" htmlEscape="true" var="pUrl" />
				<tag:paginate page="${page}" pageCount="${pageCount}" paginatorSize="10" uri="${pUrl}" next="&raquo;" previous="&laquo;" />
			</div>
		</div>
	</tiles:putAttribute>
</tiles:insertDefinition>
