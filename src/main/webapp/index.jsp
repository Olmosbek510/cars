<%@ page import="uz.inha.cars.entity.User" %>
<%@ page import="uz.inha.cars.repo.CarRepo" %>
<%@ page import="uz.inha.cars.entity.Car" %>
<%@ page import="java.util.List" %>
<%@ page import="uz.inha.cars.entity.CarDetail" %>
<%@ page import="uz.inha.cars.entity.enums.RoleName" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>JSP - Hello World</title>
    <link rel="stylesheet" href="./static/bootstrap.min.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f7f7f7;
            margin: 0;
            padding: 0;
        }

        .header {
            background-color: #333;
            color: #fff;
            padding: 10px 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .header .user-link {
            color: #fff;
            text-decoration: none;
            font-weight: bold;
        }

        .container {
            margin: 20px auto;
            max-width: 800px;
            padding: 20px;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        .button-container {
            text-align: center;
            margin-bottom: 20px;
        }

        .button-container .button {
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

        .button-container .button:hover {
            background-color: #0056b3;
        }

        .car-table {
            width: 100%;
            border-collapse: collapse;
        }

        .car-table th, .car-table td {
            padding: 10px;
            border-bottom: 1px solid #ccc;
            text-align: left;
        }

        .car-table img {
            max-width: 100px;
            max-height: 100px;
        }

        .car-details {
            margin-top: 10px;
            padding-left: 20px;
        }

        .car-details ul {
            list-style: none;
            padding: 0;
        }

        .car-details ul li {
            margin-bottom: 5px;
        }
    </style>
</head>
<body>
<%
    Object o = session.getAttribute("currentUser");
    User user = null;
    if (o != null) {
        user = (User) o;
        System.out.println(user.getFirstName());
    }
    if (user != null) {
        if (user.hasRole(RoleName.ROLE_SUPER_ADMIN)) {
            response.sendRedirect("/superadmin/superadmin.jsp");
        } else if (user.hasRole(RoleName.ROLE_ADMIN)) {
            response.sendRedirect("/admin/admin.jsp");
        }
    }
    List<Car> cars = CarRepo.findAll();
%>
<div class="header">
    <%if (user != null) {%>
    <a href="userProfile.jsp?id=<%=user.getId()%>" class="user-link"><%=user.getFirstName()%>
    </a>
    <%} else {%>
    <div>
        <a class="btn btn-dark text-white" href="login.jsp">Login</a>
        <a class="btn btn-success text-white" href="registration.jsp">Register</a>
    </div>
    <%}%>
</div>

<div class="container">
    <h2>Car Catalog</h2>
    <table class="car-table">
        <thead>
        <tr>
            <th>Photo</th>
            <th>Name</th>
            <th>Company</th>
            <th>Details</th>
        </tr>
        </thead>
        <tbody>
        <%for (Car car : cars) {%>
        <tr>
            <td><img src="/file?id=<%=car.getPhoto().getId()%>" alt="Car 1" class="table-img"></td>
            <td><%=car.getName()%>
            </td>
            <td><%=car.getCompany().getName()%>
            </td>
            <td class="car-details">
                <ul>
                    <%if (car.getCarDetails().isEmpty()) {%>
                    <li>No details</li>
                    <%
                    } else {
                        for (CarDetail carDetail : car.getCarDetails()) {
                    %>
                    <li><%=carDetail.getKey() + ": " + carDetail.getValue()%>
                    </li>
                    <%}%>
                    <%}%>
                </ul>
            </td>
        </tr>
        <%}%>
        <tr>
            <td><img src="car2.jpg" alt="Car 2"></td>
            <td>Car 2</td>
            <td>Company B</td>
            <td class="car-details">
                <ul>
                    <li>Color: Blue</li>
                    <li>Year: 2021</li>
                    <li>Price: $25,000</li>
                </ul>
            </td>
        </tr>
        <!-- Add more rows as needed -->
        </tbody>
    </table>
</div>
</body>
</html>