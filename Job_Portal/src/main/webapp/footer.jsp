<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
    String footerStyle = (String) request.getAttribute("footerStyle");
    if (footerStyle == null) {
        footerStyle = "position: fixed; bottom: 0; width: 100%; padding: 8px 0; background-color: #000; color: white; text-align: center; font-size: 12px; font-family: 'Poppins', sans-serif;";
    }
%>
<footer style="<%= footerStyle %>">
    Talent Hub rights are reserved and developed by Parth Sabhani ©2025
</footer>
</body>
</html>