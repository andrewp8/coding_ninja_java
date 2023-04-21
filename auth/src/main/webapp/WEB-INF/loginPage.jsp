<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page isErrorPage="true"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css" />
<link rel="stylesheet" href="/css/style.css" />
<script type="text/javascript" src="/js/app.js"></script>

</head>
<body>
	<div class="container mt-4">
		<h1>Register!</h1>

		<p>
			<form:errors path="user.*" />
		</p>

		<form:form method="POST" action="/register" modelAttribute="user">
			<p>
				<form:label path="username">Username:</form:label>
				<form:input path="username" />
			</p>
			<p>
				<form:label path="password">Password:</form:label>
				<form:password path="password" />
			</p>
			<p>
				<form:label path="passwordConfirmation">Password Confirmation:</form:label>
				<form:password path="passwordConfirmation" />
			</p>
			<input type="submit" value="Register!" />
		</form:form>
	</div>
</body>
</html>