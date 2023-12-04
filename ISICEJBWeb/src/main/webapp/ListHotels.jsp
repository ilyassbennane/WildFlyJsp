<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@10">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>

    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <meta charset="UTF-8">
    <title>Hotels List</title>
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
    </style></head>
<body>
    <div class="container">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <a href="/ISICEJBWeb/index.jsp" class="btn btn-warning">HOME</a>
            <h1 class="display-4">Gestion des hotels</h1>
            <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#HotelModal">
                Ajouter un hotel
            </button>
        </div>

        <!-- Add Hotel Modal -->
        <div class="modal fade" id="HotelModal" tabindex="-1" role="dialog" aria-labelledby="HotelModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <form action="HotelController" method="post">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="HotelModalCenterTitle">Ajouter un hotel</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <label class="custom-modal-label" for="Name">Nom de l'hotel</label>
                            <input type="text" name="Name" class="form-control" required>
                            <label class="custom-modal-label" for="Address">Adresse</label>
                            <input type="text" name="Address" class="form-control" required>
                            <label class="custom-modal-label" for="Telephone">Téléphone</label>
                            <input type="text" name="Telephone" class="form-control" required>
                            <label class="custom-modal-label" for="VilleId">Ville</label>
                            <!-- Replace the select options with data from your Ville list -->
                            <select name="VilleId" class="form-control" required>
                                <c:forEach items="${Villes}" var="Ville">
                                    <option value="${Ville.id}">${Ville.nom}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Fermer</button>
                            <input type="submit" class="btn btn-primary" value="Enregistrer">
                        </div>
                    </div>
                </form>
            </div>
        </div>

        <!-- Modify Hotel Modal -->
        <div class="modal fade" id="ModifyHotelModal" tabindex="-1" role="dialog" aria-labelledby="ModifyHotelModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <form action="HotelController" method="post">
                                                <input type="hidden" name="action" value="edit">
                
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="ModifyHotelModalCenterTitle">Modifier un hotel</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <input type="hidden" name="id" id="modalHotelId">
                        
                            <label class="custom-modal-label" for="Name">Nom de l'hotel</label>
                            <input type="text" name="Name" id="modalHotelName" class="form-control" required>
                            <label class="custom-modal-label" for="Address">Adresse</label>
                            <input type="text" name="Address" id="modalHotelAddress" class="form-control" required>
                            <label class="custom-modal-label" for="Telephone">Téléphone</label>
                            <input type="text" name="Telephone" id="modalHotelTelephone" class="form-control" required>
                            <label class="custom-modal-label" for="VilleId">Ville</label>
                            <select name="VilleId" class="form-control" required>
                        		<c:forEach items="${Villes}" var="Ville">
                            		<option value="${Ville.id}" <c:if test="${Ville.id eq HotelVilleId}">selected</c:if>>${Ville.nom}</option>
                        		</c:forEach>
                    </select>
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
                    <th>Nom de l'hotel</th>
                    <th>Adresse</th>
                    <th>Téléphone</th>
                    <th>Ville</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${Hotels}" var="Hotel">
                    <tr>
                        <td>${Hotel.id}</td>
                        <td>${Hotel.nom}</td>
                        <td>${Hotel.adresse}</td>
                        <td>${Hotel.telephone}</td>
                		<td>${Hotel.ville.nom}</td>
                        <td class="d-flex align-items-center">
                                             <form id="deleteForm${Hotel.id}" action="HotelController" method="post">
    <input type="hidden" name="action" value="delete">
    <input type="hidden" name="id" value="${Hotel.id}">
    <button type="submit" class="btn btn-danger" onclick="return confirmDelete(${Hotel.id})">Supprimer</button>
</form>
                            <button type="button" class="btn btn-primary ml-2" data-toggle="modal" data-target="#ModifyHotelModal"
                                    data-hotel-id="${Hotel.id}" data-hotel-name="${Hotel.nom}" data-hotel-address="${Hotel.adresse}" data-hotel-telephone="${Hotel.telephone}" data-hotel-villeId="${Hotel.ville.id}">
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
    $('#ModifyHotelModal').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget);
        console.log('Button data:', button.data());

        var HotelId = button.data('hotelId');
        console.log('HotelId:', HotelId);

        var HotelName = button.data('hotelName');
        console.log('HotelName:', HotelName);

        var HotelAddress = button.data('hotelAddress');
        console.log('HotelAddress:', HotelAddress);

        var HotelTelephone = button.data('hotelTelephone');
        console.log('HotelTelephone:', HotelTelephone);

        var HotelVilleId = button.data('hotelVilleid');
        console.log('HotelVilleId:', HotelVilleId);

        var modal = $(this);
        modal.find('#modalHotelId').val(HotelId);
        modal.find('#modalHotelName').val(HotelName);
        modal.find('#modalHotelAddress').val(HotelAddress);
        modal.find('#modalHotelTelephone').val(HotelTelephone);
        modal.find('select[name="VilleId"]').val(HotelVilleId); // Corrected line
    });
</script>
<script>
    function confirmDelete(HotelId) {
        Swal.fire({
            title: 'Confirmation',
            text: 'Are you sure you want to delete this Hotel?',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Yes, delete it!'
        }).then((result) => {
            if (result.isConfirmed) {
                document.getElementById('deleteForm' + HotelId).submit();
            }
        });
        return false; 
    }
</script>

</body>
</html>
