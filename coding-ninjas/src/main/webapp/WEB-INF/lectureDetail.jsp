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
		<h1>${oneLecture.title}</h1>
		<div class="d-flex justify-content-evenly">
			<p>
				Course:
				<c:out value="${oneLecture.getCourse().getTitle()}" />
			</p>
			<p>
				Teacher:
				<c:out value="${oneLecture.getCourse().getTeacher().getFirstName()}" />
				<c:out value="${oneLecture.getCourse().getTeacher().getLastName()}" />
			</p>
			<p>
				Difficult Level:
				<c:out value="${oneLecture.difficulty}" />
			</p>
			<p>
				Finish reading by:
				<fmt:formatDate pattern="MM/dd/YYYY" value="${oneLecture.dueDate}" />
			</p>
		</div>
		<p>
			<c:out value="${oneLecture.content}" />
		</p>
		<img src="${oneLecture.getPhotosImagePath()}" />
		<c:url value="${oneLecture.getPhotosImagePath()}"></c:url> 
		<c:out value="${oneLecture.getPhotosImagePath()}"/>
	</div>
</body>
</html>