package services;

import java.util.List;

import dao.IDao;
import dao.VilleIDAO;
import entities.Ville;
import jakarta.annotation.security.PermitAll;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;


@Stateless(name="kenza")
public class VilleService implements IDao<Ville>, VilleIDAO {

	@PersistenceContext
	private EntityManager em;
	
	
	@Override
	@PermitAll
	public boolean create(Ville o) {
		em.persist(o);
		return true;
	}

	@Override
	@PermitAll
	public boolean update(Ville o) {
		try {
	        em.merge(o);
	        return true;
	    } catch (Exception e) {
	        e.printStackTrace();
	        return false;
	    }
	}

	@Override
	@PermitAll
	public boolean delete(Ville o) {
		em.remove(em.contains(o) ? o: em.merge(o));
		return true;
	}

	@Override
	@PermitAll
	public Ville findById(int id) {
		return em.find(Ville.class, id);
	}

	@Override
	@PermitAll
	public List<Ville> findAll() {
		
		jakarta.persistence.Query query = em.createQuery("select r from Ville r");
		return query.getResultList();		
	}

	

	
	

}