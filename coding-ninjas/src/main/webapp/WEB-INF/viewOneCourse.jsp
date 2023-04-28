<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="/css/viewOneCourse.css">
<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css" />
<link rel="stylesheet" href="/css/home.css" />
<link rel="stylesheet" href="/css/messages.css" />
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Lato&family=Marvel&family=Roboto+Mono&display=swap"
	rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<meta charset="UTF-8">
<title>View One Course</title>
<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css" />
<link rel="stylesheet" href="/css/viewOneCourse.css" />
<script type="text/javascript" src="/js/app.js"></script>
</head>
<body>
	<nav class="navbar navbar-expand-lg bg-body-tertiary">
		<div class="container-fluid">
			<a class="navbar-brand" href="/">Coding Ninjas</a>
			<div class="collapse navbar-collapse" id="navbarSupportedContent">
				<ul class="navbar-nav me-auto mb-2 mb-lg-0">
					<li class="nav-item"><a class="nav-link" href="/api/v1/searchChatGPT">MChatGPT</a></li>
				</ul>
				<form id="logoutForm" method="POST" action="/logout">
					<input type="hidden" name="${_csrf.parameterName}"
						value="${_csrf.token}" /> <input type="submit" value="Logout!" class="btn btn-danger btn-sm"/>
				</form>
				<form action="/lectures/search" method="POST" class="d-flex"
					placeholder="Search">
					<input type="hidden" name="${_csrf.parameterName}"
						value="${_csrf.token}" /> <input name="keyword" type="text"
						class="form-control me-2" />
					<button class="btn btn-primary" data-toggle="button" aria-pressed="false" autocomplete="off" type="submit">Search</button>
				</form>
			</div>
		</div>
	</nav>

	<h1 class ="text-center">${currentCourse.title }</h1>
	<div class="d-flex justify-content-center p-4">
		<div class="p-5">

			<div class=" container" >
			    <div class="row ">
			        <div class="col-xl-20 col-lg-10 col-md-15 col-sm-2 col-18 ">
			        	<div class="card ">
			        		<div class="card-header">Class Message Wall</div>
				        		<div class="card-body height3 my-custom-scrollbar">
				        			<ul class="chat-list">
		        						<c:forEach var="oneMsg" items="${theseMessages}">
											<c:choose>
												<c:when test="${oneMsg.user.roles.get(0).name.contains('ROLE_ADMIN')}">
							        				<li class="in">
							        					<div class="chat-img">
							        						<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-nintendo-switch" viewBox="0 0 16 16">
															  <path d="M9.34 8.005c0-4.38.01-7.972.023-7.982C9.373.01 10.036 0 10.831 0c1.153 0 1.51.01 1.743.05 1.73.298 3.045 1.6 3.373 3.326.046.242.053.809.053 4.61 0 4.06.005 4.537-.123 4.976-.022.076-.048.15-.08.242a4.136 4.136 0 0 1-3.426 2.767c-.317.033-2.889.046-2.978.013-.05-.02-.053-.752-.053-7.979Zm4.675.269a1.621 1.621 0 0 0-1.113-1.034 1.609 1.609 0 0 0-1.938 1.073 1.9 1.9 0 0 0-.014.935 1.632 1.632 0 0 0 1.952 1.107c.51-.136.908-.504 1.11-1.028.11-.285.113-.742.003-1.053ZM3.71 3.317c-.208.04-.526.199-.695.348-.348.301-.52.729-.494 1.232.013.262.03.332.136.544.155.321.39.556.712.715.222.11.278.123.567.133.261.01.354 0 .53-.06.719-.242 1.153-.94 1.03-1.656-.142-.852-.95-1.422-1.786-1.256Z"/>
															  <path d="M3.425.053a4.136 4.136 0 0 0-3.28 3.015C0 3.628-.01 3.956.005 8.3c.01 3.99.014 4.082.08 4.39.368 1.66 1.548 2.844 3.224 3.235.22.05.497.06 2.29.07 1.856.012 2.048.009 2.097-.04.05-.05.053-.69.053-7.94 0-5.374-.01-7.906-.033-7.952-.033-.06-.09-.063-2.03-.06-1.578.004-2.052.014-2.26.05Zm3 14.665-1.35-.016c-1.242-.013-1.375-.02-1.623-.083a2.81 2.81 0 0 1-2.08-2.167c-.074-.335-.074-8.579-.004-8.907a2.845 2.845 0 0 1 1.716-2.05c.438-.176.64-.196 2.058-.2l1.282-.003v13.426Z"/>
															</svg>
							        					</div>
							        					<div class="chat-body">
							        						<div class="chat-message">
							        							<p class="sender-color">${oneMsg.user.firstName}</p>
																	<p class="date-color"> <fmt:formatDate value="${oneMsg.createdAt}" pattern="MM/dd/yyyy @ h:mm a" /></p>
							        							<p>${oneMsg.content}</p>
							        						</div>
							        					</div>
							        				</li>
							        			</c:when>										        					
										        <c:otherwise>
							        				<li class="out">
							        					<div class="chat-img">
						        							<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-nintendo-switch" viewBox="0 0 16 16">
															  <path d="M9.34 8.005c0-4.38.01-7.972.023-7.982C9.373.01 10.036 0 10.831 0c1.153 0 1.51.01 1.743.05 1.73.298 3.045 1.6 3.373 3.326.046.242.053.809.053 4.61 0 4.06.005 4.537-.123 4.976-.022.076-.048.15-.08.242a4.136 4.136 0 0 1-3.426 2.767c-.317.033-2.889.046-2.978.013-.05-.02-.053-.752-.053-7.979Zm4.675.269a1.621 1.621 0 0 0-1.113-1.034 1.609 1.609 0 0 0-1.938 1.073 1.9 1.9 0 0 0-.014.935 1.632 1.632 0 0 0 1.952 1.107c.51-.136.908-.504 1.11-1.028.11-.285.113-.742.003-1.053ZM3.71 3.317c-.208.04-.526.199-.695.348-.348.301-.52.729-.494 1.232.013.262.03.332.136.544.155.321.39.556.712.715.222.11.278.123.567.133.261.01.354 0 .53-.06.719-.242 1.153-.94 1.03-1.656-.142-.852-.95-1.422-1.786-1.256Z"/>
															  <path d="M3.425.053a4.136 4.136 0 0 0-3.28 3.015C0 3.628-.01 3.956.005 8.3c.01 3.99.014 4.082.08 4.39.368 1.66 1.548 2.844 3.224 3.235.22.05.497.06 2.29.07 1.856.012 2.048.009 2.097-.04.05-.05.053-.69.053-7.94 0-5.374-.01-7.906-.033-7.952-.033-.06-.09-.063-2.03-.06-1.578.004-2.052.014-2.26.05Zm3 14.665-1.35-.016c-1.242-.013-1.375-.02-1.623-.083a2.81 2.81 0 0 1-2.08-2.167c-.074-.335-.074-8.579-.004-8.907a2.845 2.845 0 0 1 1.716-2.05c.438-.176.64-.196 2.058-.2l1.282-.003v13.426Z"/>
															</svg>
							        					</div>
							        					<div class="chat-body">
							        						<div class="chat-message">
							        							<span class="sender-color">${oneMsg.user.firstName}</span> <span
																	class="date-color"> <fmt:formatDate
																		value="${oneMsg.createdAt}" pattern="MM/dd/yyyy @ h:mm a" />
																</span>
							        							<p>${oneMsg.content}</p>
							        						</div>
							        					</div>
							        				</li>
							        			</c:otherwise>
							        		</c:choose>
							        	</c:forEach>
									</ul>
								</div>
							</div>


						</div>
													
											
					</div>

				</div>
				<div class="form-group">
					<form:form method="post"
						action="/courses/${currentCourse.id }/addMessage"
						modelAttribute="message"
						class="input-group">
						<form:input type="text" path="content" class="form-control"/>
						<form:errors path="content" style="color:red " />
						<form:hidden path="user" value="${currentUser.id}" />
						<form:hidden path="course" value="${currentCourse.id}" />
						<input class="btn btn-lg btn-primary rounded-right" type="submit" value="Post">
					</form:form>
				</div>
				

				
				<br>
				<h3 class ="text-center">Class List</h3>
				<div class="table-wrapper-scroll-y my-custom-scrollbar"
					style="width: 90%;">
					<table class="table table-bordered table-striped mb-0">
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
				</div>
		</div>
		
		<div class="p-3" style="background-color: whitesmoke; box-shadow: 3px 3px 10px lightgrey;   height: 50%;
  overflow: auto;">
			<c:if test="${ currentUser.roles.get(0).name.contains('ROLE_ADMIN')}">
				<a href="/courses/${oneCourse.id}/lectures/new"
					class="btn btn-primary">Add new lecture</a>
			</c:if>
			<table class="table" style="text-aligh: center">
				<thead>
					<tr>
						<th>Lecture title</th>
						<th>Difficulty</th>
						<th>Finish reading by</th>
						<c:if
							test="${currentUser.roles.get(0).name.contains('ROLE_ADMIN')}">
							<th colspan=2>Action</th>
						</c:if>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="eachLecture" items="${lectureList}">
						<tr>
							<td><a
								href="/courses/${oneCourse.id}/lectures/${eachLecture.id}"
								class="link">${eachLecture.title }</a></td>
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
		</div>
	</div>

	<script src="/webjars/bootstrap/js/bootstrap.min.js">
		
	</script>
</body>
</html>