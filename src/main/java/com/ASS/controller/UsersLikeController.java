package com.ASS.controller;

import com.ASS.dao.FavoritesDAO;
import com.ASS.dao.ShareDAO;
import com.ASS.dao.UsersDAO;
import com.ASS.dao.VideosDAO;
import com.ASS.model.Favorites;
import com.ASS.model.Share;
import com.ASS.model.Users;
import com.ASS.model.Videos;
import com.ASS.utils.SendMailUtils;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.Date;

@WebServlet(urlPatterns = {"/UserHome/like", "/UserHome/share"})
public class UsersLikeController extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String userId = req.getParameter("uId");
        String videoId = req.getParameter("vId");
        String url = req.getServletPath();
        VideosDAO vDao = new VideosDAO();
        UsersDAO uDao = new UsersDAO();
        ShareDAO sDao = new ShareDAO();

        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        if (url.equals("/UserHome/like")) {
            if (userId == null || videoId == null) {
                resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                resp.getWriter().print("{\"error\":\"Missing userId or videoId\"}");
                return;
            }

            Users user = new Users();
            user.setId(userId);

            Videos video = vDao.getById(videoId);

            if (video == null) {
                resp.setStatus(HttpServletResponse.SC_NOT_FOUND);
                resp.getWriter().print("{\"error\":\"Video not found\"}");
                return;
            }

            FavoritesDAO dao = new FavoritesDAO();
            Favorites fav = dao.getFavByUserLiked(user.getId(), video.getId());

            boolean isLiked = fav != null;

            int likeCount;
            if (isLiked) {
                dao.delete(fav.getId());
                likeCount = video.getFavorites().size();
            } else {
                Favorites newFav = new Favorites();
                newFav.setUser(user);
                newFav.setVideo(video);
                newFav.setLikeDate(new Date());
                dao.create(newFav);
                likeCount = video.getFavorites().size();
            }

            resp.getWriter().print("{\"likes\":" + likeCount + ",\"liked\":" + !isLiked + "}");
            resp.getWriter().flush();
        }


        try {
            if (url.equals("/UserHome/share")) {
                String userLoginId = req.getParameter("userLoginIdShare");
                String videoIdShare = req.getParameter("videoIdShare");


                Users userShare = uDao.getById(userLoginId);
                String to = req.getParameter("to");
                System.out.println("VideoId: " + videoIdShare + " - UserShare: " + userLoginId + " - ObjUser:" + userShare.toString() + " - To:" + to);
                Videos video = vDao.getById(videoIdShare);
                SendMailUtils.sendMail("pslu mezy znzy mdeb", userShare.getEmail(), to, userShare.getFullname() + " Đã gửi cho bạn 1 video: " + video.getTitle(), "Nội <br> dung:" + video.getDescription());
                resp.getWriter().print("{\"status\":\"success\",\"message\":\" Gửi thành công video\"}");

                Share newShare = new Share();
                newShare.setUser(userShare);
                newShare.setVideo(video);
                newShare.setShareDate(new Date());
                newShare.setEmails(to);

                sDao.create(newShare);

            }
        } catch (Exception e) {
            resp.getWriter().print("{\"status\":\"error\"}");
            e.printStackTrace();
            System.out.println("xay ra loi phuong thuc email");
        }

    }
}
