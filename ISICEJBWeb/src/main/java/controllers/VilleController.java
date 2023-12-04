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
 

import dao.IDaoLocale;
import dao.VilleIDAO;

import entities.Ville;

@WebServlet("/FiliereController")
public class VilleController extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@EJB
	VilleIDAO rdao;


    public VilleController() {
        super();
    }
 
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		List<Ville> VilleList = rdao.findAll();	
		System.out.println("=====> liste : "+VilleList);
		request.setAttribute("Villes", VilleList);
		request.getRequestDispatcher("/ListVilles.jsp").forward(request, response);
	}	
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    
		String action = request.getParameter("action");
		if ("delete".equals(action)) {
		    int VilleId = Integer.parseInt(request.getParameter("id"));
		    if(rdao.findById(VilleId)!=null) {
		    	Ville Villedelete =  rdao.findById(VilleId);
		        boolean updated = rdao.update(Villedelete);
		        if (updated) {
		            rdao.delete(Villedelete);
		            boolean deleted = true;
		            if (deleted) {
		            	List<Ville> VilleList = rdao.findAll();	
						System.out.println("====> liste : "+VilleList);
						request.setAttribute("Villes", VilleList);
						request.getRequestDispatcher("/ListVilles.jsp").forward(request, response);
		            } else {
		                response.sendRedirect(request.getContextPath() + "/VilleController?deleteFailed=true");
		            }
		        }
		    }
		}

		else if("edit".equals(action)) {
	        int id = Integer.parseInt(request.getParameter("id"));
	        String name = request.getParameter("Name");
	        Ville VilleToEdit = rdao.findById(id);
	        if (VilleToEdit != null) {
	        	VilleToEdit.setNom(name);
	            rdao.update(VilleToEdit);
	        }
	        response.sendRedirect(request.getContextPath() + "/VilleController");
	    }
		else if("showform".equals(action)) {
			try {
				showEditForm(request, response);
			} catch (SQLException e) {
				e.printStackTrace();
			} catch (ServletException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	
		else {
	    String name = request.getParameter("Name");
	    Ville newVille = new Ville(name);
		    if (rdao.create(newVille)) {
		    	List<Ville> VilleList = rdao.findAll();	
				System.out.println("====> liste : "+VilleList);
				request.setAttribute("Villes", VilleList);
				request.getRequestDispatcher("/ListVilles.jsp").forward(request, response);
		    } else {
		    	System.out.println("Failure: Ville not created.");
		    }
	    }
	}
	 
	private void showEditForm(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
		int id = Integer.parseInt(request.getParameter("id"));
		Ville existingVille = rdao.findById(id);
		RequestDispatcher dispatcher = request.getRequestDispatcher("editField.jsp");
		request.setAttribute("Ville", existingVille);
		dispatcher.forward(request, response);
	
	}
}