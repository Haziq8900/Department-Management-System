package com.departmentmanagementsystem;

public class Student {
    private Integer id;
    private String name;
    private String email;
    private String enrollmentNumber;
    private String department;
    private Integer semester;

    public Student() {}

    public Student(Integer id, String name, String email, String enrollmentNumber, String department, Integer semester) {
        this.id = id;
        this.name = name;
        this.email = email;
        this.enrollmentNumber = enrollmentNumber;
        this.department = department;
        this.semester = semester;
    }

    public Student(String name, String email, String enrollmentNumber, String department, Integer semester) {
        this(null, name, email, enrollmentNumber, department, semester);
    }

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getEnrollmentNumber() { return enrollmentNumber; }
    public void setEnrollmentNumber(String enrollmentNumber) { this.enrollmentNumber = enrollmentNumber; }

    public String getDepartment() { return department; }
    public void setDepartment(String department) { this.department = department; }

    public Integer getSemester() { return semester; }
    public void setSemester(Integer semester) { this.semester = semester; }
}
