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

public class DashboardServlet extends HttpServlet {
    private final StudentService studentService = new StudentServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int totalStudents = studentService.getTotalStudentsCount();
            double classAverage = studentService.getClassAverage();
            Student topper = studentService.getClassTopper();
            Student lowest = studentService.getLowestPerformer();
            Map<String, Integer> gradeDistribution = studentService.getGradeDistribution();
            List<Student> meritList = studentService.getMeritList();
            
            // Limit merit list to top 5 for quick statistics dashboard
            List<Student> topPerformers = meritList.size() > 5 ? meritList.subList(0, 5) : meritList;

            request.setAttribute("totalStudents", totalStudents);
            request.setAttribute("classAverage", classAverage);
            request.setAttribute("topper", topper);
            request.setAttribute("lowest", lowest);
            request.setAttribute("gradeDistribution", gradeDistribution);
            request.setAttribute("topPerformers", topPerformers);

            request.getRequestDispatcher("/WEB-INF/views/dashboard.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error occurred while loading dashboard: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/dashboard.jsp").forward(request, response);
        }
    }
}
