<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" lang="en" http-equiv="Content-Type" content="text/html" />
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Flat Finder - Search Results</title>

    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous">

    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap-theme.min.css" integrity="sha384-fLW2N01lMqjakBkx3l/M9EahuwpSfeNvV63J5ezn3uZzapT0u7EYsXMjQV+0En5r" crossorigin="anonymous">

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>

    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js" integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS" crossorigin="anonymous"></script>

    <link rel="stylesheet" href="/resources/css/leaflet.css"/>

    <script src="/resources/js/leaflet.js"></script>

    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <style>
        #mapid { height: 500px;
        }
    </style>

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
            <a class="navbar-brand" href="#">Flat Finder - Search Results</a>
        </div>
        <%@ include file="/WEB-INF/fragments/navbar.jspf" %>
    </div>
</nav>

<div class="container">

    <div class="jumbotron">
        <br />
        <h1>Property Search Results</h1>
        <p>Below are the search results for your current query, use the map to locate each search result.</p>
    </div>

    <c:choose>
        <c:when test="${error != null}">

            <p>Please fill out all required search fields.</p>
            <p><a href="/success-login" class="btn btn-success">Back</a></p>

        </c:when>
        <c:when test="${noResults != null}">

            <p><strong>0</strong> results were found for your search. Please refine your search.</p>
            <p><a href="/success-login" class="btn btn-success">Back</a></p>

        </c:when>
        <c:otherwise>

            <div id="mapid" class="jumbotron"></div>
            <script type="text/javascript">
                var mymap = L.map('mapid').setView([52.621919, -1.12381], 13);

                L.tileLayer('https://a.tile.openstreetmap.org/{z}/{x}/{y}.png', {
                    maxZoom: 18,
                }).addTo(mymap);
            </script>
            <c:forEach items="${properties}" var="property">
                <script type="text/javascript">
                    var lat = ${property.latitude};
                    var lng = ${property.longitude};

                    L.marker([lat, lng]).addTo(mymap)
                            .bindPopup("${property.number}<br />${property.street}<br />${property.city}<br />${property.postcode}<br />").openPopup();
                </script>
            </c:forEach>

            <table class="table table-striped">
                <thead>
                <tr>
                    <th></th>
                    <th>Number</th>
                    <th>Street</th>
                    <th>Postcode</th>
                    <th>Type</th>
                    <th>Rooms</th>
                    <th>Price Per Month</th>
                </tr>
                </thead>
                <tbody>

                <c:forEach items="${properties}" var="property">

                    <tr>
                        <td><a class="btn btn-success" href="/property/view/${property.id}">View</a></td>
                        <td>${property.number}</td>
                        <td>${property.street}</td>
                        <td>${property.postcode}</td>
                        <td>${property.type.getType()}</td>
                        <td>${property.rooms}</td>
                        <td>${property.pricePerMonth}</td>
                    </tr>

                </c:forEach>

                </tbody>
            </table>

        </c:otherwise>
    </c:choose>

</div>

<hr />

<footer class="container">
    <p>&copy; CO2015 - Group 6</p>
</footer>

</body>
</html>