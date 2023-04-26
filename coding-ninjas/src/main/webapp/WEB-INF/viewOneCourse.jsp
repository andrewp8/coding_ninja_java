<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="/css/viewOneCourse.css">
<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css" />
<link rel="stylesheet" href="/css/home.css" />
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Lato&family=Marvel&family=Roboto+Mono&display=swap"
	rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<meta charset="UTF-8">
<title>View One Course</title>
<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css" />
<link rel="stylesheet" href="/css/style.css" />
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

	<h1>course title: ${currentCourse.title }</h1>
	<div class="d-flex justify-content-between p-3">
		<div class="p-3">
			<h3>Class List</h3>
			<div class="table-wrapper-scroll-y my-custom-scrollbar">
				<table class="table table-bordered table-striped mb-0">
					<thead>
						<tr>
							<th>First name</th>
							<th>Last name</th>
							<th>Status</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="oneUser" items="${attendees }">
							<tr>
								<td>${oneUser.firstName }</td>
								<td>${oneUser.lastName }</td>
								<c:choose>
									<c:when
										test="${ oneUser.roles.get(0).name.contains('ROLE_ADMIN')}">
										<td>Teacher</td>
									</c:when>
									<c:otherwise>
										<td>Student</td>
									</c:otherwise>
								</c:choose>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>

			<br>
			<div>
				<h3>Message the class</h3>
				<form:form method="post"
					action="/courses/${currentCourse.id }/addMessage"
					modelAttribute="message">
					<h5>
						<form:input cssClass="txtbox" type="textarea" path="content" />
						<form:errors path="content" style="color:red " />
					</h5>
					<form:hidden path="user" value="${currentUser.id}" />
					<form:hidden path="course" value="${currentCourse.id}" />
					<input class="btn btn-primary" type="submit" value="Post Message">
				</form:form>
				<h3>Class Message Wall</h3>
				<div class="message-container table-wrapper-scroll-y">

					<c:forEach var="oneMsg" items="${theseMessages}">
						<p>
							<span class="sender-color">${oneMsg.user.firstName}</span> <span
								class="date-color"> <fmt:formatDate
									value="${oneMsg.createdAt}" pattern="MM/dd/yyyy @ h:mm a" />
							</span>
						</p>
						<p>${oneMsg.content}</p>
						<p>--*--*--*--*--*--*--</p>
					</c:forEach>
				</div>

			</div>
		</div>
		<div class="p-3">
			<c:if test="${ currentUser.roles.get(0).name.contains('ROLE_ADMIN')}">
				<a href="/courses/${oneCourse.id}/lectures/new"
					class="btn btn-primary">Add new lecture</a>
			</c:if>
			<table class="table" style="text-aligh: center;">
				<thead>
					<tr>
						<th>Lecture's title</th>
						<th>Difficulty</th>
						<th>Finish reading by</th>
						<c:if
							test="${ currentUser.roles.get(0).name.contains('ROLE_ADMIN')}">
							<th colspan=2>Action</th>
						</c:if>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="eachLecture" items="${lectureList}">
						<tr>
							<td><a
								href="/courses/${oneCourse.id}/lectures/${eachLecture.id}"
								class="link">${eachLecture.title }</a></td>
							<td>${eachLecture.difficulty }</td>
							<td><fmt:formatDate pattern="MM/dd/YYYY"
									value="${eachLecture.dueDate}" /></td>
							<c:if
								test="${ currentUser.roles.get(0).name.contains('ROLE_ADMIN')}">
								<td class="d-flex gap-1"><a
									href="/courses/${oneCourse.id}/lectures/${eachLecture.id}/edit"
									class="btn btn-warning btn-sm">Edit</a> <form:form
										action="/courses/${oneCourse.id}/lectures/${eachLecture.id}/delete"
										method="delete">
										<button type="submit" class="btn btn-danger btn-sm">Delete</button>
									</form:form></td>
							</c:if>
						</tr>
					</c:forEach>
				</tbody>

			</table>
		</div>
		<div class="p-3">
			<h2>Additional stuff</h2>
		</div>
	</div>

	<script src="/webjars/bootstrap/js/bootstrap.min.js">
		
	</script>
</body>
</html>