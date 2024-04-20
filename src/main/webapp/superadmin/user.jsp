<%@ page import="uz.inha.cars.repo.UserRepo" %>
<%@ page import="uz.inha.cars.entity.User" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.StringJoiner" %>
<%@ page import="uz.inha.cars.entity.Role" %><%--
  Created by IntelliJ IDEA.
  User: orazboyevolmosbek
  Date: 17/04/24
  Time: 11:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Users</title>
    <link rel="stylesheet" href="../static/bootstrap.min.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f7f7f7;
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 800px;
            margin: 20px auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        .table-container {
            overflow-x: auto;
        }

        .user-table {
            width: 100%;
            border-collapse: collapse;
        }

        .user-table th, .user-table td {
            padding: 10px;
            border-bottom: 1px solid #ccc;
            text-align: left;
        }

        .user-table img {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            object-fit: cover;
        }

        .actions {
            text-align: center;
        }

        .actions .button {
            padding: 8px 16px;
            font-size: 14px;
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            margin-right: 5px;
            transition: background-color 0.3s ease;
        }

        .actions .button:hover {
            background-color: #0056b3;
        }

        .buttons {
            margin-top: 20px;
            text-align: center;
        }

        .buttons .button {
            padding: 10px 20px;
            font-size: 16px;
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            margin-right: 10px;
            transition: background-color 0.3s ease;
        }

        .buttons .button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
<%
    Object o = session.getAttribute("adminBack");
    String backUrl = "";
    if (o != null) {
        backUrl = (String) o;
    }
    List<User> users = UserRepo.findAll();
    Object o1 = session.getAttribute("currentUser");
    User user1 = (User) o1;
    users.removeIf(user -> user.getPhone().equals(user1.getPhone()));
%>
<div class="container">
    <div class="table-container">
        <table class="user-table">
            <thead>
            <tr>
                <th>Photo</th>
                <th>First Name</th>
                <th>Last Name</th>
                <th>Roles</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody>
            <%
                for (User user : users) {
                    StringJoiner roles = new StringJoiner(" ");
                    for (Role role : user.getRoles()) {
                        roles.add(role.getRoleName().toString());
                    }
            %>
            <tr>
                <%if (user.getProfilePhoto() != null) {%>
                <td><img src="/file?id=<%=user.getProfilePhoto().getId()%>" alt="Car 1" class="table-img"></td>
                <%} else {%>
                    <td><img src="user1.jpg" alt="User 1"></td>
                <%} %>
                <td><%=user.getFirstName()%>
                </td>
                <td><%=user.getLastName()%>
                </td>
                <td><%=roles%>
                </td>
                <td class="actions">
                    <a href="editUser.jsp?id=<%=user.getId()%>" class="btn btn-dark text-white">Edit</a>
                    <a href="${pageContext.request.contextPath}/superadmin/user/delete?id=<%=user.getId()%>" class="btn btn-danger text-white">Delete</a>
                </td>
            </tr>
            <%}%>
            <!-- Add more rows as needed -->
            </tbody>
        </table>
    </div>

    <div class="buttons">
        <a href="addUser.jsp" class="btn btn-success text-white">Add User</a>
        <a href="<%=backUrl%>" class="btn btn-dark text-white">Back</a>
    </div>
</div>
</body>
</html>
