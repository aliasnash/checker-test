<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<tiles:insertDefinition name="defaultTemplate">
	<tiles:putAttribute name="title" value="Checker Report" />
	<tiles:putAttribute name="body">

		<div class="container">
			<h1>Tree View</h1>
			<br>
			<div class="row">
				<hr>
				<h2 id="dataclick">Data</h2>
				<div class="col-sm-4">
					<h2>DENIS DATA</h2>
					<div id="templatetree" class=""></div>
				</div>
				<div class="col-sm-4">
					<h2>Events</h2>
					<div id="output"></div>
				</div>
			</div>
		</div>

	</tiles:putAttribute>
</tiles:insertDefinition>



