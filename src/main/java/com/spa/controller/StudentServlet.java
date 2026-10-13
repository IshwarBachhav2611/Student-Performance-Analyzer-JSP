package com.spa.controller;

import com.spa.exception.DuplicateRollNumberException;
import com.spa.exception.StudentNotFoundException;
import com.spa.model.Student;
import com.spa.service.StudentService;
import com.spa.service.StudentServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

public class StudentServlet extends HttpServlet {
    private final StudentService studentService = new StudentServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        try {
            switch (action) {
                case "new":
                    showNewForm(request, response);
                    break;
                case "edit":
                    showEditForm(request, response);
                    break;
                case "delete":
                    deleteStudent(request, response);
                    break;
                case "list":
                default:
                    listStudents(request, response);
                    break;
            }
        } catch (SQLException | StudentNotFoundException e) {
            e.printStackTrace();
            request.setAttribute("error", "Error executing request: " + e.getMessage());
            try {
                listStudents(request, response);
            } catch (SQLException ex) {
                throw new ServletException(ex);
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("save".equals(action)) {
            saveStudent(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/students");
        }
    }

    private void listStudents(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        String searchQuery = request.getParameter("query");
        List<Student> students;
        if (searchQuery != null && !searchQuery.trim().isEmpty()) {
            students = studentService.searchStudents(searchQuery);
            request.setAttribute("query", searchQuery);
        } else {
            students = studentService.getAllStudents();
        }
        request.setAttribute("students", students);
        request.getRequestDispatcher("/WEB-INF/views/students.jsp").forward(request, response);
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("isEdit", false);
        request.getRequestDispatcher("/WEB-INF/views/student-form.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response) throws SQLException, StudentNotFoundException, ServletException, IOException {
        String rollNumber = request.getParameter("rollNumber");
        Student student = studentService.getStudentByRollNumber(rollNumber);
        request.setAttribute("student", student);
        request.setAttribute("isEdit", true);
        request.getRequestDispatcher("/WEB-INF/views/student-form.jsp").forward(request, response);
    }

    private void deleteStudent(HttpServletRequest request, HttpServletResponse response) throws SQLException, StudentNotFoundException, IOException {
        String rollNumber = request.getParameter("rollNumber");
        studentService.deleteStudent(rollNumber);
        response.sendRedirect(request.getContextPath() + "/students?success=Student deleted successfully");
    }

    private void saveStudent(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String rollNumber = request.getParameter("rollNumber");
        String name = request.getParameter("name");
        String isEditStr = request.getParameter("isEdit");
        boolean isEdit = Boolean.parseBoolean(isEditStr);

        Student student = new Student();
        student.setRollNumber(rollNumber != null ? rollNumber.trim() : "");
        student.setName(name != null ? name.trim() : "");

        try {
            student.setJavaMarks(Integer.parseInt(request.getParameter("javaMarks")));
            student.setPythonMarks(Integer.parseInt(request.getParameter("pythonMarks")));
            student.setWebMarks(Integer.parseInt(request.getParameter("webMarks")));
            student.setAndroidMarks(Integer.parseInt(request.getParameter("androidMarks")));
            student.setOsMarks(Integer.parseInt(request.getParameter("osMarks")));
            
            if (isEdit) {
                studentService.updateStudent(student);
                response.sendRedirect(request.getContextPath() + "/students?success=Student updated successfully");
            } else {
                studentService.addStudent(student);
                response.sendRedirect(request.getContextPath() + "/students?success=Student added successfully");
            }
        } catch (NumberFormatException e) {
            sendErrorResponse(request, response, student, isEdit, "Marks must be valid numbers");
        } catch (DuplicateRollNumberException e) {
            sendErrorResponse(request, response, student, isEdit, e.getMessage());
        } catch (StudentNotFoundException e) {
            sendErrorResponse(request, response, student, isEdit, e.getMessage());
        } catch (IllegalArgumentException e) {
            sendErrorResponse(request, response, student, isEdit, e.getMessage());
        } catch (SQLException e) {
            e.printStackTrace();
            sendErrorResponse(request, response, student, isEdit, "Database error: " + e.getMessage());
        }
    }

    private void sendErrorResponse(HttpServletRequest request, HttpServletResponse response, Student student, boolean isEdit, String errorMessage) throws ServletException, IOException {
        request.setAttribute("student", student);
        request.setAttribute("isEdit", isEdit);
        request.setAttribute("error", errorMessage);
        request.getRequestDispatcher("/WEB-INF/views/student-form.jsp").forward(request, response);
    }
}
