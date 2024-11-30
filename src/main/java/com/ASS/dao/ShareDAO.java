package com.ASS.dao;

import com.ASS.DTO.VideoShareInfoDTO;
import com.ASS.interfaces.BaseDAO;
import com.ASS.model.Share;
import com.ASS.utils.JpaUtils;
import jakarta.persistence.EntityManager;
import jakarta.persistence.StoredProcedureQuery;
import jakarta.persistence.TypedQuery;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class ShareDAO implements BaseDAO<Share, String> {
    @Override
    public List<Share> getAll() {
        EntityManager em = JpaUtils.getEntityManager();
        String jpql = "SELECT s FROM Share s";
        TypedQuery<Share> query = em.createQuery(jpql, Share.class);
        return query.getResultList();
    }

    @Override
    public Share getById(String id) {
        EntityManager em = JpaUtils.getEntityManager();
        Share share = em.find(Share.class, id);
        return share;
    }

    @Override
    public void create(Share entity) {
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
    public void update(Share entity) {
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
            Share share = em.find(Share.class, id);
            em.remove(share);
            em.getTransaction().begin();
        } catch (Exception e) {
            em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    public List<VideoShareInfoDTO> getShareInfo() {
        EntityManager em = JpaUtils.getEntityManager();
        StoredProcedureQuery query = em.createStoredProcedureQuery("GetShareInfoForVideos");
        List<Object[]> results = query.getResultList();
        List<VideoShareInfoDTO> videoShareInfoList = new ArrayList<>();
        for (Object[] result : results) {
            String videoTitle = (String) result[0];
            long shareCount = ((Number) result[1]).longValue();
            Date firstShareDate = (Date) result[2];
            Date lastShareDate = (Date) result[3];
            
            VideoShareInfoDTO videoShareInfo = new VideoShareInfoDTO(videoTitle, shareCount, firstShareDate, lastShareDate);
            videoShareInfoList.add(videoShareInfo);
        }
        return videoShareInfoList;
    }

}
