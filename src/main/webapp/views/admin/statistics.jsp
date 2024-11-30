<%--
  Created by IntelliJ IDEA.
  User: doanc
  Date: 16/11/2024
  Time: 23:09
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
                <button class="nav-link active text-success" id="top10-tab" data-bs-toggle="tab"
                        data-bs-target="#top10" type="button" role="tab" aria-controls="top10"
                        aria-selected="true">Top 10 Lượt xem
                </button>
            </li>
            <li class="nav-item" role="presentation">
                <button class="nav-link text-success" id="no-likes-tab" data-bs-toggle="tab" data-bs-target="#no-likes"
                        type="button" role="tab" aria-controls="no-likes" aria-selected="false">Video Không Ai Thích
                </button>
            </li>
            <li class="nav-item" role="presentation">
                <button class="nav-link text-success" id="summary-tab" data-bs-toggle="tab" data-bs-target="#summary"
                        type="button" role="tab" aria-controls="summary" aria-selected="false">Tổng Hợp
                </button>
            </li>
        </ul>
        <div class="tab-content mt-3" id="myTabContent">
            <!-- Tab: Top 10 Lượt xem -->
            <div class="tab-pane fade show active" id="top10" role="tabpanel" aria-labelledby="top10-tab">
                <table class="table table-dark table-striped">
                    <thead>
                    <tr>
                        <th>ID</th>
                        <th>Tiêu đề</th>
                        <th>Lượt xem</th>
                        <th>Lượt thích</th>
                        <th>Trạng thái</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${top10List}" var="video">
                        <tr>
                            <td>${video.id}</td>
                            <td>${video.title}</td>
                            <td>${video.views}</td>
                            <td>${video.favorites.size()}</td>
                            <td>${video.active == true ? 'Hoạt động' : 'Đã ẩn video'}</td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>

            <!-- Tab: Video Không Ai Thích -->
            <div class="tab-pane fade" id="no-likes" role="tabpanel" aria-labelledby="no-likes-tab">
                <table class="table table-dark table-striped">
                    <thead>
                    <tr>
                        <th>ID</th>
                        <th>Tiêu đề</th>
                        <th>Lượt xem</th>
                        <th>Lượt thích</th>
                        <th>Trạng thái</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${noOneLikeList}" var="video">
                        <tr>
                            <td>${video.id}</td>
                            <td>${video.title}</td>
                            <td>${video.views}</td>
                            <td>${video.favorites.size()}</td>
                            <td>${video.active == true ? 'Đang hoạt động' : 'Đã ẩn video'}</td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>

            <!-- Tab: Tổng Hợp -->
            <div class="tab-pane fade" id="summary" role="tabpanel" aria-labelledby="summary-tab">
                <table class="table table-dark table-striped">
                    <thead>
                    <tr>
                        <th>Tiêu đề</th>
                        <th>Số lượt chia sẻ</th>
                        <th>Ngày chia sẻ đầu tiên</th>
                        <th>Ngày chia sẻ cuối cùng</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${totalList}" var="video">
                        <tr>
                            <td>${video.videoTitle}</td>
                            <td>${video.shareCount}</td>
                            <td>${video.firstShareDate == null ? 'Chưa được chia sẻ' : video.firstShareDate}</td>
                            <td>${video.lastShareDate == null ? '-' : video.lastShareDate}</td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<!-- MAIN CONTENT -->

</body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</html>
