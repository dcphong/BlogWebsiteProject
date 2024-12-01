package com.ASS.utils;

import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.Map;

public class RestIoUtils {
    public static String readJson(HttpServletRequest req) throws IOException {
        req.setCharacterEncoding("UTF-8");
        String line;
        StringBuffer sb = new StringBuffer();
        while ((line = req.getReader().readLine()) != null) {
            sb.append(line);
        }
        req.getReader().close();
        return sb.toString();
    }

    public static void writeJson(HttpServletResponse resp, String json) throws IOException {
        resp.setHeader("Access-Control-Allow-Origin", "*");
        resp.setHeader("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE");
        resp.setHeader("Access-Control-Allow-Headers", "Content-Type, Authorization");

        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        resp.getWriter().write(json);
        resp.flushBuffer();
    }

    public static <T> T readObject(HttpServletRequest req, Class<T> clazz) throws IOException {
        String json = RestIoUtils.readJson(req);
        T bean = mapper.readValue(json, clazz);
        return bean;
    }

    static private final ObjectMapper mapper = new ObjectMapper();

    public static void writeObject(HttpServletResponse resp, Object obj) throws IOException {
        String json = mapper.writeValueAsString(obj);
        RestIoUtils.writeJson(resp, json);
    }

    public static void writeEmptyObject(HttpServletResponse resp) throws IOException {
        RestIoUtils.writeObject(resp, Map.of());
    }
}
