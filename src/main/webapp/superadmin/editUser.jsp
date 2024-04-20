<%@ page import="java.util.UUID" %>
<%@ page import="uz.inha.cars.repo.UserRepo" %>
<%@ page import="uz.inha.cars.entity.User" %>
<%@ page import="uz.inha.cars.repo.RoleRepo" %>
<%@ page import="uz.inha.cars.entity.Role" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: orazboyevolmosbek
  Date: 20/04/24
  Time: 19:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Edit User</title>
    <link rel="stylesheet" href="../static/bootstrap.min.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 500px;
            margin: 50px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            font-weight: bold;
        }

        input[type="text"],
        input[type="password"],
        input[type="tel"],
        select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
            font-size: 16px;
        }

        select {
            height: 100px; /* To make the select box multiple select */
        }

        button {
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            background-color: #4CAF50;
            color: #fff;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        button:hover {
            background-color: #45a049;
        }

        .error-text {
            color: red;
            font-size: 14px;
        }
    </style>
</head>
<body>
<%
    UUID uuid = UUID.fromString(request.getParameter("id"));
    User user = UserRepo.findById(uuid);
    List<Role> roles = RoleRepo.findAll();
    Object currentFile = session.getAttribute("currentFile");
%>
<div class="container">
    <h2>User Details Editing</h2>
    <form enctype="multipart/form-data" action="${pageContext.request.contextPath}/file" method="post">
        <label>
            <%if (currentFile == null) {%>
            <img width="50" height="50"
                 src="data:image/png;base64,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"
                 alt="">
            <%} else {%>
            <img width="50" height="50" src="/file?id=<%=(UUID)currentFile%>" alt="">
            <%}%>
            <input class="d-none" type="file" name="photo">
        </label>
        <input type="hidden" name="lastUrl" value="/superadmin/editUser.jsp?id=<%=user.getId()%>">
        <button class="btn btn-success text-white">Save file</button>
    </form>

    <!-- Error message -->
    <form action="${pageContext.request.contextPath}/user/edit?id=<%=user.getId()%>" method="POST">
        <small class="error-text" id="error_message" style="display: none;">Some of the data is incorrect.</small>
        <div class="form-group">
            <label for="firstname">First Name:</label>
            <input value="<%=user.getFirstName()%>" type="text" id="firstname" name="firstname" required>
        </div>
        <div class="form-group">
            <label for="lastname">Last Name:</label>
            <input value="<%=user.getLastName()%>" type="text" id="lastname" name="lastname" required>
        </div>
        <div class="form-group">
            <label for="phone">Phone:</label>
            <input value="<%=user.getPhone()%>" type="text" id="phone" name="phone" required>
        </div>
        <div class="form-group">
            <label for="old_password">Old Password:</label>
            <input type="password" id="old_password" name="old_password" required>
        </div>
        <div class="form-group">
            <label for="new_password">New Password:</label>
            <input type="password" id="new_password" name="new_password" required>
        </div>
        <div class="form-group">
            <label for="repeat_password">Repeat New Password:</label>
            <input type="password" id="repeat_password" name="repeat_password" required>
        </div>
        <div class="form-group">
            <label for="role">Role:</label>
            <select id="role" name="role[]" multiple required>
                <%
                    for (Role role : roles) {
                        if (user.hasRole(role.getRoleName())) {
                %>
                <option selected value="<%=role.getId()%>"><%=role.getRoleName()%>
                </option>
                <%} else {%>
                <%}%>
                <option value="<%=role.getId()%>"><%=role.getRoleName()%>
                </option>
                <%}%>
            </select>
        </div>
        <div class="form-group">
            <a href="${pageContext.request.contextPath}/user/cancelEdit" class="btn btn-danger text-white">Cancel</a>
            <button type="submit">Save Changes</button>
        </div>
    </form>
</div>
</body>
</html>
