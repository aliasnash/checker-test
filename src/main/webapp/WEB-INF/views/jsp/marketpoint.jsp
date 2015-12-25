<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>

<tiles:insertDefinition name="defaultTemplate">
	<tiles:putAttribute name="title" value="Checker Category" />
	<tiles:putAttribute name="body">
		<div class="panel panel-default">
			<div class="panel-heading">
				Редактор информации о магазине <strong>${market.caption}</strong>
			</div>
			<div class="panel-body" id="articul-listing">
				<table class="table">
					<thead>
						<tr>
							<th style="vertical-align: middle">#</th>
							<th style="vertical-align: middle">Регион</th>
							<th style="vertical-align: middle">Город</th>
							<th style="vertical-align: middle">Адрес</th>
							<th class="text-right">
								<spring:url value="/market/list" htmlEscape="true" var="marketListUrl" />
								<a class="btn btn-default btn-sm" href="${marketListUrl}"> <span class="glyphicon glyphicon-arrow-left"></span>&nbsp;Назад
								</a> <a data-element-id="" data-element-name="" data-toggle="modal" data-target="#modal-edit-market-point" class="btn btn-sm btn-success"> <span
										class="glyphicon glyphicon-plus-sign" aria-hidden="true"></span> &nbsp;Добавить
								</a>
							</th>
						</tr>
					</thead>
					<tbody>

						<c:forEach items="${pointsList}" var="point" varStatus="status">
							<tr>
								<td>${status.index + 1}</td>
								<td>${point.city.region.caption}</td>
								<td>${point.city.caption}</td>
								<td>${point.description}</td>
								<td>
									<div class="btn-group pull-right" role="group" aria-label="...">
										<a data-element-id="${point.id}" data-element-name="${point.description}" data-element-id-city="${point.city.id}" data-toggle="modal"
											data-target="#modal-edit-market-point" class=" btn btn-sm btn-primary"> <span class="glyphicon glyphicon-edit" aria-hidden="true"></span>
										</a>
										<spring:url value="/market/${point.idMarket}/point/${point.id}/delete" var="pointDeleteUrl" htmlEscape="true" />
										<a class="btn btn-sm btn-danger" href="${pointDeleteUrl}" onclick="return confirm('Вы действительно хотите удалить \'${point.description}\'?')"> <span
												class="glyphicon glyphicon-remove" aria-hidden="true"></span>
										</a>
									</div>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<!-- modal -->
				<div aria-hidden="true" style="display: none;" class="modal fade" id="modal-edit-market-point">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal" aria-label="Close">
									<span aria-hidden="true">×</span>
								</button>
								<h4 class="modal-title">Информация о магазине</h4>
							</div>
							<form class="form-horizontal" role="form" action="<spring:url value="/market/${market.id}/point/update" htmlEscape="true" />" method="post">
								<input value="" name="id" type="hidden">
								<input value="" name="idcity" type="hidden">

								<div class="modal-body">
									<div class="form-group">
										<label for="city-region" class="col-md-4 control-label">Город:</label>
										<div class="col-md-5">
											<select name="city_id" class="selectpicker form-control" id="city-region" title="Выберите город">
												<c:forEach items="${cityMap}" var="map">
													<optgroup label="${map.key}">
														<c:forEach items="${map.value}" var="city">
															<option value="${city.id}">${city.caption}</option>
														</c:forEach>
													</optgroup>
												</c:forEach>
											</select>
										</div>
									</div>
									<div class="form-group">
										<label for="address-name" class="col-md-4 control-label">Адрес:</label>

										<div class="col-md-5">
											<input name="name" maxlength="50" class="form-control" id="address-name" placeholder="Адрес..." type="text">
										</div>
									</div>
								</div>

								<div class="modal-footer">
									<button type="button" class="btn btn-default btn-sm" data-dismiss="modal">Закрыть</button>
									<button type="submit" class="btn btn-primary btn-sm" id="save-market-point">Сохранить</button>
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



