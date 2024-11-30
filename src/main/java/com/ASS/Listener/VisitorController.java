package com.ASS.Listener;

import com.ASS.model.Users;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebListener;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.HttpSessionEvent;
import jakarta.servlet.http.HttpSessionListener;

@WebListener
public class VisitorController implements HttpSessionListener, ServletContextListener {
    @Override
    public void sessionCreated(HttpSessionEvent se) {
        HttpSession session = se.getSession();
        ServletContext context = session.getServletContext();

        synchronized (context) {
            Integer visitorCount = (Integer) context.getAttribute("visitors");
            if (visitorCount == null) {
                visitorCount = 0;
            }
            visitorCount++;
            context.setAttribute("visitors", visitorCount);
            System.out.println("VISITORS: " + visitorCount);
        }
    }

    @Override
    public void sessionDestroyed(HttpSessionEvent se) {
    }
}

