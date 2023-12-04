<%@page import="entities.Ville"%>
<%@page import="entities.Hotel"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<style>
    body {
        background-color: #e6ffe6; /* Light green background color */
        color: black; /* Dark green text color */
    }

    .container {
        margin: 20px auto; /* Center the container horizontally */
        max-width: 800px; /* Set a maximum width for the container */
    }

    .form-select {
        background-color: #ffffff; /* White background color for the dropdown */
        border-color: #00cc66; /* Light green border color */
        color: black; /* Black text color */
    }

    .btn-primary {
        background-color: #00cc66; /* Light green color for the button */
        border-color: #00cc66; /* Light green border color */
        color: white; /* White text color */
    }

    .btn-primary:hover {
        background-color: #009933; /* Darker green on hover */
        border-color: #009933; 
        border-radius: 20px;
    }

    .btn-warning {
        margin-right: 100px;
        border-radius: 20px; 
    }

    .table {
        background-color: #ffffff; /* White background for the table */
    }

    th, td {
        color: black; 
    }
</style>
</head>
<body>
<main style="margin-top: 58px;">
    <div class="container border mt-4 py-4 text-center">
        <form action="HotelVilleController" class="mb-4" onsubmit="return validateForm()" method="post">
            <div class="row">
                <div class="col">
                    <a href="/ISICEJBWeb/index.jsp" class="btn btn-warning">HOME</a>
                    <select class="form-select" aria-label="Default select example" name="ville">
                        <option selected value="">Sélectionner une ville</option>
                        <c:forEach items="${villes}" var="v">
                            <option value="${v.id}">${v.nom}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col">
                    <input type="submit" class="btn btn-primary" value="Chercher" />
                </div>
            </div>
        </form>

        <h1 class="text-center mb-3 text-black">Liste des Hotels par ville</h1>
        <table class="table table-striped">
            <thead>
                <tr>
                    <th scope="col">Id</th>
                    <th scope="col">Nom</th>
                    <th scope="col">Adresse</th>
                    <th scope="col">Télephone</th>
                    <th scope="col">Ville</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${hotels}" var="v">
                    <tr>
                        <th scope="row">${v.id}</th>
                        <td>${v.nom}</td>
                        <td>${v.adresse}</td>
                        <td>${v.telephone}</td>
                        <td>${v.ville.nom}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</main>
</body>
</html>
