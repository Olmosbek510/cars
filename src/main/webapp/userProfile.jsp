<%@ page import="java.util.UUID" %>
<%@ page import="uz.inha.cars.repo.UserRepo" %>
<%@ page import="uz.inha.cars.entity.User" %>
<%@ page import="java.util.StringJoiner" %>
<%@ page import="uz.inha.cars.repo.RoleRepo" %>
<%@ page import="uz.inha.cars.entity.Role" %><%--
  Created by IntelliJ IDEA.
  User: orazboyevolmosbek
  Date: 19/04/24
  Time: 11:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>User Profile details</title>
    <link rel="stylesheet" href = "./static/bootstrap.min.css">
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

        .user-photo {
            display: block;
            margin: 0 auto 20px;
            border-radius: 50%;
            overflow: hidden;
        }

        .user-photo img {
            width: 150px;
            height: 150px;
            object-fit: cover;
        }

        .user-info {
            text-align: center;
            margin-bottom: 30px;
        }

        .user-info h2 {
            margin-bottom: 10px;
            color: #333;
        }

        .user-info p {
            margin: 5px 0;
            color: #666;
        }

        .buttons {
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
    System.out.println(request.getParameter("id"));
    UUID id = UUID.fromString(request.getParameter("id"));
    System.out.println("UserId: " + id);
    User user = UserRepo.findById(id);
    StringJoiner roles = new StringJoiner(" ");
    for (Role role : user.getRoles()) {
        roles.add(role.getRoleName().toString());
    }
%>
<div class="container">
    <div class="user-info">
        <div class="user-photo">
            <%if (user.getProfilePhoto() != null) {%>
            <td><img src="/file?id=<%=user.getProfilePhoto().getId()%>" alt="Car 1" class="table-img"></td>
            <%} else {%>
            <td><img src="user1.jpg" alt="User 1"></td>
            <%} %>
        </div>
        <h2>Full name: <%=user.getFirstName()+" "+user.getLastName()%></h2>
        <p>Phone: <%=user.getPhone()%></p>
        <p>Role(s): <%=roles%></p>
    </div>

    <div class="buttons">
        <a href="setProfile..jsp?id=<%=user.getId()%>" class="button">Edit Profile</a>
        <a href="index.jsp" class="btn btn-danger text-white">Back</a>
        <a href="${pageContext.request.contextPath}/user/logout" class="button btn-danger text-white">Logout</a>
    </div>
</div>
</body>
</html>
