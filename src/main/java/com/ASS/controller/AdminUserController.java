package com.ASS.controller;

import com.ASS.dao.UsersDAO;
import com.ASS.model.Users;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.apache.commons.beanutils.BeanUtils;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@WebServlet(urlPatterns = {"/Admin/user/action", "/Admin/user/edit", "/Admin/user/pagination"})
public class AdminUserController extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String url = req.getServletPath();
        UsersDAO dao = new UsersDAO();

        try {
            resp.setContentType("application/json");
            resp.setCharacterEncoding("UTF-8");
            if (url.equals("/Admin/user/action")) {
                String action = req.getParameter("adminUserAction");

                if ("update".equals(action)) {
                    handleUpdateAction(req, resp);
                }
                if ("delete".equals(action)) {
                    String id = req.getParameter("id");
                    Users u = dao.getById(id);

                    if (u != null) {
                        dao.delete(u.getId());
                        resp.getWriter().write("{\"status\":\"errorDelete\",\"message\":\"Xóa thành công user có Id: " + u.getId() + "\"}");
                    } else {
                        resp.getWriter().write("{\"status\":\"errorDelete\",\"message\":\"User không tồn tại!\"}");
                    }
                }
            }

            if (url.equals("/Admin/user/edit")) {
                String id = req.getParameter("id");
                Users u = dao.getById(id);
                resp.getWriter().write("{\"username\":\"" + u.getId() + "\",\"password\":\"" + u.getPassword() + "\",\"email\":\"" + u.getEmail() + "\",\"fullname\":\"" + u.getFullname() + "\"}");
            }

            if (url.equals("/Admin/user/pagination")) {
                // từ từ làm
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.getWriter().write("{\"status\":\"error\",\"message\":\"Đã xảy ra lỗi trong quá trình xử lý\"}");
        }

    }

    public Map<String, String> handleValidate(Users user) {
        Map<String, String> map = new HashMap<>();
        UsersDAO dao = new UsersDAO();
        Users uEmail = dao.getByEmail(user.getEmail());

        if (user.getFullname().length() < 8) {
            map.put("fullnameMessage", "Vui lòng nhập tên trên 8 kí tự");
        }
        if (user.getId() == null || user.getId().length() < 8) {
            map.put("userMessage", "Vui lòng nhập username nhiều hơn 8 kí tự");
        }
        if (uEmail != null) {
            map.put("eUserEmail", "Email đã được sử dụng");
        }
        return map;
    }

    public void handleUpdateAction(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            UsersDAO dao = new UsersDAO();
            Users user = new Users();
            BeanUtils.populate(user, req.getParameterMap());
            Map<String, String> errors = handleValidate(user);
            Users uVisible = dao.getById(user.getId());

            resp.setContentType("application/json");
            resp.setCharacterEncoding("UTF-8");
            if (uVisible != null) {
                uVisible.setFullname(user.getFullname());
                uVisible.setEmail(user.getEmail());
                uVisible.setPassword(user.getPassword());

                dao.update(uVisible);
                resp.getWriter().write("{\"status\":\"success\", \"message\":\"Cập nhật thành công!\"}");
            } else {
                dao.create(user);
                resp.getWriter().write("{\"status\":\"success\", \"message\":\"Thêm mới thành công!\"}");
            }

            if (!errors.isEmpty()) {
                StringBuilder jsonErros = new StringBuilder("{\"status\":\"error\", \"errors\":{");
                errors.forEach((key, value) -> jsonErros.append("\"").append(key).append("\":\"").append(value).append("\","));
                jsonErros.deleteCharAt(jsonErros.length() - 1);
                jsonErros.append("}}");
                resp.getWriter().write(jsonErros.toString());
            } else {
                dao.update(user);
                resp.getWriter().write("{\"status\":\"success\", \"message\":\"Cập nhật thành công!\"}");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
