package com.ASS.controller;

import com.ASS.DTO.VideoShareInfoDTO;
import com.ASS.dao.FavoritesDAO;
import com.ASS.dao.ShareDAO;
import com.ASS.dao.UsersDAO;
import com.ASS.dao.VideosDAO;
import com.ASS.model.Users;
import com.ASS.model.Videos;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = {"/Admin/Home", "/Admin/user", "/Admin/statistics", "/Admin/adminSite"})
public class AdminController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String url = req.getServletPath();
        UsersDAO udao = new UsersDAO();
        VideosDAO vdao = new VideosDAO();
        ShareDAO sdao = new ShareDAO();
        FavoritesDAO fdao = new FavoritesDAO();


        if (url.equals("/Admin/Home")) {
            List<Videos> list = vdao.getVideosByPageNumber(0, 8);
            int pageNumber = vdao.getPageNumbersSize(vdao.getAll().size());

            req.setAttribute("pageNumbers", pageNumber);
            req.setAttribute("videoList", list);
            req.getRequestDispatcher("/views/admin/index.jsp").forward(req, resp);
            return;
        }
        if (url.equals("/Admin/user")) {
            List<Users> list = udao.getByPageSize(0, 8);

            req.setAttribute("userList", list);
            req.getRequestDispatcher("/views/admin/Users.jsp").forward(req, resp);
            return;
        }
        if (url.equals("/Admin/statistics")) {
            List<VideoShareInfoDTO> totalList = sdao.getShareInfo();
            List<Videos> noOneLikeList = vdao.getVideoNoOneLiked();
            List<Videos> top10List = vdao.getTop10VideoList();

            req.setAttribute("top10List", top10List);
            req.setAttribute("noOneLikeList", noOneLikeList);
            req.setAttribute("totalList", totalList);
            req.getRequestDispatcher("/views/admin/statistics.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doPost(req, resp);
    }
}
