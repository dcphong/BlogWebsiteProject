<%--
  Created by IntelliJ IDEA.
  User: doanc
  Date: 05/11/2024
  Time: 15:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Trang chủ</title>
</head>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fun"%>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
      integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
<link rel="stylesheet" href="/css/styles.css">
<body class="p-0 m-0 bg-ytb scrollbar-hidden" style="margin: 0px;padding: 0px ">
    <c:url value="/UserHome" var="url" scope="request"/>
    <div class="container-fluid h-100 position-relative">
        <!-- NAVBAR and REGISTER / LOGIN FORM -->
        <%@include file="/views/common/clients/header.jsp"%>
        <!-- END NAVBAR and REGISTER / LOGIN FORM -->

        <!-- NOT LOGIN NOTI -->
        <div class="toast ${isNotLogin != null ? 'show' : ''} bg-dark border-gray position-absolute" style="right: 5%"  role="alert" aria-live="assertive" aria-atomic="true">
            <div class="d-flex ">
                <div class="toast-body text-light fw-bold">
                    Vui lòng đăng nhập!
                </div>
                <button type="button" class="btn-close me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
            </div>
        </div>
        <!-- END NOT LOGIN NOTI -->

        <!-- SUB -->
        <div class="row">
            <div class="col-12 bg-ytb p-2">

                <div class="col-12 d-flex justify-content-center gap-2">
                    <button type="button" class="btn bg-button-ytb mx-1 rounded-1">Nút lọc</button>
                    <button type="button" class="btn bg-button-ytb mx-1 rounded-1">Nút lọc</button>
                    <button type="button" class="btn bg-button-ytb mx-1 rounded-1">Nút lọc</button>
                    <button type="button" class="btn bg-button-ytb mx-1 rounded-1">Nút lọc</button>
                </div>
            </div>
        </div>
        <!-- END SUB -->

        <div class="row vh-100 mb-2">
            <div class="col-md-1 col-12 p-0">
                <!-- SIDEBAR -->
                <%@include file="/views/common/clients/sidebar.jsp"%>>
                <!-- END SIDEBAR -->
            </div>

            <!-- CONTENT -->
            <div class="col-11 overflow-auto scrollbar-hidden "  style="height: 95vh">
                <div id="content" class="row row-cols-1 row-cols-md-4 row-gap-4 mt-2">
                    <c:forEach items="${listVideoSearch}" var="video">
                        <div class="col videoList mb-md-2 mb-5" style="height: 250px">
                            <c:url value="/videoDetails?vId=${video.id}" var="vId"/>
                            <a href="${vId}" class="link-ytb">
                                <div class="card border-0 bg-ytb" >
                                    <img src="/images/${video.poster}" class="card-img-top bg-ytb rounded-3" alt="...">
                                    <div class="card-body bg-ytb">
                                        <p class="card-text text-light">
                                                ${video.title}
                                            <i class="bi bi-eye float-end fst-normal"> ${video.views}</i>
                                        </p>
                                    </div>
                                </div>
                            </a>
                        </div>
                    </c:forEach>
                </div>
            </div>
            <!-- END CONTENT -->
        </div>

       <!-- PAGE NUMBERS PLACE -->
    </div>
</body>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"
        integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r"
        crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js"
        integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy"
        crossorigin="anonymous"></script>
<script src="/js/validate.js"></script>
</html>
