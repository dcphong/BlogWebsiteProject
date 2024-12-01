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
                        <form id="formUpload" method="POST" enctype="multipart/form-data">
                            <div class="mb-1">
                                <label for="videoId" class="form-label">ID Video</label>
                                <input type="text" placeholder="Nhap id bai viet..." class="form-control" name="id"
                                       id="videoId">
                                <span id="idUploadMessage" class="text-danger"></span>
                            </div>
                            <div class="mb-3">
                                <label for="videoTitle" class="form-label">Tiêu đề video</label>
                                <input type="text" placeholder="Poster..."
                                       class="border-0 bg-dark text-light float-end"
                                       name="poster" id="posterName"/>
                                <input type="text" class="form-control" placeholder="Nhap vao tieu de..." name="title"
                                       id="videoTitle">
                                <span id="titleUploadMessage" class="text-danger"></span>
                            </div>
                            <div class="mb-3">
                                <label for="viewCount" class="form-label">Số lượt xem</label>
                                <input type="number" class="form-control" name="views" id="viewCount" placeholder="0">
                                <span id="viewsUploadMessage" class="text-danger"></span>
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
                                <textarea class="form-control" placeholder="Nhập vào mô tả..." name="description"
                                          id="description" rows="3"></textarea>
                                <span id="descriptionUploadMessage" class="text-danger"></span>
                            </div>
                            <div>
                                <button type="submit" value="create" name="buttonAction" class="btn btn-primary">Thêm
                                </button>
                                <button type="submit" value="update" name="buttonAction" class="btn btn-warning">Cập
                                    nhật
                                </button>
                                <button type="submit" value="delete" name="buttonAction" class="btn btn-danger">Xóa
                                </button>
                                <button type="reset" class="btn btn-secondary">Làm mới</button>
                            </div>
                            <span id="formUploadMessage"></span>
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
                    <tbody id="contentTable">
                    <c:forEach items="${videoList}" var="video">
                        <tr>
                            <td>${video.id}</td>
                            <td>${video.title}</td>
                            <td>${video.views}</td>
                            <td>${video.active ? 'Video Hoạt động' : 'Đã ẩn video'}</td>
                            <td>
                                <button name="buttonEditVideoId" value="${video.id}" class="btn btn-sm btn-info">Chỉnh
                                    sửa
                                </button>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
                <div class="pagination-btns">
                    <c:forEach begin="1" end="${pageNumbers}" var="i">
                        <button name="paginationNum" value="${i}" class="btn btn-sm btn-light">
                                ${i}
                        </button>
                    </c:forEach>
                </div>
            </div>

        </div>
    </div>
</div>
<!-- MAIN CONTENT -->

</body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<%--<script>--%>
<%--    const fileInput = document.getElementById('formFile')--%>
<%--    const previewImage = document.getElementById('previewImage')--%>
<%--    const poster = document.getElementById('posterName')--%>

<%--    fileInput.addEventListener('change', (e) => {--%>
<%--        const file = e.target.files[0];--%>
<%--        if (file) {--%>
<%--            poster.value = file.name--%>
<%--            const reader = new FileReader();--%>
<%--            reader.onload = (e) => {--%>
<%--                previewImage.src = e.target.result;--%>
<%--            };--%>
<%--            reader.readAsDataURL(file);--%>
<%--        }--%>
<%--    })--%>

<%--    document.getElementById('formUpload').addEventListener('submit', async (e) => {--%>
<%--        e.preventDefault();--%>
<%--        const form = e.target;--%>
<%--        const formData = new FormData(form)--%>
<%--        const idMessage = document.getElementById('idUploadMessage')--%>
<%--        const titleMessage = document.getElementById('titleUploadMessage');--%>
<%--        const viewsMessage = document.getElementById('viewsUploadMessage');--%>
<%--        const formMessage = document.getElementById('formUploadMessage');--%>
<%--        const button = e.submitter;--%>
<%--        formData.append(button.name, button.value);--%>
<%--        try {--%>
<%--            const response = await fetch('/admin/upload', {--%>
<%--                method: 'POST',--%>
<%--                body: formData--%>
<%--            })--%>

<%--            const data = await response.json();--%>

<%--            if (!response.ok) {--%>
<%--                console.log('Upload image failed', await response.text());--%>
<%--            } else {--%>
<%--                if (data.status == 'success') {--%>
<%--                    formMessage.textContent = data.message;--%>
<%--                    formMessage.classList.remove('text-danger')--%>
<%--                    formMessage.classList.add('text-success')--%>
<%--                } else {--%>
<%--                    if (data.errors.idMessage) {--%>
<%--                        idMessage.textContent = data.errors.idMessage--%>
<%--                    }--%>
<%--                    if (data.errors.titleMessage) {--%>
<%--                        titleMessage.textContent = data.errors.titleMessage--%>
<%--                    }--%>
<%--                    if (data.errors.viewMessage) {--%>
<%--                        viewsMessage.textContent = data.errors.viewMessage--%>
<%--                    }--%>
<%--                    formMessage.textContent = 'Upload Blog that bai!'--%>
<%--                    formMessage.classList.add('text-danger')--%>
<%--                    formMessage.classList.remove('text-success')--%>
<%--                }--%>
<%--            }--%>
<%--        } catch (error) {--%>
<%--            console.log(error)--%>
<%--        }--%>
<%--    })--%>

<%--    const buttonGetVideoId = document.querySelectorAll("[name='buttonEditVideoId']");--%>
<%--    let idVideo = document.getElementById('videoId');--%>
<%--    let title = document.getElementById('videoTitle')--%>
<%--    let views = document.getElementById('viewCount')--%>
<%--    let description = document.getElementById('description')--%>
<%--    let activeCheck = document.getElementById('activeCheck')--%>
<%--    let inActive = document.getElementById('inactiveCheck')--%>
<%--    let viewCount = document.getElementById('viewCount')--%>

<%--    buttonGetVideoId.forEach((button) => {--%>

<%--        button.addEventListener('click', async () => {--%>
<%--            const id = button.value--%>
<%--            try {--%>
<%--                const response = await fetch('/admin/edit', {--%>
<%--                    method: 'POST',--%>
<%--                    body: new URLSearchParams({--%>
<%--                        id: id--%>
<%--                    })--%>
<%--                })--%>

<%--                const data = await response.json()--%>

<%--                if (!response.ok) {--%>
<%--                    throw new Error(`HTTP error! status: ${response.status}`);--%>
<%--                }--%>

<%--                console.log(data)--%>

<%--                idVideo.value = data.id;--%>
<%--                title.value = data.title;--%>
<%--                description.value = data.description;--%>
<%--                viewCount.value = data.views;--%>
<%--                document.getElementById('posterName').value = data.poster--%>
<%--                document.getElementById('previewImage').src = "/images/" + data.poster--%>

<%--                if (data.active == true) {--%>
<%--                    activeCheck.value = true--%>
<%--                } else {--%>
<%--                    inActive.value = false;--%>
<%--                }--%>
<%--                document.getElementById('details').classList.add('show', 'active')--%>
<%--                document.getElementById('list').classList.remove('show', 'active')--%>

<%--                document.getElementById('details-tab').classList.add('active')--%>
<%--                document.getElementById('list-tab').classList.remove('active')--%>

<%--            } catch (error) {--%>
<%--                console.log(error)--%>
<%--            }--%>
<%--        })--%>

<%--    })--%>
<%--</script>--%>
<%--<script>--%>
<%--    const paginationButtons = document.querySelectorAll("[name='paginationNum']");--%>
<%--    const content = document.getElementById("contentTable");--%>
<%--    paginationButtons.forEach((button) => {--%>
<%--        button.addEventListener("click", async () => {--%>
<%--            const value = button.value;--%>

<%--            try {--%>
<%--                const response = await fetch("/admin/video/pagination", {--%>
<%--                    method: "POST",--%>
<%--                    headers: {--%>
<%--                        "Content-Type": "application/x-www-form-urlencoded",--%>
<%--                    },--%>
<%--                    body: new URLSearchParams({value: value}),--%>
<%--                });--%>
<%--                if (!response.ok) {--%>
<%--                    throw new Error(`HTTP error! Status: ${response.status}`);--%>
<%--                }--%>
<%--                const responseData = await response.text();--%>
<%--                content.innerHTML = responseData;--%>
<%--            } catch (error) {--%>
<%--                console.error("Đã xảy ra lỗi:", error);--%>
<%--            }--%>
<%--        });--%>
<%--    });--%>
<%--</script>--%>
<script>
    const paginationButtons = document.querySelectorAll("[name='paginationNum']");
    const content = document.getElementById("contentTable");

    paginationButtons.forEach((button) => {
        button.addEventListener("click", async () => {
            const value = button.value;

            try {
                const response = await fetch("/admin/video/pagination", {
                    method: "POST",
                    headers: {
                        "Content-Type": "application/x-www-form-urlencoded",
                    },
                    body: new URLSearchParams({value: value}),
                });
                if (!response.ok) {
                    throw new Error(`HTTP error! Status: ${response.status}`);
                }
                const responseData = await response.text();
                content.innerHTML = responseData;

                // Đăng ký lại sự kiện click cho các nút "Chỉnh sửa"
                const buttonGetVideoId = document.querySelectorAll("[name='buttonEditVideoId']");
                buttonGetVideoId.forEach((button) => {
                    button.addEventListener('click', async () => {
                        const id = button.value;
                        try {
                            const response = await fetch('/admin/edit', {
                                method: 'POST',
                                body: new URLSearchParams({
                                    id: id
                                })
                            });

                            const data = await response.json();

                            if (!response.ok) {
                                throw new Error(`HTTP error! status: ${response.status}`);
                            }

                            idVideo.value = data.id;
                            title.value = data.title;
                            description.value = data.description;
                            viewCount.value = data.views;
                            document.getElementById('posterName').value = data.poster;
                            document.getElementById('previewImage').src = "/images/" + data.poster;

                            if (data.active == true) {
                                activeCheck.value = true;
                            } else {
                                inActive.value = false;
                            }

                            document.getElementById('details').classList.add('show', 'active');
                            document.getElementById('list').classList.remove('show', 'active');

                            document.getElementById('details-tab').classList.add('active');
                            document.getElementById('list-tab').classList.remove('active');

                        } catch (error) {
                            console.log(error);
                        }
                    });
                });

            } catch (error) {
                console.error("Đã xảy ra lỗi:", error);
            }
        });
    });

</script>

</html>
