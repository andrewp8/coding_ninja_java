<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>View One Course</title>
</head>
<body>
	<h1> course title: ${oneCourse.title }</h1>
	<h2>teacher first name${oneCourse.teacher.firstName }</h2>
	<h2>teacher id: ${oneCourse.teacher.id }</h2>
	<a href="/courses/${oneCourse.id}/lectures/new">Add new lecture</a>
	<table>
		<thead>
			<tr>
				<th>Lecture's title</th>
				<th>Difficulty</th>
				<th>Finish reading by</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var= "eachLecture" items="${lectureList}">
				<tr>
					<td>${eachLecture.title }</td>
					<td>${eachLecture.difficulty }</td>
					<td>${eachLecture.dueDate }</td>
				</tr>
			</c:forEach>
		</tbody>
	
	</table>
	
</body>
</html>