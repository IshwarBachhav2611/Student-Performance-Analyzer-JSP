package com.spa.service;

import com.spa.exception.DuplicateRollNumberException;
import com.spa.exception.StudentNotFoundException;
import com.spa.model.Student;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public interface StudentService {
    boolean addStudent(Student student) throws DuplicateRollNumberException, IllegalArgumentException, SQLException;
    Student getStudentByRollNumber(String rollNumber) throws StudentNotFoundException, SQLException;
    List<Student> getAllStudents() throws SQLException;
    boolean updateStudent(Student student) throws StudentNotFoundException, IllegalArgumentException, SQLException;
    boolean deleteStudent(String rollNumber) throws StudentNotFoundException, SQLException;
    List<Student> searchStudents(String searchTerm) throws SQLException;
    
    // Performance Analytics
    int getTotalStudentsCount() throws SQLException;
    double getClassAverage() throws SQLException;
    Student getClassTopper() throws SQLException;
    Student getLowestPerformer() throws SQLException;
    List<Student> getMeritList() throws SQLException;
    Map<String, Integer> getGradeDistribution() throws SQLException;
}
