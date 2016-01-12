$(window).on('load', function() {

	$('#filter-for-report-list input[name=filter_task_create_date]').change(function(event) {
		var citySelector = $('#filter-for-report-list select#filter_city');

		// прячем и обнуляем свои задачи
		var ownTaskSelector = $('#filter-for-report-list select#filter_own_tasks');
		ownTaskSelector.html('<option selected value="">Данные отсутствуют</option>');
		ownTaskSelector.selectpicker('refresh');
		$('#filter-for-report-list #filter_own_task_visibility').hide();

		// прячем и обнуляем задачи конкурента
		var otherTasksSelector = $('#filter-for-report-list select#filter_other_tasks');
		otherTasksSelector.html('<option selected value="">Данные отсутствуют</option>');
		otherTasksSelector.selectpicker('refresh');
		$('#filter-for-report-list #filter_other_task_visibility').hide();

		// прячем промо акции
		$('#filter-for-report-list #filter_promo_visibility').hide();

		$('#filter-for-report-list #filter_city_visibility').show();

		if ($(this) && $(this).val()) {
			$.ajax({
				contentType : "application/json",
				dataType : 'json',
				type : "GET",
				url : contexPath + '/ajax/' + $(this).val() + '/citiesbydate.json',

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
					citySelector.html('<option selected value="">Ошибка загрузки списка магазинов</option>');
					citySelector.selectpicker('refresh');
				},
				done : function(e) {
					console.log("DONE");
				}
			});
		}

		event.preventDefault ? event.preventDefault() : (event.returnValue = false);
	});

	$('#filter-for-report-list select#filter_city').change(function(event) {
		var taskDate = $('#filter-for-report-list input[name=filter_task_create_date]');
		var ownTaskSelector = $('#filter-for-report-list select#filter_own_tasks');

		// прячем и обнуляем задачи конкурента
		var otherTasksSelector = $('#filter-for-report-list select#filter_other_tasks');
		otherTasksSelector.html('<option selected value="">Данные отсутствуют</option>');
		otherTasksSelector.selectpicker('refresh');
		$('#filter-for-report-list #filter_other_task_visibility').hide();

		// прячем промо акции
		$('#filter-for-report-list #filter_promo_visibility').hide();

		$('#filter-for-report-list #filter_own_task_visibility').show();

		if ($(this)) {
			$.ajax({
				contentType : "application/json",
				dataType : 'json',
				type : "GET",
				url : contexPath + '/ajax/' + taskDate.val() + '/' + $(this).val() + '/tasks.json',

				success : function(data) {
					var dataCount = 0;
					var html = '';
					for ( var i in data) {
						dataCount++;
						var task = data[i];
						html = html + '<option value="' + task.id + '">' + task.caption + '</option>';
					}

					if (dataCount > 0) {
						ownTaskSelector.html(html);
						ownTaskSelector.selectpicker('refresh');
					} else {
						ownTaskSelector.html('<option selected value="">Данные отсутствуют</option>');
						ownTaskSelector.selectpicker('refresh');
					}
				},
				error : function(request, status, error) {
					ownTaskSelector.html('<option selected value="">Ошибка загрузки списка</option>');
					ownTaskSelector.selectpicker('refresh');
				},
				done : function(e) {
					console.log("DONE");
				}
			});
		}

		event.preventDefault ? event.preventDefault() : (event.returnValue = false);
	});

	$('#filter-for-report-list select#filter_own_tasks').change(function(event) {
		var otherTasksSelector = $('#filter-for-report-list select#filter_other_tasks');
		var citySelector = $('#filter-for-report-list select#filter_city');

		// прячем промо акции
		$('#filter-for-report-list #filter_promo_visibility').hide();

		$('#filter-for-report-list #filter_other_task_visibility').show();

		if ($(this)) {
			$.ajax({
				contentType : "application/json",
				dataType : 'json',
				type : "GET",
				url : contexPath + '/ajax/' + $(this).val() + '/' + citySelector.val() + '/others/tasks.json',

				success : function(data) {
					var dataCount = 0;
					var html = '';
					for ( var i in data) {
						dataCount++;
						var task = data[i];
						html = html + '<option	value="' + task.id + '">' + task.caption + '</option>';
					}

					if (dataCount > 0) {
						otherTasksSelector.html(html);
						otherTasksSelector.selectpicker('refresh');
					} else {
						otherTasksSelector.html('<option selected value="">Данные отсутствуют</option>');
						otherTasksSelector.selectpicker('refresh');
					}
				},
				error : function(request, status, error) {
					otherTasksSelector.html('<option selected value="">Ошибка загрузки списка</option>');
					otherTasksSelector.selectpicker('refresh');
				},
				done : function(e) {
					console.log("DONE");
				}
			});
		}

		event.preventDefault ? event.preventDefault() : (event.returnValue = false);
	});

	$('#filter-for-report-list select#filter_other_tasks').change(function(event) {
		if ($(this).val() && $(this).val().length > 0)
			$('#filter-for-report-list #filter_promo_visibility').show();
		else
			$('#filter-for-report-list #filter_promo_visibility').hide();
		event.preventDefault ? event.preventDefault() : (event.returnValue = false);
	});

	$('#filter-for-report-list #generate_report').on('click', function(e) {
		var taskDate = $('#filter-for-report-list input[name=filter_task_create_date]').val();
		var citySelector = $('#filter-for-report-list select#filter_city').val();
		var ownTaskSelector = $('#filter-for-report-list select#filter_own_tasks').val();
		var otherTasksSelector = $('#filter-for-report-list select#filter_other_tasks').val();

		if (taskDate && citySelector && ownTaskSelector && otherTasksSelector) {
			return true;
		} else {
			alert('Введены не все параметры');
			return false;
		}
	});
});
