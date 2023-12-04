package dao;

import java.util.List;


import jakarta.ejb.Remote;

@Remote
public interface IDao <T> {
	
	boolean create(T o);
	boolean update(T o);
	boolean delete(T o);
	T findById(int id);
	List<T> findAll();
}