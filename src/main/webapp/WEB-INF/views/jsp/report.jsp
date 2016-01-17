<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.joda.org/joda/time/tags" prefix="joda"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="/WEB-INF/tld/customTaglib.tld" prefix="tag"%>
<%@ taglib uri="/WEB-INF/tld/functions.tld" prefix="myf"%>

<tiles:insertDefinition name="defaultTemplate">
	<tiles:putAttribute name="title" value="Checker Report" />
	<tiles:putAttribute name="body">
		<div class="panel panel-default">
			<div class="panel-heading clearfix">Настройки отчета</div>
			<div class="panel-body" id="filter-for-report-list">
				<form class="form-inline" role="form" action="<spring:url value="/report/generate" htmlEscape="true" />" method="post">
					<div class="modal-body">
						<div class="row">
							<div class="form-group col-md-3">
								<div id="filter_date_visibility">
									<label for="date" class="col-md-12  control-label">Дата создания задачи:</label>
									<div class="col-md-12">
										<input readonly="readonly" name="filter_task_create_date" maxlength="50" class="form-control" id="date" placeholder="ГГГГ-ММ-ДД" value="${reportTaskDate}" type="text">
									</div>
								</div>
							</div>
							<div class="form-group col-md-3">
								<div id="filter_city_visibility" style="${empty idCityReportSaved ? 'display: none;' : '' }">
									<label for="filter_city" class="col-md-12  control-label">Город:</label>
									<div class="col-md-12">
										<select name="filter_city_id" class="selectpicker form-control" id="filter_city" title="Выберите город" data-size="15">
											<c:forEach items="${cityMap}" var="map">
												<optgroup label="${map.key}">
													<c:forEach items="${map.value}" var="city">
														<option ${idCityReportSaved == city.id ? 'selected' : ''} value="${city.id}">${city.caption}</option>
													</c:forEach>
												</optgroup>
											</c:forEach>
										</select>
									</div>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="form-group col-md-3">
								<div id="filter_own_task_visibility" style="${empty idOwnTaskReportSaved ? 'display: none;' : '' }">
									<label for="filter_own_tasks" class="col-md-12  control-label">Задачи своей сети:</label>
									<div class="col-md-12">
										<select name="filter_own_task_id" class="selectpicker form-control" id="filter_own_tasks" title="Выберите задачу" data-size="15">
											<c:choose>
												<c:when test="${empty ownTaskList}">
													<option selected value="">Задачи отсутствуют</option>
												</c:when>
												<c:otherwise>
													<c:forEach items="${ownTaskList}" var="task">
														<option ${idOwnTaskReportSaved == task.id ? 'selected' : ''} value="${task.id}">${task.caption}</option>
													</c:forEach>
												</c:otherwise>
											</c:choose>
										</select>
									</div>
								</div>
							</div>
							<div class="form-group col-md-3">
								<div id="filter_other_task_visibility" style="${empty idOtherTaskReportSaved ? 'display: none;' : '' }">
									<label for="filter_other_tasks" class="col-md-12  control-label">Задачи конкурента:</label>
									<div class="col-md-12">
										<select name="filter_other_task_id[]" class="selectpicker form-control" id="filter_other_tasks" title="Выберите задачу" multiple data-size="15" data-actions-box="true"
											data-selected-text-format="count > 3">
											<c:choose>
												<c:when test="${empty otherTaskList}">
													<option selected value="">Задачи отсутствуют</option>
												</c:when>
												<c:otherwise>
													<c:forEach items="${otherTaskList}" var="task">
														<option ${myf:containsLong(idOtherTaskReportSaved, task.id) ? 'selected' : '' } value="${task.id}">${task.caption}</option>
													</c:forEach>
												</c:otherwise>
											</c:choose>
										</select>
									</div>
								</div>
							</div>
							<div class="form-group col-md-3">
								<div id="filter_promo_visibility" style="${empty idPromoReportSaved ? 'display: none;' : '' }">
									<label for="filter_promo" class="col-md-12 danger control-label">Промоакции:</label>
									<div class="col-md-12">
										<select name="filter_promo_id[]" class="selectpicker form-control" id="filter_promo" title="Выберите промо" multiple data-size="15" data-actions-box="true"
											data-selected-text-format="count > 3">
											<c:choose>
												<c:when test="${empty idPromoReportSaved}">
													<option selected value="-1">Без промо</option>
													<option data-divider="true"></option>
													<c:forEach items="${promoList}" var="promo">
														<option selected value="${promo.id}">${promo.caption}</option>
													</c:forEach>
												</c:when>
												<c:otherwise>
													<option ${myf:containsInt(idPromoReportSaved, -1) ? 'selected' : '' } value="-1">Без промо</option>
													<option data-divider="true"></option>
													<c:forEach items="${promoList}" var="promo">
														<option ${myf:containsInt(idPromoReportSaved, promo.id) ? 'selected' : '' } value="${promo.id}">${promo.caption}</option>
													</c:forEach>
												</c:otherwise>
											</c:choose>
										</select>
									</div>
								</div>
							</div>

							<div class="form-group col-md-3">
								<div id="filter_use_photo_visibility" style="${empty idPromoReportSaved ? 'display: none;' : '' }">
									<label for="filter_use_photo" class="col-md-12 danger control-label">Без фотографий:</label>
									<div class="col-md-12">
										<input name="filter_use_photo" class="form-control" id="filter_use_photo" placeholder="..." type="checkbox" ${withoutPhoto ? 'checked' : ''}>
									</div>
								</div>
							</div>
						</div>
						<div class="form-group">
							<!-- too keep empty space -->
						</div>
					</div>
					<div class="modal-footer">
						<div class="btn-group">
							<a href="<spring:url value="/report/reset" htmlEscape="true" />" class="btn btn-default btn-sm">Сбросить</a>
							<button type="submit" class="btn btn-primary btn-sm" id="generate_report">Применить</button>
						</div>
					</div>
				</form>
			</div>
		</div>

		<div class="panel panel-default">
			<div class="panel-heading">
				История отчетов
				<span class="badge">${recordsCount}</span>
			</div>
			<div class="panel-body">
				<table class="table">
					<thead>
						<tr>
							<th style="vertical-align: middle">#</th>
							<th style="vertical-align: middle">Дата создания</th>
							<th style="vertical-align: middle">Название</th>
							<th style="vertical-align: middle">Файл</th>
							<th style="vertical-align: middle">Размер</th>
							<th style="vertical-align: middle"></th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${reportList}" var="report">
							<tr class="${not empty idReport and idReport eq report.id ? 'success' : ''}">
								<td>${report.id}</td>
								<td><joda:format value="${report.dateAdded}" style="SM" /></td>
								<td>${report.caption}</td>
								<td><a href="${rootUrl}${report.filePath}">${report.filePath}</a></td>
								<td><fmt:formatNumber type="number" groupingUsed="false" value="${report.fileSize/1024/1024}" /> Mb</td>
								<td>
									<div class="btn-group pull-right" role="group" aria-label="...">
										<spring:url value="/report/${report.id}/delete?page=${page}" var="reportDeleteUrl" htmlEscape="true" />
										<a class="btn btn-sm btn-danger" href="${reportDeleteUrl}" onclick="return confirm('Вы действительно хотите удалить отчет \'${report.caption }\'')">
											<span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
										</a>
									</div>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			<div class="text-center">
				<spring:url value="/report" htmlEscape="true" var="pUrl" />
				<tag:paginate page="${page}" pageCount="${pageCount}" paginatorSize="10" uri="${pUrl}" next="&raquo;" previous="&laquo;" />
			</div>
		</div>
	</tiles:putAttribute>
</tiles:insertDefinition>
