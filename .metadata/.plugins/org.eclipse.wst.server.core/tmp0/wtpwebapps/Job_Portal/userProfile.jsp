
<%@page import="com.model.UserModel"%>
<%@page import="com.model.EducationModel"%>
<%@page import="com.model.ProjectModel"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
UserModel model = (UserModel) session.getAttribute("model");
EducationModel emodel = (EducationModel) session.getAttribute("emodel");
Map<String, Object> userProjects = (Map<String, Object>) session.getAttribute("userProjects");

if (model == null || emodel == null || userProjects == null) {
	response.sendRedirect("userLogin.jsp");
	return;
}

List<ProjectModel> projects = (List<ProjectModel>) userProjects.get("projects");
List<String> languagesList = (List<String>) userProjects.get("languages");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>User Profile</title>
<link
	href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap"
	rel="stylesheet">
<style>

* {
	box-sizing: border-box;
	margin: 0;
	padding: 0;
}

body {
	font-family: 'Poppins', sans-serif;
	background: linear-gradient(to right, #fdfdfd, #e6f0ff);
	color: #333;
	padding: 60px 60px 40px 60px;
	line-height: 1.6;
}

.container {
	max-width: 1100px;
	margin: auto;
}

.header {
	text-align: center;
	margin-bottom: 50px;
}

.header h1 {
	font-size: 42px;
	color: #1e3a5f;
	font-weight: 600;
}

.section {
	margin-bottom: 40px;
	background: #fff;
	padding: 30px 35px;
	border-radius: 12px;
	box-shadow: 0 8px 20px rgba(0, 0, 0, 0.05);
}

.section h2 {
	font-size: 24px;
	color: #007BFF;
	margin-bottom: 20px;
	padding-bottom: 8px;
	border-bottom: 2px solid #007BFF;
}

p {
	font-size: 16px;
	margin-bottom: 10px;
}

p strong {
	color: #000;
	font-weight: 600;
}

.project-entry {
	background-color: #f4faff;
	padding: 15px 20px;
	border-left: 4px solid #007BFF;
	border-radius: 8px;
	margin-bottom: 20px;
}

/* Button styling */
.button-group {
	display: flex;
	justify-content: flex-end;
	gap: 20px;
	margin-top: 40px;
}

.button-group button {
	padding: 12px 25px;
	border: none;
	border-radius: 6px;
	font-size: 15px;
	cursor: pointer;
	font-weight: 500;
	transition: background 0.3s ease, transform 0.2s ease;
}

.edit-btn {
	background-color: #007BFF;
	color: white;
}

.edit-btn:hover {
	background-color: #0056b3;
	transform: translateY(-2px);
}

.delete-btn {
	background-color: #dc3545;
	color: white;
}

.delete-btn:hover {
	background-color: #a71d2a;
	transform: translateY(-2px);
}
</style>
</head>
<body>

	<div class="container">

		<div class="header">
			<h1>User Profile</h1>
		</div>

		<!-- Profile Info -->
		<div class="section">
			<h2>Personal Information</h2>
			<p><strong>Full Name:</strong> <%=model.getFirstName()%> <%=model.getLastName()%></p>
			<p><strong>Email:</strong> <%=model.getEmail()%></p>
			<p><strong>Age:</strong> <%=model.getAge()%></p>
			<p><strong>Gender:</strong> <%=model.getGender()%></p>
			<p><strong>Address:</strong> <%=model.getAddress()%></p>
			<p><strong>Phone Number:</strong> <%=model.getPhone()%></p>
		</div>

		<!-- Education -->
		<div class="section">
			<h2>Education</h2>
			<p><strong>Institute:</strong> <%=emodel.getInstituteName()%></p>
			<p><strong>Degree:</strong> <%=emodel.getDegreeName()%></p>
			<p><strong>Description:</strong> <%=emodel.getDegreeDescription()%></p>
			<p><strong>Passout Year:</strong> <%=emodel.getPassoutYear()%></p>
		</div>

		<!-- Projects -->
		<div class="section">
			<h2>Projects</h2>
			<% for (int i = 0; i < projects.size(); i++) {
				ProjectModel p = projects.get(i);
				String langs = languagesList.get(i);
			%>
				<div class="project-entry">
					<p><strong>Project Name:</strong> <%=p.getName()%></p>
					<p><strong>Description:</strong> <%=p.getDescription()%></p>
					<p><strong>Languages Used:</strong> <%=langs%></p>
				</div>
			<% } %>
		</div>

		<!-- Buttons -->
		<div class="button-group">
			<button class="edit-btn" onclick="window.location.href='editUserProfile.jsp'">Edit Profile</button>
			<form id="deleteForm" action="UserController" method="post" style="display:inline;">
				<input type="hidden" name="action" value="deleteUserProfile">
				<button type="button" class="delete-btn" onclick="confirmDelete()">Delete Profile</button>
			</form>
		</div>

	</div>

	<script>
		function confirmDelete() {
			if (confirm("Are you sure you want to delete your profile?")) {
				document.getElementById("deleteForm").submit();
			}
		}
	</script>


</body>
</html>
