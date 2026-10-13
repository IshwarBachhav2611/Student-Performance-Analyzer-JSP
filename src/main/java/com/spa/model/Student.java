package com.spa.model;

public class Student {
    private String rollNumber;
    private String name;
    private int javaMarks;
    private int pythonMarks;
    private int webMarks;
    private int androidMarks;
    private int osMarks;
    private double average;
    private String grade;

    public Student() {}

    public Student(String rollNumber, String name, int javaMarks, int pythonMarks, int webMarks, int androidMarks, int osMarks) {
        this.rollNumber = rollNumber;
        this.name = name;
        this.javaMarks = javaMarks;
        this.pythonMarks = pythonMarks;
        this.webMarks = webMarks;
        this.androidMarks = androidMarks;
        this.osMarks = osMarks;
        calculateAverageAndGrade();
    }

    public void calculateAverageAndGrade() {
        this.average = (javaMarks + pythonMarks + webMarks + androidMarks + osMarks) / 5.0;
        if (this.average >= 90) {
            this.grade = "A+";
        } else if (this.average >= 80) {
            this.grade = "A";
        } else if (this.average >= 70) {
            this.grade = "B";
        } else if (this.average >= 60) {
            this.grade = "C";
        } else if (this.average >= 50) {
            this.grade = "D";
        } else if (this.average >= 40) {
            this.grade = "E";
        } else {
            this.grade = "F";
        }
    }

    // Getters and Setters
    public String getRollNumber() {
        return rollNumber;
    }

    public void setRollNumber(String rollNumber) {
        this.rollNumber = rollNumber;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getJavaMarks() {
        return javaMarks;
    }

    public void setJavaMarks(int javaMarks) {
        this.javaMarks = javaMarks;
        calculateAverageAndGrade();
    }

    public int getPythonMarks() {
        return pythonMarks;
    }

    public void setPythonMarks(int pythonMarks) {
        this.pythonMarks = pythonMarks;
        calculateAverageAndGrade();
    }

    public int getWebMarks() {
        return webMarks;
    }

    public void setWebMarks(int webMarks) {
        this.webMarks = webMarks;
        calculateAverageAndGrade();
    }

    public int getAndroidMarks() {
        return androidMarks;
    }

    public void setAndroidMarks(int androidMarks) {
        this.androidMarks = androidMarks;
        calculateAverageAndGrade();
    }

    public int getOsMarks() {
        return osMarks;
    }

    public void setOsMarks(int osMarks) {
        this.osMarks = osMarks;
        calculateAverageAndGrade();
    }

    public double getAverage() {
        return average;
    }

    public void setAverage(double average) {
        this.average = average;
    }

    public String getGrade() {
        return grade;
    }

    public void setGrade(String grade) {
        this.grade = grade;
    }
}
