package com.departmentmanagementsystem.dao;

import Database.DatabaseConnection;
import com.departmentmanagementsystem.Course;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CourseDao {
    public List<Course> findAll() throws SQLException {
        String sql = "SELECT id, code, title, credits, teacher_id, sem FROM courses ORDER BY sem, id DESC";
        // Returns all courses from database, ordered by semester then ID
        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            List<Course> list = new ArrayList<>();
            while (rs.next()) list.add(mapRow(rs));
            return list;
        }
    }

    public Course findById(int id) throws SQLException {
        String sql = "SELECT id, code, title, credits, teacher_id, sem FROM courses WHERE id=?";
        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapRow(rs);
                return null;
            }
        }
    }

    public int create(Course c) throws SQLException {
        String sql = "INSERT INTO courses (code, title, credits, teacher_id, sem) VALUES (?,?,?,?,?)";
        // Persists course; returns generated key or negative one
        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, c.getCode());
            ps.setString(2, c.getTitle());
            if (c.getCredits() == null) ps.setNull(3, Types.INTEGER); else ps.setInt(3, c.getCredits());
            if (c.getTeacherId() == null) ps.setNull(4, Types.INTEGER); else ps.setInt(4, c.getTeacherId());
            if (c.getSem() == null) ps.setNull(5, Types.INTEGER); else ps.setInt(5, c.getSem());
            ps.executeUpdate();
            try (ResultSet keys = ps.getGeneratedKeys()) { if (keys.next()) return keys.getInt(1); }
            return -1;
        }
    }

    public boolean update(Course c) throws SQLException {
        String sql = "UPDATE courses SET code=?, title=?, credits=?, teacher_id=?, sem=? WHERE id=?";
        // Updates course; returns success status
        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, c.getCode());
            ps.setString(2, c.getTitle());
            if (c.getCredits() == null) ps.setNull(3, Types.INTEGER); else ps.setInt(3, c.getCredits());
            if (c.getTeacherId() == null) ps.setNull(4, Types.INTEGER); else ps.setInt(4, c.getTeacherId());
            if (c.getSem() == null) ps.setNull(5, Types.INTEGER); else ps.setInt(5, c.getSem());
            ps.setInt(6, c.getId());
            return ps.executeUpdate() > 0;
        }
    }

    public boolean delete(int id) throws SQLException {
        String sql = "DELETE FROM courses WHERE id=?";
        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        }
    }

    private Course mapRow(ResultSet rs) throws SQLException {
        return new Course(
                rs.getInt("id"),
                rs.getString("code"),
                rs.getString("title"),
                (Integer) rs.getObject("credits"),
                (Integer) rs.getObject("teacher_id"),
                (Integer) rs.getObject("sem")
        );
    }
}