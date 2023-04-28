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
<link rel="stylesheet" href="/css/searchTable.css" />
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

				<form id="logoutForm" method="POST" action="/logout" class="mx-2">
					<input type="hidden" name="${_csrf.parameterName}"
						value="${_csrf.token}" /> <input type="submit" value="Logout!"
						class="btn btn-danger btn-sm" />
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
	<div class="container mt-4 mx-auto" style="width:700px;">
		<h1 class="mb-4">
			Results from keyword: "
			<c:out value="${keyword}" />
			"
		</h1>
			<c:choose>
				<c:when test="${resultList.size() gt 0}">
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
								<td><a
									href="/courses/${eachResult.getCourse().getId()}/lectures/${eachResult.id}"
									class="link"><c:out value="${eachResult.getTitle()}" /></a></td>
								<td><c:out value="${eachResult.getCourse().getTitle()}" /></td>
								<td><c:out
										value="${eachResult.getCourse().getTeacher().getFirstName()}" />
									<c:out
										value="${eachResult.getCourse().getTeacher().getLastName()}" /></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</c:when>
				<c:otherwise>
						<h5>Sorry, there are no relevant matches with your search.</h5>
					</c:otherwise>
			</c:choose>
	</div>
</body>
</html>