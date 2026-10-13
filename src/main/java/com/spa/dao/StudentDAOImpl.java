package com.spa.dao;

import com.spa.model.Student;
import com.spa.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class StudentDAOImpl implements StudentDAO {

    private Student mapRowToStudent(ResultSet rs) throws SQLException {
        Student student = new Student();
        student.setRollNumber(rs.getString("roll_number"));
        student.setName(rs.getString("name"));
        student.setJavaMarks(rs.getInt("java_marks"));
        student.setPythonMarks(rs.getInt("python_marks"));
        student.setWebMarks(rs.getInt("web_marks"));
        student.setAndroidMarks(rs.getInt("android_marks"));
        student.setOsMarks(rs.getInt("os_marks"));
        student.setAverage(rs.getDouble("average"));
        student.setGrade(rs.getString("grade"));
        return student;
    }

    @Override
    public boolean addStudent(Student student) throws SQLException {
        String query = "INSERT INTO students (roll_number, name, java_marks, python_marks, web_marks, android_marks, os_marks, average, grade) " +
                       "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, student.getRollNumber());
            stmt.setString(2, student.getName());
            stmt.setInt(3, student.getJavaMarks());
            stmt.setInt(4, student.getPythonMarks());
            stmt.setInt(5, student.getWebMarks());
            stmt.setInt(6, student.getAndroidMarks());
            stmt.setInt(7, student.getOsMarks());
            stmt.setDouble(8, student.getAverage());
            stmt.setString(9, student.getGrade());
            return stmt.executeUpdate() > 0;
        }
    }

    @Override
    public Student getStudentByRollNumber(String rollNumber) throws SQLException {
        String query = "SELECT * FROM students WHERE roll_number = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, rollNumber);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapRowToStudent(rs);
                }
            }
        }
        return null;
    }

    @Override
    public List<Student> getAllStudents() throws SQLException {
        String query = "SELECT * FROM students ORDER BY name ASC";
        List<Student> students = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                students.add(mapRowToStudent(rs));
            }
        }
        return students;
    }

    @Override
    public boolean updateStudent(Student student) throws SQLException {
        String query = "UPDATE students SET name = ?, java_marks = ?, python_marks = ?, web_marks = ?, android_marks = ?, os_marks = ?, average = ?, grade = ? " +
                       "WHERE roll_number = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, student.getName());
            stmt.setInt(2, student.getJavaMarks());
            stmt.setInt(3, student.getPythonMarks());
            stmt.setInt(4, student.getWebMarks());
            stmt.setInt(5, student.getAndroidMarks());
            stmt.setInt(6, student.getOsMarks());
            stmt.setDouble(7, student.getAverage());
            stmt.setString(8, student.getGrade());
            stmt.setString(9, student.getRollNumber());
            return stmt.executeUpdate() > 0;
        }
    }

    @Override
    public boolean deleteStudent(String rollNumber) throws SQLException {
        String query = "DELETE FROM students WHERE roll_number = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, rollNumber);
            return stmt.executeUpdate() > 0;
        }
    }

    @Override
    public List<Student> searchStudents(String searchTerm) throws SQLException {
        String query = "SELECT * FROM students WHERE roll_number LIKE ? OR name LIKE ? ORDER BY name ASC";
        List<Student> students = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            String wildcard = "%" + searchTerm + "%";
            stmt.setString(1, wildcard);
            stmt.setString(2, wildcard);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    students.add(mapRowToStudent(rs));
                }
            }
        }
        return students;
    }

    @Override
    public int getTotalStudentsCount() throws SQLException {
        String query = "SELECT COUNT(*) FROM students";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }

    @Override
    public double getClassAverage() throws SQLException {
        String query = "SELECT AVG(average) FROM students";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                return rs.getDouble(1);
            }
        }
        return 0.0;
    }

    @Override
    public Student getClassTopper() throws SQLException {
        String query = "SELECT * FROM students ORDER BY average DESC, roll_number ASC LIMIT 1";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                return mapRowToStudent(rs);
            }
        }
        return null;
    }

    @Override
    public Student getLowestPerformer() throws SQLException {
        String query = "SELECT * FROM students ORDER BY average ASC, roll_number ASC LIMIT 1";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                return mapRowToStudent(rs);
            }
        }
        return null;
    }

    @Override
    public List<Student> getMeritList() throws SQLException {
        String query = "SELECT * FROM students ORDER BY average DESC, roll_number ASC";
        List<Student> students = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                students.add(mapRowToStudent(rs));
            }
        }
        return students;
    }

    @Override
    public Map<String, Integer> getGradeDistribution() throws SQLException {
        Map<String, Integer> distribution = new HashMap<>();
        // Pre-initialize possible grades
        distribution.put("A+", 0);
        distribution.put("A", 0);
        distribution.put("B", 0);
        distribution.put("C", 0);
        distribution.put("D", 0);
        distribution.put("E", 0);
        distribution.put("F", 0);

        String query = "SELECT grade, COUNT(*) as cnt FROM students GROUP BY grade";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                distribution.put(rs.getString("grade"), rs.getInt("cnt"));
            }
        }
        return distribution;
    }
}
