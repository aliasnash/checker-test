<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.joda.org/joda/time/tags" prefix="joda"%>

<tiles:insertDefinition name="defaultTemplate">
	<tiles:putAttribute name="title" value="Checker Task Articles" />
	<tiles:putAttribute name="body">
		<script>
		   taskTree = '${taskTree}';
			selectedArticles = [
                <c:forEach var="item" items="${taskSelected}" varStatus="status">
                ${item}
                <c:if test="${!status.last}">,</c:if>
			    </c:forEach>
			    ];
			
		</script>


		<div class="panel panel-default">
			<div class="panel-heading">
				<div class="row">
					<div class="col-md-10" id="dataclick">Информация о задаче</div>
					<div class="col-md-2 text-right">
						<a class="btn btn-default btn-sm" href="<spring:url value="/tasks/list" htmlEscape="true"/>">
							<span class="glyphicon glyphicon-arrow-left"></span>
							Назад
						</a>
					</div>
				</div>
			</div>
			<div class="panel-body">
				<div class="row">
					<div class="col-md-12">
						<h3 class="h3">Задача: "${task.caption}"</h3>
					</div>
				</div>
				<hr>
				<div class="row">
					<div class="col-md-12">
						Магазин <strong>${task.marketPoint.market.caption}&nbsp;(${task.marketPoint.description})</strong>
					</div>
				</div>
				<div class="row">
					<div class="col-md-12">
						Дата создания: <strong><joda:format value="${task.dateAdded}" style="SM" /></strong>
					</div>
				</div>
				<div class="row">
					<div class="col-md-12">
						Используемый шаблон: <strong>(${task.template.id})&nbsp;${task.template.caption}</strong>
					</div>
				</div>


				<c:if test="${not empty task.user}">
					<div class="row">
						<div class="col-md-12">
							Назначена на <strong>${task.user.email}&nbsp;(${task.user.title})</strong>
						</div>
					</div>
				</c:if>
				<hr>

				<div class="row">
					<div class="row-fluid">
						<div class="col-md-2"></div>
						<div class="col-md-2" style="vertical-align: middle">
							Выбрано <strong><span id="task_selected_articul_count">${fn:length(taskSelected)}</span></strong> единиц артикула
						</div>
						<div class="col-md-6 form-group text-right">
							<div class="btn-group" role="group" aria-label="...">
								<a class="btn btn-default " id="task_expand_category">
									<i class="glyphicon glyphicon-list-alt"></i> Раскрыть категории
								</a>
								<a class="btn btn-default " id="task_collapse_category">
									<i class="glyphicon glyphicon-list-alt"></i> Свернуть категории
								</a>
							</div>
						</div>
						<div class="col-md-2"></div>
					</div>
				</div>
				<div class="row">
					<div class="col-md-2"></div>
					<div class="col-md-8 panel-group">
						<div id="task_tree"></div>
					</div>
					<div class="col-md-2"></div>
				</div>
			</div>
		</div>
	</tiles:putAttribute>
</tiles:insertDefinition>



