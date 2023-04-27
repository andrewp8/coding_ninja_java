<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page isErrorPage="true"%>
<!DOCTYPE html>
<html>
<head>
<title>Edit Course</title>
<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css" href="/css/viewEditCourse.css">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe"
	crossorigin="anonymous"></script>
</head>
<body>
	<div class="container mx-auto">
		<form:form action="/courses/edit/${oneCourse.id}" method="post"
			modelAttribute="oneCourse" class="form">
		<h1>Edit ${oneCourse.title}</h1>
			<div class="input">
				<form:label path="title" id="title" class="form-label">Title:</form:label>
				<form:input path="title" type="text" class="form-control" />
				<form:errors path="title" class="text-danger" />
			</div>
			<div class="input">
				<form:label path="description" id="description" class="form-label">Course Description:</form:label>
				<form:textarea path="description" type="text" class="form-control"></form:textarea>
				<form:errors path="description" class="text-danger" />
			</div>
			<div>
				<form:errors path="teacher" class="error" />
				<form:input type="hidden" path="teacher" id="teacher"
					value="${userId}" class="form-control" />
			</div>
			<div class="d-flex justify-content-between">
				<a href="/" class="btn btn-secondary">Cancel</a>
				<button type="submit" class="btn btn-success">Submit</button>
			</div>
		</form:form>
	</div>
</body>
</html>