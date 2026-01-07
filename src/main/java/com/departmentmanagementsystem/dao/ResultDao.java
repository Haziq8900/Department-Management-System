package com.departmentmanagementsystem.dao;

import Database.DatabaseConnection;
import com.departmentmanagementsystem.Result;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ResultDao {

    // Add a new result record
    public boolean addResult(Result result) throws SQLException {
        String sql = "INSERT INTO result (teacher_name, course_title, course_code, student_enrollment_no, sessional_marks, mid_marks, final_marks) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, result.getTeacherName());
            ps.setString(2, result.getCourseTitle());
            ps.setString(3, result.getCourseCode());
            ps.setString(4, result.getStudentEnrollmentNo());
            ps.setInt(5, result.getSessionalMarks());
            ps.setInt(6, result.getMidMarks());
            ps.setInt(7, result.getFinalMarks());

            return ps.executeUpdate() > 0;
        }
    }

    // Update an existing result record
    public boolean updateResult(Result result) throws SQLException {
        String sql = "UPDATE result SET teacher_name = ?, course_title = ?, sessional_marks = ?, mid_marks = ?, final_marks = ? " +
                "WHERE student_enrollment_no = ? AND course_code = ?";
        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, result.getTeacherName());
            ps.setString(2, result.getCourseTitle());
            ps.setInt(3, result.getSessionalMarks());
            ps.setInt(4, result.getMidMarks());
            ps.setInt(5, result.getFinalMarks());
            ps.setString(6, result.getStudentEnrollmentNo());
            ps.setString(7, result.getCourseCode());

            return ps.executeUpdate() > 0;
        }
    }

    // Delete a result record
    public boolean deleteResult(String enrollmentNo, String courseCode) throws SQLException {
        String sql = "DELETE FROM result WHERE student_enrollment_no = ? AND course_code = ?";
        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, enrollmentNo);
            ps.setString(2, courseCode);
            return ps.executeUpdate() > 0;
        }
    }

    // Check if a result already exists for a student + course
    public boolean resultExists(String enrollmentNo, String courseCode) throws SQLException {
        String sql = "SELECT 1 FROM result WHERE student_enrollment_no = ? AND course_code = ?";
        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, enrollmentNo);
            ps.setString(2, courseCode);

            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        }
    }

    // Get all results for a student
    public List<Result> getResultsByStudent(String enrollmentNo) throws SQLException {
        String sql = "SELECT * FROM result WHERE student_enrollment_no = ?";
        List<Result> results = new ArrayList<>();

        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, enrollmentNo);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Result r = new Result(
                            rs.getString("teacher_name"),
                            rs.getString("course_title"),
                            rs.getString("course_code"),
                            rs.getString("student_enrollment_no"),
                            rs.getInt("sessional_marks"),
                            rs.getInt("mid_marks"),
                            rs.getInt("final_marks")
                    );
                    results.add(r);
                }
            }
        }

        return results;
    }

    // Get all results for a specific course
    public List<Result> getResultsByCourse(String courseCode) throws SQLException {
        String sql = "SELECT * FROM result WHERE course_code = ?";
        List<Result> results = new ArrayList<>();

        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, courseCode);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Result r = new Result(
                            rs.getString("teacher_name"),
                            rs.getString("course_title"),
                            rs.getString("course_code"),
                            rs.getString("student_enrollment_no"),
                            rs.getInt("sessional_marks"),
                            rs.getInt("mid_marks"),
                            rs.getInt("final_marks")
                    );
                    results.add(r);
                }
            }
        }

        return results;
    }

    // Get all results (optional, for admin dashboard)
    public List<Result> getAllResults() throws SQLException {
        String sql = "SELECT * FROM result";
        List<Result> results = new ArrayList<>();

        try (Connection con = DatabaseConnection.getConnection();
             Statement stmt = con.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                Result r = new Result(
                        rs.getString("teacher_name"),
                        rs.getString("course_title"),
                        rs.getString("course_code"),
                        rs.getString("student_enrollment_no"),
                        rs.getInt("sessional_marks"),
                        rs.getInt("mid_marks"),
                        rs.getInt("final_marks")
                );
                results.add(r);
            }
        }

        return results;
    }
}
