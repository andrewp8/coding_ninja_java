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
<link rel="stylesheet" href="/css/newLecture.css" />
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<script type="text/javascript" src="/js/app.js"></script>

</head>
<body>
	<div class="container mx-auto">
		<form:form action="/courses/${courseId}/lectures/new" method="post"
			modelAttribute="newLecture">
		<h2>New Lecture</h2>
			<form:input type="hidden" path="course" value="${courseId}"
				class="form-control" />
			<div>
				<form:label path="title" class="form-label">Title</form:label>
				<form:input type="text" path="title" class="form-control" />
				<p>
					<form:errors path="title" class="text-danger" />
				</p>
			</div>
			<div>
				<form:label path="content" class="form-label">Content</form:label>
				<form:textarea type="text" path="content" class="form-control"></form:textarea>
				<p>
					<form:errors path="content" class="text-danger" />
				</p>
			</div>
			<div>
				<form:label path="difficulty" class="form-label">Difficult Level:</form:label>
				<form:select path="difficulty" class="form-select">
					<c:forEach var="index" begin="1" end="5">
						<option value="${index}"><c:out value="${index}" /></option>
					</c:forEach>
				</form:select>
			</div>
			<div>
				<form:label path="dueDate" class="form-label">Finished reading
					by:</form:label>
				<form:input path="dueDate" type="date" min="${today}"
					class="form-control" />
				<p>
					<form:errors path="dueDate" class="text-danger" />
				</p>
			</div>
			<div class="d-flex justify-content-between">
				<a href="/courses/${courseId}/lectures" class="btn btn-secondary">Back</a>
				<button type="submit" class="btn btn-success">Submit</button>
			</div>
		</form:form>

		<form action="/lectures/photos/new" method="post"
			enctype="multipart/form-data" class="form">
			<div class="row">
				<label class="form-label">Photo: </label> <input type="file" name="image"
					accept="image/png, image/jpeg" class="form-control" /> <input type="hidden"
					name="${_csrf.parameterName}" value="${_csrf.token}" />
				<button type="submit" class="btn btn-success">Submit</button>
			</div>

		</form>
	</div>
</body>
</html>