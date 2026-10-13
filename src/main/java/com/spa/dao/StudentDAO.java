package com.spa.dao;

import com.spa.model.Student;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public interface StudentDAO {
    boolean addStudent(Student student) throws SQLException;
    Student getStudentByRollNumber(String rollNumber) throws SQLException;
    List<Student> getAllStudents() throws SQLException;
    boolean updateStudent(Student student) throws SQLException;
    boolean deleteStudent(String rollNumber) throws SQLException;
    List<Student> searchStudents(String searchTerm) throws SQLException;
    
    // Performance Analytics & Dashboard Queries
    int getTotalStudentsCount() throws SQLException;
    double getClassAverage() throws SQLException;
    Student getClassTopper() throws SQLException;
    Student getLowestPerformer() throws SQLException;
    List<Student> getMeritList() throws SQLException;
    Map<String, Integer> getGradeDistribution() throws SQLException;
}
