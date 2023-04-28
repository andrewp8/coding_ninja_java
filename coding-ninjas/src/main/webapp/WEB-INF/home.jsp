<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page isErrorPage="true"%>
<%@ page import="java.util.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Coding Ninjas</title>
<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css" />
<link rel="stylesheet" href="/css/home.css" />
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

					<li class="nav-item"><a class="nav-link"
						href="/api/v1/searchChatGPT">MChatGPT</a></li>
				</ul>

				<form id="logoutForm" method="POST" action="/logout" class="mx-2">
					<input type="hidden" name="${_csrf.parameterName}"
						value="${_csrf.token}" /> <input type="submit" value="Logout!"
						class="btn btn-danger btn-sm" />
				</form>
				<form action="/lectures/search" method="POST" class="d-flex"
					placeholder="Search">
					<input type="hidden" name="${_csrf.parameterName}"
						value="${_csrf.token}" /> <input name="keyword" type="text"
						class="form-control me-2" />
					<button class="btn btn-primary" data-toggle="button"
						aria-pressed="false" autocomplete="off" type="submit">Search</button>
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
				<div class="dropdown">
					<h4>Open Courses</h4>
					<table class="table dropdown-content">
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



										<td>${eachCourse.title}</td>

										<td><c:out value="${eachCourse.teacher.firstName}"></c:out></td>

										<td><a href="/dashboard/join/${eachCourse.id}"
											class="btn btn-success btn-sm">Enroll in Class</a></td>
									</c:if>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>

				<div class="dropdown">
					<h4>Enrolled Courses</h4>
					<table class="table dropdown-content">
						<thead>
							<tr>
								<th>Course</th>
								<th>Teacher</th>
								<th colspan=2>Actions</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="eachCourse" items="${assignedCourses}">
								<tr>
									<td><a href="/courses/${eachCourse.id}/lectures"
										class="link">${eachCourse.title}</a></td>
									<td><c:out value="${eachCourse.teacher.firstName}"></c:out></td>

									<c:if test="${eachCourse.teacher.id==currentUser.id}">
										<td><a href="/projects/edit/${eachCourse.id}"
											class="link">Edit Course</a></td>
									</c:if>
									<c:if test="${eachCourse.teacher.id!=currentUser.id}">
										<td><a href="/dashboard/leave/${eachCourse.id}"
											class="btn btn-danger btn-sm">Leave Class</a></td>
									</c:if>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>

				<div class="chatGPT">
					<h4 class="dropdown-toggle" data-bs-toggle="dropdown"
						aria-expanded="false">ChatGPT</h4>
					<div class="dropdown-menu">
						<div>
							<h2>Learn more with our Mock ChatGPT API</h2>
							<p class="gptResponse">${response}</p>
						</div>
						<form action="/api/v1/searchChatGPT" method="post" class="form">
							<div class="row">
								<input type="text" name="prompt" required autofocus
									class="form-control" />
								<button type="submit" class="btn btn-primary btn-sm mt-2">Send</button>

							</div>
							<input type="hidden" name="${_csrf.parameterName}"
								value="${_csrf.token}" />
						</form>
					</div>
				</div>

			</div>

			<div>
				<div class="card">
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

				<div class="card calendar">
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
					String[] weekdays = {"Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"};
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

				<div class="card">
					<div class="card-body">
						<h5>Urgent Deadlines:</h5>
						<table class="text-center">
							<thead>
								<tr>
									<th>Title</th>
									<th>Course</th>
									<th>Finished By</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="eachUrgenReading" items="${urgentReadings}"
									end="2">
									<c:if
										test="${fn:contains(eachUrgenReading.getCourse().getUsers(),currentUser)}">
										<tr class="border-bottom">
											<td style="text-transform: capitalize;"><c:out
													value="${eachUrgenReading.title}" /></td>
											<td><c:out
													value="${eachUrgenReading.getCourse().getTitle()}" /></td>
											<td><fmt:formatDate value="${eachUrgenReading.dueDate}"
													pattern="MM/dd/yyyy" /></td>
										</tr>
									</c:if>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>

			</div>
		</div>

	</div>

</body>
</html>