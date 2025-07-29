package com.example.pahanaedu2;

import com.example.pahanaedu2.auth.User;
import com.example.pahanaedu2.db.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDAOImpl {

    public boolean registerUser(User user) {
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
        String sql = "SELECT COUNT(*) FROM Users WHERE username = ? OR email = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, username);
            stmt.setString(2, email);

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    public User getUserByUsernameAndPassword(String username, String password) {
        String sql = "SELECT username, password, email, phone, role FROM Users WHERE username = ? AND password = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, username);
            stmt.setString(2, password);

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return new User(
                        rs.getString("username"),
                        rs.getString("password"),
                        rs.getString("email"),
                        rs.getString("phone"),
                        rs.getString("role")
                );
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
