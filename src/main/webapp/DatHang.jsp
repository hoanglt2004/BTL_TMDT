<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <title>Đặt hàng - Fashion Family</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css">
        <style>
            body {
                background-color: #f8f9fa;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }
            .order-container {
                max-width: 800px;
                margin: 40px auto;
                padding: 20px;
            }
            .order-form {
                background: white;
                padding: 30px;
                border-radius: 10px;
                box-shadow: 0 0 20px rgba(0,0,0,0.1);
            }
            .form-title {
                color: #333;
                text-align: center;
                margin-bottom: 30px;
                font-weight: 600;
            }
            .form-group {
                margin-bottom: 20px;
            }
            .form-control {
                border-radius: 5px;
                padding: 12px;
                border: 1px solid #ddd;
                transition: all 0.3s ease;
            }
            .form-control:focus {
                border-color: #28a745;
                box-shadow: 0 0 0 0.2rem rgba(40, 167, 69, 0.25);
            }
            .btn-order {
                background-color: #28a745;
                color: white;
                padding: 12px;
                border-radius: 5px;
                font-weight: 600;
                transition: all 0.3s ease;
            }
            .btn-order:hover {
                background-color: #218838;
                transform: translateY(-2px);
            }
            .alert {
                border-radius: 5px;
                margin-bottom: 20px;
            }
            .form-label {
                font-weight: 500;
                color: #555;
                margin-bottom: 8px;
            }
            .required-field::after {
                content: " *";
                color: #dc3545;
            }
            .order-summary {
                background: #f8f9fa;
                padding: 20px;
                border-radius: 5px;
                margin-bottom: 20px;
            }
            .order-summary h4 {
                color: #333;
                margin-bottom: 15px;
            }
            .order-summary p {
                margin-bottom: 10px;
                color: #666;
            }
            .order-summary .total {
                font-size: 1.2em;
                font-weight: 600;
                color: #28a745;
            }
        </style>
    </head>
    <body>
        <jsp:include page="Menu.jsp"></jsp:include>
        
        <div class="order-container">
            <div class="order-form">
                <h2 class="form-title">Thông tin đặt hàng</h2>
                
                <c:if test="${error!=null}">
                    <div class="alert alert-danger" role="alert">
                        <i class="fas fa-exclamation-circle"></i> ${error}
                    </div>
                </c:if>
                <c:if test="${mess!=null}">
                    <div class="alert alert-success" role="alert">
                        <i class="fas fa-check-circle"></i> ${mess}
                    </div>
                </c:if>

                <form action="order" method="post" accept-charset="UTF-8">
                    <div class="form-group">
                        <label for="name" class="form-label required-field">Họ và tên</label>
                        <input name="name" type="text" id="name" class="form-control" 
                               placeholder="Nhập họ và tên của bạn" required>
                    </div>

                    <div class="form-group">
                        <label for="phoneNumber" class="form-label required-field">Số điện thoại</label>
                        <input name="phoneNumber" type="tel" id="phoneNumber" class="form-control" 
                               placeholder="Nhập số điện thoại của bạn" required>
                    </div>

                    <div class="form-group">
                        <label for="email" class="form-label required-field">Email</label>
                        <input name="email" type="email" id="email" class="form-control" 
                               placeholder="Nhập địa chỉ email của bạn" required>
                    </div>

                    <div class="form-group">
                        <label for="deliveryAddress" class="form-label required-field">Địa chỉ giao hàng</label>
                        <textarea name="deliveryAddress" id="deliveryAddress" class="form-control" 
                                  rows="3" placeholder="Nhập địa chỉ giao hàng chi tiết" required></textarea>
                    </div>

                    <div class="order-summary">
                        <h4><i class="fas fa-info-circle"></i> Lưu ý</h4>
                        <p><i class="fas fa-check text-success"></i> Miễn phí vận chuyển cho đơn hàng từ 500.000đ</p>
                        <p><i class="fas fa-check text-success"></i> Giao hàng toàn quốc trong 2-4 ngày làm việc</p>
                        <p><i class="fas fa-check text-success"></i> Thanh toán khi nhận hàng (COD)</p>
                    </div>

                    <button class="btn btn-order btn-block" type="submit">
                        <i class="fas fa-shopping-cart"></i> Đặt hàng ngay
                    </button>
                </form>
            </div>
        </div>

        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
        <script>
            window.addEventListener("load", function loadAmountCart() {
                $.ajax({
                    url: "/WebsiteBanSua/loadAllAmountCart",
                    type: "get",
                    success: function(responseData) {
                        document.getElementById("amountCart").innerHTML = responseData;
                    }
                });
            }, false);
        </script>
    </body>
</html>