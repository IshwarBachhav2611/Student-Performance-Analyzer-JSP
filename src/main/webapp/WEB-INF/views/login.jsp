<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Student Performance Analyzer</title>
    <!-- Google Fonts (Outfit) -->
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
</head>
<body class="auth-wrapper">

    <div class="auth-card animate__animated animate__fadeIn">
        <div class="text-center auth-header mb-4">
            <span class="d-inline-block bg-primary bg-opacity-10 text-primary p-3 rounded-circle mb-3">
                <i class="bi bi-activity fs-1"></i>
            </span>
            <h3 class="fw-bold m-0 text-dark">Student Performance</h3>
            <p class="text-muted">Sign in to access student statistics</p>
        </div>

        <c:if test="${not empty error}">
            <div class="alert alert-danger d-flex align-items-center" role="alert">
                <i class="bi bi-exclamation-triangle-fill me-2"></i>
                <div>${error}</div>
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/login" method="POST" class="needs-validation" novalidate>
            <div class="mb-3">
                <label for="username" class="form-label fw-semibold">Username</label>
                <div class="input-group">
                    <span class="input-group-text bg-light border-end-0"><i class="bi bi-person text-secondary"></i></span>
                    <input type="text" class="form-control bg-light border-start-0 ps-0" id="username" name="username" placeholder="Enter username" required value="${param.username}">
                </div>
            </div>
            
            <div class="mb-4">
                <label for="password" class="form-label fw-semibold">Password</label>
                <div class="input-group">
                    <span class="input-group-text bg-light border-end-0"><i class="bi bi-lock text-secondary"></i></span>
                    <input type="password" class="form-control bg-light border-start-0 ps-0" id="password" name="password" placeholder="Enter password" required>
                </div>
            </div>

            <div class="d-grid mb-3">
                <button type="submit" class="btn btn-primary py-2.5 fw-semibold"><i class="bi bi-box-arrow-in-right me-2"></i>Sign In</button>
            </div>
        </form>

        <div class="border-top pt-3 text-center">
            <div class="alert alert-info py-2 px-3 m-0 text-start" style="font-size: 0.825rem;">
                <h6 class="fw-bold mb-1"><i class="bi bi-info-circle-fill me-1"></i>Default Credentials</h6>
                <p class="mb-0"><strong>Username:</strong> admin <br><strong>Password:</strong> admin123</p>
            </div>
        </div>
    </div>

    <!-- Bootstrap 5 Bundle JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Form Validation Bootstrap
        (() => {
            'use strict';
            const forms = document.querySelectorAll('.needs-validation');
            Array.from(forms).forEach(form => {
                form.addEventListener('submit', event => {
                    if (!form.checkValidity()) {
                        event.preventDefault();
                        event.stopPropagation();
                    }
                    form.classList.add('was-validated');
                }, false);
            });
        })();
    </script>
</body>
</html>
