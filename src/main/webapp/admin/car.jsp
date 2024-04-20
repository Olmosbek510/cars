<%@ page import="uz.inha.cars.repo.CarRepo" %>
<%@ page import="java.util.List" %>
<%@ page import="uz.inha.cars.entity.Car" %>
<%@ page import="uz.inha.cars.entity.CarDetail" %>
<%@ page import="jdk.jshell.spi.ExecutionControl" %><%--
  Created by IntelliJ IDEA.
  User: orazboyevolmosbek
  Date: 17/04/24
  Time: 11:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <link rel="stylesheet" href="../static/bootstrap.min.css">
    <title>Cars</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
        }

        .container {
            max-width: 800px;
            margin: 50px auto;
        }

        .table-img {
            max-width: 100px;
            height: auto;
        }

        .action-buttons {
            display: flex;
            justify-content: space-between;
        }

        .back-button {
            margin-top: 20px;
        }
    </style>
</head>
<body>
<%
    List<Car> cars = CarRepo.findAll();
    Object o = session.getAttribute("adminBack");
    String back = "";
    if(o!=null){
        back = (String)o;
    }
%>
<div class="container">
    <h2 class="text-center mb-4">Car Management</h2>

    <!-- Add button -->
    <a href="addCar.jsp" type="button" class="btn btn-primary mb-3">Add Car</a>
    <!-- Car table -->
    <table class="table table-striped">
        <thead>
        <tr>
            <th>Photo</th>
            <th>Car Name</th>
            <th>Company</th>
            <th>Car Details</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <%for (Car car : cars) { %>
        <tr>
        <td><img src="/file?id=<%=car.getPhoto().getId()%>" alt="Car 1" class="table-img"></td>
        <td><%=car.getName()%>
        </td>
        <td><%=car.getCompany().getName()%>
        </td>
        <td>
            <ul class="list-unstyled">
                <%if(car.getCarDetails()!=null){
                    for (CarDetail carDetail : car.getCarDetails()) {%>
                <li><strong><%=carDetail.getKey()%>
                </strong><%=carDetail.getValue()%>
                </li>
                <%}}else {%>
                    No details
                <%}%>
            </ul>
        </td>
        <td class="action-buttons">
            <a href="addDetail.jsp?id=<%=car.getId()%>" class="btn btn-dark text-white">Add detail</a>
            <a href="editCar.jsp?id=<%=car.getId()%>" type="button" class="btn btn-info btn-sm">Edit</a>
            <a href="${pageContext.request.contextPath}/admin/car/delete?id=<%=car.getId()%>" class="btn btn-danger btn-sm">Delete</a>
        </td>
        </tr>
        <%}%>
        <!-- Add more rows as needed -->
        </tbody>
    </table>

    <!-- Back button -->
    <a href="<%=back%>" type="button" class="btn btn-secondary back-button">Back</a>
</div>
</body>
</html>
