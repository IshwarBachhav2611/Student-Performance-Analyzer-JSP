<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<nav class="navbar navbar-expand-lg navbar-light bg-white border-bottom px-4 py-3">
    <div class="container-fluid p-0">
        <h4 class="m-0 fw-bold text-gray-800">${param.title}</h4>
        <div class="ms-auto d-flex align-items-center gap-3">
            <span class="badge bg-primary bg-opacity-10 text-primary border border-primary border-opacity-25 py-2 px-3 fw-bold rounded-pill">
                <i class="bi bi-person-circle me-1"></i> Admin: ${sessionScope.user.username}
            </span>
        </div>
    </div>
</nav>
