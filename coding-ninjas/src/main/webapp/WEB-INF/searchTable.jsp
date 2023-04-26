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
	<div class="container mt-4">
		<h1>
			Results from keyword:
			"<c:out value="${keyword}" />"
		</h1>
		<table class="table">
			<thead>
				<tr>
					<th>Lecture Title</th>
					<th>Course</th>
					<th>Teacher</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="eachResult" items="${resultList}">
					<tr>
						<td><a href="/courses/${eachResult.getCourse().getId()}/lectures/${eachResult.id}" class="link"><c:out value="${eachResult.getTitle()}" /></a></td>
						<td><c:out
								value="${eachResult.getCourse().getTitle()}" /></td>
						<td><c:out value="${eachResult.getCourse().getTeacher().getFirstName()}" />
							<c:out value="${eachResult.getCourse().getTeacher().getLastName()}" /></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</body>
</html>