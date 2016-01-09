$(window).on('load', function() {

	$('#filter-for-report-list select[name=filter_region_id]').change(function(event) {
		$('#filter-for-report-list #filter_city_visibility').show();
		var citySelector = $('#filter-for-report-list select#filter_city');

		var taskDate = $('#filter-for-report-list input#date');
		taskDate.val('');
		taskDate.datepicker('update');
		$('#filter-for-report-list #filter_date_visibility').hide();

		var ownTaskSelector = $('#filter-for-report-list select#filter_own_tasks');
		ownTaskSelector.html('<option selected value="">Данные отсутствуют</option>');
		ownTaskSelector.selectpicker('refresh');
		$('#filter-for-report-list #filter_own_task_visibility').hide();

		var otherTasksSelector = $('#filter-for-report-list select#filter_other_tasks');
		otherTasksSelector.html('<option selected value="">Данные отсутствуют</option>');
		otherTasksSelector.selectpicker('refresh');
		$('#filter-for-report-list #filter_other_task_visibility').hide();

		if ($(this)) {
			$.ajax({
				contentType : "application/json",
				dataType : 'json',
				type : "GET",
				url : contexPath + '/ajax/' + $($(this)).val() + '/cities.json',

				success : function(data) {
					var dataCount = 0;
					var html = '';
					for ( var i in data) {
						dataCount++;
						var city = data[i];
						html = html + '<option	value="' + city.id + '">' + city.caption + '</option>';
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

	$('#filter-for-report-list select[name=filter_city_id]').change(function(event) {
		$('#filter-for-report-list #filter_date_visibility').show();

		var taskDate = $('#filter-for-report-list input#date');
		taskDate.datepicker('update', '');

		var ownTaskSelector = $('#filter-for-report-list select#filter_own_tasks');
		ownTaskSelector.html('<option selected value="">Данные отсутствуют</option>');
		ownTaskSelector.selectpicker('refresh');
		$('#filter-for-report-list #filter_own_task_visibility').hide();

		var otherTasksSelector = $('#filter-for-report-list select#filter_other_tasks');
		otherTasksSelector.html('<option selected value="">Данные отсутствуют</option>');
		otherTasksSelector.selectpicker('refresh');
		$('#filter-for-report-list #filter_other_task_visibility').hide();

		event.preventDefault ? event.preventDefault() : (event.returnValue = false);
	});

	$('#filter-for-report-list input[name=filter_task_create_date]').change(function(event) {
		var ownTaskSelector = $('#filter-for-report-list select#filter_own_tasks');
		var citySelector = $('#filter-for-report-list select#filter_city');

		var otherTasksSelector = $('#filter-for-report-list select#filter_other_tasks');
		otherTasksSelector.html('<option selected value="">Данные отсутствуют</option>');
		otherTasksSelector.selectpicker('refresh');
		$('#filter-for-report-list #filter_other_task_visibility').hide();

		if ($(this) && $(this).val()) {
			$('#filter-for-report-list #filter_own_task_visibility').show();

			$.ajax({
				contentType : "application/json",
				dataType : 'json',
				type : "GET",
				url : contexPath + '/ajax/' + $($(this)).val() + '/' + citySelector.val() + '/tasks.json',

				success : function(data) {
					var dataCount = 0;
					var html = '';
					for ( var i in data) {
						dataCount++;
						var task = data[i];
						html = html + '<option	value="' + task.id + '">' + task.caption + '</option>';
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

	$('#filter-for-report-list select[name=filter_own_task_id]').change(function(event) {

		$('#filter-for-report-list #filter_other_task_visibility').show();
		var otherTasksSelector = $('#filter-for-report-list select#filter_other_tasks');
		var citySelector = $('#filter-for-report-list select#filter_city');

		if ($(this)) {
			$.ajax({
				contentType : "application/json",
				dataType : 'json',
				type : "GET",
				url : contexPath + '/ajax/' + $($(this)).val() + '/' + citySelector.val() + '/others/tasks.json',

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

	$('#filter-for-report-list #generate_report').on('click', function(e) {
		var citySelector = $('#filter-for-report-list select#filter_city').val();
		var taskDate = $('#filter-for-report-list input[name=filter_task_create_date]').val();
		var ownTaskSelector = $('#filter-for-report-list select#filter_own_tasks').val();
		var otherTasksSelector = $('#filter-for-report-list select#filter_other_tasks').val();

		if (citySelector && taskDate && ownTaskSelector && otherTasksSelector) {
			return true;
		} else {
			alert('Введены не все параметры');
			return false;
		}
	});
});
