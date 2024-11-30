package com.ASS.interfaces;

import java.util.List;
public interface BaseDAO<T,K> {
    List<T>  getAll();
    T getById(K id);
    void create(T entity);
    void update(T entity);
    void delete(K Id);
}
