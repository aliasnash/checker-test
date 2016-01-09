<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.joda.org/joda/time/tags" prefix="joda"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="/WEB-INF/tld/customTaglib.tld" prefix="tag"%>

<tiles:insertDefinition name="defaultTemplate">
	<tiles:putAttribute name="title" value="Checker Task Complete" />
	<tiles:putAttribute name="body">
		<script>
			contexPath = "${pageContext.servletContext.contextPath}";
		</script>
		<div class="panel panel-default">
			<div class="panel-heading clearfix">
				Фильтр
				<span class="pull-right">
					<a class="btn btn-default collapse-button" href="#filter-for-tasks-complete" data-toggle="collapse" aria-expanded="true">
						<span class="glyphicon glyphicon-chevron-up"></span>
						<span class="glyphicon glyphicon-chevron-down"></span>
					</a>
				</span>
			</div>
			<div class="panel-body collapse  in" id="filter-for-tasks-complete">
				<form class="form-inline" role="form" action="<spring:url value="/taskcomplete/list" htmlEscape="true" />" method="post">
					<div class="modal-body">
						<div class="row">
							<div class="form-group col-md-3">
								<label for="filter_city" class="col-md-12  control-label">Город:</label>
								<div class="col-md-12">
									<select name="filter_city_id" class="selectpicker form-control" id="filter_city" title="Выберите город" data-size="15">
										<c:forEach items="${cityMap}" var="map">
											<optgroup label="${map.key}">
												<c:forEach items="${map.value}" var="city">
													<option ${idCityCompleteSaved == city.id ? 'selected' : ''} value="${city.id}">${city.caption}</option>
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
															<option ${idMarketPointCompleteSaved == marketpoint.id ? 'selected' : ''} data-subtext="${marketpoint.market.owner?'своя сеть':''}" value="${marketpoint.id}">${marketpoint.market.caption}&nbsp;(${marketpoint.description})</option>
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
										<option ${empty idUserCompleteSaved ? 'selected' : ''} value="">все</option>
										<c:forEach items="${userList}" var="user">
											<option ${idUserCompleteSaved == user.id ? 'selected' : ''} value="${user.id}">${user.email}&nbsp;(${user.title})</option>
										</c:forEach>
									</select>
								</div>
							</div>
							<div class="form-group col-md-3">
								<label for="date" class="col-md-12  control-label">Дата создания задачи:</label>
								<div class="col-md-12">
									<input readonly="readonly" name="filtered_task_create_date" maxlength="50" class="form-control" id="date" placeholder="ГГГГ-ММ-ДД" value="${completeTaskCreateDate}"
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
							<a href="<spring:url value="/taskcomplete/reset" htmlEscape="true" />" class="btn btn-default btn-sm">Сбросить</a>
							<button type="submit" class="btn btn-primary btn-sm">Применить</button>
						</div>
					</div>
				</form>
			</div>
		</div>
		<div class="panel panel-default">
			<div class="panel-heading">
				Проверенные задачи&nbsp;
				<span class="badge">${recordsCount}</span>
			</div>
			<div class="panel-body">
				<c:forEach items="${taskArticleCompleteList}" var="ta">
					<div class="col-md-4">
						<div class="thumbnail text-center">
							<img class="img-thumbnail" data-photo-id="0" data-toggle="magnify" src="${rootUrl}${ta.photo.thumbNailsPath}" width="250px" height="300px"
								alt="ID:${ta.photo.id}, ${ta.article.caption}" />
							<div class="caption">
								<p>${ta.article.caption}</p>
								<p>
									ЦЕНА: <strong>${ta.price}</strong>
								</p>
								<p>
									<joda:format value="${ta.dateUpdate}" style="SM" />
								</p>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>

			<div class="text-center">
				<spring:url value="/taskcomplete/list" htmlEscape="true" var="pUrl" />
				<tag:paginate page="${page}" pageCount="${pageCount}" paginatorSize="10" uri="${pUrl}" next="&raquo;" previous="&laquo;" />
			</div>
		</div>
	</tiles:putAttribute>
</tiles:insertDefinition>



