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

@WebFilter(urlPatterns = {"/UserFavorites", "/UserHome/profiles"})
public class AuthenticationFilter extends HttpFilter implements Filter {
    @Override
    protected void doFilter(HttpServletRequest req, HttpServletResponse res, FilterChain chain) throws IOException, ServletException {
        Users user = (Users) req.getSession().getAttribute("user");
        if (user == null) {
            res.getWriter().write("NOT_LOGGED_IN");
            return;
        }
        chain.doFilter(req, res);
    }
}
