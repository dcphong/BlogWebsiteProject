$(document).ready(function () {
    
    $('#registerForm').submit(function (e) {
        e.preventDefault();
        var formData = $(this).serialize();

        setTimeout(() => {
            $.ajax({
                url: '/UserHome/register',
                type: 'POST',
                data: formData,
                dataType: 'json',
                success: function (response) {
                    $('#eRegisterUsername').text('');
                    $('#eRegisterPassword').text('');
                    $('#e2faRegisterPassword').text('');
                    $('#registerMessage').text('');
                    $('#eRegisterEmail').text('');
                    console.log(response);
                    if (response.status === 'success') {
                        $('#registerMessage').text(response.message).removeClass('text-danger').addClass('text-success');
                    } else {
                        if (response.errors.eUsername) {
                            $('#eRegisterUsername').text(response.errors.eUsername).addClass('text-danger');
                        }
                        if (response.errors.ePassword) {
                            $('#eRegisterPassword').text(response.errors.ePassword).addClass('text-danger');
                        }
                        if (response.errors.e2faPassword) {
                            $('#e2faRegisterPassword').text(response.errors.e2faPassword).addClass('text-danger');
                        }
                        if (response.errors.eEmail) {
                            $('#eRegisterEmail').text(response.errors.eEmail).addClass('text-danger');
                        }
                    }
                },
                error: function (xhr, status, error) {
                    console.error("Error:", error);
                    $('#registerMessage').text('Có lỗi sảy ra vui lòng thử lại sao ít phút').addClass('text-danger')
                }
            });
        }, 500)
    });

    $('#loginForm').submit(function (e) {
        e.preventDefault();
        var formData = $(this).serialize();


        $.ajax({
            url: '/UserHome/login',
            type: 'POST',
            data: formData,
            dataType: 'json',
            success: function (response) {
                // Xóa các thông báo lỗi cũ
                $('#loginMessage').text('');

                if (response.status === 'success') {
                    window.location.href = '/UserHome';
                } else {
                    $('#loginMessage').text(response.message).addClass('text-danger');
                }
            },
            error: function (xhr, status, error) {
                console.error("Error:", error);
                $('#loginMessage').text('Sai tên đăng nhập hoặc mật khẩu!').addClass('text-danger');
            }
        });
    });

    $('#pEditForm').submit(function (e) {
        e.preventDefault();
        var formData = $(this).serialize();

        $.ajax({
            url: '/UserHome/passwordEdit',
            type: 'POST',
            data: formData,
            dataType: 'json',
            success: function (response) {
                $('#ePass1Message').text('');
                $('#ePass2Message').text('');
                $('#ePass3Message').text('');
                console.log(response);
                if (response.status === 'success') {
                    $('#ePass2Message').text(response.message).removeClass('text-danger').addClass('text-success');
                } else {
                    if (response.errors) {
                        if (response.errors.ePass1Message) {
                            $('#ePass1Message').text(response.errors.ePass1Message).addClass('text-danger');
                        }
                        if (response.errors.ePass2Message) {
                            $('#ePass2Message').text(response.errors.ePass2Message).addClass('text-danger');
                        }
                        if (response.errors.ePass3Message) {
                            $('#ePass3Message').text(response.errors.ePass3Message).addClass('text-danger');
                        }
                    }
                }
            },
            error: function (xhr, status, error) {
                console.error("Error:", error);
                $('#ePass3Message').text('Có lỗi xảy ra vui lòng thử lại sau!').addClass('text-danger');
            }
        });
    });
});


