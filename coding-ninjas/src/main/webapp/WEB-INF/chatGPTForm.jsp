<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Mock ChatGPT</title>
<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css" />
<link rel="stylesheet" href="/css/home.css" />
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>

<link
	href="https://fonts.googleapis.com/css2?family=Lato&family=Marvel&family=Roboto+Mono&display=swap"
	rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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
	
	<div class="centered-header" id="chatgpt-main-container">
		<h1 >
			Mock ChatGPT
		</h1>
		<br>
		<br>
		<div class="d-flex justify-content-around" id="chatgpt-padding">
			<div class=px-3>
				<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-sun" viewBox="0 0 16 16">
				  <path d="M8 11a3 3 0 1 1 0-6 3 3 0 0 1 0 6zm0 1a4 4 0 1 0 0-8 4 4 0 0 0 0 8zM8 0a.5.5 0 0 1 .5.5v2a.5.5 0 0 1-1 0v-2A.5.5 0 0 1 8 0zm0 13a.5.5 0 0 1 .5.5v2a.5.5 0 0 1-1 0v-2A.5.5 0 0 1 8 13zm8-5a.5.5 0 0 1-.5.5h-2a.5.5 0 0 1 0-1h2a.5.5 0 0 1 .5.5zM3 8a.5.5 0 0 1-.5.5h-2a.5.5 0 0 1 0-1h2A.5.5 0 0 1 3 8zm10.657-5.657a.5.5 0 0 1 0 .707l-1.414 1.415a.5.5 0 1 1-.707-.708l1.414-1.414a.5.5 0 0 1 .707 0zm-9.193 9.193a.5.5 0 0 1 0 .707L3.05 13.657a.5.5 0 0 1-.707-.707l1.414-1.414a.5.5 0 0 1 .707 0zm9.193 2.121a.5.5 0 0 1-.707 0l-1.414-1.414a.5.5 0 0 1 .707-.707l1.414 1.414a.5.5 0 0 1 0 .707zM4.464 4.465a.5.5 0 0 1-.707 0L2.343 3.05a.5.5 0 1 1 .707-.707l1.414 1.414a.5.5 0 0 1 0 .708z"/>
				</svg>
				<h3>Examples</h3>
				<p>Explain quantum computing in simple terms</p>
				<p>Got any creative ideas for a 10 year old’s birthday?</p>
				<p>How do I make an HTTP request in Javascript?</p>
			</div>
			<div class=px-3>
				<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-lightning-charge" viewBox="0 0 16 16">
				  <path d="M11.251.068a.5.5 0 0 1 .227.58L9.677 6.5H13a.5.5 0 0 1 .364.843l-8 8.5a.5.5 0 0 1-.842-.49L6.323 9.5H3a.5.5 0 0 1-.364-.843l8-8.5a.5.5 0 0 1 .615-.09zM4.157 8.5H7a.5.5 0 0 1 .478.647L6.11 13.59l5.732-6.09H9a.5.5 0 0 1-.478-.647L9.89 2.41 4.157 8.5z"/>
				</svg>
				<h3>Capabilities</h3>
				<p>Trained to decline inappropriate requests</p>
				<p>Allows user to provide follow-up corrections</p>
			</div>
			<div class=px-3>
				<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-exclamation-triangle" viewBox="0 0 16 16">
				  <path d="M7.938 2.016A.13.13 0 0 1 8.002 2a.13.13 0 0 1 .063.016.146.146 0 0 1 .054.057l6.857 11.667c.036.06.035.124.002.183a.163.163 0 0 1-.054.06.116.116 0 0 1-.066.017H1.146a.115.115 0 0 1-.066-.017.163.163 0 0 1-.054-.06.176.176 0 0 1 .002-.183L7.884 2.073a.147.147 0 0 1 .054-.057zm1.044-.45a1.13 1.13 0 0 0-1.96 0L.165 13.233c-.457.778.091 1.767.98 1.767h13.713c.889 0 1.438-.99.98-1.767L8.982 1.566z"/>
				  <path d="M7.002 12a1 1 0 1 1 2 0 1 1 0 0 1-2 0zM7.1 5.995a.905.905 0 1 1 1.8 0l-.35 3.507a.552.552 0 0 1-1.1 0L7.1 5.995z"/>
				</svg>
				<h3>Limitations
				</h3>
				<p>May occasionally generate incorrect information</p>
				<p>May occasionally produce harmful instructions or biased content</p>
				<p>Limited knowledge of world and events after 2021</p>
			</div>
		
		</div>
		<div class="form-group">
				<form action="/api/v1/searchChatGPT" method="post" class="input-group">
					<input type="text" name="prompt" required class="form-control" placeholder="Ask away..."/>
					<input type="submit" value="Send" class="btn btn-success"/>
					<input type="hidden" name="${_csrf.parameterName}"
						value="${_csrf.token}" />
				</form>
		</div>

		<h2>ChatGPT responded with:</h2>
		<p>${response}</p>
		<a href="/api/v1/searchChatGPT"><button type="submit" class="btn btn-warning">Clear Results</button></a>

	</div>
</body>
</html>