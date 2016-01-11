<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.joda.org/joda/time/tags" prefix="joda"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="/WEB-INF/tld/customTaglib.tld" prefix="tag"%>

<tiles:insertDefinition name="defaultTemplate">
	<tiles:putAttribute name="title" value="Checker Task Check" />
	<tiles:putAttribute name="body">
		<script>
			contexPath = "${pageContext.servletContext.contextPath}";
		</script>
		<div class="panel panel-default">
			<div class="panel-heading clearfix">
				Фильтр
				<span class="pull-right">
					<a class="btn btn-default collapse-button" href="#filter-for-tasks-check" data-toggle="collapse" aria-expanded="true">
						<span class="glyphicon glyphicon-chevron-up"></span>
						<span class="glyphicon glyphicon-chevron-down"></span>
					</a>
				</span>
			</div>
			<div class="panel-body collapse in" id="filter-for-tasks-check">
				<form class="form-inline" role="form" action="<spring:url value="/taskcheck/list" htmlEscape="true" />" method="post">
					<div class="modal-body">
						<div class="row">
							<div class="form-group col-md-3">
								<label for="filter_city" class="col-md-12  control-label">Город:</label>
								<div class="col-md-12">
									<select name="filter_city_id" class="selectpicker form-control" id="filter_city" title="Выберите город" data-size="15">
										<c:forEach items="${cityMap}" var="map">
											<optgroup label="${map.key}">
												<c:forEach items="${map.value}" var="city">
													<option ${idCityCheckSaved == city.id ? 'selected' : ''} value="${city.id}">${city.caption}</option>
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
															<option ${idMarketPointCheckSaved == marketpoint.id ? 'selected' : ''} data-subtext="${marketpoint.market.owner?'своя сеть':''}" value="${marketpoint.id}">${marketpoint.market.caption}&nbsp;(${marketpoint.description})</option>
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
										<option ${empty idUserCheckSaved ? 'selected' : ''} value="">все</option>
										<c:forEach items="${userList}" var="user">
											<option ${idUserCheckSaved == user.id ? 'selected' : ''} value="${user.id}">${user.email}&nbsp;(${user.title})</option>
										</c:forEach>
									</select>
								</div>
							</div>
							<div class="form-group col-md-3">
								<label for="date" class="col-md-12  control-label">Дата создания задачи:</label>
								<div class="col-md-12">
									<input readonly="readonly" name="filtered_task_create_date" maxlength="50" class="form-control" id="date" placeholder="ГГГГ-ММ-ДД" value="${checkTaskCreateDate}"
										type="text">
								</div>
							</div>
						</div>
						<div class="form-group">
							<!-- too keep empty space -->
						</div>
					</div>
					<div class="modal-footer">
						<div class="btn-group">
							<a href="<spring:url value="/taskcheck/reset" htmlEscape="true" />" class="btn btn-default btn-sm">Сбросить</a>
							<button type="submit" class="btn btn-primary btn-sm">Применить</button>
						</div>
					</div>
				</form>
			</div>
		</div>

		<div class="panel panel-default">
			<div class="panel-heading">
				Проверка задач&nbsp;
				<span class="badge">${recordsCount}</span>
			</div>
			<div class="panel-body">
				<c:forEach items="${taskArticleCheckList}" var="ta">
					<div class="col-md-4">
						<div class="thumbnail text-center">
							<img class="img-thumbnail" data-photo-id="0" data-toggle="magnify" src="${rootUrl}${ta.photo.thumbNailsPath}" width="250px" height="300px"
								alt="ID:${ta.photo.id}, ${ta.article.caption}" />
							<div class="caption">
								<p>${ta.article.caption}</p>
								<p>
									ЦЕНА: <strong>${ta.price}</strong> ${empty ta.weight ? '&nbsp;' : ' ВЕС:' } <strong>${empty ta.weight ? '&nbsp;' : ta.weight }</strong>
								</p>
								<p>
									<joda:format value="${ta.dateUpdate}" style="SM" />
								</p>
								<p>${empty ta.promo ? 'без акции' : ta.promo.caption }</p>
								<p>
									<strong>${ta.availability ? '&nbsp;' : 'продукт не доступен' }</strong>
								</p>
								<p>${ta.taskComment}</p>
								<div class="btn-group" role="group" aria-label="...">
									<a class=" btn btn-sm btn-success" href="<spring:url value="/taskcheck/complete/${ta.id}?page=${page}" htmlEscape="true" />">
										<span class="glyphicon glyphicon-thumbs-up" aria-hidden="true"></span>
										Хорошее
									</a>
									<a class=" btn btn-sm btn-primary" data-target="#modal-correct-check-task" data-toggle="modal" data-element-price="${ta.price}" data-element-weight="${ta.weight}"
										data-element-availability="${ta.availability}" data-element-id="${ta.id}">
										<span class="glyphicon glyphicon-edit" aria-hidden="true"></span>
										Исправить
									</a>
									<a class="btn btn-sm btn-danger" data-target="#modal-add-task" data-element-id="${ta.id}" data-toggle="modal">
										<span class="glyphicon glyphicon-thumbs-down" aria-hidden="true"></span>
										Плохое
									</a>
								</div>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>

			<div class="text-center">
				<spring:url value="/taskcheck/list" htmlEscape="true" var="pUrl" />
				<tag:paginate page="${page}" pageCount="${pageCount}" paginatorSize="10" uri="${pUrl}" next="&raquo;" previous="&laquo;" />
			</div>
		</div>

		<!-- modal -->
		<div class="modal fade" id="modal-correct-check-task">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title">Исправить информацию</h4>
					</div>
					<form class="form-horizontal" role="form" action="<spring:url value="/taskcheck/correct?page=${page}" htmlEscape="true" />" method="post">
						<input type="hidden" value="" name="id">

						<div class="modal-body">
							<div class="form-group">
								<label for="check-task-price" class="col-md-4 control-label">Новая цена:</label>

								<div class="col-md-7">
									<input id="check-task-price" class="form-control" type="text" name="check-task-price" value="" />
								</div>
							</div>
							<div class="form-group">
								<label for="check-task-weight" class="col-md-4 control-label">Вес:</label>

								<div class="col-md-7">
									<input id="check-task-weight" class="form-control" type="text" name="check-task-weight" maxlength="8" value="" />
								</div>
							</div>
							<div class="form-group">
								<label for="check-task-availability" class="col-md-4 control-label">Доступность:</label>

								<div class="col-md-7">
									<input name="check-task-availability" class="form-control" id="check-task-availability" placeholder="..." type="checkbox">
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

		<!-- modal -->
		<div class="modal fade" id="modal-add-task">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title">Новая задача</h4>
					</div>
					<form class="form-horizontal" role="form" action="<spring:url value="/taskcheck/fail/new?page=${page}" htmlEscape="true" />" method="post">
						<input type="hidden" value="" name="id">

						<div class="modal-body">
							<div class="form-group">
								<label for="fail-task-description" class="col-md-4 control-label">Задание:</label>

								<div class="col-md-7">
									<textarea rows="4" maxlength="255" class="form-control" id="fail-task-description" name="fail-description" placeholder="Что не так на фото?"></textarea>
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
	</tiles:putAttribute>
</tiles:insertDefinition>



