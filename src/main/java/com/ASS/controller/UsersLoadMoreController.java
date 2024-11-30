package com.ASS.controller;

import com.ASS.dao.VideosDAO;
import com.ASS.model.Videos;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

@WebServlet(urlPatterns = {"/UserHome/pagination", "/UserHome/paginationButton", "/loadVideosDetails"})
public class UsersLoadMoreController extends HttpServlet {
    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = request.getServletPath();
        VideosDAO dao = new VideosDAO();

        if (url.equals("/UserHome/pagination")) {
            String value = request.getParameter("value");
            Integer page = Integer.valueOf(value) - 1;
            System.out.println((page * 8));
            List<Videos> vList = dao.getVideosByPageNumber((page * 8), 8);
            request.setAttribute("vList", vList);

            ServletContext context = request.getServletContext();
            context.setAttribute("currentPage", page);

            try (PrintWriter out = response.getWriter()) {
                for (Videos video : vList) {
                    out.println("<div class=\"col videoList mb-md-2 mb-5\" style=\"height: 250px\">" +
                            "<a href=\"/videoDetails?vId=" + video.getId() + "\" class=\"link-ytb\">" +
                            "<div class=\"card border-0 bg-ytb\">" +
                            "<img src=\"/images/" + video.getPoster() + "\" class=\"card-img-top bg-ytb rounded-3\" alt=\"...\">" +
                            "<div class=\"card-body bg-ytb\">" +
                            "<p class=\"card-text text-light\">" + video.getTitle() +
                            "<i class=\"bi bi-eye float-end fst-normal\">" + video.getViews() + "</i></p>" +
                            "</div></div></a></div>");
                }
            }
        }

        if (url.equals("/UserHome/paginationButton")) {
            String value = request.getParameter("paginationButton");
            System.out.println(value);
            List<Videos> vList = new ArrayList<>();
            if (value.equals("firstPage")) {
                vList = dao.getVideosByPageNumber(0, 8);
            }
            if (value.equals("lastPage")) {
                vList = dao.getVideosByPageNumber((dao.getAll().size() - 8), 8);
            }
            if (value.equals("nextPage")) {
                String currentPageString = request.getParameter("currentPage");
                int currentPage = (currentPageString != null && !currentPageString.isEmpty()) ? Integer.parseInt(currentPageString) : 0;
                int nextPage = (currentPage + 1) * 8;  // Trang tiếp theo
                vList = dao.getVideosByPageNumber(nextPage, 8);
            }

            if (value.equals("previousPage")) {
                String currentPageString = request.getParameter("currentPage");
                int currentPage = (currentPageString != null && !currentPageString.isEmpty()) ? Integer.parseInt(currentPageString) : 0;
                int previousPage = (currentPage - 1) * 8;  // Trang trước
                vList = dao.getVideosByPageNumber(previousPage, 8);
            }


            try (PrintWriter out = response.getWriter()) {
                for (Videos video : vList) {
                    out.println("<div class=\"col videoList mb-md-2 mb-5\" style=\"height: 250px\">" +
                            "<a href=\"/videoDetails?vId=" + video.getId() + "\" class=\"link-ytb\">" +
                            "<div class=\"card border-0 bg-ytb\">" +
                            "<img src=\"/images/" + video.getPoster() + "\" class=\"card-img-top bg-ytb rounded-3\" alt=\"...\">" +
                            "<div class=\"card-body bg-ytb\">" +
                            "<p class=\"card-text text-light\">" + video.getTitle() +
                            "<i class=\"bi bi-eye float-end fst-normal\"> " + video.getViews() + "</i></p>" +
                            "</div></div></a></div>");
                }
            }
        }

        if (url.equals("/loadVideosDetails")) {
            String amount = request.getParameter("detailsAjax");
            List<Videos> listDetails = dao.getNextVideosList(Integer.parseInt(amount));
            listDetails.forEach(videoDetail -> {
                try {
                    PrintWriter out = response.getWriter();
                    out.println("<c:url value=\"/videoDetails?vId=${video.id}\" var=\"vId\"/>\n" +
                            "    <a href=\"/videoDetails?vId=" + videoDetail.getId() + "\" class=\"link-ytb\">\n" +
                            "          <div class=\"row videoList\" style=\"height: 150px;\">\n" +
                            "            <div class=\"col-6\">\n" +
                            "              <img src=\"/images/" + videoDetail.getPoster() + "\" class=\"rounded-3 w-100 object-fit\" alt=\"\">\n" +
                            "            </div>\n" +
                            "            <div class=\"col-6 text-light\">\n" +
                            "              <h5>" + videoDetail.getTitle() + "</h5>\n" +
                            "              <p>" + videoDetail.getDescription() + "</p>\n" +
                            "            </div>\n" +
                            "          </div>\n" +
                            "        </a>");
                } catch (IOException e) {
                    e.printStackTrace();
                }
            });
        }
    }
}
