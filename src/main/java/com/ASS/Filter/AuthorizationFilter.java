package com.ASS.Filter;

import com.ASS.model.Users;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebFilter(urlPatterns = {"/Admin/Home"})
public class AuthorizationFilter extends HttpFilter implements Filter {
    @Override
    protected void doFilter(HttpServletRequest req, HttpServletResponse res, FilterChain chain) throws IOException, ServletException {
        Users user = (Users) req.getSession().getAttribute("user");
        res.setCharacterEncoding("UTF-8");
        req.setCharacterEncoding("UTF-8");

        if (user == null) {
            res.getWriter().write("NOT_LOGGED_IN");
            return;
        }
        if (!user.isAdmin()) {
            res.getWriter().write("ACCESS_DENIED");
            return;
        }

        chain.doFilter(req, res);
    }
}
