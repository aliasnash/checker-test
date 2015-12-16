//triggered when modal is about to be shown
$('#modal-edit-promo').on('show.bs.modal', function(e) {
	// get data-id attribute of the clicked element
	var elementId = $(e.relatedTarget).data('element-id');
	var elementName = $(e.relatedTarget).data('element-name');
	// populate the textbox
	$(e.currentTarget).find('input[name="id"]').val(elementId);
	$(e.currentTarget).find('input[name="name"]').val(elementName);
});

// triggered when modal is about to be shown
$('#modal-edit-region').on('show.bs.modal', function(e) {
	// get data-id attribute of the clicked element
	var elementId = $(e.relatedTarget).data('element-id');
	var elementName = $(e.relatedTarget).data('element-name');
	// populate the textbox
	$(e.currentTarget).find('input[name="id"]').val(elementId);
	$(e.currentTarget).find('input[name="name"]').val(elementName);
});