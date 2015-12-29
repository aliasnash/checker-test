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
				<table class="table">
					<thead>
						<tr>
							<th></th>
							<th style="vertical-align: middle">Пользователь</th>
							<th style="vertical-align: middle">Описание</th>
							<th style="vertical-align: middle">Цена</th>
							<th style="vertical-align: middle">Дата</th>
							<th></th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${taskArticleCheckList}" var="ta">
							<tr>
								<td><img class="img-thumbnail" data-toggle="magnify" src="${rootUrl}${ta.photo.thumbNailsPath}" width="150px" height="200px" alt="ID:${ta.photo.id}, ${ta.article.caption}" /></td>
								<td style="vertical-align: middle">${ta.tasks.user.title}</td>
								<td style="vertical-align: middle">${ta.article.caption}</td>
								<td style="vertical-align: middle">${ta.price}</td>
								<td style="vertical-align: middle"><joda:format value="${ta.dateUpdate}" pattern="yyyy-MM-dd" /></td>
								<td style="vertical-align: middle">

									<div class="btn-group pull-right" aria-label="..." role="group">
										<a class=" btn btn-sm btn-info" href="/checked/13651"> <span class="glyphicon glyphicon-thumbs-up" aria-hidden="true"></span> Хорошее
										</a> <a class=" btn btn-sm btn-primary" data-target="#modal-correct-price" data-toggle="modal" data-element-price="35.00" data-element-id="13651"> <span
												class="glyphicon glyphicon-edit" aria-hidden="true"></span> Исправить
										</a> <a class="btn btn-sm btn-danger" data-target="#modal-add-task" data-element-id="13651" data-toggle="modal"> <span
												class="glyphicon glyphicon-thumbs-down" aria-hidden="true"></span> Плохое
										</a>
									</div>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>

			</div>
		</div>
	</tiles:putAttribute>
</tiles:insertDefinition>



