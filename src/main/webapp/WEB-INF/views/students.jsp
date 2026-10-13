<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Records - Student Performance Analyzer</title>
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
            <jsp:param name="active" value="students"/>
        </jsp:include>

        <!-- Main Content -->
        <div id="content">
            <!-- Navbar -->
            <jsp:include page="/WEB-INF/views/common/navbar.jsp">
                <jsp:param name="title" value="Student Management"/>
            </jsp:include>

            <div class="main-container">

                <!-- Alert Messages -->
                <c:if test="${not empty param.success}">
                    <div class="alert alert-success alert-dismissible fade show d-flex align-items-center mb-4" role="alert">
                        <i class="bi bi-check-circle-fill me-2 fs-5"></i>
                        <div>${param.success}</div>
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </c:if>
                <c:if test="${not empty error}">
                    <div class="alert alert-danger alert-dismissible fade show d-flex align-items-center mb-4" role="alert">
                        <i class="bi bi-exclamation-triangle-fill me-2 fs-5"></i>
                        <div>${error}</div>
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </c:if>

                <!-- Search and Add Header -->
                <div class="card border-0 shadow-sm p-4 mb-4 bg-white">
                    <div class="row align-items-center g-3">
                        <!-- Search Form -->
                        <div class="col-12 col-md-8">
                            <form action="${pageContext.request.contextPath}/students" method="GET" class="d-flex gap-2">
                                <div class="input-group">
                                    <span class="input-group-text bg-light text-secondary border-end-0">
                                        <i class="bi bi-search"></i>
                                    </span>
                                    <input type="text" name="query" class="form-control bg-light border-start-0" placeholder="Search by name or roll number..." value="${query}">
                                </div>
                                <button type="submit" class="btn btn-primary px-4 fw-semibold">Search</button>
                                <c:if test="${not empty query}">
                                    <a href="${pageContext.request.contextPath}/students" class="btn btn-outline-secondary">Reset</a>
                                </c:if>
                            </form>
                        </div>
                        <!-- Add Student Trigger -->
                        <div class="col-12 col-md-4 text-md-end">
                            <a href="${pageContext.request.contextPath}/students?action=new" class="btn btn-success px-4 py-2 fw-semibold">
                                <i class="bi bi-plus-lg me-1"></i> Add Student
                            </a>
                        </div>
                    </div>
                </div>

                <!-- Student List Table -->
                <div class="card border-0 shadow-sm p-4 bg-white">
                    <h5 class="fw-bold text-dark mb-4"><i class="bi bi-list-columns-reverse me-2 text-info"></i>Student Academic Directory</h5>
                    
                    <c:choose>
                        <c:when test="${not empty students}">
                            <div class="table-responsive">
                                <table class="table table-hover align-middle m-0 rounded-3 overflow-hidden">
                                    <thead>
                                        <tr>
                                            <th>Roll No</th>
                                            <th>Name</th>
                                            <th class="text-center">Java</th>
                                            <th class="text-center">Python</th>
                                            <th class="text-center">Web</th>
                                            <th class="text-center">Android</th>
                                            <th class="text-center">OS</th>
                                            <th class="text-center">Average</th>
                                            <th class="text-center">Grade</th>
                                            <th class="text-center">Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${students}" var="student">
                                            <tr>
                                                <td><code>${student.rollNumber}</code></td>
                                                <td class="fw-semibold text-dark">${student.name}</td>
                                                <td class="text-center">${student.javaMarks}</td>
                                                <td class="text-center">${student.pythonMarks}</td>
                                                <td class="text-center">${student.webMarks}</td>
                                                <td class="text-center">${student.androidMarks}</td>
                                                <td class="text-center">${student.osMarks}</td>
                                                <td class="text-center fw-bold text-primary">
                                                    <fmt:formatNumber value="${student.average}" maxFractionDigits="1"/>%
                                                </td>
                                                <td class="text-center">
                                                    <span class="grade-badge ${student.grade == 'A+' ? 'A-plus' : student.grade}">
                                                        ${student.grade}
                                                    </span>
                                                </td>
                                                <td class="text-center">
                                                    <div class="btn-group gap-2">
                                                        <a href="${pageContext.request.contextPath}/students?action=edit&rollNumber=${student.rollNumber}" class="btn btn-sm btn-outline-primary rounded">
                                                            <i class="bi bi-pencil-square"></i> Edit
                                                        </a>
                                                        <a href="${pageContext.request.contextPath}/students?action=delete&rollNumber=${student.rollNumber}" class="btn btn-sm btn-outline-danger rounded" onclick="return confirm('Are you sure you want to delete ${student.name} (${student.rollNumber})?');">
                                                            <i class="bi bi-trash"></i> Delete
                                                        </a>
                                                    </div>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="d-flex flex-column align-items-center justify-content-center text-muted py-5">
                                <i class="bi bi-person-x fs-1 mb-2"></i>
                                <h5>No active matching files matches found.</h5>
                                <c:choose>
                                    <c:when test="${not empty query}">
                                        <p class="m-0">Try checking spelling or adjusting keyword search criteria.</p>
                                    </c:when>
                                    <c:otherwise>
                                        <p class="m-0">The directory is empty. Build records database by clicking "Add Student" above.</p>
                                    </c:otherwise>
                                </c:choose>
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
