<%--
  Created by IntelliJ IDEA.
  User: doanc
  Date: 16/11/2024
  Time: 20:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fun" %>
<link href="/css/admin.css" rel="stylesheet"/>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
<body style="background-color: #121212;color:#e0e0e0;margin: 0">

<!-- HEADER -->
<%@include file="/views/common/admin/header.jsp" %>
<!-- END HEADER -->

<!-- SIDEBAR -->
<%@include file="/views/common/admin/aside.jsp" %>
<!-- END SIDEBAR -->

<!-- MAIN CONTENT -->
<div class="content">
    <div class="tab-content">
        <ul class="nav nav-tabs" id="myTab" role="tablist">
            <li class="nav-item" role="presentation">
                <button class="nav-link active text-success" id="details-tab" data-bs-toggle="tab"
                        data-bs-target="#details" type="button" role="tab" aria-controls="details"
                        aria-selected="true">Video Chi Tiết
                </button>
            </li>
            <li class="nav-item" role="presentation">
                <button class="nav-link text-success" id="list-tab" data-bs-toggle="tab" data-bs-target="#list"
                        type="button" role="tab" aria-controls="list" aria-selected="false">Danh Sách Video
                </button>
            </li>
        </ul>
        <div class="tab-content mt-3" id="myTabContent">
            <!-- Tab: Video Chi Tiết -->
            <div class="tab-pane fade show active" id="details" role="tabpanel" aria-labelledby="details-tab"
                 style="height: 450px;">
                <div class="row">
                    <div class="col-md-4">
                        <img src="https://via.placeholder.com/300x200" alt="Video" id="previewImage"
                             class="img-fluid rounded">
                        <div class="mb-3">
                            <label for="formFile" class="form-label">Default file input example</label>
                            <input class="form-control" type="file" id="formFile">
                        </div>
                    </div>
                    <div class="col-md-8">
                        <form>
                            <div class="mb-1">
                                <label for="videoId" class="form-label">ID Video</label>
                                <input type="text" class="form-control" name="id" id="videoId">
                            </div>
                            <div class="mb-3">
                                <label for="videoTitle" class="form-label">Tiêu đề video</label>
                                <input type="hidden" name="poster" id="posterName"/>
                                <input type="text" class="form-control" name="title" id="videoTitle">
                            </div>
                            <div class="mb-3">
                                <label for="viewCount" class="form-label">Số lượt xem</label>
                                <input type="number" class="form-control" name="views" id="viewCount">
                            </div>
                            <div class="mb-3">
                                <div class="form-check-inline">
                                    <input class="form-check-input" name="active" value="true" type="checkbox"
                                           id="activeCheck">
                                    <label class="form-check-label" for="activeCheck">Hoạt động</label>
                                </div>
                                <div class="form-check-inline">
                                    <input class="form-check-input" type="checkbox" name="active" value="false"
                                           id="inactiveCheck">
                                    <label class="form-check-label" for="inactiveCheck">Ẩn</label>
                                </div>
                            </div>
                            <div class="mb-3">
                                <label for="description" class="form-label">Mô tả</label>
                                <textarea class="form-control" name="description" id="description" rows="3"></textarea>
                            </div>
                            <div>
                                <button type="button" class="btn btn-primary">Thêm</button>
                                <button type="button" class="btn btn-warning">Cập nhật</button>
                                <button type="button" class="btn btn-danger">Xóa</button>
                                <button type="reset" class="btn btn-secondary">Làm mới</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <!-- Tab: Danh Sách Video -->
            <div class="tab-pane fade" id="list" role="tabpanel" aria-labelledby="list-tab">
                <table class="table table-dark table-striped">
                    <thead>
                    <tr>
                        <th>ID</th>
                        <th>Tiêu đề</th>
                        <th>Lượt xem</th>
                        <th>Trạng thái</th>
                        <th>Chức năng</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${videoList}" var="video">
                        <tr>
                            <td>${video.id}</td>
                            <td>${video.title}</td>
                            <td>${video.views}</td>
                            <td>${video.active == true ? 'Video Hoạt động' : 'Đã ẩn video'}</td>
                            <td>
                                <button class="btn btn-sm btn-info">Chỉnh sửa</button>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
                <div class="pagination-btns">
                    <button class="btn btn-sm btn-light">First</button>
                    <button class="btn btn-sm btn-light">Prev</button>
                    <button class="btn btn-sm btn-light">Next</button>
                    <button class="btn btn-sm btn-light">Last</button>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- MAIN CONTENT -->

</body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    const fileInput = document.getElementById('formFile')
    const previewImage = document.getElementById('previewImage')
    const poster = document.getElementById('posterName')

    fileInput.addEventListener('change', (e) => {
        const file = e.target.files[0];
        if (file) {
            poster.value = file.name
            const reader = new FileReader();
            reader.onload = (e) => {
                previewImage.src = e.target.result;
            };
            reader.readAsDataURL(file);
        }
    })
</script>
</html>
