<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${isEdit ? 'Edit' : 'Add'} Student - Student Performance Analyzer</title>
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
                <jsp:param name="title" value="${isEdit ? 'Modify Student Record' : 'Enroll New Student'}"/>
            </jsp:include>

            <div class="main-container">

                <!-- Back button link -->
                <div class="mb-4">
                    <a href="${pageContext.request.contextPath}/students" class="btn btn-sm btn-outline-secondary fw-semibold">
                        <i class="bi bi-arrow-left"></i> Back to Student Directory
                    </a>
                </div>

                <!-- Server Side Validation Alerts -->
                <c:if test="${not empty error}">
                    <div class="alert alert-danger d-flex align-items-center mb-4" role="alert">
                        <i class="bi bi-exclamation-octagon-fill me-2 fs-5"></i>
                        <div>${error}</div>
                    </div>
                </c:if>

                <!-- Form Card -->
                <div class="card border-0 shadow-sm p-4 bg-white" style="max-width: 800px;">
                    <div class="border-bottom pb-3 mb-4">
                        <h5 class="fw-bold m-0"><i class="bi bi-file-earmark-person me-2 text-primary"></i>Student Marks Sheet Data</h5>
                        <p class="text-muted m-0 small">Please provide the identification profile and subject marks (between 0 and 100).</p>
                    </div>

                    <form action="${pageContext.request.contextPath}/students" method="POST" class="needs-validation" novalidate>
                        <!-- Action hidden values -->
                        <input type="hidden" name="action" value="save">
                        <input type="hidden" name="isEdit" value="${isEdit}">
                        
                        <!-- Profile section -->
                        <div class="row g-3 mb-4">
                            <!-- Roll number -->
                            <div class="col-12 col-md-4">
                                <label for="rollNumber" class="form-label fw-semibold">Roll Number</label>
                                <c:choose>
                                    <c:when test="${isEdit}">
                                        <!-- Readonly in Edit Mode -->
                                        <input type="text" class="form-control bg-light" id="rollNumberDisplay" value="${student.rollNumber}" disabled>
                                        <input type="hidden" name="rollNumber" value="${student.rollNumber}">
                                    </c:when>
                                    <c:otherwise>
                                        <!-- Enabled in New Mode -->
                                        <input type="text" class="form-control" id="rollNumber" name="rollNumber" placeholder="e.g. STU101" required value="${student.rollNumber}">
                                        <div class="invalid-feedback">Please enter a unique Roll Number.</div>
                                    </c:otherwise>
                                </c:choose>
                            </div>

                            <!-- Name -->
                            <div class="col-12 col-md-8">
                                <label for="name" class="form-label fw-semibold">Full Name</label>
                                <input type="text" class="form-control" id="name" name="name" placeholder="e.g. John Doe" required value="${student.name}">
                                <div class="invalid-feedback">Student name is required.</div>
                            </div>
                        </div>

                        <!-- Marks section -->
                        <h6 class="fw-bold text-secondary border-bottom pb-2 mb-3">Academic Performance Marks (0 - 100)</h6>
                        
                        <div class="row g-3 mb-4">
                            <!-- Java Marks -->
                            <div class="col-12 col-sm-6 col-md-4">
                                <label for="javaMarks" class="form-label fw-semibold">Java Programming</label>
                                <input type="number" class="form-control" id="javaMarks" name="javaMarks" min="0" max="100" placeholder="0-100" required value="${student != null ? student.javaMarks : ''}">
                                <div class="invalid-feedback">Enter marks between 0 and 100.</div>
                            </div>

                            <!-- Python Marks -->
                            <div class="col-12 col-sm-6 col-md-4">
                                <label for="pythonMarks" class="form-label fw-semibold">Python Programming</label>
                                <input type="number" class="form-control" id="pythonMarks" name="pythonMarks" min="0" max="100" placeholder="0-100" required value="${student != null ? student.pythonMarks : ''}">
                                <div class="invalid-feedback">Enter marks between 0 and 100.</div>
                            </div>

                            <!-- Web Tech Marks -->
                            <div class="col-12 col-sm-6 col-md-4">
                                <label for="webMarks" class="form-label fw-semibold">Web Technologies</label>
                                <input type="number" class="form-control" id="webMarks" name="webMarks" min="0" max="100" placeholder="0-100" required value="${student != null ? student.webMarks : ''}">
                                <div class="invalid-feedback">Enter marks between 0 and 100.</div>
                            </div>

                            <!-- Android Marks -->
                            <div class="col-12 col-sm-6 col-md-4">
                                <label for="androidMarks" class="form-label fw-semibold">Android Development</label>
                                <input type="number" class="form-control" id="androidMarks" name="androidMarks" min="0" max="100" placeholder="0-100" required value="${student != null ? student.androidMarks : ''}">
                                <div class="invalid-feedback">Enter marks between 0 and 100.</div>
                            </div>

                            <!-- OS Marks -->
                            <div class="col-12 col-sm-6 col-md-4">
                                <label for="osMarks" class="form-label fw-semibold">Operating Systems</label>
                                <input type="number" class="form-control" id="osMarks" name="osMarks" min="0" max="100" placeholder="0-100" required value="${student != null ? student.osMarks : ''}">
                                <div class="invalid-feedback">Enter marks between 0 and 100.</div>
                            </div>
                        </div>

                        <!-- Action buttons -->
                        <div class="border-top pt-3 d-flex gap-2">
                            <button type="submit" class="btn btn-primary px-4 fw-semibold">
                                <i class="bi bi-save me-1"></i> ${isEdit ? 'Update Details' : 'Save Student'}
                            </button>
                            <a href="${pageContext.request.contextPath}/students" class="btn btn-outline-secondary px-4">Cancel</a>
                        </div>
                    </form>
                </div>

            </div>

            <!-- Footer -->
            <jsp:include page="/WEB-INF/views/common/footer.jsp" />
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
