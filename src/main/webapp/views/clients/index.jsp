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
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fun" %>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
      integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
<link rel="stylesheet" href="/css/styles.css">
<body class="p-0 m-0 bg-ytb scrollbar-hidden" style="margin: 0px;padding: 0px ">
<c:url value="/UserHome" var="url" scope="request"/>
<div class="container-fluid h-100 position-relative">
    <!-- NAVBAR and REGISTER / LOGIN FORM -->
    <%@include file="/views/common/clients/header.jsp" %>
    <!-- END NAVBAR and REGISTER / LOGIN FORM -->

    <!-- SUB -->
    <div class="row">
        <div class="col-12 bg-ytb p-2">

            <div class="col-12 d-flex justify-content-center gap-2">
                <button type="submit" id="filterTop10" class="btn bg-button-ytb mx-1 rounded-1">Top 10 video</button>
                <button type="submit" class="btn bg-button-ytb mx-1 rounded-1">Tất cả</button>
                <button type="submit" class="btn bg-button-ytb mx-1 rounded-1">Nút lọc</button>
                <button type="submit" class="btn bg-button-ytb mx-1 rounded-1">Nút lọc</button>
            </div>
        </div>
    </div>
    <!-- END SUB -->

    <div class="row vh-100 mb-2">
        <div class="col-md-1 col-12 p-0">
            <!-- SIDEBAR -->
            <%@include file="/views/common/clients/sidebar.jsp" %>
            >
            <!-- END SIDEBAR -->
        </div>

        <!-- CONTENT -->
        <div class="col-11 scrollbar-hidden d-flex">
            <div id="content" class="row row-cols-1  row-cols-md-4 row-gap-4 mt-2">
                <c:forEach items="${vList}" var="video">
                    <div class="col videoList mb-md-2 mb-5" style="height: 250px">
                        <c:url value="/videoDetails?vId=${video.id}" var="vId"/>
                        <a href="${vId}" class="link-ytb">
                            <div class="card border-0 bg-ytb">
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

        <!-- OVERLAY -->
        <div id="overlay" class="position-fixed z-3 top-0 start-0 w-100 h-100 bg-dark opacity-50 d-none"></div>

        <!-- Spinner -->
        <div id="HomeLoadingSpinner"
             class="spinner-border text-light position-fixed top-50 start-50 d-none" role="status">
            <span class="visually-hidden">Loading...</span>
        </div>

        <div class="row justify-content-center w-100 p-0 m-0" style="height: 50px">
            <c:set value="${applicationScope.currentPage}" var="currentPage"/>
            <input type="hidden" id="currentPage" value="${currentPage}"/>
            <div id="pagination" class=" d-flex justify-content-center align-items-center">
                <button class="btn btn-outline-light mx-1" id="firstPage">
                    <i class="bi bi-chevron-double-left"></i>
                </button>
                <button class="btn btn-outline-light mx-1" id="prevPage">
                    <i class="bi bi-chevron-left"></i>
                </button>

                <c:forEach begin="1" end="${pageNumbers}" var="i">
                    <button name="paginationNum" value="${i}" class="btn btn-outline-light mx-1 pageButton">
                            ${i}
                    </button>
                </c:forEach>

                <button class="btn btn-outline-light mx-1" id="nextPage">
                    <i class="bi bi-chevron-right"></i>
                </button>
                <button class="btn btn-outline-light mx-1" id="lastPage">
                    <i class="bi bi-chevron-double-right"></i>
                </button>
            </div>
        </div>
        <!-- END CONTENT -->
    </div>

    <!-- PAGE NUMBERS PLACE -->
</div>
</body>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"
        integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r"
        crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js"
        integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy"
        crossorigin="anonymous"></script>
<script src="/js/home.js"></script>
<script>
    let spinner = $('#HomeLoadingSpinner');
    let overlay = $('#overlay');

    $(document).ready(() => {
        $('#searchInput').on('input', function () {
            var searchValue = $('#searchInput').val().trim();
            if (searchValue.length > 0) {
                $.ajax({
                    url: '/UserHome/findSuggestions',
                    type: 'POST',
                    data: {valueSearch: searchValue},
                    success: function (response) {
                        var suggestions = response.suggestions;
                        showSuggestions(suggestions)
                    },
                    error: function () {
                        console.log('Da co loi khong the tim kiem!!!')
                    }
                });
            } else {
                console.log('Chua nhap du lieu search!')
                $('#suggestions').hide();
            }
        });

        const showSuggestions = (suggestions) => {
            $('#suggestions').empty();

            if (suggestions.length > 0) {
                suggestions.forEach((suggestion) => {
                    $('#searchInput').toggleClass('rounded-bottom-0')
                    $('#buttonSearch').toggleClass('rounded-bottom-0')
                    $('#suggestions').append('<a href="#" class="list-group-item position-absolute rounded-top-0 list-group-item-action">' + suggestion + '</a>')
                });
                $('#suggestions').show();
            } else {
                $('#searchInput').toggleClass('rounded-bottom-0')
                $('#buttonSearch').toggleClass('rounded-bottom-0')
                $('#suggestions').hide();
            }
        };

        $(document).click((event) => {
            if (!$(event.target).closest('#searchInput').length) {
                $('#suggestions').hide()
            }
        });

        $('#filterTop10').on('click', () => {
            spinner.removeClass('d-none');
            overlay.removeClass('d-none');
            setTimeout(() => {
                $.ajax({
                    url: '/UserHome/filterTop10',
                    type: 'POST',
                    success: (response) => {
                        var row = document.getElementById('content')
                        row.innerHTML = "";
                        row.innerHTML += response;
                        spinner.addClass('d-none');
                        overlay.addClass('d-none');
                    }, error: () => {
                        spinner.addClass('d-none');
                        overlay.addClass('d-none');
                    },
                    complete: () => {
                        $('#HomeLoadingSpinner').removeClass('d-none')
                        spinner.addClass('d-none');
                        overlay.addClass('d-none');
                    }
                })
            }, 500)
        })

        $(document).ready(function () {
            $('#buttonSearch').on('click', () => {
                var searchValue = $('#searchInput').val().trim();
                isSearching = true;

                $.ajax({
                    url: '/UserHome/Search',
                    type: 'POST',
                    data: {value: searchValue},
                    success: (response) => {
                        var row = document.getElementById('content')
                        console.log(response)
                        row.innerHTML = "";
                        row.innerHTML += response;
                    },
                    error: (error) => {
                        isSearching = false;
                        console.log('Loi gi khong biet nx!', error)
                    }
                })
            })
        })

    })
</script>
<script>
    document.addEventListener("DOMContentLoaded", () => {
        const spinner = document.getElementById("HomeLoadingSpinner");
        const overlay = document.getElementById("overlay");
        const paginationButtons = document.querySelectorAll("[name='paginationNum']");
        const content = document.getElementById("content");
        const loginMessage = document.getElementById('loginMessage');

        paginationButtons.forEach((button) => {
            button.addEventListener("click", async () => {
                const value = button.value;
                document.getElementById('currentPage').value = value;
                
                spinner.classList.remove("d-none");
                overlay.classList.remove("d-none");

                try {
                    const response = await fetch("/UserHome/pagination", {
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
                } catch (error) {
                    console.error("Đã xảy ra lỗi:", error);
                } finally {
                    spinner.classList.add("d-none");
                    overlay.classList.add("d-none");
                }
            });
        });

        document.getElementById('firstPage').addEventListener('click', async function () {

            spinner.classList.remove("d-none");
            overlay.classList.remove("d-none");
            try {
                const response = await fetch('/UserHome/paginationButton', {
                        method: 'POST',
                        headers: {
                            "Content-Type": "application/x-www-form-urlencoded",
                        },
                        body: new URLSearchParams({paginationButton: 'firstPage'}),
                    })
                ;
                if (!response.ok) {
                    throw new Error(`HTTP error! Status: ${response.status}`);
                }
                const responseData = await response.text();
                content.innerHTML = responseData;
            } catch (error) {
                console.log("loi phan trang", error)
            } finally {
                spinner.classList.add("d-none");
                overlay.classList.add("d-none");
            }
        })

        document.getElementById('lastPage').addEventListener('click', async function () {

            spinner.classList.remove("d-none");
            overlay.classList.remove("d-none");
            try {
                const response = await fetch('/UserHome/paginationButton', {
                        method: 'POST',
                        headers: {
                            "Content-Type": "application/x-www-form-urlencoded",
                        },
                        body: new URLSearchParams({paginationButton: 'lastPage'}),
                    })
                ;
                if (!response.ok) {
                    throw new Error(`HTTP error! Status: ${response.status}`);
                }
                const responseData = await response.text();
                content.innerHTML = responseData;
            } catch (error) {
                console.log("loi phan trang", error)
            } finally {
                spinner.classList.add("d-none");
                overlay.classList.add("d-none");
            }
        })

        document.getElementById('nextPage').addEventListener('click', async function () {
            let currentPage = document.getElementById('currentPage').value;
            currentPage = parseInt(currentPage) + 1;
            document.getElementById('currentPage').value = currentPage;

            spinner.classList.remove("d-none");
            overlay.classList.remove("d-none");
            try {
                const response = await fetch('/UserHome/paginationButton', {
                        method: 'POST',
                        headers: {
                            "Content-Type": "application/x-www-form-urlencoded",
                        },
                        body: new URLSearchParams({paginationButton: 'nextPage', currentPage: currentPage}),
                    })
                ;
                if (!response.ok) {
                    throw new Error(`HTTP error! Status: ${response.status}`);
                }
                const responseData = await response.text();
                content.innerHTML = responseData;
            } catch (error) {
                console.log("loi phan trang", error)
            } finally {
                spinner.classList.add("d-none");
                overlay.classList.add("d-none");
            }
        })

        document.getElementById('prevPage').addEventListener('click', async function () {
            const currentPage = document.getElementById('currentPage').value;
            const nextPage = parseInt(currentPage) - 1;
            document.getElementById('currentPage').value = nextPage;
            spinner.classList.remove("d-none");
            overlay.classList.remove("d-none");
            try {
                const response = await fetch('/UserHome/paginationButton', {
                        method: 'POST',
                        headers: {
                            "Content-Type": "application/x-www-form-urlencoded",
                        },
                        body: new URLSearchParams({paginationButton: 'prevPage', currentPage: currentPage}),
                    })
                ;
                if (!response.ok) {
                    throw new Error(`HTTP error! Status: ${response.status}`);
                }
                const responseData = await response.text();
                content.innerHTML = responseData;
            } catch (error) {
                console.log("loi phan trang", error)
            } finally {
                spinner.classList.add("d-none");
                overlay.classList.add("d-none");
            }
        })
    });
</script>

</html>
