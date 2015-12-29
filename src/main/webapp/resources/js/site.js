$(window).on('load', function() {

	$('#modal-add-network').on('show.bs.modal', function(e) {
		// get data-id attribute of the clicked element
		var elementId = $(e.relatedTarget).data('element-id');
		var elementName = $(e.relatedTarget).data('element-name');
		// populate the textbox
		$(e.currentTarget).find('input[name="id"]').val(elementId);
		$(e.currentTarget).find('input[name="name"]').val(elementName);
	});

	// triggered when modal is about to be shown
	$('#modal-add-shop').on('show.bs.modal', function(e) {
		var citySelector = $(e.currentTarget).find('select[name="city_id"]');
		var typeSelector = $(e.currentTarget).find('select[name="type_id"]');
		// get data-id attribute of the clicked element
		var elementId = $(e.relatedTarget).data('element-id');
		var elementAddress = $(e.relatedTarget).data('element-address');
		var elementCity = $(e.relatedTarget).data('element-city');
		var elementType = $(e.relatedTarget).data('element-type');
		// populate the textbox
		$(e.currentTarget).find('input[name="id"]').val(elementId);
		$(e.currentTarget).find('input[name="address"]').val(elementAddress);
		if (elementId) {
			citySelector.prop('disabled', true);
			citySelector.find('option').prop('checked', false);
			citySelector.val(elementCity);
			// ---
			typeSelector.prop('disabled', true);
			typeSelector.find('option').prop('checked', false);
			typeSelector.val(elementType);
		} else {
			typeSelector.val('');
			citySelector.val('');
			citySelector.prop('disabled', false);
			typeSelector.prop('disabled', false);
		}
		citySelector.selectpicker('refresh');
		typeSelector.selectpicker('refresh');
	});


	$('.table-select tr:not(.disabled)').on('click', function(e) {
		if ($(this).hasClass('selected')) {
			$(this).removeClass('selected');
		} else {
			// $(this).parent().find('.selected').removeClass('selected')
			$(this).addClass('selected');
		}
	});

	$('#btn-move-left').on('click', function(e) {
		var rows = $('#right-table tr.selected').detach();
		rows.removeClass('selected');
		$('#left-table').append(rows);
	});

	$('#btn-move-right').on('click', function(e) {
		var rows = $('#left-table tr.selected').detach();
		rows.removeClass('selected');
		$('#right-table').append(rows);
	});

	$('#table-select-submit').on('click', function(e) {
		$('#table-select-form').submit();
	});

	/* REPORT FILTER LOGIC */
	$('#report-filter select[name=zone_id]').on('change', function(e) {

		var citySelector = $('#report-filter select#city-name');

		if ($(this).val() == -1) {
			citySelector.parent().parent().children().addClass('hidden');
		} else {
			$.get('/selector/city/' + $(this).val(), function(data) {
				alert(data);

				citySelector.html(data);
				citySelector.val(-1);
				citySelector.selectpicker('refresh');
				citySelector.parent().parent().children().not('select').removeClass('hidden');
			});
		}
	});

	$('#report-filter select[name=category_id]').on('change', function(e) {
		var citySelector = $('#report-filter select#articul-name');
		if ($(this).val() == -1) {
			citySelector.parent().parent().children().addClass('hidden');
		} else {
			$.get('/selector/articul/' + $(this).val(), function(data) {
				citySelector.html(data);
				citySelector.val(-1);
				citySelector.selectpicker('refresh');
				citySelector.parent().parent().children().not('select').removeClass('hidden');
			});
		}
	});

	$.expr[":"].contains = $.expr.createPseudo(function(arg) {
		return function(elem) {
			return $(elem).text().toUpperCase().indexOf(arg.toUpperCase()) >= 0;
		};
	});

	$('#articul-name-filter').on('keyup', function(e) {
		if ($(this).val().length > 0) {
			$('.table-select tr').hide();
			var str = $(this).val();
			$('.table-select tr:contains(' + str + ')').show();
		} else {
			$('.table-select tr').show();
		}
	});

	/* REPORT FILTER LOGIC END */
	$('.sortable-tbody').sortable();

	$('.close-button').on('click', function() {
		if ($(this).find('.glyphicon').hasClass('glyphicon-folder-close')) {
			$(this).find('.glyphicon').removeClass("glyphicon-folder-close").addClass("glyphicon-folder-open");
		} else {
			$(this).find('.glyphicon').removeClass("glyphicon-folder-open").addClass("glyphicon-folder-close");
		}
	});

	$('.selector-button').on('click', function() {
		if ($(this).find('.glyphicon').hasClass('glyphicon-ok-sign')) {
			$(this).parent().parent().find('.selector-button .glyphicon').removeClass("glyphicon-ok-sign").addClass("glyphicon-remove-sign");
			// $(this).parent().addClass('white');
			$(this).parent().parent().find('.panel-heading').addClass('white');
			$(this).parent().parent().find('input[type=hidden]').prop('disabled', true);
		} else {
			$(this).parent().parent().find('.selector-button .glyphicon').removeClass("glyphicon-remove-sign").addClass("glyphicon-ok-sign");
			// $(this).parent().removeClass('white');
			$(this).parent().parent().find('.panel-heading').removeClass('white');
			$(this).parent().parent().find('input[type=hidden]').prop('disabled', false);
		}
	});

	$.each($('.selector-button'), function(index, element) {
		var hasRemoveSign = $(element).hasClass('glyphicon-remove-sign');
		var hasCollapseButton = $(element).parent().find('.close-button').length > 0;
		var hasEnabledElements = $(element).parent().parent().find('.this-is-articul .glyphicon-ok-sign').length;
		if (!hasRemoveSign && hasCollapseButton && !hasEnabledElements) {
			$(this).find('.glyphicon').removeClass("glyphicon-ok-sign").addClass("glyphicon-remove-sign");

			$(this).parent().addClass('white');
		}
	});
});
