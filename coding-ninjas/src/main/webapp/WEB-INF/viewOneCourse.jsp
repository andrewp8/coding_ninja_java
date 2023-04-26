<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>View One Course</title>
<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css" />
<link rel="stylesheet" href="/css/style.css" />
<script type="text/javascript" src="/js/app.js"></script>
</head>
<body>

	<a href="/"><button>Return to home</button></a>
	<h1>course title: ${currentCourse.title }</h1>
	<br>

	<table>
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

	<h2>teacher first name${oneCourse.teacher.firstName }</h2>
	<h2>teacher id: ${oneCourse.teacher.id }</h2>
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
					<td><a href="/courses/${oneCourse.id}/lectures/${eachLecture.id}" class="link">${eachLecture.title }</a></td>
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

	<div>
		<h2>Class Message Wall</h2>
		<div id="commentbox">
			<c:forEach var="oneMmsg" items="${theseMessages}">
				<p>${oneMmsg.user.firstName}says:${oneMmsg.content}</p>
				<p>--*--*--*--*--*--*--</p>
			</c:forEach>
		</div>
		<h3>Message the class</h3>
		<form:form method="post" action="/courses/addMessage"
			modelAttribute="message">
			<h5>
				<form:input cssClass="txtbox" type="textarea" path="content" />
			</h5>
			<form:hidden path="user" value="${currentUser.id}" />
			<form:hidden path="course" value="${currentCourse.id}" />
			<input class="btn" type="submit" value="Submit">
		</form:form>
		<form:errors cssClass="red" path="message.*" />
	</div>

</body>
</html>