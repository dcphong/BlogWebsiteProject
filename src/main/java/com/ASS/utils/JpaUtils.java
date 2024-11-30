package com.ASS.utils;

import com.ASS.model.Users;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.persistence.TypedQuery;

import java.util.List;

public class JpaUtils {
    public static EntityManager getEntityManager() {
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("SOF3012_ASS");

        return emf.createEntityManager();
    }
}
