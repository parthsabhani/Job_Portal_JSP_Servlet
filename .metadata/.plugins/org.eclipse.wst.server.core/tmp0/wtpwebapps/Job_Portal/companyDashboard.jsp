<%@page import="com.model.CompanyModel"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    CompanyModel model = (CompanyModel) session.getAttribute("model");

    // Check if session is invalid or user is not logged in
    if (model == null) {
        response.sendRedirect("companyLogin.jsp");
        return; 
    }

    // If logged in, set user info
    request.setAttribute("firstname", model.getName());
    request.setAttribute("lastname", "");
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Company Dashboard</title>
</head>
<body>

	<!-- Header Start -->
	<jsp:include page="header.jsp" />
	<!-- Header End -->
	
	<!-- Footer Start -->
	<%
    	request.setAttribute("footerStyle", "position: fixed; bottom: 0; width: 100%; padding: 10px 0; background-color: #f0f2f5; color: #000000; text-align: center; font-size: 12px; font-family: 'Poppins', sans-serif;");
	%>
	<jsp:include page="footer.jsp" />
	<!-- Footer End -->
</body>
</html>