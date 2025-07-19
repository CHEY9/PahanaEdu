package com.example.pahanaedu2.bill;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.HashMap;

@WebServlet("/staff/bills")
public class BillsListServlet extends HttpServlet {

    private static final String DB_URL = "jdbc:sqlserver://localhost:1433;databaseName=PahanaEdu;encrypt=true;trustServerCertificate=true";
    private static final String DB_USER = "sa";
    private static final String DB_PASS = "12345";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Map<String, Object>> billsList = new ArrayList<>();

        String sql = "SELECT b.bill_id, b.Id AS customerId, c.name AS customerName, b.totalAmount, b.dateTime " +
                "FROM bills b " +
                "JOIN customers c ON b.Id = c.id " +
                "ORDER BY b.dateTime DESC";

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Map<String, Object> bill = new HashMap<>();
                bill.put("billId", rs.getInt("bill_id"));
                bill.put("customerId", rs.getInt("customerId"));
                bill.put("customerName", rs.getString("customerName"));
                bill.put("totalAmount", rs.getDouble("totalAmount"));
                bill.put("dateTime", rs.getString("dateTime"));
                billsList.add(bill);
            }

            request.setAttribute("billsList", billsList);
            request.getRequestDispatcher("/Staff/bills-list.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error: " + e.getMessage());
        }
    }
}
