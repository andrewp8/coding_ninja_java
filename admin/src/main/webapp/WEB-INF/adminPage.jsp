<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="/css/style.css">
<title>Admin Dashboard</title>
</head>
<body>

	<h1>Welcome, ${currentUser.firstName}</h1>
	<form id="logoutForm" method="POST" action="/logout">
	    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	    <input type="submit" value="Logout!" />
	</form>

	<table>
	    <thead> 
	    	<tr>
	    		<th>Name</th>
	    		<th>Email</th>
	    		<th>Action</th>
	    	</tr>
	    </thead>
	    <tbody>
	    	<c:forEach var="user" items="${users}">
	    	<c:if test = "${!user.roles.get(0).name.contains('ROLE_SUPER_ADMIN')}">
		        <tr>
					<td>${user.firstName} ${user.lastName}</td>
					<td>${user.email}</td>
					<c:if test = "${currentUser.roles.get(0).name.contains('ROLE_SUPER_ADMIN')}">
				        <td><a href="/delete/${user.id}">Delete</a> <a href="/admin/${user.id}">Make Admin</a></td>
				    </c:if>
				    <c:if test = "${currentUser.roles.get(0).name.contains('ROLE_ADMIN')}">        
				        <c:if test = "${user.roles.get(0).name.contains('ROLE_USER')}">
				        	<td><a href="/delete/${user.id}">Delete</a> <a href="/admin/${user.id}">Make Admin</a></td>
				    	</c:if>
				    	<c:if test = "${user.roles.get(0).name.contains('ROLE_ADMIN')}">
				        	<td>Admin</td>
				    	</c:if>
				    </c:if>
				</tr>
		    </c:if>	
		</c:forEach>
	    </tbody>
	</table>

	<a href="/courses/new"><button> +Add a Course</button></a>
	
	<h4>All Courses</h4>

	<table>
	    <thead> 
	    	<tr>
	    		<th>Course</th>
	    		<th>Teacjer</th>
	    		<th>Actions</th>
	    	</tr>
	    </thead>
	    <tbody>
	    	<c:forEach var="eachCourse" items="${unassignedCourses}">
			<tr>
				<c:if test = "${eachCourse.teacher.id!=currentUser.id}">
				<td><a href="/courses/${eachCourse.id}">${eachCourse.title}</a></td>
				<td><c:out value="${eachCourse.teacher.firstName}"></c:out></td>
				
			    <td><a href="/dashboard/join/${eachCourse.id}">Join Team</a></td>
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