<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="/css/style.css">
<title>Dashboard</title>
</head>
<body>

<p>Welcome, ${user.firstName}</p>
<form id="logoutForm" method="POST" action="/logout">
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
    <input type="submit" value="Logout!" />
</form>

<p>First Name: ${currentUser.firstName}</p>
<p>Last Name: ${currentUser.lastName}</p>
<p>Email: ${currentUser.email}</p>
<p>Signup Date: <fmt:formatDate pattern = "MMMM dd, y" value = "${currentUser.createdAt}" /></p>
<p>Last Sign in: <fmt:formatDate pattern = "MMMM dd, y" value = "${currentUser.lastLogin}" /></p>
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
				<c:if test = "${eachCourse.teacher.id!=currentUser.id}">
				<td><a href="/courses/${eachCourse.id}">${eachCourse.title}</a></td>
				<td><c:out value="${eachCourse.teacher.firstName}"></c:out></td>
				
			    <td><a href="/dashboard/join/${eachCourse.id}">Enroll in Class</a></td>
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
				<td><a href="/projects/${eachCourse.id}">${eachCourse.title}</a></td>
				<td><c:out value="${eachCourse.teacher.firstName}"></c:out></td>
				
				<c:if test = "${eachCourse.teacher.id==currentUser.id}">
			       <td><a href="/projects/edit/${eachCourse.id}">Edit Course</a></td>
			    </c:if>
			    <c:if test = "${eachCourse.teacher.id!=currentUser.id}">
			       <td><a href="/dashboard/leave/${eachCourse.id}">Leave Team</a></td>
			    </c:if>
			</tr>	
		</c:forEach>
	    </tbody>
	</table>

</body>
</html>