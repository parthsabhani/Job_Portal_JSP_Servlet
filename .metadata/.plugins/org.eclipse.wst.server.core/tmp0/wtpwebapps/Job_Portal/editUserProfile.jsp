<%@page import="java.util.Map"%>
<%@page import="com.model.ProjectModel"%>
<%@page import="java.util.List"%>
<%@page import="com.model.EducationModel"%>
<%@page import="com.model.UserModel"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
UserModel model = (UserModel) session.getAttribute("model");
EducationModel emodel = (EducationModel) session.getAttribute("emodel");
Map<String, Object> userProjects = (Map<String, Object>) session.getAttribute("userProjects");

if (model == null || emodel == null || userProjects == null) {
	response.sendRedirect("userLogin.jsp?error=object is getting null");
	return;
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit User Profile</title>
<link
	href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap"
	rel="stylesheet">
<style>
 /* Reset */ * {
	box-sizing: border-box;
	margin: 0;
	padding: 0;
}

/* Page styling */
body {
	font-family: 'Poppins', sans-serif;
	background: linear-gradient(to right, #fdfdfd, #e6f0ff);
	padding: 60px 40px;
	color: #333;
}

/* Form container takes full width */
form {
	max-width: 1000px;
	margin: 0 auto;
}

/* Headings */
h2 {
	font-size: 36px;
	color: #1e3a5f;
	font-weight: 600;
	margin-bottom: 40px;
	text-align: center;
}

/* Section headers */
h3 {
	margin-top: 50px;
	font-size: 24px;
	color: #007BFF;
	border-bottom: 2px solid #007BFF;
	padding-bottom: 6px;
	margin-bottom: 20px;
}

/* Labels & inputs */
label {
	display: block;
	margin-bottom: 6px;
	font-weight: 500;
	font-size: 15px;
	color: #2c3e50;
}

input[type="text"], input[type="email"], input[type="number"], textarea,
	select {
	width: 100%;
	padding: 12px;
	margin-bottom: 20px;
	border: 1px solid #ccc;
	border-radius: 6px;
	font-size: 15px;
	background-color: #fff;
	transition: 0.2s;
}

input:focus, textarea:focus, select:focus {
	border-color: #007BFF;
	box-shadow: 0 0 5px rgba(0, 123, 255, 0.15);
}

/* Side-by-side fields */
.flex-row {
	display: flex;
	flex-wrap: wrap;
	gap: 40px;
	margin-bottom: 30px;
}

.flex-item {
	flex: 1;
	min-width: 200px;
}

/* Buttons */
.form-actions {
	text-align: center;
	margin-top: 40px;
}

.form-actions button {
	padding: 12px 25px;
	background-color: #007BFF;
	color: white;
	border: none;
	border-radius: 6px;
	font-size: 16px;
	cursor: pointer;
	transition: background-color 0.3s ease, transform 0.2s ease;
}

.form-actions button:hover {
	background-color: #0056b3;
	transform: translateY(-2px);
	box-shadow: 0 4px 12px rgba(0, 123, 255, 0.2);
}

/* Project section visual grouping */
.project-block {
	background-color: #f4faff;
	border-left: 5px solid #007BFF;
	padding: 20px;
	margin-bottom: 25px;
	border-radius: 8px;
}
</style>
</head>
<body>

	<div class="form-container">
		<h2>Edit Profile</h2>
		<form action="updateUserProfile.jsp" method="post"
			enctype="multipart/form-data">

			<label for="firstName">First Name:</label> <input type="text"
				id="firstName" name="firstName" value="<%=model.getFirstName()%>"
				required> <label for="lastName">Last Name:</label> <input
				type="text" id="lastName" name="lastName"
				value="<%=model.getLastName()%>" required> <label
				for="email">Email:</label> <input type="email" id="email"
				name="email" value="<%=model.getEmail()%>" required>

			<!-- Age & Gender side-by-side -->
			<div class="flex-row">
				<div class="flex-item">
					<label for="age">Age:</label> <input type="number" id="age"
						name="age" value="<%=model.getAge()%>" required>
				</div>

				<div class="flex-item">
					<label for="gender">Gender:</label> <select id="gender"
						name="gender">
						<option value="Male"
							<%="Male".equals(model.getGender()) ? "selected" : ""%>>Male</option>
						<option value="Female"
							<%="Female".equals(model.getGender()) ? "selected" : ""%>>Female</option>
						<option value="Other"
							<%="Other".equals(model.getGender()) ? "selected" : ""%>>Other</option>
					</select>
				</div>
			</div>

			<label for="address">Address:</label>
			<textarea id="address" name="address" rows="3" required><%=model.getAddress()%></textarea>

			<label for="phone">Phone Number:</label> <input type="text"
				id="phone" name="phone" value="<%=model.getPhone()%>" required>

			<!-- Education Section -->
			<h3 style="margin: 30px 0px;">Education</h3>

			<label for="instituteName">Institute Name:</label> <input type="text"
				id="instituteName" name="instituteName"
				value="<%=(emodel.getInstituteName() != null && !emodel.getInstituteName().isEmpty()) ? emodel.getInstituteName() : ""%>">

			<div class="flex-row">
				<div class="flex-item">
					<label for="passoutYear">Passout Year:</label> <select
						id="passoutYear" name="passoutYear">
						<%
						int currentYear = java.util.Calendar.getInstance().get(java.util.Calendar.YEAR);
						int selectedYear = emodel.getPassoutYear();
						for (int year = 1920; year <= currentYear; year++) {
							String selected = (year == selectedYear) ? "selected" : "";
						%>
						<option value="<%=year%>" <%=selected%>><%=year%></option>
						<%
						}
						%>
					</select>
				</div>

				<div class="flex-item">
					<label for="degreeName">Degree Name:</label> <input type="text"
						id="degreeName" name="degreeName"
						value="<%=(emodel.getDegreeName() != null && !emodel.getDegreeName().isEmpty()) ? emodel.getDegreeName() : ""%>">
				</div>
			</div>

			<label for="degreeDescription">Degree Description:</label> <input
				type="text" id="degreeDescription" name="degreeDescription"
				value="<%=(emodel.getDegreeDescription() != null && !emodel.getDegreeDescription().isEmpty())
		? emodel.getDegreeDescription()
		: ""%>">

			<h3 style="margin: 30px 0px;">Projects</h3>

			<%
			List<ProjectModel> projects = (List<ProjectModel>) userProjects.get("projects");
			List<String> languagesList = (List<String>) userProjects.get("languages");

			for (int i = 0; i < projects.size(); i++) {
				ProjectModel p = projects.get(i);
				String langs = languagesList.get(i);
			%>
			<div style="margin-bottom: 25px;">
				<label for="projectName<%=i%>"><strong>Project
						Name:</strong></label> <input type="text" id="projectName<%=i%>"
					name="projectName<%=i%>" value="<%=p.getName()%>" required>

				<label for="projectDesc<%=i%>" style="margin-top: 10px;"><strong>Project
						Description:</strong></label>
				<textarea id="projectDesc<%=i%>" name="projectDesc<%=i%>" rows="3"
					required><%=p.getDescription()%></textarea>

				<label for="projectLang<%=i%>" style="margin-top: 10px;"><strong>Coding
						Languages:</strong></label> <input type="text" id="projectLang<%=i%>"
					name="projectLang<%=i%>" value="<%=langs%>" required> <input
					type="hidden" name="projectId<%=i%>" value="<%=p.getProjectid()%>">
			</div>
			<%
			}
			%>

			<input type="hidden" name="projectCount" value="<%=projects.size()%>">


			<div class="form-actions">
				<button type="submit" name="action" value="updateUserProfile">Update
					Profile</button>
			</div>
		</form>
	</div>

</body>
</html>
