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
	<h1>Marco</h1>
	<h1>Andrew</h1>
	<h3>Polo</h3>
<h3>Andrew just added</h3>
<<<<<<< HEAD

<p>i love to drink boba</p>
=======
<h3>3rd added</h3>
<<<<<<< HEAD
>>>>>>> df852bba6a07aa25715a47d90c5fbdf3340ff2dc
=======
<p>taco for life</p>
>>>>>>> 7c4705cb556be1603e75693592eba033a96afbb8
	<a><button></button></a>
	<h1> course title: ${oneCourse.title }</h1>
	<h2>teacher first name${oneCourse.teacher.firstName }</h2>
	<h2>teacher id: ${oneCourse.teacher.id }</h2>
	<table>
		<thead>
			<tr>
				<th>First name</th>
				<th>Last name</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var= "eachUser" items="${allUsers }">
				<tr>
					<td>${eachUser.firstName }</td>
					<td>${eachUser.lastName }</td>
				</tr>
			</c:forEach>
		</tbody>
	
	</table>
	
</body>
</html>