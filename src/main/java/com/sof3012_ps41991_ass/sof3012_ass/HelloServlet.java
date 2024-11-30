package com.sof3012_ps41991_ass.sof3012_ass;

import java.io.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

@WebServlet("/index")
public class HelloServlet extends HttpServlet {
    private String message;

    public void init() {
        message = "Hello World!";
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
//        response.sendRedirect(request.getContextPath() + "/UserHome");
        request.getRequestDispatcher("/UserHome").forward(request, response);
    }

    public void destroy() {
    }
}