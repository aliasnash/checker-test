<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.joda.org/joda/time/tags" prefix="joda"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="/WEB-INF/tld/customTaglib.tld" prefix="tag"%>

<tiles:insertDefinition name="defaultTemplate">
	<tiles:putAttribute name="title" value="Checker Task Complete" />
	<tiles:putAttribute name="body">
		<div class="panel panel-default">
			<div class="panel-heading">Проверенные задачи</div>
			<div class="panel-body">
				<c:forEach items="${taskArticleCompleteList}" var="ta">
					<div class="col-md-4">
						<div class="thumbnail text-center">
							<img class="img-thumbnail" data-photo-id="0" data-toggle="magnify" src="${rootUrl}${ta.photo.thumbNailsPath}" width="250px" height="300px"
								alt="ID:${ta.photo.id}, ${ta.article.caption}" />
							<div class="caption">
								<p>${ta.article.caption}</p>
								<p>
									ЦЕНА: <strong>${ta.price}</strong>
								</p>
								<p>
									<joda:format value="${ta.dateUpdate}" style="SM" />
								</p>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>

			<div class="text-center">
				<spring:url value="/taskcomplete/list" htmlEscape="true" var="pUrl" />
				<tag:paginate page="${page}" pageCount="${pageCount}" paginatorSize="10" uri="${pUrl}" next="&raquo;" previous="&laquo;" />
			</div>
		</div>
	</tiles:putAttribute>
</tiles:insertDefinition>



