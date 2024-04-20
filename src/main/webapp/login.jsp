<%--
  Created by IntelliJ IDEA.
  User: orazboyevolmosbek
  Date: 17/04/24
  Time: 09:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Login</title>
    <link rel="stylesheet" href="static/bootstrap.min.css">
    <style>
        .login-container {
            max-width: 400px;
            margin: 100px auto 0;
            border: 1px solid #ccc;
            padding: 20px;
            border-radius: 10px;
        }

        .invalid-msg {
            color: red;
            font-size: 0.8rem;
        }
    </style>
</head>
<body>
<%
    Object object = session.getAttribute("errorMessage");
    String errorMessage = "";
    if (object != null) {
        errorMessage = (String) object;
    }
%>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="login-container">
                <h2 class="text-center mb-4">Login</h2>
                <form action="/auth/login" method="post">
                    <div class="form-group">
                        <label for="phone">Phone Number</label>
                        <input type="tel" class="form-control" id="phone" name="phone" placeholder="Enter phone number">
                    </div>
                    <div class="form-group">
                        <label for="password">Password</label>
                        <input type="password" class="form-control" id="password" name="password"
                               placeholder="Enter password">
                        <small class="invalid-msg"><%=errorMessage%>
                        </small>
                    </div>
                    <div class="form-group mt-4">
                        <button type="submit" class="btn btn-primary btn-block">Login</button>
                    </div>
                    <div class="form-group">
                        <a type="button" class="btn btn-secondary btn-block" href="index.jsp">Cancel</a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
</body>
</html>
