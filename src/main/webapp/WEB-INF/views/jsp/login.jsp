<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>

<tiles:insertDefinition name="defaultTemplate">
	<tiles:putAttribute name="title" value="Checker Login" />
	<tiles:putAttribute name="body">
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		<div class="login-container">
			<form class="form-signin" method="POST" action="<c:url value='/process-login'/>">
				<h2 class="form-signin-heading">Anmelden</h2>
				<c:if test="${error == true}">
					<div class="alert alert-danger">
						<a class="close" data-dismiss="alert" href="#">×</a>
						<p>Login</p>
					</div>
				</c:if>
				<input type="text" name="j_username" id="j_username" class="form-control" placeholder="eMail Adresse" required autofocus>
				<input type="password" name="j_password" id="j_password" class="form-control" placeholder="Passwort" required>
				<label class="checkbox"> <input type="checkbox" value="remember-me">remember-me
				</label>
				<button class="btn btn-lg btn-primary btn-block" type="submit">submit</button>
			</form>
		</div>
	</tiles:putAttribute>
</tiles:insertDefinition>



