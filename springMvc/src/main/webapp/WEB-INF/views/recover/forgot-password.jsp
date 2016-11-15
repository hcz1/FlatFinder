<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Flat Finder - Forgot Password</title>

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
            <a class="navbar-brand">Flat Finder - Forgot Password</a>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
            <ul class="nav navbar-nav">
                <li class="active"><a href="/">Home</a></li>
            </ul>
        </div><!--/.nav-collapse -->
    </div>
</nav>
<div class="container">
    <div class="jumbotron">
        <br />
        <h1>Forgot Password?</h1>
        <p>Please enter your username to recover your account</p>
    </div>

    <c:if test="${submitted != null}">
        <div class="alert alert-success" role="alert">
            <strong>Success!</strong> If the username you entered exists, you will be sent an email with instructions on how to recover your account.
        </div>
    </c:if>
    <form:form method="POST" action="/forgot/send" modelAttribute="User">
        <table>
            <tr>
                <td>Enter Username: </td>
                <td><div class="form-group">
                    <form:input role="form" type="text" path="login" class="form-control"
                                placeholder="Username" required="required"></form:input>
                </div></td>
            </tr>
            <tr><td><br /></td></tr>
            <tr>
                <td colspan="2"><input type="submit" value="Submit" class="btn btn-success"/></td>
            </tr>
        </table>

    </form:form>

</div>

<hr />

<footer class="container">
    <p>&copy; CO2015 - Group 6</p>
</footer>


</body>
</html>