<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>

<tiles:insertDefinition name="defaultTemplate">
	<tiles:putAttribute name="title" value="Checker Category" />
	<tiles:putAttribute name="body">
		<div class="panel panel-default">
			<div class="panel-heading">Редактор категорий</div>
			<div class="panel-body">
				<table class="table">
					<thead>
						<tr>
							<th style="vertical-align: middle">#</th>
							<th style="vertical-align: middle">Название категории</th>
							<th class="text-right">
								<a class="btn btn-default btn-sm" href="<spring:url value="/category/top/reset" htmlEscape="true" />"><span class="glyphicon glyphicon-flag"></span>
									Сброс ТОП артикулов</a> <a data-element-id="" data-element-name="" data-toggle="modal" data-target="#modal-edit-category" class="btn btn-sm btn-success">
									<span class="glyphicon glyphicon-plus-sign" aria-hidden="true"></span>&nbsp;Добавить
								</a>
							</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${categoryList}" var="category" varStatus="status">
							<tr>
								<td>${status.index + 1}</td>
								<td>${category.caption}</td>
								<td>
									<div class="btn-group pull-right" role="group" aria-label="...">
										<spring:url value="/category/${category.id}/goods/list" var="categoryGoodsUrl" htmlEscape="true" />
										<a class=" btn btn-sm btn-default" href="${categoryGoodsUrl}"> <span class="glyphicon glyphicon-list" aria-hidden="true"></span> Подкатегории
										</a> <a data-element-id="${category.id}" data-element-name="${category.caption }" data-toggle="modal" data-target="#modal-edit-category"
											class=" btn btn-sm btn-primary"> <span class="glyphicon glyphicon-edit" aria-hidden="true"></span>
										</a>
										<spring:url value="/category/${category.id}/delete" var="categoryDeleteUrl" htmlEscape="true" />
										<a class="btn btn-sm btn-danger" href="${categoryDeleteUrl}"
											onclick="return confirm('Вы действительно хотите удалить категорию \'${category.caption }\' и все товары?')"> <span
												class="glyphicon glyphicon-remove" aria-hidden="true"></span>
										</a>
									</div>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<!-- modal -->
				<div class="modal fade" id="modal-edit-category">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal" aria-label="Close">
									<span aria-hidden="true">×</span>
								</button>
								<h4 class="modal-title">Категория</h4>
							</div>
							<form class="form-horizontal" role="form" action="<spring:url value="/category/update" htmlEscape="true" />" method="post">
								<input value="" name="id" type="hidden">

								<div class="modal-body">
									<div class="form-group">
										<label for="category-name" class="col-md-4 control-label">Название:</label>

										<div class="col-md-5">
											<input name="name" maxlength="50" class="form-control" id="category-name" placeholder="Название категории..." type="text">
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
			</div>
		</div>
	</tiles:putAttribute>
</tiles:insertDefinition>



