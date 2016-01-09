$(window).on('load', function() {

	var $tree = $('#templatetree').treeview({
		showTags : true,
		selectedIcon : "glyphicon glyphicon-ok",
		multiSelect : true,
		levels : 3,
		data : templateTree,

		onNodeSelected : function(event, node) {
			var idarticle = node.idarticle;
			if (idarticle) {
				selectedArticles.push(idarticle);
			}
			selectedArticles = selectedArticles.filter(function(e) {
				return e;
			});
			$('#selected_articul_count').text(selectedArticles.length);
		},

		onNodeUnselected : function(event, node) {
			var idarticle = node.idarticle;
			if (idarticle) {
				delete selectedArticles[selectedArticles.indexOf(idarticle)];
			}
			selectedArticles = selectedArticles.filter(function(e) {
				return e;
			});
			$('#selected_articul_count').text(selectedArticles.length);
		}
	});

	$tree.on('nodeSelected', function(ev, node) {
		for ( var i in node.nodes) {
			var child = node.nodes[i];
			$(this).treeview(true).selectNode(child.nodeId);
		}
	});

	$tree.on('nodeUnselected', function(ev, node) {
		for ( var i in node.nodes) {
			var child = node.nodes[i];
			$(this).treeview(true).unselectNode(child.nodeId);
		}
	});

	$('#expand_category').on('click', function(e) {
		$tree.treeview('expandAll', {
			levels : 3,
			silent : true
		});
	});

	$('#collapse_category').on('click', function(e) {
		$tree.treeview('collapseAll', {
			silent : true
		});
	});

	$('#tree-submit').on('click', function(e) {
		selectedArticles = selectedArticles.filter(function(e) {
			return e;
		});
		
		$('input[id="template_selected_articles"]').val(selectedArticles);
		$('#template_form').submit();
	});
});
