<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>

<tiles:insertDefinition name="defaultTemplate">
	<tiles:putAttribute name="title" value="Checker Cities" />
	<tiles:putAttribute name="body">
		<div class="panel panel-default">
			<div class="panel-heading clearfix">
				Фильтр
				<span class="pull-right">
					<a class="btn btn-default collapse-button" href="#filter-region" data-toggle="collapse" aria-expanded="true">
						<span class="glyphicon glyphicon-chevron-up"></span>
						<span class="glyphicon glyphicon-chevron-down"></span>
					</a>
				</span>
			</div>
			<div class="panel-body collapse in" id="filter-region">
				<form class="form-inline" role="form" action="<spring:url value="/city/list" htmlEscape="true" />" method="post">
					<div class="modal-body">
						<div class="row">
							<div class="form-group col-md-3">
								<label for="filter_city-region" class="col-md-12  control-label">Название:</label>
								<div class="col-md-12">
									<select name="filter_region_id" class="selectpicker form-control" id="filter_city-region" title="Выберите регион">
										<c:forEach items="${regionList}" var="region">
											<option ${idRegion == region.id ? 'selected' : ''} value="${region.id}">${region.caption }</option>
										</c:forEach>
									</select>
								</div>
							</div>
						</div>
						<div class="form-group">
							<!-- too keep empty space -->
						</div>
					</div>
					<div class="modal-footer">
						<div class="btn-group">
							<a href="<spring:url value="/city/reset" htmlEscape="true" />" class="btn btn-default btn-sm">Сбросить</a>
							<button type="submit" class="btn btn-primary btn-sm">Применить</button>
						</div>
					</div>
				</form>
			</div>
		</div>

		<div class="panel panel-default">
			<div class="panel-heading">Редактор городов</div>
			<div class="panel-body">
				<table class="table">
					<thead>
						<tr>
							<th>Регион</th>
							<th style="vertical-align: middle">Город</th>
							<th class="">
								<button data-element-id="" data-element-name="" data-toggle="modal" data-target="#modal-edit-city" class="pull-right btn btn-sm btn-success">
									<span class="glyphicon glyphicon-plus-sign" aria-hidden="true"></span>
									&nbsp;Добавить
								</button>
							</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${cityList}" var="city">
							<tr>
								<td width="150">${city.region.caption}</td>
								<td>${city.caption}</td>
								<td>
									<div class="btn-group pull-right" role="group" aria-label="...">
										<a data-element-id="${city.id}" data-element-name="${city.caption}" data-element-region="${city.region.id}" data-toggle="modal" data-target="#modal-edit-city"
											class=" btn btn-sm btn-primary">
											<span class="glyphicon glyphicon-edit" aria-hidden="true"></span>
										</a>
										<spring:url value="/city/delete/${city.region.id}/${city.id}" var="cityDeleteUrl" htmlEscape="true" />
										<a class="btn btn-sm btn-danger" href="${cityDeleteUrl}" onclick="return confirm('Вы действительно хотите удалить город \'${city.caption}\'?')">
											<span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
										</a>
									</div>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>

				<!-- modal -->
				<div aria-hidden="true" style="display: none;" class="modal fade" id="modal-edit-city">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal" aria-label="Close">
									<span aria-hidden="true">×</span>
								</button>
								<h4 class="modal-title">Город</h4>
							</div>
							<form class="form-horizontal" role="form" action="<spring:url value="/city/update" htmlEscape="true" />" method="post">
								<input value="" name="id" type="hidden">
								<input value="" name="idregion" type="hidden">
								<input value="" name="idregionfilter" type="hidden">

								<div class="modal-body">
									<div class="form-group">
										<label for="city-zone" class="col-md-4 control-label">Регион:</label>
										<div class="col-md-5">
											<select name="region_id" class="selectpicker form-control" id="city-region" title="Выберите регион">
												<c:forEach items="${regionList}" var="region">
													<option value="${region.id}">${region.caption }</option>
												</c:forEach>
											</select>
										</div>
									</div>
									<div class="form-group">
										<label for="city-name" class="col-md-4 control-label">Город:</label>
										<div class="col-md-5">
											<input name="name" maxlength="50" class="form-control" id="city-name" placeholder="Название города..." type="text">
										</div>
									</div>
								</div>

								<div class="modal-footer">
									<button type="button" class="btn btn-default btn-sm" data-dismiss="modal">Закрыть</button>
									<button type="submit" class="btn btn-primary btn-sm" id="save-city">Сохранить</button>
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



