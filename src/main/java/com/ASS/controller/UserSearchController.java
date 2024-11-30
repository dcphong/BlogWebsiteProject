package com.ASS.controller;

import com.ASS.dao.VideosDAO;
import com.ASS.model.Videos;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet(urlPatterns = {"/UserHome/findSuggestions","/UserHome/Search"})
public class UserSearchController extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String url = req.getServletPath();
        VideosDAO vDao = new VideosDAO();

        if(url.equals("/UserHome/Search")){
            resp.setContentType("text/html;charset=UTF-8");
            String valueSearch = req.getParameter("value");
            System.out.println("VALUE SEARCH :"+valueSearch);
            List<Videos> listVideoSearch = vDao.getListVideoByTitle(valueSearch);
            listVideoSearch.forEach(video -> {
                try {
                    resp.getWriter().println("<div class=\"col videoList mb-md-2 mb-5\" style=\"height: 250px\">\n" +
                            "                                <a href=\"/videoDetails?vId="+video.getId()+"\" class=\"link-ytb\">\n" +
                            "                                    <div class=\"card border-0 bg-ytb\">\n" +
                            "                                        <img src=\"/images/"+video.getPoster()+"\" class=\"card-img-top bg-ytb rounded-3\" alt=\"...\">\n" +
                            "                                        <div class=\"card-body bg-ytb\">\n" +
                            "                                            <p class=\"card-text text-light\">\n" +
                            "                                                "+video.getTitle()+"\n" +
                            "                                                <i class=\"bi bi-eye float-end fst-normal\"> "+video.getViews()+"</i>\n" +
                            "                                            </p>\n" +
                            "                                        </div>\n" +
                            "                                    </div>\n" +
                            "                                </a>\n" +
                            "                            </div>");
                }catch (Exception e){
                    e.printStackTrace();
                }
            });
            resp.getWriter().close();
        }else{
            resp.setContentType("application/json");
            resp.setCharacterEncoding("UTF-8");
            String keyWord = req.getParameter("valueSearch");
            List<String> suggestions = vDao.getSuggestionVideo(keyWord);
            StringBuilder jsonResponse = new StringBuilder();
            jsonResponse.append("{\"suggestions\": [");
            for (int i = 0; i < suggestions.size(); i++) {
                jsonResponse.append("\"").append(suggestions.get(i)).append("\"");
                if (i < suggestions.size() - 1) {
                    jsonResponse.append(", ");
                }
            }
            jsonResponse.append("]}");
            resp.getWriter().write(jsonResponse.toString());
        }
    }
}
