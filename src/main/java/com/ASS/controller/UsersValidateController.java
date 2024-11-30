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
import java.lang.reflect.InvocationTargetException;
import java.util.HashMap;
import java.util.Map;

@WebServlet(urlPatterns = {"/UserHome/register", "/UserHome/login", "/UserHome/passwordEdit", "/updateProfiles"})
public class UsersValidateController extends HttpServlet {
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {


        String action = req.getServletPath();
        System.out.println("URL ACTION:" + action);
        if (action.equals("/UserHome/register")) {
            handleRegister(req, resp);
        } else if (action.equals("/UserHome/login")) {
            handleLogin(req, resp);
        } else if (action.equals("/UserHome/passwordEdit")) {
            handleChangePassword(req, resp);
        } else if (action.equals("/updateProfiles")) {
            handleUpdateProfiles(req, resp);
        }
    }

    private Map<String, String> validateUser(Users user, String confirmPassword, String email) {
        Map<String, String> errors = new HashMap<>();
        UsersDAO dao = new UsersDAO();
        Users u = dao.getById(user.getId());
        Users uEmail = dao.getByEmail(email);

        if (u != null) {
            errors.put("eUsername", "Username đã tồn tại!");
        }
        if (user.getId() == null || user.getId().length() < 8) {
            errors.put("eUsername", "Vui lòng nhập username lớn hơn 8 ký tự.");
        }
        if (user.getPassword() == null || user.getPassword().length() < 6) {
            errors.put("ePassword", "Vui lòng nhập mật khẩu lớn hơn 6 ký tự.");
        }
        if (confirmPassword == null || !confirmPassword.equals(user.getPassword())) {
            errors.put("e2faPassword", "Mật khẩu không chính xác.");
        }
        if (uEmail != null) {
            errors.put("eEmail", "Email đã được đăng ký.");
        }
        return errors;
    }

    private void handleRegister(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Users user = new Users();
        UsersDAO dao = new UsersDAO();
        Map<String, String> errors = new HashMap<>();
        try {
            BeanUtils.populate(user, request.getParameterMap());
            errors = validateUser(user, request.getParameter("2faPassword"), request.getParameter("email"));
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");

            if (errors.isEmpty()) {
                dao.create(user);
                response.getWriter().write("{\"status\":\"success\", \"message\":\"Đăng ký thành công!\"}");
            } else {
                StringBuilder jsonErrors = new StringBuilder("{\"status\":\"error\", \"errors\":{");
                errors.forEach((key, value) -> jsonErrors.append("\"").append(key).append("\":\"").append(value).append("\","));
                jsonErrors.deleteCharAt(jsonErrors.length() - 1);
                jsonErrors.append("}}");
                response.getWriter().write(jsonErrors.toString());
            }
        } catch (IllegalAccessException | InvocationTargetException e) {
            e.printStackTrace();
        }
    }

    private void handleLogin(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("id");
        String password = req.getParameter("password");

        UsersDAO dao = new UsersDAO();
        Users user = dao.getById(username);
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        if (user != null && user.getPassword().equals(password)) {
            req.getSession().setAttribute("user", user);
            resp.getWriter().write("{\"status\":\"success\",\"message\":\"Đăng nhập thành công!\"}");
        } else {
        }
    }

    private void handleChangePassword(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String password1 = req.getParameter("password");
        String password2 = req.getParameter("password2");
        String password3 = req.getParameter("password3");
        String userId = req.getParameter("userLoginId");

        UsersDAO dao = new UsersDAO();
        Users user = dao.getById(userId);
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        Map<String, String> errors = new HashMap<>();

        if (!user.getPassword().equals(password1)) {
            errors.put("ePass1Message", "Mật khẩu cũ không chính xác");
        }
        if (password2.length() < 6) {
            errors.put("ePass2Message", "Mật khẩu phải trên 6 kí tự");
        }
        if (!password3.equals(password2)) {
            errors.put("ePass3Message", "Mật khẩu không khớp");
        }

        if (!errors.isEmpty()) {
            StringBuilder jsonErrors = new StringBuilder("{\"status\":\"error\", \"errors\":{");
            errors.forEach((key, value) -> jsonErrors.append("\"").append(key).append("\":\"").append(value).append("\","));
            jsonErrors.deleteCharAt(jsonErrors.length() - 1);
            jsonErrors.append("}}");
            resp.getWriter().write(jsonErrors.toString());
        } else {
            user.setPassword(password2);
            dao.update(user);
            resp.getWriter().write("{\"status\":\"success\", \"message\":\"Đổi mật khẩu thành công!\"}");
        }
    }

    public void handleUpdateProfiles(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String username = request.getParameter("id");
        String fullname = request.getParameter("fullname");
        String email = request.getParameter("email");

        UsersDAO dao = new UsersDAO();
        Users user = dao.getByEmail(email);
        Users userU = dao.getById(username);

        Map<String, String> errors = new HashMap<>();

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        if (user != null) {
            errors.put("emailError", "Email đã được sử dụng!");
        }

        if (fullname == null) {
            errors.put("fullnError", "Vui lòng nhập họ tên!");
        } else if (!email.contains("@") && email.length() < 10) {
            errors.put("emailError", "Vui lòng nhập email hợp lệ! ví dụ: abcs@gmail.com <-");
        }

        if (errors.isEmpty()) {
            String id = request.getParameter("userLoginId");
            user = dao.getById(id);
            user.setFullname(fullname);
            user.setEmail(email);
            dao.update(user);

            request.getSession().setAttribute("user", user);

            response.getWriter().write("{\"status\":\"success\", \"message\":\"Đổi thông tin thành công!\"}");
        } else {
            StringBuilder jsonErrors = new StringBuilder("{\"status\":\"error\", \"errors\":{");
            errors.forEach((key, value) -> jsonErrors.append("\"").append(key).append("\":\"").append(value).append("\","));
            jsonErrors.deleteCharAt(jsonErrors.length() - 1);
            jsonErrors.append("}}");
            response.getWriter().write(jsonErrors.toString());
        }
    }
}
