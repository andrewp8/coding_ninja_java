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
<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css" />
<link rel="stylesheet" href="/css/home.css" />
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<script type="text/javascript" src="/js/app.js"></script>

</head>
<body>

	<nav class="navbar navbar-expand-lg bg-body-tertiary">
		<div class="container-fluid">
			<a class="navbar-brand" href="/">Coding Ninjas</a>
			<div class="collapse navbar-collapse" id="navbarSupportedContent">
				<ul class="navbar-nav me-auto mb-2 mb-lg-0">
					<li class="nav-item"><a class="nav-link" aria-current="page"
						href="/lessons">Lessons</a></li>
					<li class="nav-item"><a class="nav-link" href=#status>Status</a></li>
					<li class="nav-item"><a class="nav-link" href="/api/v1/searchChatGPT">ChatGPT</a></li>
				</ul>
				<form action="/lectures/search" method="POST" class="d-flex"
					placeholder="Search">
					<input type="hidden" name="${_csrf.parameterName}"
						value="${_csrf.token}" /> <input name="keyword" type="text"
						class="form-control me-2" />
					<button class="btn btn-outline-success" type="submit">Search</button>
				</form>
			</div>
		</div>
	</nav>
	<div class="container mt-4">
		<h1>New Lecture</h1>
		<form:form action="/courses/${courseId}/lectures/new" method="post"
			modelAttribute="newLecture">
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
			enctype="multipart/form-data">
			<div>

				<label>Photos: </label> <input type="file" name="image"
					accept="image/png, image/jpeg" /> <input type="hidden"
					name="${_csrf.parameterName}" value="${_csrf.token}" />
				<button type="submit" class="btn btn-success">Submit</button>
			</div>

		</form>
	</div>
</body>
</html>