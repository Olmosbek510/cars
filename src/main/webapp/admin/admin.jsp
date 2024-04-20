<%--
  Created by IntelliJ IDEA.
  User: orazboyevolmosbek
  Date: 17/04/24
  Time: 10:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="stylesheet" href="../static/bootstrap.min.css">
    <title>Admin</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
        }

        .sidebar {
            height: 100%;
            width: 250px;
            position: fixed;
            top: 0;
            left: 0;
            background-color: #343a40;
            padding-top: 20px;
        }

        .sidebar a {
            padding: 10px;
            text-decoration: none;
            font-size: 18px;
            color: #f8f9fa;
            display: block;
        }

        .sidebar a:hover {
            background-color: #495057;
        }

        .content {
            margin-left: 250px;
            padding: 20px;
        }
    </style>
</head>
<body>
<div class="sidebar">
    <%
        session.setAttribute("adminBack", "/admin/admin.jsp");
    %>
    <h2 class="text-center text-white mb-4">Admin Panel</h2>
    <a href="car.jsp">Cars</a>
    <a href="#">Logout</a>
</div>

<!-- Page content -->
<div class="content">
    <h2>Welcome Admin!</h2>
    <p>This is your admin dashboard. You can manage users and cars here.</p>
</div>
</body>
</html>
