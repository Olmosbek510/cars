<%@ page import="java.util.List" %>
<%@ page import="uz.inha.cars.entity.CarDetail" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.UUID" %>
<%@ page import="uz.inha.cars.repo.CarRepo" %>
<%@ page import="uz.inha.cars.entity.Car" %><%--
  Created by IntelliJ IDEA.
  User: orazboyevolmosbek
  Date: 17/04/24
  Time: 13:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="stylesheet" href="../static/bootstrap.min.css">
    <title>Add detail</title>
</head>
<body>
<%
    @SuppressWarnings("unchecked")
    Object o = session.getAttribute("details");
    UUID id = UUID.fromString(request.getParameter("id"));
    Car car = CarRepo.findById(id);
    List<CarDetail> carDetails = car.getCarDetails();
    if(o!=null){
        carDetails.addAll((List<CarDetail>)o);
    }
%>
<ul>
    <%for (CarDetail carDetail : carDetails) {%>
        <li><%=carDetail.getKey()+": "+carDetail.getValue()%></li>
    <%}%>
    <li></li>
</ul>
<form action="${pageContext.request.contextPath}/admin/car/addDetail" method="post">
    <input name="carId" type="hidden" value="<%=request.getParameter("id")%>">
<label>
    <input type="text" placeholder="key" name="key">
</label>
<label>
    <input type="text" placeholder="value" name="value">
</label>
<button>OK</button>
</form>
<hr>
<hr>
<form action="${pageContext.request.contextPath}/admin/car/details/save" method="post">
    <input type="hidden" value="<%=request.getParameter("id")%>" name="id">
    <button class="btn btn-dark text-white">Back</button>
</form>
</body>
</html>
