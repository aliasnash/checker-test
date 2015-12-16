<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<tiles:insertDefinition name="defaultTemplate">
	<tiles:putAttribute name="title" value="Checker Goods" />
	<tiles:putAttribute name="body">
		<div class="panel panel-default">
			<div class="panel-heading clearfix">
				Фильтр
				<span class="pull-right">
					<a class="btn btn-default collapse-button" href="#report-filter" data-toggle="collapse" aria-expanded="true"> <span
							class="glyphicon glyphicon-chevron-up"></span> <span class="glyphicon glyphicon-chevron-down"></span>
					</a>
				</span>
			</div>
			<div class="panel-body collapse in" id="report-filter">
				<form class="form-inline" role="form" action="/check/filter" method="post">
					<div class="modal-body">
						<div class="row">
							<div class="form-group col-md-3">
								<label for="city-zone" class="col-md-12  control-label">Название:</label>

								<div class="col-md-12">
									<select name="zone_id" class="form-control" id="city-zone" placeholder="Регион...">
										<option selected="selected" value="-1">Выберите регион</option>
										<!--option value="-1">Все регионы</option-->
										<option value="1">Москва и м/о</option>
										<option value="2">Северо запад</option>
										<option value="3">Юг</option>
										<option value="5">Урал</option>
										<option value="4">Центр</option>
										<option value="6">Сибирь</option>
									</select>
								</div>
							</div>
							<div class="form-group col-md-3">
								<label for="networks" class="col-md-12  control-label">Сеть для проверки:</label>

								<div class="col-md-12">
									<select name="network_id" class="form-control" id="networks" placeholder="Торговые сети">
										<option selected="selected" value="-1">Все сети</option>
										<!--option value="-1">Все сети</option-->
										<option value="1">Шаблоны</option>
										<option value="11">Тестовая</option>
										<option value="15">Окей Пражская_ФРОВ_пн_пт</option>
										<option value="16">Окей Пражская_Биржа</option>
										<option value="17">Карусель ю.Бут_ФРОВ_пн_пт</option>
										<option value="18">Карусель ю.Бут_Биржа</option>
										<option value="19">Окей Пражская_СП</option>
										<option value="20">Окей Пражская_Охл_рыба</option>
										<option value="21">Окей Пражская_Диабет_пит</option>

									</select>
								</div>
							</div>
							<div class="form-group col-md-3">
								<label for="categories" class="col-md-12  control-label">Категория:</label>

								<div class="col-md-12">
									<select name="category_id" class="form-control" id="categories" placeholder="Категория">
										<option selected="selected" value="-1">Все категории</option>
										<option value="1">Замороженные продукты</option>
										<option value="2">Молочная гастрономия</option>
										<option value="3">Детское питание (Fresh)</option>
										<option value="4">Мясная гастрономия</option>
										<option value="5">Кондитерские изделия (Fresh)</option>
										<option value="6">Хлеб, хлебобулочные изделия (Food)</option>
										<option value="7">Алкоголь</option>
										<option value="8">Кондитерские изделия (Food)</option>
										<option value="9">Бакалея (Food)</option>

									</select>
								</div>
							</div>
							<div class="form-group col-md-3">
								<label for="date" class=" col-md-12 control-label">Дата:</label>

								<div class="col-md-5">
									<input readonly="readonly" name="date" maxlength="50" class="form-control" id="date" placeholder="DD-MM-YYYY" value="2015-12-15" type="text">
								</div>
							</div>
						</div>
						<div class="row">
							<br>
						</div>
						<div class="row">
							<div class="form-group col-md-3">
								<label for="city-name" class="col-md-12 control-label hidden">Город:</label>

								<div class="col-md-12 hidden">
									<select name="city_id" class="form-control" id="city-name" placeholder="Город...">
										<option value="-1">Все города</option>
									</select>
								</div>
							</div>
							<div class="form-group col-md-3"></div>
							<div class="form-group col-md-3">
								<label for="articul-name" class="col-md-12 control-label hidden">Артикул:</label>

								<div class="col-md-12 hidden">
									<select name="articul_id" class="form-control" id="articul-name" placeholder="Артикул...">
										<option value="-1">Все артикулы</option>
									</select>
								</div>
							</div>
							<div class="form-group col-md-3"></div>
						</div>
						<div class="form-group">
							<!-- too keep empty space -->
						</div>
					</div>
					<div class="modal-footer">
						<div class="btn-group">
							<a href="http://x5.checkprice.lqom.ru/check/filter/reset" class="btn btn-default btn-sm">Сбросить</a>
							<button type="submit" class="btn btn-primary btn-sm">Применить</button>
						</div>
					</div>
				</form>
			</div>
		</div>
		<div class="panel panel-default">
			<div class="panel-heading">Отчеты по торговой сети "Окей Праж_Промо_02_фуд"</div>
			<div class="panel-body">
				<div class="col-md-3 report-item">
					<div class="row">
						<spring:url value="/resources/goods/no-photo-available.png" var="picUrl" htmlEscape="true" />
						<img class="col-md-12" src="${picUrl}" alt=" " title="">
					</div>
					<div class="row text-center">
						<span class="pull-left report-price">
							3427577 АГУША Сок ГРУША освет.200мл: <strong> Отсутствует </strong>
						</span>
						<span class="pull-right report-time">
							<small>09:14:12</small>
						</span>
						<span class="articul-title"></span>
					</div>
				</div>
				<div class="col-md-3 report-item">
					<div class="row">
						<spring:url value="/resources/goods/no-photo-available.png" var="picUrl" htmlEscape="true" />
						<img class="col-md-12" src="${picUrl}" alt=" " title="">
					</div>
					<div class="row text-center">
						<span class="pull-left report-price">
							3355289 АГУША Сок дет.Ябл-Вишня TBA Base 200мл: <strong> Отсутствует </strong>
						</span>
						<span class="pull-right report-time">
							<small>09:14:59</small>
						</span>
						<span class="articul-title"></span>
					</div>
				</div>
				<div class="col-md-3 report-item">
					<div class="row">
						<spring:url value="/resources/goods/1.jpg" var="picUrl" htmlEscape="true" />
						<img class="col-md-12" data-photo-id="4537" src="${picUrl}" alt=" " title="">
						<a class="btn btn-default correct-btn" href="#" data-element-id="9633" data-toggle="modal" data-target="#modal-add-task"> <span
								class="glyphicon glyphicon-thumbs-down"></span>
						</a> <a class="btn btn-default correct-price-btn btn-info" href="#" data-element-id="9633" data-element-price="23.93" data-toggle="modal"
							data-target="#modal-correct-price"> <span class="glyphicon glyphicon-tag"></span>
						</a>
					</div>
					<div class="row text-center">
						<span class="pull-left report-price">
							3355291 АГУША Сок дет.Ябл-Шипов.TBA Base 200м: <strong> 23.93 </strong>
						</span>
						<span class="pull-right report-time">
							<small>09:17:15</small>
						</span>
						<span class="articul-title"></span>
					</div>
				</div>
				<div class="col-md-3 report-item">
					<div class="row">
						<spring:url value="/resources/goods/no-photo-available.png" var="picUrl" htmlEscape="true" />
						<img class="col-md-12" src="${picUrl}" alt=" " title="">
					</div>
					<div class="row text-center">
						<span class="pull-left report-price">
							3050091 АГУША Сок с мякотью яблоко-банан 200мл: <strong> Отсутствует </strong>
						</span>
						<span class="pull-right report-time">
							<small>09:17:35</small>
						</span>
						<span class="articul-title"></span>
					</div>
				</div>
				<div class="col-md-3 report-item">
					<div class="row">
						<spring:url value="/resources/goods/2.jpg" var="picUrl" htmlEscape="true" />
						<img class="col-md-12" data-photo-id="4538" src="${picUrl}" alt=" " title="">
						<a class="btn btn-default correct-btn" href="#" data-element-id="9635" data-toggle="modal" data-target="#modal-add-task"> <span
								class="glyphicon glyphicon-thumbs-down"></span>
						</a> <a class="btn btn-default correct-price-btn btn-info" href="#" data-element-id="9635" data-element-price="23.93" data-toggle="modal"
							data-target="#modal-correct-price"> <span class="glyphicon glyphicon-tag"></span>
						</a>
					</div>
					<div class="row text-center">
						<span class="pull-left report-price">
							3004046 АГУША Сок МУЛЬТИФРУКТ с мякотью 200мл: <strong> 23.93 </strong>
						</span>
						<span class="pull-right report-time">
							<small>09:17:35</small>
						</span>
						<span class="articul-title"></span>
					</div>
				</div>

				<div class="col-md-3 report-item">
					<div class="row">
						<spring:url value="/resources/goods/3.jpg" var="picUrl" htmlEscape="true" />
						<img class="col-md-12" data-photo-id="5170" src="${picUrl}" alt=" " title="">
						<a class="btn btn-default correct-btn" href="#" data-element-id="11111" data-toggle="modal" data-target="#modal-add-task"> <span
								class="glyphicon glyphicon-thumbs-down"></span>
						</a> <a class="btn btn-default correct-price-btn btn-info" href="#" data-element-id="11111" data-element-price="154.90" data-toggle="modal"
							data-target="#modal-correct-price"> <span class="glyphicon glyphicon-tag"></span>
						</a>
					</div>
					<div class="row text-center">
						<span class="pull-left report-price">
							27063 IBERICA Маслины с косточкой ж/б 420г: <strong> 154.90 </strong>
						</span>
						<span class="pull-right report-time">
							<small>17:17:26</small>
						</span>
						<span class="articul-title"></span>
					</div>
				</div>
			</div>
		</div>
		<!-- modal -->
		<div class="modal fade" id="modal-add-task">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">×</span>
						</button>
						<h4 class="modal-title">Новая задача</h4>
					</div>
					<form class="form-horizontal" role="form" action="/tasks/new" method="post">
						<input value="" name="report_id" type="hidden">

						<div class="modal-body">
							<div class="form-group">
								<label for="task-description" class="col-md-4 control-label">Задание:</label>
								<div class="col-md-7">
									<textarea rows="4" maxlength="255" class="form-control" id="task-description" name="description" placeholder="Что не так на фото?"></textarea>
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
		<div class="modal fade" id="modal-correct-price">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">×</span>
						</button>
						<h4 class="modal-title">Исправить цену</h4>
					</div>
					<form class="form-horizontal" role="form" action="/check/correct" method="post">
						<input value="" name="report_id" type="hidden">

						<div class="modal-body">
							<div class="form-group">
								<label for="price" class="col-md-4 control-label">Новая цена:</label>
								<div class="col-md-7">
									<input id="price" class="form-control" name="price" type="text">
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



