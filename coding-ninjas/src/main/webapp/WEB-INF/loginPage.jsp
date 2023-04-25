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
<link rel="stylesheet" href="/css/loginPage.css" />
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Lato&family=Marvel&family=Roboto+Mono&display=swap"
	rel="stylesheet">

</head>
<body>
	<c:if test="${logoutMessage != null}">
		<p class="message">
			<c:out value="${logoutMessage}"></c:out>
		</p>
	</c:if>
	<div class="container mx-auto" style="width: 90%;">
		<h1 class="mt-4">Welcome to Coding Ninjas!</h1>
		<div class="d-flex justify-content-between mt-4">
			<div class="register">
				<h3>Register</h3>
				<form:form action="/register" method="post" modelAttribute="user">
					<div>
						<form:label path="firstName" class="form-lable">First Name:</form:label>
						<form:errors path="firstName" class="text-danger" />
						<form:input type="text" path="firstName" class="form-control" />
					</div>
					<div>
						<form:label path="lastName" class="form-lable">Last Name:</form:label>
						<form:errors path="lastName" class="text-danger" />
						<form:input type="text" path="lastName" class="form-control" />
					</div>
					<div>
						<form:label path="email" class="form-lable">Email:</form:label>
						<form:errors path="email" class="text-danger" />
						<form:input type="email" path="email" class="form-control" />
					</div>
					<div>
						<form:label path="password" class="form-lable">Password:</form:label>
						<form:errors path="password" class="text-danger" />
						<form:input type="password" path="password" class="form-control" />
					</div>
					<div>
						<form:label path="confirm" class="form-lable">Confirm Password:</form:label>
						<form:errors path="confirm" class="text-danger" />
						<form:input type="password" path="confirm" class="form-control" />
					</div>
					<div class="d-flex justify-content-between mt-4">
						<div></div>
						<button type="submit" class="btn btn-primary">Register</button>
					</div>
				</form:form>
			</div>
			<div class="login">
				<h3>Login</h3>
				<c:if test="${errorMessage != null}">
					<p class="text-danger">
						<c:out value="${errorMessage}"></c:out>
					</p>
				</c:if>
				<form:form action="/login" method="post" modelAttribute="user">
					<input type="hidden" name="${_csrf.parameterName}"
						value="${_csrf.token}" />
					<div>
						<form:label path="email" class="form-lable">Email:</form:label>
						<form:input type="email" path="email" class="form-control" />
					</div>
					<div>
						<form:label path="password" class="form-lable">Password:</form:label>
						<form:input type="password" path="password" class="form-control" />
					</div>
					<div class="d-flex justify-content-between mt-4">
						<div></div>
						<button type="submit" class="btn btn-success">Login</button>
					</div>
				</form:form>
			</div>
		</div>
	</div>
</body>
</html>