package com.example.pahanaedu2;

import com.example.pahanaedu2.db.DBConnection;

import java.sql.*;

public class test {
    public static void main(String[] args) {
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement()) {

            ResultSet rs = stmt.executeQuery("SELECT username, password FROM Users");

            while (rs.next()) {
                System.out.println("DB User: " + rs.getString("username") + ", Password: " + rs.getString("password"));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
