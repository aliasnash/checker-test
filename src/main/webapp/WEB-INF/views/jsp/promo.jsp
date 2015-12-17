<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>

<tiles:insertDefinition name="defaultTemplate">
	<tiles:putAttribute name="title" value="Checker Promo" />
	<tiles:putAttribute name="body">
		<div class="panel panel-default">
			<div class="panel-heading">Типы акций</div>
			<div class="panel-body">
				<table class="table">
					<thead>
						<tr>
							<th style="vertical-align: middle">Название акции</th>
							<th class="">
								<button data-element-id="" data-element-name="" data-toggle="modal" data-target="#modal-edit-promo" class="pull-right btn btn-sm btn-success">
									<span class="glyphicon glyphicon-plus-sign" aria-hidden="true"></span>
									&nbsp;Добавить
								</button>
							</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${promoList}" var="promo">
							<tr>
								<td>${promo.caption }</td>
								<td>
									<div class="btn-group pull-right" role="group" aria-label="...">
										<a data-element-id="${promo.id}" data-element-name="${promo.caption }" data-toggle="modal" data-target="#modal-edit-promo"
											class=" btn btn-sm btn-primary"> <span class="glyphicon glyphicon-edit" aria-hidden="true"></span>
										</a>
										<spring:url value="/promo/delete/${promo.id}" var="promoDeleteUrl" htmlEscape="true" />
										<a class="btn btn-sm btn-danger" href="${promoDeleteUrl}" onclick="return confirm('Вы действительно хотите удалить тип акции \'${promo.caption}\'')">
											<span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
										</a>
									</div>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>

				<!-- modal -->
				<div class="modal fade" id="modal-edit-promo">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal" aria-label="Close">
									<span aria-hidden="true">×</span>
								</button>
								<h4 class="modal-title">Акция</h4>
							</div>
							<form class="form-horizontal" role="form" action="<spring:url value="/promo/update" htmlEscape="true" />" method="post">
								<input value="" name="id" type="hidden">

								<div class="modal-body">
									<div class="form-group">
										<label for="special-name" class="col-md-4 control-label">Название:</label>

										<div class="col-md-5">
											<input name="name" maxlength="50" class="form-control" id="special-name" placeholder="Название акции..." type="text">
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



