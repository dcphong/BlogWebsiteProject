package com.ASS.utils;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

@WebServlet("/uploads/*")
public class Fileutils extends HttpServlet {
    private static final String UPLOAD_DIR = "C:/uploads/images";

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String fileName = req.getPathInfo().substring(1); // Lấy tên file từ URL
        File file = new File(UPLOAD_DIR, fileName);

        if (!file.exists()) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND); // Nếu file không tồn tại
            return;
        }

        String contentType = getServletContext().getMimeType(file.getName());
        if (contentType == null) {
            contentType = "application/octet-stream";
        }
        resp.setContentType(contentType);
        resp.setContentLengthLong(file.length());

        try (var inputStream = new FileInputStream(file);
             var outputStream = resp.getOutputStream()) {
            inputStream.transferTo(outputStream); // Gửi file về client
        }
    }
}
