<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - Student Performance Analyzer</title>
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
</head>
<body class="d-flex">

    <!-- Wrapper -->
    <div class="wrapper">
        <!-- Sidebar -->
        <jsp:include page="/WEB-INF/views/common/sidebar.jsp">
            <jsp:param name="active" value="dashboard"/>
        </jsp:include>

        <!-- Main Content -->
        <div id="content">
            <!-- Navbar -->
            <jsp:include page="/WEB-INF/views/common/navbar.jsp">
                <jsp:param name="title" value="Performance Dashboard"/>
            </jsp:include>

            <div class="main-container">
                <!-- Welcome Section -->
                <div class="row mb-4">
                    <div class="col-12">
                        <div class="card border-0 bg-primary bg-opacity-10 text-primary p-4 rounded-3 d-flex flex-row align-items-center justify-content-between">
                            <div>
                                <h3 class="fw-bold mb-1">Welcome back, ${sessionScope.user.username}!</h3>
                                <p class="mb-0 text-secondary">Here is an overview of the current student marks performance and statistical indicators.</p>
                            </div>
                            <div class="d-none d-md-block fs-1">
                                <i class="bi bi-mortarboard-fill"></i>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Stats Cards -->
                <div class="row g-4 mb-4">
                    <!-- Total Students -->
                    <div class="col-12 col-md-6 col-lg-3">
                        <div class="card stats-card card-primary p-3">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <h6 class="text-muted fw-semibold text-uppercase mb-1" style="font-size: 0.75rem;">Total Students</h6>
                                    <h2 class="fw-bold m-0">${totalStudents}</h2>
                                </div>
                                <div class="text-primary stats-icon">
                                    <i class="bi bi-people-fill"></i>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Class Average -->
                    <div class="col-12 col-md-6 col-lg-3">
                        <div class="card stats-card card-success p-3">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <h6 class="text-muted fw-semibold text-uppercase mb-1" style="font-size: 0.75rem;">Class Average</h6>
                                    <h2 class="fw-bold m-0">
                                        <fmt:formatNumber value="${classAverage}" maxFractionDigits="2"/>%
                                    </h2>
                                </div>
                                <div class="text-success stats-icon">
                                    <i class="bi bi-graph-up-arrow"></i>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Topper -->
                    <div class="col-12 col-md-6 col-lg-3">
                        <div class="card stats-card card-warning p-3">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <h6 class="text-muted fw-semibold text-uppercase mb-1" style="font-size: 0.75rem;">Class Topper</h6>
                                    <h4 class="fw-bold m-0 text-truncate" style="max-width: 150px;">
                                        <c:choose>
                                            <c:when test="${not empty topper}">
                                                ${topper.name}
                                            </c:when>
                                            <c:otherwise>N/A</c:otherwise>
                                        </c:choose>
                                    </h4>
                                    <span class="text-muted" style="font-size: 0.8rem;">
                                        <c:if test="${not empty topper}">Avg: <fmt:formatNumber value="${topper.average}" maxFractionDigits="1"/>%</c:if>
                                    </span>
                                </div>
                                <div class="text-warning stats-icon">
                                    <i class="bi bi-trophy-fill"></i>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Lowest Performer -->
                    <div class="col-12 col-md-6 col-lg-3">
                        <div class="card stats-card card-danger p-3">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <h6 class="text-muted fw-semibold text-uppercase mb-1" style="font-size: 0.75rem;">Lowest Performer</h6>
                                    <h4 class="fw-bold m-0 text-truncate" style="max-width: 150px;">
                                        <c:choose>
                                            <c:when test="${not empty lowest}">
                                                ${lowest.name}
                                            </c:when>
                                            <c:otherwise>N/A</c:otherwise>
                                        </c:choose>
                                    </h4>
                                    <span class="text-muted" style="font-size: 0.8rem;">
                                        <c:if test="${not empty lowest}">Avg: <fmt:formatNumber value="${lowest.average}" maxFractionDigits="1"/>%</c:if>
                                    </span>
                                </div>
                                <div class="text-danger stats-icon">
                                    <i class="bi bi-exclamation-octagon-fill"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Charts & Tables Section -->
                <div class="row g-4 mb-4">
                    <!-- Grade Distribution (Chart.js) -->
                    <div class="col-12 col-lg-5">
                        <div class="card border-0 shadow-sm p-4 h-100 bg-white">
                            <h5 class="fw-bold text-dark mb-3"><i class="bi bi-chart-pie me-2"></i>Grade Distribution</h5>
                            <c:choose>
                                <c:when test="${totalStudents > 0}">
                                    <div class="chart-container" style="position: relative; height:280px; width:100%">
                                        <canvas id="gradeChart"></canvas>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="d-flex flex-column align-items-center justify-content-center h-100 text-muted py-5">
                                        <i class="bi bi-folder-x fs-1 mb-2"></i>
                                        <p class="m-0">No student files recorded yet.</p>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>

                    <!-- Top 5 Performers (Merit list) -->
                    <div class="col-12 col-lg-7">
                        <div class="card border-0 shadow-sm p-4 h-100 bg-white">
                            <div class="d-flex justify-content-between align-items-center mb-3">
                                <h5 class="fw-bold text-dark m-0"><i class="bi bi-star-fill me-2 text-warning"></i>Top Performers</h5>
                                <a href="${pageContext.request.contextPath}/performance" class="btn btn-sm btn-outline-primary fw-semibold">View Merit List</a>
                            </div>
                            <c:choose>
                                <c:when test="${not empty topPerformers}">
                                    <div class="table-responsive">
                                        <table class="table table-hover align-middle m-0 overflow-hidden rounded-2">
                                            <thead>
                                                <tr>
                                                    <th>Rank</th>
                                                    <th>Roll ID</th>
                                                    <th>Name</th>
                                                    <th>Avg Marks</th>
                                                    <th>Grade</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach items="${topPerformers}" var="student" varStatus="status">
                                                    <tr>
                                                        <td class="fw-bold">
                                                            <c:choose>
                                                                <c:when test="${status.index == 0}">
                                                                    <span class="badge bg-gold text-dark fs-6" style="background-color: #ffd700;">🥇 1</span>
                                                                </c:when>
                                                                <c:when test="${status.index == 1}">
                                                                    <span class="badge bg-silver text-dark fs-7" style="background-color: #e2e8f0;">🥈 2</span>
                                                                </c:when>
                                                                <c:when test="${status.index == 2}">
                                                                    <span class="badge bg-bronze text-white fs-7" style="background-color: #cd7f32;">🥉 3</span>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    ${status.index + 1}
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </td>
                                                        <td><code>${student.rollNumber}</code></td>
                                                        <td class="fw-semibold">${student.name}</td>
                                                        <td class="fw-bold text-primary"><fmt:formatNumber value="${student.average}" maxFractionDigits="1"/>%</td>
                                                        <td>
                                                            <span class="grade-badge ${student.grade == 'A+' ? 'A-plus' : student.grade}">
                                                                ${student.grade}
                                                            </span>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="d-flex flex-column align-items-center justify-content-center h-100 text-muted py-5">
                                        <i class="bi bi-folder-x fs-1 mb-2"></i>
                                        <p class="m-0">No records found. Click <a href="${pageContext.request.contextPath}/students?action=new">here</a> to add a student.</p>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>

            </div>

            <!-- Footer -->
            <jsp:include page="/WEB-INF/views/common/footer.jsp" />
        </div>
    </div>

    <!-- Bootstrap 5 Bundle JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <!-- Chart.js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <c:if test="${totalStudents > 0}">
    <script>
        const ctx = document.getElementById('gradeChart').getContext('2d');
        const distribution = {
            'A+': ${gradeDistribution['A+'] != null ? gradeDistribution['A+'] : 0},
            'A': ${gradeDistribution['A'] != null ? gradeDistribution['A'] : 0},
            'B': ${gradeDistribution['B'] != null ? gradeDistribution['B'] : 0},
            'C': ${gradeDistribution['C'] != null ? gradeDistribution['C'] : 0},
            'D': ${gradeDistribution['D'] != null ? gradeDistribution['D'] : 0},
            'E': ${gradeDistribution['E'] != null ? gradeDistribution['E'] : 0},
            'F': ${gradeDistribution['F'] != null ? gradeDistribution['F'] : 0}
        };

        new Chart(ctx, {
            type: 'doughnut',
            data: {
                labels: Object.keys(distribution),
                datasets: [{
                    label: 'Students Count',
                    data: Object.values(distribution),
                    backgroundColor: [
                        '#10b981', // A+ Green
                        '#34d399', // A Light Green
                        '#3b82f6', // B Blue
                        '#fbbf24', // C Amber
                        '#f97316', // D Orange
                        '#f87171', // E Tomato
                        '#ef4444'  // F Red
                    ],
                    borderWidth: 2,
                    hoverOffset: 4
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        position: 'right',
                        labels: {
                            font: {
                                family: "'Outfit', sans-serif",
                                size: 12
                            }
                        }
                    }
                },
                cutout: '65%'
            }
        });
    </script>
    </c:if>
</body>
</html>
