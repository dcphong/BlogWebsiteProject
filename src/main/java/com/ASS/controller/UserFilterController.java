package com.ASS.controller;

import com.ASS.dao.VideosDAO;
import com.ASS.model.Videos;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = {"/UserHome/filterTop10"})
public class UserFilterController extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String url = req.getServletPath();
        VideosDAO vdao = new VideosDAO();
        if (url.equals("/UserHome/filterTop10")) {
            resp.setContentType("text/html;charset=UTF-8");
            List<Videos> listTop10 = vdao.getTop10VideoList();
            listTop10.forEach(video -> {
                try {
                    resp.getWriter().println("<div class=\"col videoList mb-md-2 mb-5\" style=\"height: 250px\">\n" +
                            "                                <a href=\"/videoDetails?vId=" + video.getId() + "\" class=\"link-ytb\">\n" +
                            "                                    <div class=\"card border-0 bg-ytb\">\n" +
                            "                                        <img src=\"/images/" + video.getPoster() + "\" class=\"card-img-top bg-ytb rounded-3\" alt=\"...\">\n" +
                            "                                        <div class=\"card-body bg-ytb\">\n" +
                            "                                            <p class=\"card-text text-light\">\n" +
                            "                                                " + video.getTitle() + "\n" +
                            "                                                <i class=\"bi bi-eye float-end fst-normal\"> " + video.getViews() + "</i>\n" +
                            "                                            </p>\n" +
                            "                                        </div>\n" +
                            "                                    </div>\n" +
                            "                                </a>\n" +
                            "                            </div>");
                } catch (Exception e) {
                    e.printStackTrace();
                }
            });
        }
    }
}
