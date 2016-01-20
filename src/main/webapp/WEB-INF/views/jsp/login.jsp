<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>

<tiles:insertDefinition name="loginTemplate">
	<tiles:putAttribute name="title" value="Checker Login" />
	<tiles:putAttribute name="body">
		<div class="container">
			<form method="POST" action="<c:url value='/login'/>" class="form-signin">
				<fieldset>
					<legend>Администрирование</legend>

					<div class="form-group">
						<label for="username">Пользователь</label>
						<input type="text" class="form-control" name="username" id="username" placeholder="Username" required autofocus />
					</div>

					<div class="form-group">
						<label for="password">Пароль</label>
						<input type="password" class="form-control" name="password" id="password" placeholder="Password" required />
					</div>

					<input type="submit" class="btn btn-primary" name="submit" value="Войти" />

					<c:if test="${not empty failed}">
						<div class="alert alert-danger" id="login_message">
							<button type="button" class="close" data-dismiss="alert">&times;</button>
							<strong>Failed</strong> Пользователь и пароль не совпадают
						</div>
					</c:if>
				</fieldset>
			</form>
		</div>
	</tiles:putAttribute>
</tiles:insertDefinition>



