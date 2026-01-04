package com.departmentmanagementsystem.dao;

import Database.DatabaseConnection;
import com.departmentmanagementsystem.Student;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class StudentDao {
    public List<Student> findAll() throws SQLException {
        String sql = "SELECT id, name, email, enrollment_number, department, semester FROM students ORDER BY id DESC";
        // Returns all students, mapping each row to object
        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            List<Student> list = new ArrayList<>();
            while (rs.next()) list.add(mapRow(rs));
            return list;
        }
    }

    public Student findById(int id) throws SQLException {
        String sql = "SELECT id, name, email, enrollment_number, department, semester FROM students WHERE id=?";
        // Returns student by ID, mapping row to object
        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapRow(rs);
                return null;
            }
        }
    }

    public int create(Student s) throws SQLException {
        String sql = "INSERT INTO students (name, email, enrollment_number, department, semester) VALUES (?,?,?,?,?)";
        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, s.getName());
            ps.setString(2, s.getEmail());
            ps.setString(3, s.getEnrollmentNumber());
            ps.setString(4, s.getDepartment());
            if (s.getSemester() == null) ps.setNull(5, Types.INTEGER); else ps.setInt(5, s.getSemester());
            ps.executeUpdate();
            try (ResultSet keys = ps.getGeneratedKeys()) { if (keys.next()) return keys.getInt(1); }
            return -1;
        }
    }

    public boolean update(Student s) throws SQLException {
        String sql = "UPDATE students SET name=?, email=?, enrollment_number=?, department=?, semester=? WHERE id=?";
        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, s.getName());
            ps.setString(2, s.getEmail());
            ps.setString(3, s.getEnrollmentNumber());
            ps.setString(4, s.getDepartment());
            if (s.getSemester() == null) ps.setNull(5, Types.INTEGER); else ps.setInt(5, s.getSemester());
            ps.setInt(6, s.getId());
            return ps.executeUpdate() > 0;
        }
    }

    public boolean delete(int id) throws SQLException {
        String sql = "DELETE FROM students WHERE id=?";
        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        }
    }

    /**
     * Maps database row to student record
     */
    private Student mapRow(ResultSet rs) throws SQLException {
        return new Student(
                rs.getInt("id"),
                rs.getString("name"),
                rs.getString("email"),
                rs.getString("enrollment_number"),
                rs.getString("department"),
                (Integer) rs.getObject("semester")
        );
    }
}
