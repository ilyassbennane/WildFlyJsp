package controllers;

import jakarta.ejb.EJB;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import dao.HotelIDAO;
import dao.VilleIDAO;
import entities.Hotel;
import entities.Ville;

@WebServlet("/HotelController")
public class HotelController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @EJB
    HotelIDAO hotelDao;
    
    @EJB
    VilleIDAO villeDao;

    public HotelController() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Hotel> hotelList = hotelDao.findAll();
        List<Ville> villeList = villeDao.findAll();

        System.out.println("=====> liste : " + hotelList);
        request.setAttribute("Hotels", hotelList);
        request.setAttribute("Villes", villeList);

        request.getRequestDispatcher("/ListHotels.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("delete".equals(action)) {
            int hotelId = Integer.parseInt(request.getParameter("id"));
            if (hotelDao.findById(hotelId) != null) {
                Hotel hotelDelete = hotelDao.findById(hotelId);
                boolean updated = hotelDao.update(hotelDelete);

                if (updated) {
                    hotelDao.delete(hotelDelete);
                    boolean deleted = true;

                    if (deleted) {
                        List<Hotel> hotelList = hotelDao.findAll();
                        System.out.println("====> liste : " + hotelList);
                        request.setAttribute("Hotels", hotelList);
                        request.getRequestDispatcher("/ListHotels.jsp").forward(request, response);
                    } else {
                        response.sendRedirect(request.getContextPath() + "/HotelController?deleteFailed=true");
                    }
                }
            }
        } else if ("edit".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            String name = request.getParameter("Name");
            String address = request.getParameter("Address");
            String telephone = request.getParameter("Telephone");
            int villeId = Integer.parseInt(request.getParameter("VilleId"));

            Hotel hotelToEdit = hotelDao.findById(id);

            if (hotelToEdit != null) {
                hotelToEdit.setNom(name);
                hotelToEdit.setAdresse(address);
                hotelToEdit.setTelephone(telephone);
                Ville selectedVille = villeDao.findById(villeId);
                hotelToEdit.setVille(selectedVille);

                // Update the hotel
                boolean updated = hotelDao.update(hotelToEdit);

                if (updated) {
                    List<Hotel> hotelList = hotelDao.findAll();
                    request.setAttribute("Hotels", hotelList);
                    request.getRequestDispatcher("/ListHotels.jsp").forward(request, response);
                } else {
                    response.sendRedirect(request.getContextPath() + "/HotelController?updateFailed=true");
                }
            }
        
        } else if ("showform".equals(action)) {
            try {
                showEditForm(request, response);
            } catch (SQLException e) {
                e.printStackTrace();
            } catch (ServletException e) {
                e.printStackTrace();
            } catch (IOException e) {
                e.printStackTrace();
            }
        } else {
            String name = request.getParameter("Name");
            String address = request.getParameter("Address");
            String telephone = request.getParameter("Telephone");
            int villeId = Integer.parseInt(request.getParameter("VilleId"));
            Ville selectedVille = villeDao.findById(villeId);


            Hotel newHotel = new Hotel(name, address, telephone,selectedVille);
            

            if (hotelDao.create(newHotel)) {
                List<Hotel> hotelList = hotelDao.findAll();
                System.out.println("====> liste : " + hotelList);
                request.setAttribute("Hotels", hotelList);
                request.getRequestDispatcher("/ListHotels.jsp").forward(request, response);
            } else {
                System.out.println("Failure: Hotel not created.");
            }
        }
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Hotel existingHotel = hotelDao.findById(id);
        RequestDispatcher dispatcher = request.getRequestDispatcher("editField.jsp");
        request.setAttribute("Hotel", existingHotel);
        dispatcher.forward(request, response);
    }
}
