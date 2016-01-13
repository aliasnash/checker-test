$(window).on('load', function() {

	$('#data-for-generate-task #save-task').on('click', function(e) {
		var taskName = $('#data-for-generate-task input#id_task_name').val();
		var templateSelector = $('#data-for-generate-task select#select-template-name').val();
		var marketSelector = $('#data-for-generate-task select#market-point option:selected').val();

		if (taskName && templateSelector && marketSelector && marketSelector.length > 0) {
			return true;
		} else {
			if (!taskName)
				alert('Название задачи не введено');
			else if (!templateSelector)
				alert('Не выбран шаблон');
			else if (!marketSelector) alert('Не выбрана сеть');
			return false;
		}
	});

	$('#select-user-name').change(function(e) {
		if ($(this).prop('checked')) {
			$('#block-user-name').show();
		} else {
			$('#block-user-name').hide();
		}
	});

	$('#data-for-generate-task select#select-city-name').change(function(event) {
		var templateSelector = $('#data-for-generate-task select#select-template-name');
		var marketSelector = $('#data-for-generate-task select#market-point');
		var userSelector = $('#data-for-generate-task select#user-name');

		if ($(this)) {
			$('#data-for-generate-task #select-template-name-block').show();
			$.ajax({
				contentType : "application/json",
				dataType : 'json',
				type : "GET",
				url : contexPath + '/ajax/city/' + $(this).val() + '/templates.json',

				success : function(data) {
					var dataCount = 0;
					var html = '';
					for ( var i in data) {
						dataCount++;
						var template = data[i];
						html = html + '<option value="' + template.id + '">' + template.caption + '</option>';
					}

					if (dataCount > 0) {
						templateSelector.html(html);
						templateSelector.selectpicker('refresh');
					} else {
						templateSelector.html('<option selected value="">Данные отсутствуют</option>');
						templateSelector.selectpicker('refresh');
					}
				},
				error : function(request, status, error) {
					templateSelector.html('<option selected value="">Ошибка загрузки списка</option>');
					templateSelector.selectpicker('refresh');
				},
				done : function(e) {
					console.log("DONE");
				}
			});

			$('#data-for-generate-task #select-market-template-block').show();
			$.ajax({
				contentType : "application/json",
				dataType : 'json',
				type : "GET",
				url : contexPath + '/ajax/' + $(this).val() + '/marketpoints.json',

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
						marketSelector.html('<option selected value="">Данные отсутствуют</option>');
						marketSelector.selectpicker('refresh');
					}
				},
				error : function(request, status, error) {
					marketSelector.html('<option selected value="">Ошибка загрузки списка</option>');
					marketSelector.selectpicker('refresh');
				},
				done : function(e) {
					console.log("DONE");
				}
			});

			$('#data-for-generate-task #block-user-name-checker').show();
			$.ajax({
				contentType : "application/json",
				dataType : 'json',
				type : "GET",
				url : contexPath + '/ajax/city/' + $(this).val() + '/users.json',

				success : function(data) {
					var dataCount = 0;
					var html = '';
					for ( var i in data) {
						dataCount++;
						var user = data[i];
						html = html + '<option value="' + user.id + '">' + user.email + ' (' + user.title + ')</option>';
					}

					if (dataCount > 0) {
						userSelector.html(html);
						userSelector.selectpicker('refresh');
					} else {
						userSelector.html('<option selected value="">Данные отсутствуют</option>');
						userSelector.selectpicker('refresh');
					}
				},
				error : function(request, status, error) {
					userSelector.html('<option selected value="">Ошибка загрузки списка</option>');
					userSelector.selectpicker('refresh');
				},
				done : function(e) {
					console.log("DONE");
				}
			});
		}

		event.preventDefault ? event.preventDefault() : (event.returnValue = false);
	});

	$('#data-for-generate-task #generate_tasks').on('click', function(e) {
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
