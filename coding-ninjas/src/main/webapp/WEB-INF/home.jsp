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
<script type="text/javascript" src="/js/app.js"></script>

</head>
<body>
	<div class="container m-4">
		<div class="d-flex justify-content-between">
			<h1>Welcome, ${user.firstName}</h1>
			<form id="logoutForm" method="POST" action="/logout">
				<input type="hidden" name="${_csrf.parameterName}"
					value="${_csrf.token}" /> <input type="submit" value="Logout!"
					class="btn btn-danger" />
			</form>
		</div>

		<div class="d-flex justify-content-between">
			<div>
				<h4>All Courses</h4>

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

									<td><a
										href="/dashboard/${eachCourse.title}/${eachCourse.id}">Enroll
											in Class</a></td>
								</c:if>
							</tr>
						</c:forEach>
					</tbody>
				</table>

				<hr>
				<h4>Your Courses</h4>
				<table>
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
								<td><c:out value="${eachCourse.teacher.username}"></c:out></td>

								<c:if test="${eachCourse.teacher.id==currentUser.id}">
									<td><a href="/courses/edit/${eachCourse.id}">Edit
											Course</a></td>
								</c:if>

								<!-- make model -->
								<c:if test="${eachCourse.teacher.id!=currentUser.id}">
									<td><a href="/dashboard/leave/${eachCourse.id}">Leave
											Team</a></td>
								</c:if>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			<div class="card px-auto" style="width:15rem;">
				<p>First Name: ${currentUser.firstName}</p>
				<p>Last Name: ${currentUser.lastName}</p>
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
</body>
</html>