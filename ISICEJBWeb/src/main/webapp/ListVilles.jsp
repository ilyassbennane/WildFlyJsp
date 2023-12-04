<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix ="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<!DOCTYPE html>
<html>
<head>
<!-- Add these lines to include SweetAlert2 -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@10">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>

    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <meta charset="UTF-8">
    <title>Villes List</title>
   <style>
        body {
            background-color: #e6ffe6; /* Light green background color */
            color: black; /* Dark green text color */
        }

        .container {
            margin-top: 20px;
        }

        .custom-modal-label {
            font-weight: bold;
        }

        .btn-primary {
            background-color: #00cc66; /* Light green button background color */
            border-color: #00cc66; /* Light green button border color */
            border-radius: 20px; /* Adjust the border-radius to make buttons more round */
            padding: 10px 20px; /* Add padding to maintain button size */
        }

        .btn-primary:hover {
            background-color: #009933; /* Darker green on hover */
            border-color: #009933; /* Darker green border on hover */
        }

        .table {
            background-color: #ffffff; /* White background for the table */
        }

        th, td {
            color: black; /* Dark green text color for table headers and cells */
        }
        .btn-warning{
        border-radius: 20px;
        }
        .btn-danger{
        border-radius: 20px;
        }
        .btn-secondary{
        border-radius: 20px;}
    </style>
</head>
<body>
    <div class="container">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <a href="/ISICEJBWeb/index.jsp" class="btn btn-warning">HOME</a>
            <h1 class="display-4">Gestion des villes</h1>
            <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#VilleModal">
                Ajouter un ville
            </button>
        </div>

        <!-- Add Ville Modal -->
        <div class="modal fade" id="VilleModal" tabindex="-1" Ville="dialog" aria-labelledby="VilleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" Ville="document">
                <form action="VilleController" method="post">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="VilleModalCenterTitle">Ajouter un ville</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <label class="custom-modal-label" for="Name">Nom du ville</label>
                            <input type="text" name="Name" class="form-control" required>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Fermer</button>
                            <input type="submit" class="btn btn-primary" value="Enregistrer">
                        </div>
                    </div>
                </form>
            </div>
        </div>

        <!-- Modify Ville Modal -->
        <div class="modal fade" id="ModifyVilleModal" tabindex="-1" Ville="dialog" aria-labelledby="ModifyVilleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" Ville="document">
                <form action="VilleController" method="post">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="ModifyVilleModalCenterTitle">Modifier un ville</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <label class="custom-modal-label" for="Name">Nom du ville</label>
                            <input type="text" name="Name" id="modalVilleName" class="form-control" required>
                            <input type="hidden" name="action" value="edit">
                            <input type="hidden" name="id" id="modalVilleId">
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Fermer</button>
                            <input type="submit" class="btn btn-primary" value="Enregistrer les modifications">
                        </div>
                    </div>
                </form>
            </div>
        </div>

        <table class="table">
            <thead class="thead-light">
                <tr>
                    <th>ID</th>
                    <th>Nom du ville</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${Villes}" var="Ville">
                    <tr>
                        <td>${Ville.id}</td>
                        
                        <td>${Ville.nom}</td>
                        <td class="d-flex align-items-center">
                          <form id="deleteForm${Ville.id}" action="VilleController" method="post">
    <input type="hidden" name="action" value="delete">
    <input type="hidden" name="id" value="${Ville.id}">
    <button type="submit" class="btn btn-danger" onclick="return confirmDelete(${Ville.id})">Supprimer</button>
</form>

                            <button type="button" class="btn btn-primary ml-2" data-toggle="modal" data-target="#ModifyVilleModal"
                                    data-Ville-id="${Ville.id}" data-Ville-name="${Ville.nom}">
                                Modifier
                            </button>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
    <script>
    $('#ModifyVilleModal').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget);
        console.log('Button data:', button.data());

        // Use camelCase instead of kebab-case in data attribute names
        var VilleId = button.data('villeId');
        console.log('VilleId:', VilleId);

        var VilleName = button.data('villeName');
        console.log('VilleName:', VilleName);

        var modal = $(this);
        modal.find('#modalVilleId').val(VilleId);
        modal.find('#modalVilleName').val(VilleName);
    });


    </script>
<script>
    function confirmDelete(VilleId) {
        Swal.fire({
            title: 'Confirmation',
            text: 'Are you sure you want to delete this Ville?',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Yes, delete it!'
        }).then((result) => {
            if (result.isConfirmed) {
                document.getElementById('deleteForm' + VilleId).submit();
            }
        });
        return false; 
    }
</script>
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

</body>
</html>