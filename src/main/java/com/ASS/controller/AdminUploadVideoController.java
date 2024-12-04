package com.ASS.controller;


import com.ASS.dao.VideosDAO;
import com.ASS.model.Videos;
import com.ASS.utils.RestIoUtils;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.nio.file.Path;
import java.util.HashMap;
import java.util.Map;

@WebServlet(urlPatterns = {"/admin/edit"})
public class AdminUploadVideoController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        Videos video = new Videos();
        VideosDAO dao = new VideosDAO();

        String url = req.getServletPath();

        if (url.equals("/admin/edit")) {
            String id = req.getParameter("id");

            video = dao.getById(id);
            if (video != null) {
                System.out.println(video);
                RestIoUtils.writeObject(resp, video);
            } else {
                RestIoUtils.writeJson(resp, "{\"status\":\"error\",\"message\":\"Loi khong tim thay doi tuong\"}");
            }
        }
    }


}
