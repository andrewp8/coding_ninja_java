<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>View One Course</title>
</head>
<body>
	
	<a href="/"><button>Return to home</button></a>
	<h1> course title: ${currentCourse.title }</h1>
	<br>
	
	<table>
		<thead>
			<tr>
				<th>First name</th>
				<th>Last name</th>
				<th>Status</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var= "oneUser" items="${attendees }">
				<tr>
					<td>${oneUser.firstName }</td>
					<td>${oneUser.lastName }</td>
					<c:choose>
						<c:when test="${ oneUser.roles.get(0).name.contains('ROLE_ADMIN')}">
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
	
		<div>
			<h2>Class Message Wall</h2>
			<div id="commentbox">
                <c:forEach var="oneMmsg" items="${theseMessages}" >
                    <p>${oneMmsg.user.firstName} says: ${oneMmsg.content}</p>
                    <p>--*--*--*--*--*--*--</p>
                </c:forEach>
            </div>
            	<h3>Message the class</h3>
                <form:form method="post" action="/courses/addMessage" modelAttribute="message">
                	<h5>
                		<form:input cssClass="txtbox" type="textarea" path="content"/>
					</h5>
					<form:hidden path="user" value="${currentUser.id}"/>
					<form:hidden path="course" value="${currentCourse.id}"/>
			   		<input class="btn" type="submit" value="Submit">          
                </form:form>
               	<form:errors cssClass="red" path="message.*"/>
		</div>
	
</body>
</html>