package com.spa.service;

import com.spa.dao.StudentDAO;
import com.spa.dao.StudentDAOImpl;
import com.spa.exception.DuplicateRollNumberException;
import com.spa.exception.StudentNotFoundException;
import com.spa.model.Student;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public class StudentServiceImpl implements StudentService {
    private final StudentDAO studentDAO = new StudentDAOImpl();

    private void validateStudentMarks(Student student) throws IllegalArgumentException {
        if (student.getRollNumber() == null || student.getRollNumber().trim().isEmpty()) {
            throw new IllegalArgumentException("Roll number is required");
        }
        if (student.getName() == null || student.getName().trim().isEmpty()) {
            throw new IllegalArgumentException("Student name is required");
        }
        
        int[] marks = {
            student.getJavaMarks(), 
            student.getPythonMarks(), 
            student.getWebMarks(), 
            student.getAndroidMarks(), 
            student.getOsMarks()
        };
        String[] subjects = {"Java", "Python", "Web", "Android", "Operating System"};
        
        for (int i = 0; i < marks.length; i++) {
            if (marks[i] < 0 || marks[i] > 100) {
                throw new IllegalArgumentException(subjects[i] + " marks must be between 0 and 100");
            }
        }
    }

    @Override
    public boolean addStudent(Student student) throws DuplicateRollNumberException, IllegalArgumentException, SQLException {
        validateStudentMarks(student);
        if (studentDAO.getStudentByRollNumber(student.getRollNumber()) != null) {
            throw new DuplicateRollNumberException("Student with roll number " + student.getRollNumber() + " already exists!");
        }
        // Force recalculation of average and grade before inserting
        student.calculateAverageAndGrade();
        return studentDAO.addStudent(student);
    }

    @Override
    public Student getStudentByRollNumber(String rollNumber) throws StudentNotFoundException, SQLException {
        if (rollNumber == null || rollNumber.trim().isEmpty()) {
            throw new IllegalArgumentException("Roll number cannot be empty");
        }
        Student student = studentDAO.getStudentByRollNumber(rollNumber);
        if (student == null) {
            throw new StudentNotFoundException("Student with roll number " + rollNumber + " not found");
        }
        return student;
    }

    @Override
    public List<Student> getAllStudents() throws SQLException {
        return studentDAO.getAllStudents();
    }

    @Override
    public boolean updateStudent(Student student) throws StudentNotFoundException, IllegalArgumentException, SQLException {
        validateStudentMarks(student);
        if (studentDAO.getStudentByRollNumber(student.getRollNumber()) == null) {
            throw new StudentNotFoundException("Student with roll number " + student.getRollNumber() + " does not exist!");
        }
        student.calculateAverageAndGrade();
        return studentDAO.updateStudent(student);
    }

    @Override
    public boolean deleteStudent(String rollNumber) throws StudentNotFoundException, SQLException {
        if (rollNumber == null || rollNumber.trim().isEmpty()) {
            throw new IllegalArgumentException("Roll number cannot be empty");
        }
        if (studentDAO.getStudentByRollNumber(rollNumber) == null) {
            throw new StudentNotFoundException("Student with roll number " + rollNumber + " does not exist!");
        }
        return studentDAO.deleteStudent(rollNumber);
    }

    @Override
    public List<Student> searchStudents(String searchTerm) throws SQLException {
        if (searchTerm == null || searchTerm.trim().isEmpty()) {
            return studentDAO.getAllStudents();
        }
        return studentDAO.searchStudents(searchTerm.trim());
    }

    @Override
    public int getTotalStudentsCount() throws SQLException {
        return studentDAO.getTotalStudentsCount();
    }

    @Override
    public double getClassAverage() throws SQLException {
        return studentDAO.getClassAverage();
    }

    @Override
    public Student getClassTopper() throws SQLException {
        return studentDAO.getClassTopper();
    }

    @Override
    public Student getLowestPerformer() throws SQLException {
        return studentDAO.getLowestPerformer();
    }

    @Override
    public List<Student> getMeritList() throws SQLException {
        return studentDAO.getMeritList();
    }

    @Override
    public Map<String, Integer> getGradeDistribution() throws SQLException {
        return studentDAO.getGradeDistribution();
    }
}
