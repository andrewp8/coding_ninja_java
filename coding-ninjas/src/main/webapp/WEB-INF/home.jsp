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
<link rel="stylesheet" href="/css/home.css" />
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
					<li class="nav-item"><a class="nav-link" href="/status">Status</a></li>
				</ul>
				<form class="d-flex" role="search">
					<input class="form-control me-2" type="search" placeholder="Search"
						aria-label="Search">
					<button class="btn btn-outline-success" type="submit">Search</button>
				</form>
			</div>
		</div>
	</nav>
	<div class="container m-4">
		<div class="d-flex justify-content-between">
			<h1>Welcome Back, <span style="text-transform:capitalize;">${currentUser.firstName}</span></h1>
			<form id="logoutForm" method="POST" action="/logout">
				<input type="hidden" name="${_csrf.parameterName}"
					value="${_csrf.token}" /> <input type="submit" value="Logout!"
					class="btn btn-danger" />
			</form>
		</div>

		<h4>All Courses</h4>
		<div class="d-flex justify-content-between">
			<div>
				<table>
					<thead>
						<tr>
							<th>Course</th>
							<th>Teacher</th>
							<th>Actions</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="eachCourse" items="${unassignedCourses}">
							<tr>
								<c:if test="${eachCourse.teacher.id!=currentUser.id}">
									<td><a href="/courses/${eachCourse.id}">${eachCourse.title}</a></td>
									<td><c:out value="${eachCourse.teacher.firstName}"></c:out></td>

									<td><a href="/dashboard/join/${eachCourse.id}">Enroll
											in Class</a></td>
								</c:if>
							</tr>
						</c:forEach>
					</tbody>
				</table>

				<hr>

				<div class="dropdown">
					<h4>Your Courses</h4>
				<table class="table dropdown-content">
					<thead>
						<tr>
							<th>Course</th>
							<th>Teacher</th>
							<th>Due Date</th>
							<th>Actions</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="eachCourse" items="${assignedCourses}">
							<tr>
								<td><a href="/courses/${eachCourse.id}">${eachCourse.title}</a></td>
								<td><c:out value="${eachCourse.teacher.firstName}"></c:out></td>

								<c:if test="${eachCourse.teacher.id==currentUser.id}">
									<td><a href="/projects/edit/${eachCourse.id}">Edit
											Course</a></td>
								</c:if>
								<c:if test="${eachCourse.teacher.id!=currentUser.id}">
									<td><a href="/dashboard/leave/${eachCourse.id}">Leave
											Class</a></td>
								</c:if>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				</div>
			</div>

			<div class="card" style="width: 15rem;">
				<div class="card-body">
					<h5 style="text-transform: capitalize;">Hello,
						${currentUser.firstName} ${currentUser.lastName}</h5>
					<p>Email: ${currentUser.email}</p>
					<p>
						Signup Date:
						<fmt:formatDate pattern="MMMM dd, y"
							value="${currentUser.createdAt}" />
					</p>
					<p>
						Last Sign in:
						<fmt:formatDate pattern="MMMM dd, y"
							value="${currentUser.lastLogin}" />
					</p>
				</div>
			</div>
		</div>

	</div>
</body>
</html>