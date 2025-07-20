package com.example.pahanaedu2.db;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnectionTest {
    public static void main(String[] args) {
        String url = "jdbc:sqlserver://localhost:1433;databaseName=PahanaEdu;encrypt=false";
        String user = "sa";
        String password = "12345";

        try {
            Connection conn = DriverManager.getConnection(url, user, password);

            if (conn != null) {
                System.out.println("Connection successful!");
                conn.close();
            } else {
                System.out.println("Failed to connect.");
            }
        } catch (SQLException e) {
            System.out.println("Connection failed!");
            e.printStackTrace();
        }
    }

}
