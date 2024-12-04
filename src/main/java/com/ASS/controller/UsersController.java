package com.ASS.controller;

import com.ASS.dao.FavoritesDAO;
import com.ASS.dao.UsersDAO;
import com.ASS.dao.VideosDAO;
import com.ASS.model.Favorites;
import com.ASS.model.Users;
import com.ASS.model.Videos;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.apache.commons.beanutils.BeanUtils;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(urlPatterns = {"/UserHome", "/videoDetails", "/UserFavorites", "/UserHome/profiles", "/UserHome/logout", "/videoDetails/like"})
public class UsersController extends HttpServlet {

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String url = request.getServletPath();
        System.out.println("URL : " + url);

        Users user = new Users();
        UsersDAO uDao = new UsersDAO();
        List<Users> uList = new ArrayList<Users>();

        Videos video = new Videos();
        VideosDAO vDao = new VideosDAO();
        List<Videos> vList = vDao.getVideosByPageNumber(0, 8);
        int pageNumber = vDao.getPageNumbersSize(vDao.getAll().size());

        Favorites favorite = new Favorites();
        FavoritesDAO fDao = new FavoritesDAO();
        List<Favorites> fList = new ArrayList<>();

        if (url.equals("/UserHome/logout")) {
            request.getSession().removeAttribute("user");
            response.sendRedirect(request.getContextPath() + "/UserHome");
            return;
        }

        Users userLogin = (Users) request.getSession().getAttribute("user");
        if (userLogin != null) {
            request.setAttribute("userLogin", userLogin);
            request.setAttribute("isLogin", "true");
        }

        if (url.equals("/UserHome")) {
            request.setAttribute("vList", vList);
            request.setAttribute("pageNumbers", pageNumber);
            request.setAttribute("vList", vList);
            request.getRequestDispatcher("/views/clients/index.jsp").forward(request, response);
        }
        if (url.equals("/videoDetails")) {
            String vId = request.getParameter("vId");
            video = vDao.getById(vId);
            int like = video.getFavorites().size();
            int newLike = video.getViews() + 1;
            video.setViews(newLike);
            vDao.update(video);

            if (userLogin != null) {
                favorite = fDao.getFavByUserLiked(userLogin.getId(), vId);
                if (favorite != null) {
                    request.setAttribute("userIsLiked", true);
                }
            }

            request.setAttribute("vList", vDao.getAll());
            request.setAttribute("like", like);
            request.setAttribute("videoDetails", video);
            request.getRequestDispatcher("/views/clients/details.jsp").forward(request, response);
            return;
        }
        if (url.equals("/UserFavorites")) {
            String isLogin = request.getParameter("isLogin");
            user = uDao.getById(userLogin.getId());
            fList = user.getFavorites();
            request.setAttribute("fList", fList);
            request.getRequestDispatcher("/views/clients/favorites.jsp").forward(request, response);
        }
    }
}
