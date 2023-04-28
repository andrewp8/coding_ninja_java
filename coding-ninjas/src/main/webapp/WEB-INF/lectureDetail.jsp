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
<link rel="stylesheet" href="/css/lectureDetail.css" />
<script type="text/javascript" src="/js/app.js"></script>

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

				<form id="logoutForm" method="POST" action="/logout"  class="mx-2">
					<input type="hidden" name="${_csrf.parameterName}"
						value="${_csrf.token}" /> <input type="submit" value="Logout!"
						class="btn btn-danger btn-sm mr-2" />
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
	<div class=" container mt-4 d-flex justify-content-evenly">
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
	<div class="container">
		<div class="row gap-4">
			<div class="col col-lg-3 left bg-dark">
				<ul class="list-group">
					<c:forEach var="eachLecture" items="${lecturesList}">
						<a href="/courses/${oneCourse.id}/lectures/${eachLecture.id}"
							class="list-group-item list-group-item-action bg-dark text-light link"
							aria-current="true">${eachLecture.title}</a>
					</c:forEach>
				</ul>
			</div>
			<div class="col lecture">
				<h1>${oneLecture.title}</h1>
				<img src="${oneLecture.getPhotosImagePath()}" />
				<p>
					<c:out value="${oneLecture.content}" />
				</p>
								<img src="https://image.spreadshirtmedia.com/image-server/v1/products/T1459A839PA3861PT28D1025112854W10000H10000/views/1,width=550,height=550,appearanceId=839,backgroundColor=F2F2F2/i-love-coding-sticker.jpg" style="width:50%"/>
			</div>
		</div>

	</div>
	<div class=" container mt-4 d-flex justify-content-between">
	<div></div>
	<a href="/courses/${oneCourse.id}/lectures" class="btn btn-secondary">Back</a>
	</div>
</body>
</html>