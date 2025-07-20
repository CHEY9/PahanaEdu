package com.example.pahanaedu2.auth;

import com.example.pahanaedu2.db.DBConnection;

import java.sql.*;
import com.example.pahanaedu2.db.DBConnection;
import com.example.pahanaedu2.auth.User;

public class AuthService {

    // Register a new user (Admin or Staff)
    public boolean registerUser(User user) {

        if (isUserExists(user.getUsername(), user.getEmail())) {
            return false;
        }
        String sql = "INSERT INTO Users (username, password, email, phone, role) VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, user.getUsername());
            stmt.setString(2, user.getPassword());
            stmt.setString(3, user.getEmail());
            stmt.setString(4, user.getPhone());
            stmt.setString(5, user.getRole());

            int rowsInserted = stmt.executeUpdate();
            return rowsInserted > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    public boolean isUserExists(String username, String email) {
        String sql = "SELECT COUNT(*) FROM Users WHERE LOWER(username) = LOWER(?) OR LOWER(email) = LOWER(?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, username.trim().toLowerCase());
            stmt.setString(2, email.trim().toLowerCase());

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                int count = rs.getInt(1);
                System.out.println("User check count: " + count);
                return count > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    public User login(String username, String password) {
        String sql = "SELECT * FROM Users WHERE username=? AND password=?";

        System.out.println("Trying to login with username: " + username + " and password: " + password);

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, username);
            stmt.setString(2, password);

            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                System.out.println("Login successful for: " + username);
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setUsername(rs.getString("username"));
                user.setPassword(rs.getString("password"));
                user.setEmail(rs.getString("email"));
                user.setPhone(rs.getString("phone"));
                user.setRole(rs.getString("role"));
                return user;
            } else {
                System.out.println("Login failed for: " + username);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }
}