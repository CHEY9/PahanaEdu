package com.example.pahanaedu2.staff;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.*;

@WebServlet("/staff/manage-bills")
public class ManageBillsServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Map<String, Object>> bills = new ArrayList<>();
        String jdbcURL = "jdbc:sqlserver://localhost:1433;databaseName=PahanaEdu;encrypt=true;trustServerCertificate=true";
        String dbUser = "sa";
        String dbPassword = "12345";

        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            Connection conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

            String sql = """
                SELECT 
                    b.bill_id,
                    b.Id AS customer_id,
                    c.name AS customerName,
                    b.bill_date_time,
                    SUM(bi.total_price) AS total_amount
                FROM bills b
                JOIN bill_items bi ON b.bill_id = bi.bill_id
                JOIN customers c ON b.Id = c.id
                GROUP BY b.bill_id, b.Id, c.name, b.bill_date_time
                ORDER BY b.bill_date_time DESC
            """;

            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Map<String, Object> bill = new HashMap<>();
                bill.put("billId", rs.getInt("bill_id"));
                bill.put("customerId", rs.getInt("customer_id"));
                bill.put("customerName", rs.getString("customerName"));
                bill.put("billDateTime", rs.getTimestamp("bill_date_time"));
                bill.put("totalAmount", rs.getDouble("total_amount"));
                bills.add(bill);
            }

            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error: " + e.getMessage());
        }

        request.setAttribute("bills", bills);
        request.getRequestDispatcher("/Staff/manage-bills.jsp").forward(request, response);
    }
}
