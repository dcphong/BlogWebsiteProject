package com.ASS.interfaces;

import com.ASS.model.Users;

import java.util.List;

public interface UserInterface {
    List<Users> getNextVideos(int amount);

    Users getByName(String name);

    List<Users> getByPageSize(int currentPage, int pageSize);

    int getPagesNumber(int firstPages, int elementsNum);

    Users getByEmail(String email);

    void likeVideo(String uId, String vId);

    Users getByIdOrEmail(String IdOrEmail);
}
