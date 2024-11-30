<%--
  Created by IntelliJ IDEA.
  User: doanc
  Date: 05/11/2024
  Time: 21:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Video yêu thích</title>
</head>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fun"%>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
      integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
<link rel="stylesheet" href="/css/styles.css">

<body class="p-0 m-0 bg-ytb" style="margin: 0px;padding: 0px">
    <div class="container-fluid">
        <%@include file="/views/common/clients/header.jsp" %>
        <!-- END HEADER -->
        <div class="row">
            <!-- MAIN CONTENT -->
            <div class="col-1 p-0">
            </div>
            <div class="col-11 bg-ytb p-2">
                <h1 class="float-start fs-5 text-light mx-2">Video yêu thích: ${fList == null ? 'chưa có video nào' : fList.size()} </h1>
            </div>
            <!-- END MAIN CONTENT -->
        </div>
        <!-- CONTENT -->
        <div class="row h-100 mb-2">
            <div class="col-1 p-0">
                <!-- SIDEBAR -->
                <%@include file="/views/common/clients/sidebar.jsp"%>>
                <!-- END SIDEBAR -->
            </div>
            <div class="col-11 row row-cols-1 row-cols-md-4 mt-2 row-gap-4">
                <c:forEach items="${fList}" var="favorite">
                    <div class="col">
                        <c:url value="/videoDetails?vId=${favorite.video.id}" var="vId"/>
                        <a href="${vId}" class="link-ytb">
                            <div class="card w-100 border-0 bg-ytb">
                                <img src="/images/${favorite.video.poster}" class="card-img-top bg-ytb rounded-3" alt="...">
                                <div class="card-body bg-ytb">
                                    <p class="card-text text-light">
                                            ${favorite.video.title}
                                        <i class="bi bi-eye float-end fst-normal"> ${favorite.video.views}</i>
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
</body>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"
        integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r"
        crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js"
        integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy"
        crossorigin="anonymous"></script>
</html>
