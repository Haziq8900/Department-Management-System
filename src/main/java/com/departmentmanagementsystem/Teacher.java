package com.departmentmanagementsystem;

public class Teacher {
    private Integer id;
    private String name;
    private String email;
    private String department;
    private String phone;

    public Teacher() {
    }

    public Teacher(Integer id, String name, String email, String department, String phone) {
        this.id = id;
        this.name = name;
        this.email = email;
        this.department = department;
        this.phone = phone;
    }

    public Teacher(String name, String email, String department, String phone) {
        this(null, name, email, department, phone);
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getDepartment() {
        return department;
    }

    public void setDepartment(String department) {
        this.department = department;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }
}
