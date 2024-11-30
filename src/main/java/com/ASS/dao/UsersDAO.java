package com.ASS.dao;


import com.ASS.interfaces.BaseDAO;
import com.ASS.interfaces.UserInterface;
import com.ASS.model.Favorites;
import com.ASS.model.Users;
import com.ASS.model.Videos;
import com.ASS.utils.JpaUtils;
import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
import jakarta.persistence.Query;
import jakarta.persistence.TypedQuery;

import java.util.ArrayList;
import java.util.List;

public class UsersDAO implements BaseDAO<Users, String>, UserInterface {

    @Override
    public void create(Users entity) {
        EntityManager em = JpaUtils.getEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(entity);
            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }

    }

    @Override
    public List<Users> getAll() {
        EntityManager em = JpaUtils.getEntityManager();
        String jpql = "SELECT u FROM Users u";
        TypedQuery<Users> query = em.createQuery(jpql, Users.class);

        return query.getResultList();
    }

    @Override
    public Users getById(String id) {
        EntityManager em = JpaUtils.getEntityManager();
        String jpql = "SELECT u FROM Users u WHERE u.id = :id";
        TypedQuery<Users> query = em.createQuery(jpql, Users.class);
        query.setParameter("id", id);
        List<Users> list = query.getResultList();
        return list.isEmpty() ? null : list.get(0);
    }

    @Override
    public Users getByName(String name) {
        EntityManager em = JpaUtils.getEntityManager();
        String jpql = "SELECT u FROM Users u WHERE u.fullname LIKE :name AND u.email LIKE :email AND u.admin = :role";
        TypedQuery<Users> query = em.createQuery(jpql, Users.class);
        query.setParameter("name", "%" + name);
        query.setParameter("email", "%@fpt.edu.vn");
        query.setParameter("role", false);
        Users u = new Users();
        try {
            u = query.getSingleResult();
        } catch (Exception e) {
            return null;
        }
        return u;
    }

    @Override
    public void update(Users entity) {
        EntityManager em = JpaUtils.getEntityManager();
        try {
            em.getTransaction().begin();
            em.merge(entity);
            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    @Override
    public void delete(String id) {
        EntityManager em = JpaUtils.getEntityManager();
        try {
            em.getTransaction().begin();
            Users u = em.find(Users.class, id);
            if (u != null) {
                em.remove(u);
                em.getTransaction().commit();
                System.out.println("Xoa user voi id: " + id);
            } else {
                em.getTransaction().rollback();
            }
        } catch (Exception e) {
            em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    @Override
    public List<Users> getByPageSize(int currentPage, int pageSize) {
        EntityManager em = JpaUtils.getEntityManager();
        String jpql = "SELECT u FROM Users u";
        TypedQuery<Users> query = em.createQuery(jpql, Users.class);
        query.setFirstResult(currentPage);
        query.setMaxResults(pageSize);

        return query.getResultList();
    }

    @Override
    public int getPagesNumber(int firstPages, int elementsNum) {
        int n = 0;
        if (elementsNum % firstPages == 0) {
            n = elementsNum / firstPages;
        } else {
            n = (elementsNum / firstPages) + 1;
        }
        return n;
    }

    @Override
    public List<Users> getNextVideos(int amount) {
        EntityManager em = JpaUtils.getEntityManager();
        List<Users> list = new ArrayList<>();
        String jpql = "SElECT u FROM Users u ORDER BY u.id OFFSET :amount ROWS FETCH NEXT 8 ROWS ONLY";
        TypedQuery<Users> query = em.createQuery(jpql, Users.class);
        query.setParameter("amount", amount);
        return list;
    }

    @Override
    public Users getByEmail(String email) {
        EntityManager em = JpaUtils.getEntityManager();
        String jpql = "SELECT u FROM Users u WHERE u.email = :email";
        TypedQuery<Users> query = em.createQuery(jpql, Users.class);
        query.setParameter("email", email);
        try {
            Users u = query.getSingleResult();
            return u;
        } catch (NoResultException e) {
            return null;
        }
    }


    @Override
    public void likeVideo(String uId, String vId) {
        Users u = getById(uId);
        VideosDAO vdao = new VideosDAO();
        Videos v = vdao.getById(vId);

        FavoritesDAO fdao = new FavoritesDAO();
        boolean alreadyLike = u.getFavorites().stream().anyMatch(fav -> fav.getVideo().getId().equals(vId));
        EntityManager em = JpaUtils.getEntityManager();

        if (alreadyLike) {
            Favorites favoritesToRemove = u.getFavorites().stream().filter(fav -> fav.getVideo().getId().equals(vId)).findFirst().orElse(null);
            if (favoritesToRemove != null) {
                fdao.delete(favoritesToRemove.getId());
                u.getFavorites().remove(favoritesToRemove);
            }
        } else {
            Favorites fav = new Favorites();
            fav.setVideo(v);
            fav.setUser(u);

            fdao.create(fav);
            u.getFavorites().add(fav);
        }
    }

    @Override
    public Users getByIdOrEmail(String IdOrEmail) {
        EntityManager em = JpaUtils.getEntityManager();
        String jpql = "SELECT u FROM Users u WHERE u.id = :IdOrEmail OR u.email = :IdOrEmail";
        TypedQuery<Users> query = em.createQuery(jpql, Users.class);
        query.setParameter("IdOrEmail", IdOrEmail);
        Users u = new Users();
        try {
            u = query.getSingleResult();
        } catch (NoResultException e) {
            return null;
        }
        return u;
    }

}

