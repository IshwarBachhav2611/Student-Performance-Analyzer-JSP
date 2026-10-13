package com.spa.controller;

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
import java.util.Map;

public class PerformanceServlet extends HttpServlet {
    private final StudentService studentService = new StudentServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            double classAverage = studentService.getClassAverage();
            Student topper = studentService.getClassTopper();
            Student lowest = studentService.getLowestPerformer();
            List<Student> meritList = studentService.getMeritList();
            Map<String, Integer> gradeDistribution = studentService.getGradeDistribution();

            request.setAttribute("classAverage", classAverage);
            request.setAttribute("topper", topper);
            request.setAttribute("lowest", lowest);
            request.setAttribute("meritList", meritList);
            request.setAttribute("gradeDistribution", gradeDistribution);

            request.getRequestDispatcher("/WEB-INF/views/analysis.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error occurred while fetching analysis: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/analysis.jsp").forward(request, response);
        }
    }
}
