package com.ASS.controller;

import com.ASS.dao.VideosDAO;
import com.ASS.model.Videos;
import com.ASS.utils.RestIoUtils;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.nio.file.Path;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/api/uploadImage")
@MultipartConfig
public class SaveImageController extends HttpServlet {
    private static final String IMAGE_DIRECTORY = "D:/images/";

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String buttonAction = req.getParameter("buttonAction");
        String videoId = req.getParameter("id");
        String title = req.getParameter("title");
        String description = req.getParameter("description");
        Videos video = new Videos();
        VideosDAO dao = new VideosDAO();
        String url = req.getServletPath();


        if (url.equals("/api/uploadImage")) {
            Part filePart = req.getPart("file");
            //END UPLOAD IMAGES
            video.setId(videoId);
            video.setTitle(title);
            video.setDescription(description);
            video.setViews(0);
            video.setActive(Boolean.parseBoolean(req.getParameter("active")));
            video.setPoster(req.getParameter("poster"));
            System.out.println(video);
            if (buttonAction.equals("update")) {
                handleSaveImage(req, filePart);
                dao.update(video);
                System.out.println(video);
                resp.getWriter().write("{\"status\":\"success\",\"message\":\"Cap nhat thanh cong video co id: " + videoId + "\"}");
            }
            if (buttonAction.equals("delete")) {
                dao.delete(videoId);
                resp.getWriter().write("{\"status\":\"success\",\"message\":\"Xoa thanh cong video co id: " + videoId + "\"}");
            }
            if (buttonAction.equals("create")) {
                Map<String, String> errors = validateUpload(videoId, title, description);
                if (errors.isEmpty()) {
                    handleSaveImage(req, filePart);
                    dao.create(video);
                    System.out.println("Video created:" + video);
                    resp.getWriter().write("{\"status\":\"success\",\"message\":\"Upload thanh cong\"}");
                } else {
                    StringBuilder jsonErrors = new StringBuilder("{\"status\":\"error\",\"errors\":{");
                    errors.forEach((key, value) ->
                            jsonErrors.append("\"").append(key).append("\":\"").append(value).append("\",")
                    );
                    jsonErrors.deleteCharAt(jsonErrors.length() - 1);
                    jsonErrors.append("}}");
//                    RestIoUtils.writeJson(resp, jsonErrors.toString());
                    resp.getWriter().write(jsonErrors.toString());
                }
            }
        }
    }

    private Map<String, String> validateUpload(String id, String title, String description) {
        Map<String, String> errors = new HashMap<>();
        Videos video = new Videos();
        VideosDAO dao = new VideosDAO();
        video = dao.getById(id);

        if (video != null) {
            errors.put("idMessage", "Id da tồn tại!");
        } else {
            if (id.length() < 4) {
                errors.put("idMessage", "Vui lòng nhập id lớn hơn 4 kí tự");
            }
        }

        if (title.length() < 15) {
            errors.put("titleMessage", "vui long nhap tieu de lon hon 15 ki tu");
        }
        if (description.length() < 15) {
            errors.put("descriptionMessage", "vui long nhap mo ta lon hon 15 ki tu");
        }
        return errors;
    }

    private String handleSaveImage(HttpServletRequest req, Part filePart) throws IOException, ServletException {
        try {
            filePart = req.getPart("file");

            if (filePart == null || filePart.getSubmittedFileName() == null) {
                return "EMPTY";
            }

            String fileName = Path.of(filePart.getSubmittedFileName()).getFileName().toString();

            String uploadPath = IMAGE_DIRECTORY; // Đảm bảo IMAGE_DIRECTORY đã được xác định đúng
            System.out.println("UPLOAD PATH: " + uploadPath);

            File uploadDir = new File(uploadPath);

            if (!uploadDir.exists()) {
                boolean dirCreated = uploadDir.mkdirs();
                if (dirCreated) {
                    System.out.println("Thư mục đã được tạo thành công.");
                } else {
                    System.out.println("Không thể tạo thư mục.");
                    return null;
                }
            }

            String filePath = uploadPath + File.separator + fileName;

            filePart.write(filePath);
            System.out.println("Đã lưu hình ảnh tại: " + filePath);

            return IMAGE_DIRECTORY + "/" + fileName;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

}
