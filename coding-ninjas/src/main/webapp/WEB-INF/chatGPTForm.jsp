<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="starter-template">
		<h1>
			ChatGPT API at<br />agile-coding.blogspot.com
		</h1>
		<h2>Send message to ChatGPT</h2>
		<form action="/api/v1/searchChatGPT" method="post">
			<fieldset>
				<div class="form-group">
					<input type="text" name="prompt" required
						autofocus />
				</div>
				<div class="row">
					<input type="submit" value="Send" />
				</div>
			</fieldset>
			<input type="hidden" name="${_csrf.parameterName}"
				value="${_csrf.token}" />
		</form>
		<h2>ChatGPT responded with:</h2>
		<p>${response}</p>
	</div>
</body>
</html>