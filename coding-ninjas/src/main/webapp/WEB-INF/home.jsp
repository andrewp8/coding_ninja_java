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
<link href="https://fonts.googleapis.com/css2?family=Lato&family=Marvel&family=Roboto+Mono&display=swap" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

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
					<li class="nav-item"><a class="nav-link" href="/chatgpt">ChatGPT</a></li>
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
<<<<<<< HEAD
										<td><a href="/courses/${eachCourse.id}/lectures" class="link">${eachCourse.title}</a></td>
=======
										<td>${eachCourse.title}</td>
>>>>>>> 32a996890158aaf62888803903a0c92ef9eb7f01
										<td><c:out value="${eachCourse.teacher.firstName}"></c:out></td>

										<td><a href="/dashboard/join/${eachCourse.id}" class="btn btn-success btn-sm">Enroll
												in Class</a></td>
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
									<td><a href="/courses/${eachCourse.id}/lectures" class="link">${eachCourse.title}</a></td>
									<td><c:out value="${eachCourse.teacher.firstName}"></c:out></td>

									<c:if test="${eachCourse.teacher.id==currentUser.id}">
										<td><a href="/projects/edit/${eachCourse.id}" class="link">Edit
												Course</a></td>
									</c:if>
									<c:if test="${eachCourse.teacher.id!=currentUser.id}">
										<td><a href="/dashboard/leave/${eachCourse.id}" class="btn btn-danger btn-sm">Leave
												Class</a></td>
									</c:if>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
				<div class="dropdown" id="status">
					<h4>Status</h4>
					<canvas id="myChart" class="dropdown-content"></canvas>
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
					</div>
				</div>
			</div>

		</div>

		<script>
			var ctx = document.getElementById('myChart').getContext('2d');
			var myChart = new Chart(ctx, {
				type : 'bar',
				data : {
					labels : [ 'Red', 'Blue', 'Yellow', 'Green', 'Purple',
							'Orange' ],
					datasets : [ {
						label : '# of Votes',
						data : [ 12, 19, 3, 5, 2, 3 ],
						backgroundColor : [ 'rgba(255, 99, 132, 0.2)',
								'rgba(54, 162, 235, 0.2)',
								'rgba(255, 206, 86, 0.2)',
								'rgba(75, 192, 192, 0.2)',
								'rgba(153, 102, 255, 0.2)',
								'rgba(255, 159, 64, 0.2)' ],
						borderColor : [ 'rgba(255, 99, 132, 1)',
								'rgba(54, 162, 235, 1)',
								'rgba(255, 206, 86, 1)',
								'rgba(75, 192, 192, 1)',
								'rgba(153, 102, 255, 1)',
								'rgba(255, 159, 64, 1)' ],
						borderWidth : 1
					} ]
				},
				options : {
					scales : {
						yAxes : [ {
							ticks : {
								beginAtZero : true
							}
						} ]
					}
				}
			});
		</script>
</body>
</html>