package com.departmentmanagementsystem.dao;

import Database.DatabaseConnection;
import com.departmentmanagementsystem.Teacher;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TeacherDao {
    public List<Teacher> findAll() throws SQLException {
        String sql = "SELECT id, name, email, department, phone FROM teachers ORDER BY id DESC";
        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            List<Teacher> list = new ArrayList<>();
            while (rs.next()) {
                list.add(mapRow(rs));
            }
            return list;
        }
    }

    public Teacher findById(int id) throws SQLException {
        String sql = "SELECT id, name, email, department, phone FROM teachers WHERE id = ?";
        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapRow(rs);
                return null;
            }
        }
    }

    public int create(Teacher t) throws SQLException {
        String sql = "INSERT INTO teachers (name, email, department, phone) VALUES (?,?,?,?)";
        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, t.getName());
            ps.setString(2, t.getEmail());
            ps.setString(3, t.getDepartment());
            ps.setString(4, t.getPhone());
            ps.executeUpdate();
            try (ResultSet keys = ps.getGeneratedKeys()) {
                if (keys.next()) return keys.getInt(1);
                return -1;
            }
        }
    }

    public boolean update(Teacher t) throws SQLException {
        String sql = "UPDATE teachers SET name=?, email=?, department=?, phone=? WHERE id=?";
        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, t.getName());
            ps.setString(2, t.getEmail());
            ps.setString(3, t.getDepartment());
            ps.setString(4, t.getPhone());
            ps.setInt(5, t.getId());
            return ps.executeUpdate() > 0;
        }
    }

    public boolean delete(int id) throws SQLException {
        String sql = "DELETE FROM teachers WHERE id=?";
        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        }
    }

    private Teacher mapRow(ResultSet rs) throws SQLException {
        return new Teacher(
                rs.getInt("id"),
                rs.getString("name"),
                rs.getString("email"),
                rs.getString("department"),
                rs.getString("phone")
        );
    }
}
