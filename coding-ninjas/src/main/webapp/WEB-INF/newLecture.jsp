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
		<h1>New Lecture</h1>
		<form:form action="/courses/${courseId}/lectures/new" method="POST"
			modelAttribute="newLecture">
			<div>
				<form:label path="title" class="form-label">Title</form:label>
				<form:input type="text" path="title" class="form-control" />
				<p>
					<form:errors path="title" class="text-danger" />
				</p>
			</div>
			<div>
				<form:label path="content" class="form-label">Content</form:label>
				<form:textarea type="text" path="content" class="form-control"></form:textarea>
				<p>
					<form:errors path="content" class="text-danger" />
				</p>
			</div>
			<div>
				<form:label path="difficulty" class="form-label">Difficult Level:</form:label>
				<form:select path="difficulty" class="form-select">
					<%for(int index = 1; index<=5; index++){ %>
						<form:option value="${index}">
							<p><%=index%></p>
						</form:option>
					<% }%>
				</form:select>
			</div>
			<div>
			
			</div>
		</form:form>
	</div>
</body>
</html>