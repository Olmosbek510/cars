<%@ page import="uz.inha.cars.entity.Company" %>
<%@ page import="java.util.List" %>
<%@ page import="uz.inha.cars.repo.CompanyRepo" %>
<%@ page import="java.util.UUID" %>
<%@ page import="jakarta.validation.ConstraintViolation" %>
<%@ page import="java.util.Set" %>
<%@ page import="uz.inha.cars.entity.User" %>
<%@ page import="org.postgresql.util.LruCache" %><%--
  Created by IntelliJ IDEA.
  User: orazboyevolmosbek
  Date: 19/04/24
  Time: 09:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Registration</title>
    <link rel="stylesheet" href="./static/bootstrap.min.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .container {
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            padding: 40px;
            width: 400px;
        }

        .container h2 {
            text-align: center;
            color: #333;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            font-size: 16px;
            color: #555;
            margin-bottom: 5px;
        }

        .form-group input {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 16px;
        }

        .btn {
            display: block;
            width: 100%;
            padding: 10px;
            border: none;
            border-radius: 5px;
            background-color: #007bff;
            color: #fff;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .btn:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
<%
    @SuppressWarnings("unchecked")
    Object currentFile = session.getAttribute("currentFile");
    Object o = request.getAttribute("violations");
    if(o!=null){
        Set<ConstraintViolation<User>> violations = (Set<ConstraintViolation<User>>) o;
        for (ConstraintViolation<User> violation : violations) {
            System.out.println(violation);
        }
    }
%>
<div class="container">
    <h2>Registration Form</h2>
    <form action="/register" method="post">
        <div class="form-group">
            <label for="firstname">First Name</label>
            <input type="text" id="firstname" name="firstname" required>
        </div>
        <div class="form-group">
            <label for="lastname">Last Name</label>
            <input type="text" id="lastname" name="lastname" requ  ired>
        </div>
        <div class="form-group">
            <label for="username">Phone</label>
            <input type="text" id="username" name="phone" required>
        </div>
        <div class="form-group">
            <label for="password">Password</label>
            <input type="password" id="password" name="password" required>
        </div>
        <div class="form-group">
            <label for="repeat-password">Repeat Password</label>
            <input type="password" id="repeat-password" name="repeat-password" required>
        </div>
        <button type="submit" class="btn">Register</button>
    </form>
</div>
</body>
</html>
