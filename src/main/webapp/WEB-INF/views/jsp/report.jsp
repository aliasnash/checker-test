<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>

<tiles:insertDefinition name="defaultTemplate">
	<tiles:putAttribute name="title" value="Checker Report" />
	<tiles:putAttribute name="body">
		<div class="panel panel-default">
			<div class="panel-heading clearfix">
				Дневной прогресс
				<span class="pull-right">
					<a class="btn btn-default collapse-button" href="#report-progress" data-toggle="collapse" aria-expanded="true"> <span
							class="glyphicon glyphicon-chevron-up"></span> <span class="glyphicon glyphicon-chevron-down"></span>
					</a>
				</span>
			</div>
			<div class="panel-body collapse in" id="report-progress">
				<div class="row">
					<div class="col-md-12">
						Всего задач на сегодня: 3713<br>&nbsp;<br>
					</div>
				</div>
				<div class="row">
					<div class="col-md-12">
						<div class="row">
							<div class="col-md-4 text-right">Сеть "Ашан Химки_KVI_DRY_ЦФ", проверено:</div>
							<div class="col-md-8">
								<div class="progress">
									<div class="progress-bar" role="progressbar" aria-valuenow="70" aria-valuemin="0" aria-valuemax="100" style="width: 70%; min-width: 2em;">70</div>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-md-4 text-right">Сеть "Ашан Химки_KVI_DRY_ЦФ", загружено:</div>
							<div class="col-md-8">
								<div class="progress">
									<div class="progress-bar-success progress-bar" role="progressbar" aria-valuenow="1" aria-valuemin="0" aria-valuemax="355"
										style="width: 0.28169014084507%; min-width: 2em;">1</div>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-md-4 text-right">Сеть "Тестовая", проверено:</div>
							<div class="col-md-8">
								<div class="progress">
									<div class="progress-bar" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="25" style="width: 0%; min-width: 2em;">0</div>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-md-4 text-right">Сеть "Тестовая", загружено:</div>
							<div class="col-md-8">
								<div class="progress">
									<div class="progress-bar-success progress-bar" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="25"
										style="width: 0%; min-width: 2em;">0</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

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
				<form class="form-inline" role="form" action="/xls/filter" method="post">
					<div class="modal-body">
						<div class="row">
							<div class="form-group col-md-3">
								<div class="row">
									<div class="form-group col-md-12">
										<label for="city-zone" class="col-md-12  control-label">Регионы:</label>

										<div class="col-md-12">
											<select name="zones[]" class="form-control" id="city-zone" placeholder="Регион..." multiple="multiple">
												<option selected="selected" value="-1">Все регионы</option>
												<option value="1">Москва и м/о</option>
												<option value="2">Северо запад</option>
												<option value="3">Юг</option>
												<option value="5">Урал</option>
												<option value="4">Центр</option>
												<option value="6">Сибирь</option>
											</select>
										</div>
									</div>
								</div>
								<div class="row">
									<!-- Networks -->
									<div class="form-group col-md-12">
										<label for="city-zone" class="col-md-12  control-label">Сети:</label>

										<div class="col-md-12">
											<select name="networks[]" class="form-control" id="networks" placeholder="Сети..." multiple="multiple">
												<option selected="selected" value="-1">Все сети</option>
												<option value="72">Ашан Химки_KVI_DRY_ЦФ</option>
												<option value="52">Ашан Химки_KVI_Мод_FRESH</option>
												<option value="42">Ашан Химки_Биржа_ЦФ</option>
												<option value="26">Окей Пражская_ФрОв_BB1</option>
												<option value="49">Окей Пражская_ФрОв_KVI_ЦФ</option>
												<option value="15">Окей Пражская_ФРОВ_пн_пт</option>
												<option value="76">Окей Пражская_Цыпленок_ЦФ</option>
												<option value="78">ОкейПраж_Промо04СОПУТКА1</option>
												<option value="11">Тестовая</option>
											</select>

										</div>
									</div>
									<!-- networks -->
								</div>
								<div class="row">
									<div class="form-group col-md-12">
										<label for="cities" class="col-md-12 control-label">Город:</label>

										<div class="col-md-12">
											<select name="cities[]" class="form-control" id="cities" placeholder="Город..." multiple="multiple">
												<option selected="selected" value="-1">Все города</option>
												<option value="2">Москва</option>
												<option value="3">Химки</option>
											</select>
										</div>
									</div>
								</div>
								<input name="categories[]" value="-1" type="hidden">

								<div class="row">
									<div class="form-group col-md-12">
										<label for="specials" class="col-md-12  control-label">Промоакции:</label>

										<div class="col-md-12">
											<select name="specials[]" class="form-control" id="specials" placeholder="Промо" multiple="multiple">
												<option selected="selected" value="-1">Все промоакции</option>
												<option value="1">3 по цене 2</option>
												<option value="2">карта лояльности</option>
												<option value="3">1+1</option>
												<option value="5">Скидка %</option>
												<option value="7">Скидка по купону</option>
											</select>
										</div>
									</div>
								</div>
							</div>
							<div class="form-group col-md-3">
								<label for="network" class="col-md-12  control-label">Сеть для сравнения:</label>

								<div class="col-md-12">
									<select name="network_id" class="form-control" id="network" placeholder="Торговые сети" mu=""">
										<!--option value="-1">Все сети</option-->
										<option selected="selected" value="72">Ашан Химки_KVI_DRY_ЦФ</option>
										<option value="52">Ашан Химки_KVI_Мод_FRESH</option>
										<option value="42">Ашан Химки_Биржа_ЦФ</option>
										<option value="50">Ашан Химки_ВВ1_СТМ</option>
										<option value="33">Ашан Химки_ВВ_Корма-хлеб</option>
										<option value="64">Ашан Химки_Промо_02_фуд</option>
										<option value="66">Ашан Химки_Промо_04_фуд</option>
										<option value="34">Ашан Химки_ПРОМО_ЦФ</option>
										<option value="11">Тестовая</option>
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
						<!-- city -->
						<div class="row">
							<div class="form-group col-md-3"></div>
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
							<a href="http://x5.checkprice.lqom.ru/xls/download" class="btn btn-success btn-sm">Скачать отчет</a>
						</div>
					</div>
				</form>
			</div>
		</div>
	</tiles:putAttribute>
</tiles:insertDefinition>



