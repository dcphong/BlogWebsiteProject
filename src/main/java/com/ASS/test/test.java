package com.ASS.test;

import com.ASS.DTO.VideoShareInfoDTO;
import com.ASS.dao.ShareDAO;
import com.ASS.dao.UsersDAO;
import com.ASS.dao.VideosDAO;
import com.ASS.model.Users;
import com.ASS.model.Videos;

import java.sql.SQLOutput;
import java.util.ArrayList;
import java.util.List;

public class test {
    public static void main(String[] args) {
//        Users u = new Users();
//        UsersDAO dao = new UsersDAO();
//        u = dao.getByIdOrEmail("U004");
//        System.out.println(u.toString());
//
//        Videos video = new Videos();
//        VideosDAO vDao = new VideosDAO();
//        List<Videos> vlit = vDao.getTop10VideoList();
//        vlit.forEach(System.out::println);

//        vlit = vDao.getVideoNoOneLiked();
//        vlit.forEach(System.out::println);

//
//        vlit = vDao.getVideoIn2024();
//        vlit.forEach(System.out::println);

        ShareDAO sDao = new ShareDAO();
        List<VideoShareInfoDTO> oList = sDao.getShareInfo();
        oList.forEach(System.out::println);
    }
}
