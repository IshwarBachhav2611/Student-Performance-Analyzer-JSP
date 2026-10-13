<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div id="sidebar">
    <div class="sidebar-header">
        <i class="bi bi-activity fs-3 text-info"></i>
        <span class="fs-5 fw-bold">SPA Portal</span>
    </div>
    <ul class="list-unstyled components flex-grow-1">
        <li class="${param.active == 'dashboard' ? 'active' : ''}">
            <a href="${pageContext.request.contextPath}/dashboard">
                <i class="bi bi-speedometer2"></i> Dashboard
            </a>
        </li>
        <li class="${param.active == 'students' ? 'active' : ''}">
            <a href="${pageContext.request.contextPath}/students">
                <i class="bi bi-people"></i> Student Records
            </a>
        </li>
        <li class="${param.active == 'performance' ? 'active' : ''}">
            <a href="${pageContext.request.contextPath}/performance">
                <i class="bi bi-bar-chart-line"></i> Analytics Panel
            </a>
        </li>
    </ul>
    <div class="p-3 border-top border-secondary mt-auto">
        <div class="d-grid">
            <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline-danger btn-sm">
                <i class="bi bi-box-arrow-left me-2"></i>Logout
            </a>
        </div>
    </div>
</div>
