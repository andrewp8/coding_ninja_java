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

</head>
<body>
	<div class="container mt-4">
		<h1 style="color: yellowgreen;">Book Broker</h1>
		<p>A place for friends to share thoughts on books.</p>
		<div class="d-flex justify-content-evenly m-2">
			<div class="border border-primary rounded p-4">
				<h3>Registration</h3>
				<form:form action="/register" method="POST" modelAttribute="user">
					<div class="form-group">
						<form:label path="userName" class="form-label">User Name:</form:label>
						<form:input path="userName" type="text" class="form-control" />
						<form:errors path="userName" class="text-danger" />
					</div>
					<div class="form-group">
						<form:label path="email" class="form-label">Email:</form:label>
						<form:input path="email" type="email" class="form-control" />
						<form:errors path="email" class="text-danger" />
					</div>
					<div class="form-group">
						<form:label path="password" class="form-label">Password:</form:label>
						<form:input path="password" type="password" class="form-control" />
						<form:errors path="password" class="text-danger" />
					</div>
					<div class="form-group">
						<form:label path="confirm" class="form-label">Confirm Password:</form:label>
						<form:input path="confirm" type="password" class="form-control" />
						<form:errors path="confirm" class="text-danger" />
					</div>
					<div class="d-flex justify-content-between">
						<div></div>
						<button type="submit" class="btn btn-primary mt-4">Submit</button>
					</div>
				</form:form>
			</div>

			<div class="border border-success rounded p-4">
				<h3>Login</h3>
				<form:form action="/login" method="POST" modelAttribute="user">
					<div class="form-group">
						<form:label path="email" class="form-label">Email:</form:label>
						<form:input path="email" type="email" class="form-control" />
						<form:errors path="email" class="text-danger" />
					</div>
					<div class="form-group">
						<form:label path="password" class="form-label">Password:</form:label>
						<form:input path="password" type="password" class="form-control" />
						<form:errors path="password" class="text-danger" />
					</div>
<%-- 					<input type="hidden" name="${_csrf.parameterName}" --%>
<%-- 						value="${_csrf.token}" /> --%>
					<div class="d-flex justify-content-between">
						<div></div>
						<button type="submit" class="btn btn-success mt-4">Submit</button>
					</div>
				</form:form>
			</div>
		</div>
	</div>
</body>
</html>