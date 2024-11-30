package com.ASS.dao;

import com.ASS.interfaces.BaseDAO;
import com.ASS.interfaces.FavoritesInterface;
import com.ASS.model.Favorites;
import com.ASS.utils.JpaUtils;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;

import java.util.List;

public class FavoritesDAO implements BaseDAO<Favorites,Long>, FavoritesInterface {

	@Override
	public List<Favorites> getAll() {
		EntityManager em = JpaUtils.getEntityManager();
        TypedQuery<Favorites> query = em.createQuery("SELECT f FROM Favorites f", Favorites.class);
        return query.getResultList();
	}

	@Override
	public Favorites getById(Long id) {
		EntityManager em = JpaUtils.getEntityManager();
        Favorites favorites = em.find(Favorites.class, id);
        return favorites;
	}

	@Override
	public void create(Favorites entity) {
		EntityManager em = JpaUtils.getEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(entity);
            em.getTransaction().commit();
        }catch(Exception e) {
            em.getTransaction().rollback();
            throw e;
        }finally{
            em.close();
        }
	}

	@Override
	public void update(Favorites entity) {
		 EntityManager em = JpaUtils.getEntityManager();
	        try {
	            em.getTransaction().begin();
	            em.merge(entity);
	            em.getTransaction().commit();
	        }catch (Exception e) {
	            em.getTransaction().rollback();
	            throw e;
	        }finally{
	            em.close();
	        }
	}

	@Override
	public void delete(Long Id) {
		 EntityManager em = JpaUtils.getEntityManager();
	        try {
	            em.getTransaction().begin();
	            Favorites favorites = em.find(Favorites.class, Id);
	            em.remove(favorites);
				em.getTransaction().commit();
	        }catch (Exception e) {
				System.out.println("KHONG XOA DUOC");
	            em.getTransaction().rollback();
	            throw e;
	        }finally {
	            em.close();
	        }
	    }

	@Override
	public Favorites getFavByUserLiked(String uId, String vId) {
		String jpql = "SELECT f FROM Favorites f WHERE f.user.id = :uId AND f.video.id = :vId";
		EntityManager em = JpaUtils.getEntityManager();
		TypedQuery<Favorites> query = em.createQuery(jpql, Favorites.class);
		query.setParameter("uId", uId);
		query.setParameter("vId", vId);
		if(query.getResultList().isEmpty()){
			return null;
		}else{
			return query.getSingleResult();
		}
	}


}
