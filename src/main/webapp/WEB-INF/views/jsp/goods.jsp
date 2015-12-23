<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>

<tiles:insertDefinition name="defaultTemplate">
	<tiles:putAttribute name="title" value="Checker Goods" />
	<tiles:putAttribute name="body">
		<div class="panel panel-default">
			<div class="panel-heading">
				Редактор подкатегорий <strong>${category.caption}</strong>
			</div>
			<div class="panel-body">
				<table class="table">
					<thead>
						<tr>
							<th style="vertical-align: middle">#</th>
							<th style="vertical-align: middle">Подкатегория</th>
							<th class="text-right">
								<a class="btn btn-default btn-sm" href="<spring:url value="/category/list" htmlEscape="true" />"><span class="glyphicon glyphicon-arrow-left"></span>
									Назад</a> <a data-element-id="" data-element-name="" data-toggle="modal" data-target="#modal-edit-goods" class="btn btn-sm btn-success"> <span
										class="glyphicon glyphicon-plus-sign" aria-hidden="true"></span>&nbsp;Добавить
								</a>
							</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${goodsList}" var="goods" varStatus="status">
							<tr>
								<td>${status.index + 1}</td>
								<td>${goods.caption}</td>
								<td>
									<div class="btn-group pull-right" role="group" aria-label="...">
										<spring:url value="/category/${category.id}/${goods.id}/article/list" htmlEscape="true" var="articleListUrl" />
										<a class=" btn btn-sm btn-default" href="${articleListUrl}"> <span class="glyphicon glyphicon-list" aria-hidden="true"></span> Артикулы
										</a> <a data-element-id="${goods.id}" data-element-name="${goods.caption}" data-toggle="modal" data-target="#modal-edit-goods"
											class=" btn btn-sm btn-primary"> <span class="glyphicon glyphicon-edit" aria-hidden="true"></span>
										</a>
										<spring:url value="/category/${category.id}/${goods.id}/delete" var="categoryGoodsDeleteUrl" htmlEscape="true" />
										<a class="btn btn-sm btn-danger" href="${categoryGoodsDeleteUrl}"
											onclick="return confirm('Вы действительно хотите удалить подкатегорию \'${goods.caption}\' со всеми артикулами?')"> <span
												class="glyphicon glyphicon-remove" aria-hidden="true"></span>
										</a>
									</div>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<!-- modal -->
				<div class="modal fade" id="modal-edit-goods">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal" aria-label="Close">
									<span aria-hidden="true">×</span>
								</button>
								<h4 class="modal-title">Подкатегория</h4>
							</div>
							<form class="form-horizontal" role="form" action="<spring:url value="/category/${category.id}/goods/update" htmlEscape="true" />" method="post">
								<input value="" name="id" type="hidden">

								<div class="modal-body">
									<div class="form-group">
										<label for="subcategory-name" class="col-md-4 control-label">Наименование:</label>

										<div class="col-md-5">
											<input name="name" maxlength="50" class="form-control" id="subcategory-name" placeholder="Название подкатегории..." type="text">
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



