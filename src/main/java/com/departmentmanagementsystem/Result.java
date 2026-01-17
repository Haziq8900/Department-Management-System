package com.departmentmanagementsystem;

public class Result {
    private String teacherName;
    private String courseTitle;
    private String courseCode;
    private String studentEnrollmentNo;
    private Integer sessionalMarks; // Mandatory
    private Integer midMarks; // Optional
    private Integer finalMarks; // Optional
    private Integer credits; // Course credits (to determine max marks)

    // Default constructor
    public Result() {}

    // Constructor with all fields
    public Result(String teacherName, String courseTitle, String courseCode, String studentEnrollmentNo,
                  Integer sessionalMarks, Integer midMarks, Integer finalMarks) {
        this.teacherName = teacherName;
        this.courseTitle = courseTitle;
        this.courseCode = courseCode;
        this.studentEnrollmentNo = studentEnrollmentNo;
        this.sessionalMarks = sessionalMarks;
        this.midMarks = midMarks;
        this.finalMarks = finalMarks;
    }

    // Constructor with credits
    public Result(String teacherName, String courseTitle, String courseCode, String studentEnrollmentNo,
                  Integer sessionalMarks, Integer midMarks, Integer finalMarks, Integer credits) {
        this.teacherName = teacherName;
        this.courseTitle = courseTitle;
        this.courseCode = courseCode;
        this.studentEnrollmentNo = studentEnrollmentNo;
        this.sessionalMarks = sessionalMarks;
        this.midMarks = midMarks;
        this.finalMarks = finalMarks;
        this.credits = credits;
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

    public Integer getSessionalMarks() { return sessionalMarks; }
    public void setSessionalMarks(Integer sessionalMarks) { this.sessionalMarks = sessionalMarks; }

    public Integer getMidMarks() { return midMarks; }
    public void setMidMarks(Integer midMarks) { this.midMarks = midMarks; }

    public Integer getFinalMarks() { return finalMarks; }
    public void setFinalMarks(Integer finalMarks) { this.finalMarks = finalMarks; }

    public Integer getCredits() { return credits; }
    public void setCredits(Integer credits) { this.credits = credits; }

    /**
     * Get maximum marks based on credits
     * Credits >= 3 → 100 marks
     * Credits < 3 → 50 marks
     */
    public int getMaxMarks() {
        if (credits == null) {
            return 100; // Default to 100 if credits not set
        }
        return (credits >= 3) ? 100 : 50;
    }

    /**
     * Get marks distribution based on total marks
     * For 100 marks: Sessional(20) + Mid(30) + Final(50)
     * For 50 marks: Sessional(10) + Mid(15) + Final(25)
     */
    public String getMarksDistribution() {
        int maxMarks = getMaxMarks();
        if (maxMarks == 100) {
            return "Sessional(20) + Mid(30) + Final(50)";
        } else {
            return "Sessional(10) + Mid(15) + Final(25)";
        }
    }

    /**
     * Get maximum sessional marks based on credits
     */
    public int getMaxSessionalMarks() {
        return (getMaxMarks() == 100) ? 20 : 10;
    }

    /**
     * Get maximum mid marks based on credits
     */
    public int getMaxMidMarks() {
        return (getMaxMarks() == 100) ? 30 : 15;
    }

    /**
     * Get maximum final marks based on credits
     */
    public int getMaxFinalMarks() {
        return (getMaxMarks() == 100) ? 50 : 25;
    }

    /**
     * Calculate grade only if final marks are entered
     * Otherwise return "Incomplete" or "Pending"
     */
    public String getGrade() {
        // If final marks not entered, return pending status
        if (finalMarks == null) {
            return "Pending";
        }

        int total = getTotalMarks();
        int maxMarks = getMaxMarks();

        // Calculate percentage
        double percentage = (total * 100.0) / maxMarks;

        if (percentage >= 90) return "A+";
        else if (percentage >= 81) return "A";
        else if (percentage >= 73) return "B+";
        else if (percentage >= 65) return "B";
        else if (percentage >= 60) return "C+";
        else if (percentage >= 55) return "C";
        else if (percentage >= 50) return "C-";
        else return "F";
    }

    /**
     * Calculate total marks (null values treated as 0)
     */
    public int getTotalMarks() {
        int sessional = (sessionalMarks != null) ? sessionalMarks : 0;
        int mid = (midMarks != null) ? midMarks : 0;
        int finals = (finalMarks != null) ? finalMarks : 0;
        return sessional + mid + finals;
    }

    /**
     * Check if result is complete (all marks entered)
     */
    public boolean isComplete() {
        return sessionalMarks != null && midMarks != null && finalMarks != null;
    }
}