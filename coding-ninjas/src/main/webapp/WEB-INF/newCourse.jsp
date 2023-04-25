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
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Lato&family=Marvel&family=Roboto+Mono&display=swap" rel="stylesheet">

<script type="text/javascript" src="/js/app.js"></script>

</head>
<body>
	<h2>
		<a href="/dashboard">Dashboard</a>
	</h2>

	<h1>Create a new Course</h1>

	<form:form action="/courses/new" method="post"
		modelAttribute="newCourse">

		<table>
			<thead>
				<tr>
					<td class="float-left">Course Title:</td>
					<td class="float-left"><form:errors path="title"
							class="text-danger" /> <form:input class="input" path="title" />
					</td>
				</tr>
				<tr>
					<td class="float-left">Course Description:</td>
					<td class="float-left"><form:errors path="description"
							class="text-danger" /> <form:textarea rows="4" class="input"
							path="description" /></td>
				</tr>

				<form:errors path="teacher" class="error" />
				<form:input type="hidden" path="teacher" value="${userId}"
					class="form-control" />

				<tr>
					<td><a class="linkBtn" href="/">Cancel</a></td>
					<td><input class="input" type="submit" value="Submit" /></td>
				</tr>
			</thead>
		</table>
	</form:form>
</body>
</html>