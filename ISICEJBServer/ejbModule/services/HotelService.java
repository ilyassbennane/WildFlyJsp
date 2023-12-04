package services;

import java.util.List;


import dao.IDao;
import dao.HotelIDAO;
import entities.Hotel;
import entities.Ville;
import jakarta.annotation.security.PermitAll;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.Query;

@Stateless(name = "hotelService")
public class HotelService implements IDao<Hotel>, HotelIDAO {

    @PersistenceContext
    private EntityManager em;

    @Override
    @PermitAll
    public boolean create(Hotel o) {
        em.persist(o);
        return true;
    }

    @Override
    @PermitAll
    public boolean update(Hotel o) {
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
    public boolean delete(Hotel o) {
        em.remove(em.contains(o) ? o : em.merge(o));
        return true;
    }

    @Override
    @PermitAll
    public Hotel findById(int id) {
        return em.find(Hotel.class, id);
    }

    @Override
    @PermitAll
    public List<Hotel> findAll() {
        jakarta.persistence.Query query = em.createQuery("select h from Hotel h");
        return query.getResultList();
    }
    

	@Override
	@PermitAll
	public List<Hotel> findByVille(Ville ville) {
	    Query query = em.createQuery("SELECT h FROM Hotel h WHERE h.ville = :villeParam");
	    query.setParameter("villeParam", ville);
	    return query.getResultList();
	}

}
