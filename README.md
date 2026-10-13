# Student Performance Analyzer

A complete, professional J2EE Web Application developed using the MVC Architecture, DAO Pattern, and Service Layer. The portal helps administrators track student marks, manage academic profiles, search records, compute cohort averages, and visualize overall grades distributions via an interactive modern dashboard.

---

## Technical Stack

- **Backend:** Java 17, Servlet 4.0, JSP 2.3, JDBC
- **Build & Dependency Tool:** Maven 3.9+
- **Database:** MySQL 8.0
- **Frontend library styling:** Bootstrap 5, Bootstrap Icons, Chart.js, Outfit / Inter Fonts
- **Password Security:** BCrypt password hashing (`jbcrypt` library)

---

## Directory Structure

```text
Student-Performance-Analyzer-SpringBoot/
│
├── pom.xml                                  # Maven project configurations
├── README.md                                # Setup & running handbook
├── .gitignore                               # Git exclusions definition
│
└── src/
    └── main/
        ├── java/
        │   └── com/spa/
        │       ├── controller/              # MVC Servlets (Login, Logout, Dashboard, Student, Performance)
        │       ├── dao/                     # Database Access layer interfaces & implementations (JDBC mappings)
        │       ├── exception/               # Checked exceptions details (DuplicateRollNumber, StudentNotFound)
        │       ├── filter/                  # AuthenticationFilter restricting secure directories
        │       ├── model/                   # Data Entities (Student and User representation classes)
        │       ├── service/                 # Domain boundary Validations and Service Layers
        │       └── util/                    # Helper Classes (DBConnection singleton, PasswordUtil bcrypt helper)
        │
        ├── resources/
        │   ├── db.properties                # JDBC Credentials file
        │   └── schema.sql                   # MySQL tables setup and admin seed data
        │
        └── webapp/
            ├── css/
            │   └── style.css                # Premium styling overrides and themes
            ├── WEB-INF/
            │   ├── web.xml                  # Web deployment descriptor
            │   └── views/                   # Secure JSPs
            │       ├── common/              # Layout parts (navbar, sidebar, footer fragments)
            │       ├── login.jsp            # Sign in screen layout
            │       ├── dashboard.jsp        # Statistics charts view
            │       ├── students.jsp         # Class directory database table view & CRUD
            │       ├── student-form.jsp     # Shared addition / modify students form
            │       └── analysis.jsp         # In-depth merit ranking listings
            └── index.jsp                    # Root context forwarder to /dashboard
```

---

## Database Configuration

### 1. Database Schema
Before running the application, import the database instructions. Create a database called `student_performance_db` in MySQL and create the tables. You can execute the script provided in `src/main/resources/schema.sql`:

```sql
-- Database Setup
CREATE DATABASE IF NOT EXISTS student_performance_db;
USE student_performance_db;

-- 1. Users Table (Authentication)
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role VARCHAR(50) DEFAULT 'ADMIN',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. Students Table (Records)
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

-- Seed Default Admin Credentials
-- Plain password: admin123 (bcrypt-hashed)
INSERT INTO users (username, password, role)
SELECT 'admin', '$2a$10$gR5xG28c7vQ8iWjKeoE.f.hD6rE4f4mU0P7.oSz/6K3l6NnC5yVfa', 'ADMIN'
WHERE NOT EXISTS (SELECT 1 FROM users WHERE username = 'admin');
```

### 2. Connection Settings
To update credentials, modify the config file located in:
`src/main/resources/db.properties`

```properties
db.url=jdbc:mysql://localhost:3306/student_performance_db?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC
db.username=root
db.password=your_mysql_password
db.driver=com.mysql.cj.jdbc.Driver
```

---

## Setup & Run Instructions

### Prerequisites
- Java Development Kit (JDK) 17 or higher
- Apache Maven 3.9+
- MySQL Server 8.0+
- Apache Tomcat Server 9.0+

### Build the Project
Compile and package the application into a Deployable WAR archive using Maven:
```bash
mvn clean package
```
This generates the packaged bundle at `target/student-performance-analyzer.war`.

---

## Deployment on Apache Tomcat

1. **Copy the WAR Package:**
   Copy the file `student-performance-analyzer.war` from the `target/` directory.
   
2. **Deploy to Tomcat Webapps:**
   Paste the `.war` configuration into your Tomcat deployment folder:
   `[Tomcat_Installation_Dir]/webapps/`

3. **Start Tomcat Server:**
   - On Windows: Run `[Tomcat_Installation_Dir]/bin/startup.bat`
   - On Mac/Linux: Run `[Tomcat_Installation_Dir]/bin/startup.sh`

4. **Access Portal:**
   Open your browser and navigate to:
   `http://localhost:8080/student-performance-analyzer/`

5. **Log In:**
   - **Username:** `admin`
   - **Password:** `admin123`
