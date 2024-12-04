<%--
  Created by IntelliJ IDEA.
  User: doanc
  Date: 05/11/2024
  Time: 16:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Video chi tiết</title>
</head>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fun" %>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
      integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
<link rel="stylesheet" href="/css/styles.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

<body class="p-0 m-0 bg-ytb " style="margin: 0px;padding: 0px">
<div class="container-fluid ">
    <!-- HEADER NAVBAR -->
    <%@include file="/views/common/clients/header.jsp" %>
    <!-- END HEADER NAVBAR -->
    <div class="row">
        <c:set value="${videoDetails}" var="video" scope="request"/>
        <div class="col-md-8 col-12 px-4 ">
            <c:url value="/imageLoad" var="imgApi"/>
            <div class="overflow-hidden rounded-3" style="height: 750px">
                <img src="${imgApi}?imageName=${video.poster}" class="rounded-3 object-fit shadow-5 mt-4" alt=""
                     style="width: 95%;">
            </div>
            <h1 class="fs-5 text-light mt-2 mx-3">${video.title}</h1>
            <hr class="text-light">
            <div class="row">
                <div class="mx-3 col-5 p-0 m-0">
                    <i class=" bi bi-eye float-start fst-normal text-light"> <span class="fs-6 fw-normal">${video.views} Lượt xem</span>
                    </i>
                </div>
                <div class="col-md-6 col-12">
                    <div class="input-group float-end d-flex justify-content-end">

                        <button id="likeButton" type="button" data-video-id="${video.id}" data-user-id="${userLogin.id}"
                                class="btn ${userIsLiked != null ? 'bg-light text-black' : 'text-light bg-button-ytb'} rounded-5 border-secondary">
                            <i class="fa-regular fa-thumbs-up"></i>
                            <span id="likeCount">${video.favorites.size()}</span>
                        </button><!-- LIKE BUTTON -->

                        <button id="buttonShareByUser" type="button" data-user-share-id="${userLogin.id}"
                                class="btn bg-button-ytb w-25 mx-2 rounded-5 border-secondary" data-bs-toggle="modal">
                            <i class="fa-solid fa-share"></i> Chia sẻ
                        </button>

                    </div>
                </div>
            </div>
            <div class="row mb-3 mt-3">
                <div class="bg-description mx-3 rounded-3" style="width: 95%">
                    <p class="card-text text-light mb-5">
                        ${video.description}
                    </p>
                </div>
            </div>
        </div>

        <!-- LIST OTHER VIDEO -->
        <div id="contentDetails" class="col-md-4 col-12 overflow-auto mt-2 scrollbar-hidden" style="height: 750px;">
            <c:url value="/imageLoad" var="imgApi"/>
            <c:forEach items="${vList}" var="videoOther">
                <c:url value="/videoDetails?vId=${videoOther.id}" var="vIdUrl"/>
                <a href="${vIdUrl}" class="link-ytb">
                    <div class="row videoList mb-2" style="height: 150px;">
                        <div class="col-6 overflow-hidden" style="height: 150px">
                            <img src="${imgApi}?imageName=${videoOther.poster}" class="rounded-3 w-100 object-fit"
                                 alt="">
                        </div>
                        <div class="col-6 text-light">
                            <h5 class="fs-6 fw-bold">
                                <c:choose>
                                    <c:when test="${fun:length(videoOther.title) > 40}">
                                        ${fun:substring(videoOther.title,0,40)}...
                                    </c:when>
                                    <c:otherwise>
                                        ${videoOther.title}
                                    </c:otherwise>
                                </c:choose>
                            </h5>
                            <p>
                                <c:choose>
                                    <c:when test="${fun:length(videoOther.description) > 60}">
                                        ${fun:substring(videoOther.description,0,60)}...
                                    </c:when>
                                    <c:otherwise>
                                        ${videoOther.description}
                                    </c:otherwise>
                                </c:choose>
                            </p>
                            <div class="text-light"><i class="bi bi-eye float-end fst-normal"> ${videoOther.views}</i>
                            </div>
                        </div>
                    </div>
                </a>
            </c:forEach>
        </div>
        <!-- END LIST OTHER VIDEO -->

    </div>
    <!-- END NAVBAR -->
</div>

<!-- MODAL -->
<div class="modal fade" id="shareForm" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content bg-ytb">
            <form action="" class="" id="shareForms" method="POST">
                <div class="modal-header bg-ytb text-light">
                    <h1 class="modal-title fs-5" id="exampleModalLabel">Share video</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>

                <div class="modal-body bg-dark text-light">
                    <input type="hidden" name="videoIdShare" value="${video.id}"/>
                    <input type="hidden" name="userLoginIdShare" value="${userLogin.id}"/>
                    <label for="emailToSend" class="form-label">Chia sẻ video tới email:</label>
                    <input type="text" name="to" placeholder="Nhập email muốn chia sẻ..." id="emailToSend"
                           class="form-control mb-3">
                    <span id="emailShareMessage" class="text-danger d-block"></span>

                    <div id="loadingSpinner" class="d-none text-center">
                        <div class="spinner-border text-light" role="status">
                            <span class="visually-hidden">Loading...</span>
                        </div>
                        Đang gửi email...
                    </div>
                </div>

                <div class="modal-footer bg-ytb text-light">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                    <button type="submit" name="shareButton" class="btn btn-primary">Chia sẻ</button>
                </div>
            </form>
        </div>
    </div>
</div>
<!-- END MODAL -->

</body>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"
        integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r"
        crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js"
        integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy"
        crossorigin="anonymous"></script>
<script>
    var myModal = new bootstrap.Modal(document.getElementById('tabsFormLogin'));
    var shareModal = new bootstrap.Modal(document.getElementById('shareForm'));

    $(document).ready(function () {
        $('#likeButton').on('click', function () {
            const videoId = $(this).data('video-id')
            const userId = $(this).data('user-id')
            if (userId == '') {
                $('#tabsFormLogin a[href="#login"]').tab('show');
                myModal.show();
                $('#loginMessage').text('Vui lòng đăng nhập trước khi like!').addClass('text-danger').removeClass('text-success')

            } else {
                $.ajax({
                    url: '/UserHome/like',
                    type: 'POST',
                    data: {
                        vId: videoId,
                        uId: userId
                    },
                    success: function (response) {
                        $('#likeCount').text(response.likes);
                        $('#likeButton').toggleClass('bg-light text-black', response.liked)
                    },
                    error: function (xhr, status, error) {
                        console.error('Loi roi!', error)
                    }
                })
            }
        });

        $('#buttonShareByUser').on('click', function () {
            const userShareId = $(this).data('user-share-id')
            console.log(userShareId)
            if (userShareId == '' || userShareId == null) {
                $('#shareForm').modal('hide');
                $('#tabsFormLogin a[href="#login"]').tab('show');
                myModal.show();
                $('#loginMessage').text('Vui lòng đăng nhập trước khi share!').addClass('text-danger').removeClass('text-success')
            } else {
                myModal.hide();
                $('#shareForm').modal('show');
            }
        });

        $('#shareForms').submit(function () {
            const emailAddress = $('#emailToSend');

            if (emailAddress == '') {
                $('#emailShareMessage').text('Vui lòng nhập email muốn share!')
            } else {
                $('#loadingSpinner').removeClass('d-none');
                var formData = $(this).serialize();
                $.ajax({
                    url: '/UserHome/share',
                    type: 'POST',
                    data: formData,
                    dataType: 'json',
                    success: (response) => {
                        if (response.status === 'success') {
                            $('#emailShareMessage').text(response.message).addClass('text-success').removeClass('text-danger')
                        } else {
                            $('#emailShareMessage').text('Lỗi xảy ra khi gửi email').addClass('text-danger')
                        }
                    },
                    error: (error) => {
                        console.log(error);
                        $('#emailShareMessage').text('Đã xảy ra lỗi không mong muốn!').addClass('text-danger')
                    },
                    complete: () => {
                        $('#loadingSpinner').addClass('d-none');
                    }
                });
            }
        });

    });
</script>
</html>
