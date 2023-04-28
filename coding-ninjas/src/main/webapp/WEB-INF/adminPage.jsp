<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page isErrorPage="true"%>
<%@ page import="java.util.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Coding Ninjas</title>
<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css" href="/css/adminPage.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Lato&family=Marvel&family=Roboto+Mono&display=swap"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe"
	crossorigin="anonymous"></script>
</head>
<body>
	<nav class="navbar navbar-expand-lg bg-body-tertiary">
		<div class="container-fluid">
			<a class="navbar-brand" href="/">Coding Ninjas</a>
			<div class="collapse navbar-collapse" id="navbarSupportedContent">
				<ul class="navbar-nav me-auto mb-2 mb-lg-0">
					<li class="nav-item"><a class="nav-link" href="/api/v1/searchChatGPT">MChatGPT</a></li>
				</ul>

				<form id="logoutForm" method="POST" action="/logout">
					<input type="hidden" name="${_csrf.parameterName}"
						value="${_csrf.token}" /> <input type="submit" value="Logout!" class="btn btn-danger btn-sm"/>
				</form>
				<form action="/lectures/search" method="POST" class="d-flex"
					placeholder="Search">
					<input type="hidden" name="${_csrf.parameterName}"
						value="${_csrf.token}" /> <input name="keyword" type="text"
						class="form-control me-2" />
					<button class="btn btn-primary" data-toggle="button" aria-pressed="false" autocomplete="off" type="submit">Search</button>
				</form>
			</div>
		</div>
	</nav>

	<div class="container mx-auto" style="width: 90%;">

		<div class="d-flex justify-content-between mt-4 mb-4">
			<h1>
				Welcome Back, <span style="text-transform: capitalize;">${currentUser.firstName}</span>
			</h1>
		</div>

		<div class="d-flex justify-content-between">
			<div>
				<div class="adminBoard">
					<table class="table">
						<thead>
							<tr>
								<th>Name</th>
								<th>Email</th>
								<th>Action</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="user" items="${users}">
								<c:if
									test="${!user.roles.get(0).name.contains('ROLE_SUPER_ADMIN')}">
									<tr>
										<td style="text-transform: capitalize;">${user.firstName}
											${user.lastName}</td>
										<td>${user.email}</td>
										<c:if
											test="${currentUser.roles.get(0).name.contains('ROLE_SUPER_ADMIN')}">
											<td><a href="/delete/${user.id}">Delete</a> <a
												href="/admin/${user.id}">Make Admin</a></td>
										</c:if>
										<c:if
											test="${currentUser.roles.get(0).name.contains('ROLE_ADMIN')}">
											<c:if test="${user.roles.get(0).name.contains('ROLE_USER')}">
												<td><a href="/delete/${user.id}"
													class="btn btn-danger btn-sm">Delete</a> <a
													href="/admin/${user.id}" class="btn btn-primary btn-sm">Make
														Admin</a></td>
											</c:if>
											<c:if test="${user.roles.get(0).name.contains('ROLE_ADMIN')}">
												<td>Admin</td>
											</c:if>
										</c:if>
									</tr>
								</c:if>
							</c:forEach>
						</tbody>
					</table>
				</div>

				<div class="allCourse">
					<div class="dropdown-toggle" data-bs-toggle="dropdown"
						aria-expanded="false">
						<div class="d-flex justify-content-between">
							<h4>All Courses</h4>
							<button class="btn btn-primary" data-bs-toggle="modal"
								data-bs-target="#newCourseForm">+Add a course</button>
						</div>
						<div class="dropdown-menu">
							<table class="table">
								<thead>
									<tr>
										<th>Course</th>
										<th>Teacher</th>
										<th>Description</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="eachCourse" items="${unassignedCourses}">
										<tr>
											<c:if test="${eachCourse.teacher.id!=currentUser.id}">
												<td><a href="/courses/${eachCourse.id}/lecture"
													class="link">${eachCourse.title}</a></td>
												<td><c:out value="${eachCourse.teacher.firstName}"></c:out></td>

												<td><c:out value="${eachCourse.description }"></c:out></td>
											</c:if>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
					</div>
				</div>
				<div class="yourCourse">
					<div class="dropdown-toggle" data-bs-toggle="dropdown"
						aria-expanded="false">
						<h4>Your Courses</h4>
						<div class="dropdown-menu">
							<table class="table tb p-2">
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
											<td><a href="/courses/${eachCourse.id}/lectures"
												class="link">${eachCourse.title}</a></td>
											<td><c:out value="${eachCourse.teacher.firstName}"></c:out></td>

											<c:if test="${eachCourse.teacher.id==currentUser.id}">
												<td><a href="/courses/edit/${eachCourse.id}"
													class="btn btn-warning btn-sm">Edit Course</a></td>
												<td><form action="/admin/courses/${eachCourse.id }"
														method="post">
														<input type="hidden" name="${_csrf.parameterName}"
															value="${_csrf.token}" /> <input type="hidden"
															name="_method" value="delete">
														<button type="submit" class="btn btn-danger btn-sm">Delete</button>
													</form></td>
											</c:if>
											<c:if test="${eachCourse.teacher.id!=currentUser.id}">
												<td><a href="/dashboard/leave/${eachCourse.id}">Leave
														Course</a></td>
											</c:if>
										</tr>

									</c:forEach>
								</tbody>
							</table>
						</div>
					</div>

				</div>
				<div class="chatGPT">
					<h4 class="dropdown-toggle" data-bs-toggle="dropdown"
						aria-expanded="false">ChatGPT</h4>
					<div class="dropdown-menu">
						<div>
							<h2>ChatGPT responded with:</h2>
							<p class="gptResponse">${response}</p>
						</div>
						<form action="/api/v1/searchChatGPT" method="post" class="form">
							<div class="form-group">
								<label class="form-label">Enter your message:</label> <input
									type="text" name="prompt" required autofocus
									class="form-control" />
							</div>
							<button type="submit" class="btn btn-primary btn-sm mt-2">Send</button>

							<input type="hidden" name="${_csrf.parameterName}"
								value="${_csrf.token}" />
						</form>
					</div>
				</div>
			</div>
			<div>
				<div>
					<div class="card"
						style="background-color: whitesmoke; border: none;">
						<div class="card-body">
							<p style="text-transform: capitalize;">Username:
								${currentUser.firstName} ${currentUser.lastName}</p>
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
					<div class="card calendar" style="border: none;">
						<%
						Calendar cal = Calendar.getInstance();
						int year = cal.get(Calendar.YEAR);
						int month = cal.get(Calendar.MONTH);
						int day = cal.get(Calendar.DAY_OF_MONTH);
						Calendar firstDay = Calendar.getInstance();
						firstDay.set(Calendar.YEAR, year);
						firstDay.set(Calendar.MONTH, month);
						firstDay.set(Calendar.DAY_OF_MONTH, 1);
						int numDays = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
						String[] weekdays = { "Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat" };
						%>
						<table class="calendar">
							<thead>
								<tr>
									<%
									for (int i = 0; i < weekdays.length; i++) {
									%>
									<th><%=weekdays[i]%></th>
									<%
									}
									%>
								</tr>
							</thead>
							<tbody>
								<%
								for (int i = 1; i <= numDays; i++) {
								%>
								<%
								if (i == 1 || firstDay.get(Calendar.DAY_OF_WEEK) == Calendar.SUNDAY) {
								%>
								<tr>
									<%
									}
									%>
									<%
									if (i == day) {
									%>
									<td class="current-day"><%=i%></td>
									<%
									} else {
									%>
									<td><%=i%></td>
									<%
									}
									%>
									<%
									if (i == numDays || firstDay.get(Calendar.DAY_OF_WEEK) == Calendar.SATURDAY) {
									%>
								</tr>
								<%
								}
								%>
								<%
								firstDay.add(Calendar.DAY_OF_MONTH, 1);
								%>
								<%
								}
								%>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- NEW COURSE -->
	<div class="modal fade" id="newCourseForm" data-bs-backdrop="static"
		data-bs-keyboard="false" tabindex="-1"
		aria-labelledby="staticBackdropLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h1 class="modal-title fs-5" id="staticBackdropLabel">Add New
						Course</h1>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<form:form action="/" method="post" modelAttribute="newCourse">
						<div>
							<form:label path="title" class="form-label">Title:</form:label>
							<form:input path="title" type="text" class="form-control" />
							<form:errors path="title" class="text-danger" />
						</div>
						<div>
							<form:label path="description" class="form-label">Course Description:</form:label>
							<form:textarea path="description" type="text"
								class="form-control"></form:textarea>
							<form:errors path="description" class="text-danger" />
						</div>
						<div>
							<form:errors path="teacher" class="error" />
							<form:input type="hidden" path="teacher"
								value="${currentUser.id}" class="form-control" />
						</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">Cancle</button>
					<button type="submit" class="btn btn-primary">Submit</button>
				</div>
				</form:form>
			</div>
		</div>
	</div>
</body>
</html>