<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Academic Analysis - Student Performance Analyzer</title>
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
            <jsp:param name="active" value="performance"/>
        </jsp:include>

        <!-- Main Content -->
        <div id="content">
            <!-- Navbar -->
            <jsp:include page="/WEB-INF/views/common/navbar.jsp">
                <jsp:param name="title" value="Academic Performance Analysis"/>
            </jsp:include>

            <div class="main-container">

                <div class="row g-4 mb-4">
                    <!-- Class Metrics Card -->
                    <div class="col-12 col-md-4">
                        <div class="card border-0 shadow-sm p-4 bg-white h-100">
                            <h5 class="fw-bold mb-3"><i class="bi bi-graph-up text-primary me-2"></i>Class Statistics</h5>
                            <hr>
                            <div class="d-flex justify-content-between mb-3">
                                <span class="text-secondary">Class Average:</span>
                                <span class="fw-bold text-dark"><fmt:formatNumber value="${classAverage}" maxFractionDigits="2"/>%</span>
                            </div>
                            <div class="d-flex justify-content-between mb-3">
                                <span class="text-secondary">Total Records:</span>
                                <span class="fw-bold text-dark">${meritList.size()} students</span>
                            </div>
                            <div class="d-flex justify-content-between mb-3">
                                <span class="text-secondary">Highest Scorer:</span>
                                <span class="fw-bold text-success">${not empty topper ? topper.name : 'N/A'}</span>
                            </div>
                            <div class="d-flex justify-content-between">
                                <span class="text-secondary">Lowest Scorer:</span>
                                <span class="fw-bold text-danger">${not empty lowest ? lowest.name : 'N/A'}</span>
                            </div>
                        </div>
                    </div>

                    <!-- Grade Distribution Counters -->
                    <div class="col-12 col-md-8">
                        <div class="card border-0 shadow-sm p-4 bg-white h-100">
                            <h5 class="fw-bold mb-3"><i class="bi bi-pie-chart text-info me-2"></i>Grade Cohort Summary</h5>
                            <hr>
                            <div class="row g-2 justify-content-center text-center">
                                <div class="col-4 col-sm-2">
                                    <div class="bg-success bg-opacity-10 border border-success border-opacity-25 rounded p-2">
                                        <span class="fs-4 fw-bold text-success">${gradeDistribution['A+']}</span>
                                        <div class="small fw-semibold text-success">A+</div>
                                    </div>
                                </div>
                                <div class="col-4 col-sm-2">
                                    <div class="bg-success bg-opacity-10 border border-success border-opacity-25 rounded p-2">
                                        <span class="fs-4 fw-bold text-success">${gradeDistribution['A']}</span>
                                        <div class="small fw-semibold text-success">A</div>
                                    </div>
                                </div>
                                <div class="col-4 col-sm-2">
                                    <div class="bg-primary bg-opacity-10 border border-primary border-opacity-25 rounded p-2">
                                        <span class="fs-4 fw-bold text-primary">${gradeDistribution['B']}</span>
                                        <div class="small fw-semibold text-primary">B</div>
                                    </div>
                                </div>
                                <div class="col-4 col-sm-2">
                                    <div class="bg-warning bg-opacity-10 border border-warning border-opacity-25 rounded p-2">
                                        <span class="fs-4 fw-bold text-warning">${gradeDistribution['C']}</span>
                                        <div class="small fw-semibold text-warning">C</div>
                                    </div>
                                </div>
                                <div class="col-4 col-sm-2">
                                    <div class="bg-warning bg-opacity-10 border border-warning border-opacity-25 rounded p-2">
                                        <span class="fs-4 fw-bold text-warning">${gradeDistribution['D']}</span>
                                        <div class="small fw-semibold text-warning">D</div>
                                    </div>
                                </div>
                                <div class="col-4 col-sm-2">
                                    <div class="bg-danger bg-opacity-10 border border-danger border-opacity-25 rounded p-2">
                                        <span class="fs-4 fw-bold text-danger">${gradeDistribution['E'] + gradeDistribution['F']}</span>
                                        <div class="small fw-semibold text-danger">Fail (E/F)</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Complete Merit List -->
                <div class="card border-0 shadow-sm p-4 bg-white">
                    <h5 class="fw-bold mb-4"><i class="bi bi-award-fill text-warning me-2"></i>Class Merit List & Subject Breakdown</h5>
                    
                    <c:choose>
                        <c:when test="${not empty meritList}">
                            <div class="table-responsive">
                                <table class="table table-hover align-middle m-0 rounded-3 overflow-hidden text-center">
                                    <thead>
                                        <tr class="table-light">
                                            <th>Rank</th>
                                            <th>Roll No</th>
                                            <th class="text-start">Name</th>
                                            <th>Java</th>
                                            <th>Python</th>
                                            <th>Web Tech</th>
                                            <th>Android</th>
                                            <th>OS</th>
                                            <th>Average</th>
                                            <th>Grade</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${meritList}" var="student" varStatus="status">
                                            <tr>
                                                <td class="fw-bold text-dark">${status.index + 1}</td>
                                                <td><code>${student.rollNumber}</code></td>
                                                <td class="text-start fw-semibold text-dark">${student.name}</td>
                                                <td>${student.javaMarks}</td>
                                                <td>${student.pythonMarks}</td>
                                                <td>${student.webMarks}</td>
                                                <td>${student.androidMarks}</td>
                                                <td>${student.osMarks}</td>
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
                            <div class="d-flex flex-column align-items-center justify-content-center text-muted py-5">
                                <i class="bi bi-file-earmark-bar-graph fs-1 mb-2"></i>
                                <h5>No active matching files matches found.</h5>
                                <p class="m-0">Please register students to review merit logs.</p>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>

            </div>

            <!-- Footer -->
            <jsp:include page="/WEB-INF/views/common/footer.jsp" />
        </div>
    </div>

    <!-- Bootstrap 5 Bundle JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
