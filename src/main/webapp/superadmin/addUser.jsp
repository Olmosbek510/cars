<%@ page import="uz.inha.cars.repo.RoleRepo" %>
<%@ page import="uz.inha.cars.entity.Role" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: orazboyevolmosbek
  Date: 19/04/24
  Time: 17:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Add new user</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
        }

        form {
            max-width: 400px;
            margin: auto;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
            background-color: #f9f9f9;
        }

        input[type="text"],
        input[type="password"],
        select {
            width: 100%;
            padding: 10px;
            margin: 5px 0;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }

        input[type="submit"],
        input[type="button"] {
            width: 100%;
            background-color: #4CAF50;
            color: white;
            padding: 14px 20px;
            margin: 8px 0;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        input[type="submit"]:hover,
        input[type="button"]:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
<%
    List<Role> roles = RoleRepo.findAll();
%>
<form action="${pageContext.request.contextPath}/register" method="post" id="addUserForm">
    <label for="firstName">First Name:</label>
    <input type="text" id="firstName" name="firstname" required>

    <label for="lastName">Last Name:</label>
    <input type="text" id="lastName" name="lastname" required>

    <label for="phone">Phone:</label>
    <input type="text" id="phone" name="phone" required>

    <label for="password">Password:</label>
    <input type="password" id="password" name="password" required>

    <label for="repeatPassword">Repeat Password:</label>
    <input type="password" id="repeatPassword" name="repeat-password" required>

    <label for="roles">Roles:</label>
    <select id="roles" name="roles[]" multiple>
        <%for (Role role : roles) {%>
        <option value="<%=role.getId()%>"><%=role.getRoleName().toString()%></option>
        <%}%>
    </select>
    <input type="submit" value="Save">
    <input type="button" value="Cancel" onclick="window.location.href='cancel.html'">
</form>
</body>
</html>
