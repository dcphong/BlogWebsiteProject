// let isLoading = false;  // Đảm bảo rằng biến này được kiểm soát chính xác
//
// $(window).scroll(function () {
//     // Kiểm tra khi người dùng cuộn đến gần đáy trang
//     if ($(window).scrollTop() + $(window).height() >= $(document).height() - 100) {
//         if (!isLoading && !isSearching) {
//             isLoading = true;  // Đánh dấu đang tải dữ liệu
//             loadMoreVideos();  // Gọi hàm tải thêm video
//         }
//     }
// });
//
// function loadMoreVideos() {
//     var amount = document.getElementsByClassName("videoList").length;  // Số video hiện có
//
//     $.ajax({
//         url: "/UserHome/loadMore",  // URL tải thêm video
//         type: "GET",
//         data: {
//             exits: amount  // Truyền số lượng video hiện tại vào yêu cầu
//         },
//         success: function (response) {
//             var row = document.getElementById("content");
//             row.innerHTML += response;  // Thêm video mới vào trang
//
//             // Reset trạng thái isLoading sau khi tải xong
//             isLoading = false;
//
//             // Có thể kiểm tra lại chiều cao trang ở đây nếu cần
//             // $(window).trigger('scroll'); // Nếu cần kích hoạt lại scroll để cập nhật trạng thái cuộn
//         },
//         error: function () {
//             console.error("Lỗi khi tải thêm video");
//             isLoading = false;  // Đảm bảo reset isLoading khi gặp lỗi
//         }
//     });
// }
