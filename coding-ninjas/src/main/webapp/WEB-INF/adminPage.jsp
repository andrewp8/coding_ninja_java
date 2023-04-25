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
<link rel="stylesheet" type="text/css" href="/css/adminPage.css">
<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css" />
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Lato&family=Marvel&family=Roboto+Mono&display=swap" rel="stylesheet">

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
			<form class="d-flex" role="search">
				<input class="form-control me-2" type="search" placeholder="Search"
					aria-label="Search">
				<button class="btn btn-outline-success" type="submit">Search</button>
			</form>
		</div>
	</div>
	</nav>

	<div class="container mx-auto" style="width: 90%;">

		<div class="d-flex justify-content-between mt-4 mb-4">
			<h1>
				Welcome Back, <span style="text-transform: capitalize;">${currentUser.firstName}</span>
			</h1>
			<form id="logoutForm" method="POST" action="/logout">
				<input type="hidden" name="${_csrf.parameterName}"
					value="${_csrf.token}" /> <input type="submit" value="Logout!"
					class="btn btn-danger" />
			</form>
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

				<div class="allCourse mt-4 dropdown">
					<div class="d-flex justify-content-between">
						<h4>All Courses</h4>
						<a href="/courses/new" class="btn btn-success btn-sm">+Add a
							Course</a>
					</div>

					<table class="table dropdown-content">
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
										<td><a href="/courses/${eachCourse.id}/lecture" class="link">${eachCourse.title}</a></td>
										<td><c:out value="${eachCourse.teacher.firstName}"></c:out></td>

										<td><c:out value="${eachCourse.description }"></c:out></td>
									</c:if>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
				<div class="yourCourse dropdown">
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
									<td><a href="/courses/${eachCourse.id}/lectures" class="link">${eachCourse.title}</a></td>
									<td><c:out value="${eachCourse.teacher.firstName}"></c:out></td>

									<c:if test="${eachCourse.teacher.id==currentUser.id}">
										<td><a href="/courses/edit/${eachCourse.id}"
											class="btn btn-warning btn-sm">Edit Course</a></td>
										<td><form action="/admin/courses/${eachCourse.id }"
												method="post">
												<input type="hidden" name="_method" value="delete">
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
			<div>
				<div>
					<div class="card" style="	background-color: whitesmoke;	border: none;">
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
					<div class="card calendar" style="	border: none;">
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


</body>
</html>