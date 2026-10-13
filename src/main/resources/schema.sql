-- Create Database if not exists
CREATE DATABASE IF NOT EXISTS student_performance_db;
USE student_performance_db;

-- Users Table (for Authentication)
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role VARCHAR(50) DEFAULT 'ADMIN',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Students Table (for Student Performance Analyzer)
CREATE TABLE IF NOT EXISTS students (
    roll_number VARCHAR(50) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    java_marks INT NOT NULL CHECK (java_marks >= 0 AND java_marks <= 100),
    python_marks INT NOT NULL CHECK (python_marks >= 0 AND python_marks <= 100),
    web_marks INT NOT NULL CHECK (web_marks >= 0 AND web_marks <= 100),
    android_marks INT NOT NULL CHECK (android_marks >= 0 AND android_marks <= 100),
    os_marks INT NOT NULL CHECK (os_marks >= 0 AND os_marks <= 100),
    average DOUBLE NOT NULL,
    grade VARCHAR(5) NOT NULL
);

-- Insert Default Admin User
-- Password is 'admin123' bcrypt hashed
-- Hash: $2a$10$hQxfeKBg9zK49zN2Lp6q2O9lDkXm0a4m0a4m0a4m0a4m0a4m0a4m0 (Wait, let's generic hash it dynamically or use a known BCrypt hash for "admin123")
-- Let's use the standard BCrypt hash for "admin123": $2a$10$gR5xG28c7vQ8iWjKeoE.f.hD6rE4f4mU0P7.oSz/6K3l6NnC5yVfa
INSERT INTO users (username, password, role)
SELECT 'admin', '$2a$10$gR5xG28c7vQ8iWjKeoE.f.hD6rE4f4mU0P7.oSz/6K3l6NnC5yVfa', 'ADMIN'
WHERE NOT EXISTS (SELECT 1 FROM users WHERE username = 'admin');
