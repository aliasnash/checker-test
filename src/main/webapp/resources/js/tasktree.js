$(window).on('load', function() {

	var $tasktree = $('#task_tree').treeview({
		showTags : true,
		selectedIcon : "glyphicon glyphicon-ok",
		multiSelect : false,
		levels : 3,
		data : taskTree,

	// onNodeSelected : function(event, node) {
	// var idarticle = node.idarticle;
	// if (idarticle) {
	// selectedArticles.push(idarticle);
	// }
	// selectedArticles = selectedArticles.filter(function(e) {
	// return e;
	// });
	// $('#task_selected_articul_count').text(selectedArticles.length);
	// },
	//
	// onNodeUnselected : function(event, node) {
	// var idarticle = node.idarticle;
	// if (idarticle) {
	// delete selectedArticles[selectedArticles.indexOf(idarticle)];
	// }
	// selectedArticles = selectedArticles.filter(function(e) {
	// return e;
	// });
	// $('#task_selected_articul_count').text(selectedArticles.length);
	// }
	});

	// $tasktree.on('nodeSelected', function(ev, node) {
	// for ( var i in node.nodes) {
	// var child = node.nodes[i];
	// $(this).treeview(true).selectNode(child.nodeId);
	// }
	// });
	//
	// $tasktree.on('nodeUnselected', function(ev, node) {
	// for ( var i in node.nodes) {
	// var child = node.nodes[i];
	// $(this).treeview(true).unselectNode(child.nodeId);
	// }
	// });

	$('#task_expand_category').on('click', function(e) {
		$tasktree.treeview('expandAll', {
			levels : 3,
			silent : true
		});
	});

	$('#task_collapse_category').on('click', function(e) {
		$tasktree.treeview('collapseAll', {
			silent : true
		});
	});
});
