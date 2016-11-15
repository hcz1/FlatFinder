<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" lang="en" http-equiv="Content-Type" content="text/html" />
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Flat Finder - Manage Users</title>

    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous">

    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap-theme.min.css" integrity="sha384-fLW2N01lMqjakBkx3l/M9EahuwpSfeNvV63J5ezn3uZzapT0u7EYsXMjQV+0En5r" crossorigin="anonymous">

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>

    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js" integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS" crossorigin="anonymous"></script>

</head>
<body>

<!-- Fixed navbar -->
<nav class="navbar navbar-inverse navbar-fixed-top">
    <div class="container">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="#">Flat Finder - Administrator</a>
        </div>
        <%@ include file="/WEB-INF/fragments/navbar.jspf" %>
    </div>
</nav>

<div class="container">
    <div class="jumbotron">
        <h1>Manage Users</h1>
        <p>Here you can view all the users in the system and choose to edit/suspend them.</p>
    </div>

    <c:if test="${suspended != null}">
        <div class="alert alert-success" role="alert">
            <strong>Success!</strong> You have successfully suspended the user from using the system.
        </div>
    </c:if>
    <c:if test="${unSuspended != null}">
        <div class="alert alert-success" role="alert">
            <strong>Success!</strong> You have successfully un suspended the user from the system.
        </div>
    </c:if>
    <c:if test="${deleted != null}">
        <div class="alert alert-success" role="alert">
            <strong>Success!</strong> You have successfully deleted the user from using the system.
        </div>
    </c:if>
    <c:if test="${edited != null}">
        <div class="alert alert-success" role="alert">
            <strong>Success!</strong> You have successfully edited a user.
        </div>
    </c:if>
    <div class="table-responsive">
        <table class="table table-hover">
            <tr>
                <th>ID</th>
                <th>Username</th>
                <th>Role</th>
                <th>Activated</th>
                <th>Suspended</th>
                <th>Email Address</th>
                <th>Options</th>
            </tr>
            <c:forEach items ="${users}" var ="user">
                <tr>
                    <td>${user.id}</td>
                    <td>${user.login}</td>
                    <td>${user.role.role}</td>
                    <td>${user.confirmed}</td>
                    <td>${user.suspended}</td>
                    <td>${user.emailAddress}</td>
                    <td>
                        <c:if test="${user.role.role != 'ADMINISTRATOR'}">
                            <a href="/admin/view-user/${user.id}" class="btn btn-danger">Edit</a>
                            <c:if test="${user.suspended == true}">
                                <a href="/admin/user/unSuspend/${user.id}" class="btn btn-danger">Un Suspend</a>
                            </c:if>
                            <c:if test="${user.suspended == false}">
                                <a href="/admin/user/suspend/${user.id}" class="btn btn-danger">Suspend</a>
                            </c:if>
                            <a href="/admin/user/delete/${user.id}" class="btn btn-danger">Delete</a>
                        </c:if>
                    </td>
                </tr>
            </c:forEach>
        </table>
    </div>
</div>

<hr />

<footer class="container">
    <p>&copy; CO2015 - Group 6</p>
</footer>

</body>
</html>