$(window).on('load', function() {

	$('[data-toggle="tooltip"]').tooltip();

	$('select').selectpicker();

	$('#date').datepicker({
		format : "yyyy-mm-dd",
		language : "ru",
		weekStart : 1,
		autoclose : true
	});

	$("#template-upload").fileinput({
		language : "ru",
		showPreview : false,
		elErrorContainer : "#errorBlock",
		allowedFileExtensions : [ "xls", "xlsx" ]
	});

	// triggered when modal is about to be shown
	$('#modal-assign-task').on('show.bs.modal', function(e) {
		// get data-id attribute of the clicked element
		var elementId = $(e.relatedTarget).data('element-id');
		var elementName = $(e.relatedTarget).data('element-name');
		var elementMarket = $(e.relatedTarget).data('element-market');

		// populate the textbox
		$(e.currentTarget).find('input[name="id"]').val(elementId);
		$(e.currentTarget).find('input[name="name-task"]').val(elementName);
		$(e.currentTarget).find('input[name="name-market"]').val(elementMarket);

		$(e.currentTarget).find('input[name="name-task"]').prop('disabled', true);
		$(e.currentTarget).find('input[name="name-market"]').prop('disabled', true);
	});

	// triggered when modal is about to be shown
	$('#modal-add-task').on('show.bs.modal', function(e) {
		var elementId = $(e.relatedTarget).data('element-id');

		$(e.currentTarget).find('input[name="id"]').val(elementId);
	});

	// triggered when modal is about to be shown
	$('#modal-correct-check-task').on('show.bs.modal', function(e) {
		var elementId = $(e.relatedTarget).data('element-id');
		var price = $(e.relatedTarget).data('element-price');
		var weight = $(e.relatedTarget).data('element-weight');
		var availability = $(e.relatedTarget).data('element-availability');

		$(e.currentTarget).find('input[name="id"]').val(elementId);
		$(e.currentTarget).find('input[name="check-task-price"]').val(price);
		$(e.currentTarget).find('input[name="check-task-weight"]').val(weight);
		$(e.currentTarget).find('input[name="check-task-availability"]').prop('checked', availability);
	});

	// triggered when modal is about to be shown
	$('#modal-correct-complete-task').on('show.bs.modal', function(e) {
		var elementId = $(e.relatedTarget).data('element-id');
		var price = $(e.relatedTarget).data('element-price');
		var weight = $(e.relatedTarget).data('element-weight');
		var availability = $(e.relatedTarget).data('element-availability');

		$(e.currentTarget).find('input[name="id"]').val(elementId);
		$(e.currentTarget).find('input[name="complete-task-price"]').val(price);
		$(e.currentTarget).find('input[name="complete-task-weight"]').val(weight);
		$(e.currentTarget).find('input[name="complete-task-availability"]').prop('checked', availability);
	});

	$('#modal-edit-category, #modal-edit-goods, #modal-edit-promo, #modal-edit-region, #modal-edit-market').on('show.bs.modal', function(e) {
		// get data-id attribute of the clicked element
		var elementId = $(e.relatedTarget).data('element-id');
		var elementName = $(e.relatedTarget).data('element-name');
		var owner = $(e.relatedTarget).data('element-owner');
		// populate the textbox
		$(e.currentTarget).find('input[name="id"]').val(elementId);
		$(e.currentTarget).find('input[name="name"]').val(elementName);

		if (owner) {
			$(e.currentTarget).find('input[name="owner"]').prop('checked', true);
		} else {
			$(e.currentTarget).find('input[name="owner"]').prop('checked', false);
		}
	});

	// triggered when modal is about to be shown
	$('#modal-add-user-tasks').on('show.bs.modal', function(e) {
		// get data-id attribute of the clicked element
		var elementId = $(e.relatedTarget).data('element-id');
		var elementName = $(e.relatedTarget).data('element-name');

		// populate the textbox
		$(e.currentTarget).find('input[name="id"]').val(elementId);
		$('#user-title').text(elementName);
	});

	// triggered when modal is about to be shown
	$('#modal-edit-user').on('show.bs.modal', function(e) {
		// get data-id attribute of the clicked element
		var elementId = $(e.relatedTarget).data('element-id');
		var elementName = $(e.relatedTarget).data('element-name');
		var elementEmail = $(e.relatedTarget).data('element-email');
		var elementPwd = $(e.relatedTarget).data('element-pwd');

		// populate the textbox
		$(e.currentTarget).find('input[name="id"]').val(elementId);
		$(e.currentTarget).find('input[name="title"]').val(elementName);
		$(e.currentTarget).find('input[name="email"]').val(elementEmail);
		$(e.currentTarget).find('input[name="pwd"]').val(elementPwd);
	});

	// triggered when modal is about to be shown
	$('#modal-edit-articul').on('show.bs.modal', function(e) {
		// get data-id attribute of the clicked element
		var elementId = $(e.relatedTarget).data('element-id');
		var elementName = $(e.relatedTarget).data('element-name');
		var elementCode = $(e.relatedTarget).data('element-code');
		// var elementSubCategoryId =
		// $(e.relatedTarget).data('element-subcategory-id');
		var topProduct = $(e.relatedTarget).data('element-top-product');
		// populate the textbox
		$(e.currentTarget).find('input[name="id"]').val(elementId);
		$(e.currentTarget).find('input[name="name"]').val(elementName);
		$(e.currentTarget).find('input[name="code"]').val(elementCode);

		if (topProduct) {
			$(e.currentTarget).find('input[name="top_product"]').prop('checked', true);
		} else {
			$(e.currentTarget).find('input[name="top_product"]').prop('checked', false);
		}
	});

	// triggered when modal is about to be shown
	$('#modal-edit-template').on('show.bs.modal', function(e) {
		// get data-id attribute of the clicked element
		var elementId = $(e.relatedTarget).data('element-id');
		var elementName = $(e.relatedTarget).data('element-name');
		var elementDate = $(e.relatedTarget).data('element-date');
		var elementFile = $(e.relatedTarget).data('element-file');
		var elementIdCity = $(e.relatedTarget).data('element-idcity');

		var cityBlock = $('#template-save-city-block');

		if (elementIdCity) {
			cityBlock.hide();
		} else {
			cityBlock.show();
		}

		// populate the textbox
		$(e.currentTarget).find('input[name="id"]').val(elementId);
		$(e.currentTarget).find('input[name="name"]').val(elementName);

		$(e.currentTarget).find('input[name="date"]').val(elementDate);
		$(e.currentTarget).find('input[name="file"]').val(elementFile);

		$(e.currentTarget).find('input[name="date"]').prop('disabled', true);
		$(e.currentTarget).find('input[name="file"]').prop('disabled', true);
	});

	$('#modal-edit-market-point').on('show.bs.modal', function(e) {
		// get data-id attribute of the clicked element
		var elementId = $(e.relatedTarget).data('element-id');
		var elementName = $(e.relatedTarget).data('element-name');
		var elementCity = $(e.relatedTarget).data('element-id-city');
		var citySelector = $('select[name="city_id"]');

		// populate the textbox
		$('input[name="id"]').val(elementId);
		$('input[name="name"]').val(elementName);
		$('input[name="idcity"]').val(elementCity);

		if (elementId) {
			citySelector.prop('disabled', true);
			citySelector.val(elementCity);
		} else {
			citySelector.prop('disabled', false);
			citySelector.val("-1");
		}

		citySelector.selectpicker('render');
		citySelector.selectpicker('refresh');
	});

	$('#modal-edit-city').on('show.bs.modal', function(e) {
		// get data-id attribute of the clicked element
		var elementId = $(e.relatedTarget).data('element-id');
		var elementName = $(e.relatedTarget).data('element-name');
		var elementRegion = $(e.relatedTarget).data('element-region');
		var regionSelector = $('select[name="region_id"]');

		// populate the textbox
		$('input[name="id"]').val(elementId);
		$('input[name="name"]').val(elementName);
		$('input[name="idregion"]').val(elementRegion);

		if (elementId) {
			regionSelector.prop('disabled', true);
			regionSelector.val(elementRegion);
		} else {
			regionSelector.prop('disabled', false);
			regionSelector.val("-1");
		}

		regionSelector.selectpicker('render');
		regionSelector.selectpicker('refresh');
	});

	$('#save-market-point').on('click', function(e) {
		var cityValue = $('select[name="city_id"]').val();

		if (cityValue) {
			$('input[name="idcity"]').val(cityValue);
			return true;
		} else {
			return false;
		}
	});

	$('#save-city').on('click', function(e) {
		var regionValue = $('select[name="region_id"]').val();
		var regionFilterValue = $('select[name="filter_region_id"]').val();

		if (regionValue) {
			$('input[name="idregion"]').val(regionValue);
			$('input[name="idregionfilter"]').val(regionFilterValue);
			return true;
		} else {
			return false;
		}
	});

	$('#template-save').on('click', function(e) {
		var dateTemplateValue = $('input[name="filtered_template_date"]').val();

		$('input[name="date-template-filtered"]').val(dateTemplateValue);
		return true;
	});

	$('#save-assign-user').on('click', function(e) {
		var userId = $('select[name="user-id"]').val();
		if (userId) {
			$('input[name="iduser"]').val(userId);
			return true;
		} else {
			return false;
		}
	});

	$('#top-product').change(function(e) {
		if ($(this).prop('checked')) {
			$('#articul-listing tr.articul:not(.top-product)').hide();
		} else {
			$('#articul-listing tr.articul:not(.top-product)').show();
		}
	});

	// $('#only-price').change(function(e) {
	// if ($(this).prop('checked')) {
	// $('#template-listing tr.template-data:not(.with-price)').hide();
	// } else {
	// $('#template-listing tr.template-data:not(.with-price)').show();
	// }
	// });

	// $('#template-usefilename').change(function(e) {
	// if ($(this).prop('checked')) {
	// $('#template-name').prop('disabled', true);
	// } else {
	// $('#template-name').prop('disabled', false);
	// }
	// });

	$('#select-user-name').change(function(e) {
		if ($(this).prop('checked')) {
			$('#block-user-name').show();
		} else {
			$('#block-user-name').hide();
		}
	});

	$('#filter-for-tasks-list select[name=filter_city_id]').change(function(event) {
		var citySelector = $('#filter-for-tasks-list select#filter_city');
		var marketSelector = $('#filter-for-tasks-list select#filter_market_point');
		ajaxMarketPoint(citySelector, marketSelector);
		event.preventDefault ? event.preventDefault() : (event.returnValue = false);
	});

	$('#filter-for-tasks-check select[name=filter_city_id]').change(function(event) {
		var citySelector = $('#filter-for-tasks-check select#filter_city');
		var marketSelector = $('#filter-for-tasks-check select#filter_market_point');
		ajaxMarketPoint(citySelector, marketSelector);
		event.preventDefault ? event.preventDefault() : (event.returnValue = false);
	});

	$('#filter-for-tasks-fail select[name=filter_city_id]').change(function(event) {
		var citySelector = $('#filter-for-tasks-fail select#filter_city');
		var marketSelector = $('#filter-for-tasks-fail select#filter_market_point');
		ajaxMarketPoint(citySelector, marketSelector);
		event.preventDefault ? event.preventDefault() : (event.returnValue = false);
	});

	$('#filter-for-tasks-complete select[name=filter_city_id]').change(function(event) {
		var citySelector = $('#filter-for-tasks-complete select#filter_city');
		var marketSelector = $('#filter-for-tasks-complete select#filter_market_point');
		ajaxMarketPoint(citySelector, marketSelector);
		event.preventDefault ? event.preventDefault() : (event.returnValue = false);
	});

	$('#filter-for-tasks-dyn select[name=filter_city_id]').change(function(event) {
		var citySelector = $('#filter-for-tasks-dyn select#filter_city');
		var marketSelector = $('#filter-for-tasks-dyn select#filter_market_point');
		ajaxMarketPoint(citySelector, marketSelector);
		event.preventDefault ? event.preventDefault() : (event.returnValue = false);
	});

	function ajaxMarketPoint(citySelector, marketSelector) {
		if (citySelector) {
			$.ajax({
				contentType : "application/json",
				dataType : 'json',
				type : "GET",
				url : contexPath + '/ajax/' + $(citySelector).val() + '/marketpoints.json',

				success : function(data) {
					var dataCount = 0;
					var html = '';
					for ( var i in data) {
						dataCount++;
						html = html + '<optgroup label="' + i + '">';

						for ( var k in data[i]) {
							var marketPoint = data[i][k];

							html = html + '<option';
							if (marketPoint.market.owner)
								html = html + '	data-subtext="своя сеть"';
							else
								html = html + '	data-subtext=""';
							html = html + '	value="' + marketPoint.id + '">';
							html = html + marketPoint.market.caption + '&nbsp;(' + marketPoint.description + ')';
							html = html + '</option>';
						}
					}

					if (dataCount > 0) {
						marketSelector.html(html);
						marketSelector.selectpicker('refresh');
					} else {
						marketSelector.html('<option selected value="">Сеть отсутствует</option>');
						marketSelector.selectpicker('refresh');
					}
				},
				error : function(request, status, error) {
					marketSelector.html('<option selected value="">Ошибка загрузки списка магазинов</option>');
					marketSelector.selectpicker('refresh');
				},
				done : function(e) {
					console.log("DONE");
				}
			});
		}
	}

	$('#filter-template-build input[name=filtered_template_date]').change(function(event) {
		var citySelector = $('#filter-template-build select#filtered_template_city');

		if ($(this) && $(this).val()) {
			$.ajax({
				contentType : "application/json",
				dataType : 'json',
				type : "GET",
				url : contexPath + '/ajax/template/' + $(this).val() + '/citiesbydate.json',

				success : function(data) {
					var dataCount = 0;
					var html = '';
					for ( var i in data) {
						dataCount++;
						html = html + '<optgroup label="' + i + '">';

						for ( var k in data[i]) {
							var city = data[i][k];
							html = html + '<option value="' + city.id + '">' + city.caption + '</option>';
						}
					}

					if (dataCount > 0) {
						citySelector.html(html);
						citySelector.selectpicker('refresh');
					} else {
						citySelector.html('<option selected value="">Данные отсутствуют</option>');
						citySelector.selectpicker('refresh');
					}
				},
				error : function(request, status, error) {
					citySelector.html('<option selected value="">Ошибка загрузки списка</option>');
					citySelector.selectpicker('refresh');
				},
				done : function(e) {
					console.log("DONE");
				}
			});
		}

		event.preventDefault ? event.preventDefault() : (event.returnValue = false);
	});
});
