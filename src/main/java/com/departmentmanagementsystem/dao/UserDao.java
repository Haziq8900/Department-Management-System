package com.departmentmanagementsystem.dao;

import Database.DatabaseConnection;
import java.sql.*;
import com.departmentmanagementsystem.User;

public class UserDao {

    // Returns true if credentials match
    public User login(String username, String password) throws SQLException {
        String sql = "SELECT id, username, email, role FROM users WHERE username = ? AND password = ?";
        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, username);
            ps.setString(2, password);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    User user = new User();
                    user.setId(rs.getInt("id"));
                    user.setUsername(rs.getString("username"));
                    user.setEmail(rs.getString("email"));
                    user.setRole(rs.getString("role")); // IMPORTANT!
                    return user;
                }
            }
        }
        return null;
    }

    // Returns true if password was changed
    public boolean changePassword(String username, String oldPassword, String newPassword) throws SQLException {
        String sql = "UPDATE users SET password = ? WHERE username = ? AND password = ?";
        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, newPassword);
            ps.setString(2, username);
            ps.setString(3, oldPassword);
            return ps.executeUpdate() > 0;
        }
    }

    // Register a new user (simple plain-text password)
    public boolean registerUser(String username, String password) throws SQLException {
        if (userExists(username)) {
            return false;
        }
        String sql = "INSERT INTO users (username, password) VALUES (?, ?)";
        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, username);
            ps.setString(2, password);
            return ps.executeUpdate() > 0;
        }
    }

    // Check if a username already exists
    public boolean userExists(String username) throws SQLException {
        String sql = "SELECT 1 FROM users WHERE username = ?";
        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, username);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        }
    }

    // Delete a user by username
    public boolean deleteUser(String username) throws SQLException {
        String sql = "DELETE FROM users WHERE username = ?";
        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, username);
            return ps.executeUpdate() > 0;
        }
    }
}
