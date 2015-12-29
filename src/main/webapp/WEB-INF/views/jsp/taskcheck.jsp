<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.joda.org/joda/time/tags" prefix="joda"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>

<tiles:insertDefinition name="defaultTemplate">
	<tiles:putAttribute name="title" value="Checker Task Check" />
	<tiles:putAttribute name="body">
		<div class="panel panel-default">
			<div class="panel-heading">Проверка задач</div>
			<div class="panel-body">
				<c:forEach items="${taskArticleCheckList}" var="ta">
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
								<div class="btn-group" role="group" aria-label="...">
									<a class=" btn btn-sm btn-success" href="<spring:url value="/taskcheck/complete/${ta.id}" htmlEscape="true" />">
										<span class="glyphicon glyphicon-thumbs-up" aria-hidden="true"></span>
										Хорошее
									</a>
									<a class=" btn btn-sm btn-primary" data-target="#modal-correct-price" data-toggle="modal" data-element-price="${ta.price}" data-element-id="${ta.id}">
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
				<ul class="pagination ">
					<li><a href="<spring:url value="/taskcheck/list?page=${page-1}" htmlEscape="true" />" aria-label="Previous">
							<span aria-hidden="true">&laquo;</span>
						</a></li>
					<c:forEach var="pageIndex" begin="1" end="${pageCount}">
						<li class="${page==pageIndex?'active':''}"><a href="<spring:url value="/taskcheck/list?page=${pageIndex}" htmlEscape="true" />">${pageIndex}</a></li>
					</c:forEach>
					<li><a href="<spring:url value="/taskcheck/list?page=${page+1}" htmlEscape="true" />" aria-label="Next">
							<span aria-hidden="true">&raquo;</span>
						</a></li>
				</ul>
			</div>
		</div>

		<!-- modal -->
		<div class="modal fade" id="modal-correct-price">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title">Исправить цену</h4>
					</div>
					<form class="form-horizontal" role="form" action="<spring:url value="/taskcheck/correct" htmlEscape="true" />" method="post">
						<input type="hidden" value="" name="id">

						<div class="modal-body">
							<div class="form-group">
								<label for="price" class="col-md-4 control-label">Новая цена:</label>

								<div class="col-md-7">
									<input id="price" class="form-control" type="text" name="price" value="" />
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
					<form class="form-horizontal" role="form" action="<spring:url value="/taskcheck/fail/new" htmlEscape="true" />" method="post">
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



