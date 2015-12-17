<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>

<tiles:insertDefinition name="defaultTemplate">
	<tiles:putAttribute name="title" value="Checker Category" />
	<tiles:putAttribute name="body">
		<div class="panel panel-default">
			<div class="panel-heading">
				Редактор артикулов продукта <strong>${goods.caption}</strong>
				<span class="pull-right">
					Top product:&nbsp;
					<input id="top-product" type="checkbox">
				</span>
			</div>
			<div class="panel-body" id="articul-listing">
				<table class="table">
					<thead>
						<tr>
							<th style="vertical-align: middle">#</th>
							<th style="vertical-align: middle">Артикул</th>
							<th style="vertical-align: middle">Описание</th>
							<th style="vertical-align: middle">TOP</th>
							<th class="text-right">
								<spring:url value="/category/${goods.idCategory}/goods/list" htmlEscape="true" var="goodsListUrl" />
								<a class="btn btn-default btn-sm" href="${goodsListUrl}"><span class="glyphicon glyphicon-arrow-left"></span> Назад</a> <a data-element-id=""
									data-element-name="" data-toggle="modal" data-target="#modal-edit-articul" class="btn btn-sm btn-success"> <span
										class="glyphicon glyphicon-plus-sign" aria-hidden="true"></span>&nbsp;Добавить
								</a>
							</th>
						</tr>
					</thead>
					<tbody>

						<c:forEach items="${articleList}" var="article" varStatus="status">
							<tr class="${article.topProduct?'top-product':''} articul">
								<td>${status.index + 1}</td>
								<td>${article.articleCode}</td>
								<td>${article.caption}</td>
								<td><span class="${article.topProduct?'glyphicon glyphicon-ok':''}" aria-hidden="true"></span></td>
								<td>
									<div class="btn-group pull-right" role="group" aria-label="...">
										<a data-element-id="${article.id}" data-element-name="${article.caption}" data-element-code="${article.articleCode}"
											data-element-subcategory-id="${article.idGood}" data-toggle="modal" data-target="#modal-edit-articul"
											data-element-top-product="${article.topProduct?1:0}" class=" btn btn-sm btn-primary"> <span class="glyphicon glyphicon-edit" aria-hidden="true"></span>
										</a>
										<spring:url value="/category/${goods.idCategory}/${article.idGood}/${article.id}/delete" var="articleDeleteUrl" htmlEscape="true" />
										<a class="btn btn-sm btn-danger" href="${articleDeleteUrl}"
											onclick="return confirm('Вы действительно хотите удалить артикул \'${article.caption}\'?')"> <span class="glyphicon glyphicon-remove"
												aria-hidden="true"></span>
										</a>
									</div>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<!-- modal -->
				<div aria-hidden="true" style="display: none;" class="modal fade" id="modal-edit-articul">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal" aria-label="Close">
									<span aria-hidden="true">×</span>
								</button>
								<h4 class="modal-title">Артикул</h4>
							</div>
							<form class="form-horizontal" role="form" action="<spring:url value="/category/${goods.idCategory}/${goods.id}/article/update" htmlEscape="true" />"
								method="post">
								<input value="" name="id" type="hidden">

								<div class="modal-body">
									<div class="form-group">
										<label for="articul-name" class="col-md-4 control-label">Название:</label>

										<div class="col-md-5">
											<input name="name" maxlength="50" class="form-control" id="articul-name" placeholder="Название артикула..." type="text">
										</div>
									</div>
									<div class="form-group">
										<label for="articul-code" class="col-md-4 control-label">Код:</label>

										<div class="col-md-5">
											<input name="code" maxlength="50" class="form-control" id="articul-code" placeholder="Код артикула..." type="text">
										</div>
									</div>
									<div class="form-group">
										<label for="articul-top_product" class="col-md-4 control-label">Топ продукт:</label>

										<div class="col-md-5">
											<input name="top_product" class="form-control" id="articul-top_product" placeholder="Топ артикул..." type="checkbox">
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



