<%@ page import="uz.inha.cars.repo.CarRepo" %>
<%@ page import="static uz.inha.cars.config.DB.entityManager" %>
<%@ page import="uz.inha.cars.entity.Car" %>
<%@ page import="java.util.UUID" %>
<%@ page import="uz.inha.cars.repo.CompanyRepo" %>
<%@ page import="uz.inha.cars.entity.Company" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: orazboyevolmosbek
  Date: 19/04/24
  Time: 14:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Edit Car</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f7f7f7;
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 400px;
            margin: 50px auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            font-size: 16px;
            color: #333;
            margin-bottom: 5px;
        }

        .form-group select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 16px;
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
    UUID carId = UUID.fromString(request.getParameter("id"));
    entityManager.getTransaction().begin();
    Car car = entityManager.find(Car.class, carId);
    entityManager.getTransaction().commit();
    List<Company> companies = CompanyRepo.findAll();
%>
<div class="container">
    <form action="${pageContext.request.contextPath}/admin/editCar" method="post">
        <h2>Edit Car Details</h2>
        <div class="form-group">
            <label for="car-name">Car Name</label>
            <input id="car-name" value="<%=car.getName()%>" name="name">
        </div>
        <div class="form-group">
            <label for="car-company">Car Company</label>
            <select id="car-company" name="companyId">
                <%
                    for (Company company : companies) {
                        if (car.getCompany().getId().equals(company.getId())) {
                %>
                <option value="<%=company.getId()%>" selected><%=company.getName()%>
                </option>
                <%} else {%>
                <option value="<%=company.getId()%>"><%=company.getName()%></option>
                <%} %>
                <%} %>
                <!-- Add more options as needed -->
            </select>
            <input type="hidden" value="<%=car.getId()%>" name="id">
        </div>
        <div class="buttons">
            <button class="button">Save Changes</button>
            <a class="button" href="car.jsp">Cancel</a>
        </div>
    </form>
</div>
</body>
</html>
