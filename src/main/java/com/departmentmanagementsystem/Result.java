package com.departmentmanagementsystem;

public class Result {
    private String teacherName;
    private String courseTitle;
    private String courseCode;
    private String studentEnrollmentNo;
    private int sessionalMarks;
    private int midMarks;
    private int finalMarks;

    // Default constructor
    public Result() {}

    // Constructor with all fields
    public Result(String teacherName, String courseTitle, String courseCode, String studentEnrollmentNo,
                  int sessionalMarks, int midMarks, int finalMarks) {
        this.teacherName = teacherName;
        this.courseTitle = courseTitle;
        this.courseCode = courseCode;
        this.studentEnrollmentNo = studentEnrollmentNo;
        this.sessionalMarks = sessionalMarks;
        this.midMarks = midMarks;
        this.finalMarks = finalMarks;
    }

    // Getters and Setters
    public String getTeacherName() { return teacherName; }
    public void setTeacherName(String teacherName) { this.teacherName = teacherName; }

    public String getCourseTitle() { return courseTitle; }
    public void setCourseTitle(String courseTitle) { this.courseTitle = courseTitle; }

    public String getCourseCode() { return courseCode; }
    public void setCourseCode(String courseCode) { this.courseCode = courseCode; }

    public String getStudentEnrollmentNo() { return studentEnrollmentNo; }
    public void setStudentEnrollmentNo(String studentEnrollmentNo) { this.studentEnrollmentNo = studentEnrollmentNo; }

    public int getSessionalMarks() { return sessionalMarks; }
    public void setSessionalMarks(int sessionalMarks) { this.sessionalMarks = sessionalMarks; }

    public int getMidMarks() { return midMarks; }
    public void setMidMarks(int midMarks) { this.midMarks = midMarks; }

    public int getFinalMarks() { return finalMarks; }
    public void setFinalMarks(int finalMarks) { this.finalMarks = finalMarks; }
}
