package com.example.pahanaedu2.reports;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.*;

@WebServlet("/Admin/reports/top-customers")
public class TopCustomersServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Map<String, Object>> topCustomers = new ArrayList<>();

        String sql = "SELECT c.id, c.name, SUM(bi.quantity * bi.unit_price) AS totalSpent " +
                "FROM Customers c " +
                "JOIN bills b ON c.id = b.id " +
                "JOIN bill_items bi ON b.bill_id = bi.bill_id " +
                "GROUP BY c.id, c.name " +
                "ORDER BY totalSpent DESC";

        try (Connection conn = DriverManager.getConnection(
                "jdbc:sqlserver://localhost:1433;databaseName=PahanaEdu;encrypt=true;trustServerCertificate=true",
                "sa", "12345");
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Map<String, Object> row = new HashMap<>();
                row.put("id", rs.getInt("id"));
                row.put("name", rs.getString("name"));
                row.put("totalSpent", rs.getDouble("totalSpent"));
                topCustomers.add(row);
            }

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error: " + e.getMessage());
        }

        request.setAttribute("topCustomers", topCustomers);
        request.getRequestDispatcher("/Admin/reports/top-customers.jsp").forward(request, response);
    }
}
