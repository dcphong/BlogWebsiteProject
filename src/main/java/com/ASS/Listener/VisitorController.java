package com.ASS.Listener;

import com.ASS.model.Users;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebListener;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.HttpSessionEvent;
import jakarta.servlet.http.HttpSessionListener;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;

@WebListener
public class VisitorController implements HttpSessionListener, ServletContextListener {
    private int visitorCount = 0;

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        ServletContext context = sce.getServletContext();
        visitorCount = (int) context.getAttribute("visitorCount");

        System.out.println("Web dùng , đóng hết phiên làm việc!");
    }

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        ServletContext context = sce.getServletContext();
        String path = "D:\\visitorCount.txt";
        try {
            if (Files.exists(Paths.get(path))) {
                String content = Files.readString(Paths.get(path));
                visitorCount = Integer.parseInt(content.trim());
            } else {
                visitorCount = 0;
            }
        } catch (IOException e) {
            visitorCount = 0;
            e.printStackTrace();
        }
        context.setAttribute("visitorCount", visitorCount);
        System.out.println("Khởi tạo lượt truy cập mới: " + visitorCount);
    }

    @Override
    public void sessionDestroyed(HttpSessionEvent se) {
        HttpSessionListener.super.sessionDestroyed(se);
    }

    @Override
    public void sessionCreated(HttpSessionEvent se) {
        ServletContext context = se.getSession().getServletContext();
        visitorCount = (int) context.getAttribute("visitorCount");
        visitorCount++;
        context.setAttribute("visitorCount", visitorCount);

        try {
            String content = String.valueOf(visitorCount);
            String path = "D:\\visitorCount.txt";

            if (!Files.exists(Paths.get(path))) {
                Files.createFile(Paths.get(path));
            }
            Files.write(Paths.get(path), content.getBytes());

        } catch (IOException e) {
            throw new RuntimeException(e);
        }

        System.out.println("Đã tạo 1 phiên mới:" + visitorCount);
    }
}

