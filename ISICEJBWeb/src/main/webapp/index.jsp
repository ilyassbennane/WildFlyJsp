<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@ taglib prefix ="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Gestion</title>
    <!-- Add Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <style>
        body {
            background-color: #e6ffe6; /* Light green background color */
            color: #009933; /* Dark green text color */
        }

        .container {
            margin-top: 50px;
            text-align: center;
        }

        .btn-primary {
            background-color: #00cc66; /* Green button background color */
            border-color: #00cc66; /* Green button border color */
            border-radius: 10000px; /* Adjust the border-radius to make buttons more round */
            padding: 10px 20px; /* Add padding to maintain button size */
        }

        .btn-primary:hover {
            background-color: #009933; /* Darker green on hover */
            border-color: #009933; /* Darker green border on hover */
        }

        .display-4 {
            color: #009933; /* Dark green display heading color */
        }
    </style>
</head>
<body>
    <div class="container mt-5">
        <h1 class="display-4 text-center mb-4">Gestion</h1>
        <form action="VilleController" class="mb-3">
            <button class="btn btn-primary btn-block">Gestion des villes</button>
        </form>
        
        <form action="HotelController" class="mb-3">
            <button class="btn btn-primary btn-block">Gestion des hotels</button>
        </form>
               
        <form action="HotelVilleController" class="mb-3">
            <button class="btn btn-primary btn-block">Hotel By Ville</button>
        </form>
    </div>
    <!-- Add Bootstrap JS -->
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
</body>
</html>
