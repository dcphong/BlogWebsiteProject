package com.ASS.controller;

import com.ASS.dao.VideosDAO;
import com.ASS.model.Videos;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet("/admin/video/pagination")
public class AdminPaginationController extends HttpServlet {
    private static final int PAGE_SIZE = 8;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = request.getServletPath();
        VideosDAO dao = new VideosDAO();

        if (url.equals("/admin/video/pagination")) {
            String value = request.getParameter("value");
            Integer page = Integer.valueOf(value) - 1;
            System.out.println((page * 8));
            List<Videos> vList = dao.getVideosByPageNumber((page * 8), 8);
            request.setAttribute("vList", vList);

            ServletContext context = request.getServletContext();
            context.setAttribute("currentPage", page);

            try (PrintWriter out = response.getWriter()) {
                for (Videos video : vList) {
                    String active = video.isActive() ? "Video hoat dong" : "Da an video";
                    out.println("<tr>\n" +
                            "                            <td>" + video.getId() + "</td>\n" +
                            "                            <td>" + video.getTitle() + "</td>\n" +
                            "                            <td>" + video.getViews() + "</td>\n" +
                            "                            <td>" + active + "</td>\n" +
                            "                            <td>\n" +
                            "                                <button name=\"buttonEditVideoId\" value=\"" + video.getId() + "\" class=\"btn btn-sm btn-info\">Chỉnh\n" +
                            "                                    sửa\n" +
                            "                                </button>\n" +
                            "                            </td>\n" +
                            "                        </tr>");
                }
            }
        }
    }
}
