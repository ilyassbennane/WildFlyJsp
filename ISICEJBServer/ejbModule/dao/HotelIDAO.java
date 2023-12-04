package dao;

import entities.Hotel;
import entities.Ville;

import java.util.List;

import jakarta.ejb.Local;


@Local
public interface HotelIDAO extends IDaoLocale<Hotel>{
	public List<Hotel> findByVille(Ville ville);


}
