package com.ASS.dao;

import com.ASS.interfaces.BaseDAO;
import com.ASS.interfaces.VideoInterface;
import com.ASS.model.Users;
import com.ASS.model.Videos;
import com.ASS.utils.JpaUtils;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;

import java.util.List;

public class VideosDAO implements BaseDAO<Videos, String>, VideoInterface {

    @Override
    public List<Videos> getAll() {
        EntityManager em = JpaUtils.getEntityManager();
        String jpql = "SELECT v FROM Videos v";
        TypedQuery<Videos> query = em.createQuery(jpql, Videos.class);
        return query.getResultList();
    }

    @Override
    public Videos getById(String id) {
        EntityManager em = JpaUtils.getEntityManager();
        String jpql = "SELECT v FROM Videos v WHERE v.id = :id";
        TypedQuery<Videos> query = em.createQuery(jpql, Videos.class);
        query.setParameter("id", id);
        List<Videos> list = query.getResultList();
        return list.isEmpty() ? null : list.get(0);
    }

    @Override
    public void create(Videos entity) {
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
    public void update(Videos entity) {
        EntityManager em = JpaUtils.getEntityManager();
        try {
            em.getTransaction().begin();

            Videos u = em.find(Videos.class, entity.getId());

            if (u != null) {
                u.setId(entity.getId());
                u.setTitle(entity.getTitle());
                u.setDescription(entity.getDescription());
                u.setActive(entity.isActive());
                u.setViews(entity.getViews());
                u.setPoster(entity.getPoster());
                em.merge(u);
                em.getTransaction().commit();
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
    public void delete(String id) {
        EntityManager em = JpaUtils.getEntityManager();
        try {
            em.getTransaction().begin();
            Videos video = em.find(Videos.class, id);
            em.remove(video);
            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
            e.printStackTrace();
            throw e;
        } finally {
            em.close();
        }
    }

    @Override
    public List<Videos> getVideosByPageNumber(int currentPage, int pageSize) {
        EntityManager em = JpaUtils.getEntityManager();
        String jpql = "SELECT v FROM Videos v";
        TypedQuery<Videos> query = em.createQuery(jpql, Videos.class);
        query.setFirstResult(currentPage);
        query.setMaxResults(pageSize);
        return query.getResultList();
    }


    @Override
    public int getPageNumbersSize(int elementsNumber) {
        int n = 0;
        if (elementsNumber % 8 == 0) {
            n = elementsNumber / 8;
        } else {
            n = elementsNumber / 8 + 1;
        }
        return n;
    }

    @Override
    public List<Videos> getNextVideosList(int amount) {
        EntityManager em = JpaUtils.getEntityManager();
        String jpql = "SELECT v FROM Videos v ORDER BY v.id OFFSET :amount ROWS FETCH NEXT 8 ROWS ONLY";
        TypedQuery<Videos> query = em.createQuery(jpql, Videos.class);
        query.setParameter("amount", amount);
        return query.getResultList();
    }

    @Override
    public List<String> getSuggestionVideo(String title) {
        EntityManager em = JpaUtils.getEntityManager();
        String jpql = "SELECT v.title FROM Videos v WHERE v.title LIKE :title";
        TypedQuery<String> query = em.createQuery(jpql, String.class);
        query.setParameter("title", "%" + title + "%");
        return query.getResultList();
    }

    @Override
    public List<Videos> getListVideoByTitle(String title) {
        EntityManager em = JpaUtils.getEntityManager();
        String jpql = "SELECT v FROM Videos v WHERE v.title LIKE :title";
        TypedQuery<Videos> query = em.createQuery(jpql, Videos.class);
        query.setParameter("title", "%" + title + "%");
        return query.getResultList();
    }

    @Override
    public List<Videos> getTop10VideoList() {
        EntityManager em = JpaUtils.getEntityManager();
        String jpql = "SELECT  v FROM Videos v ORDER BY v.views DESC";
        TypedQuery<Videos> query = em.createQuery(jpql, Videos.class).setMaxResults(10);
        return query.getResultList();
    }

    @Override
    public List<Videos> getVideoNoOneLiked() {
        EntityManager em = JpaUtils.getEntityManager();
        String jpql = "SELECT v FROM Videos v LEFT JOIN Favorites f ON v.id = f.video.id WHERE f.id IS NULL";
        TypedQuery<Videos> query = em.createQuery(jpql, Videos.class);
        return query.getResultList();
    }

    @Override
    public List<Videos> getVideoIn2024() {
        EntityManager em = JpaUtils.getEntityManager();
        String jpql = "SELECT s.video FROM Share s WHERE YEAR(s.shareDate) = 2024 ORDER BY s.shareDate DESC";
        TypedQuery<Videos> query = em.createQuery(jpql, Videos.class);
        List<Videos> results = query.getResultList();
        return results.stream().distinct().toList();
    }


}
