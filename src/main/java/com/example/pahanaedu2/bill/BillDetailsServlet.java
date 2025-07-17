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

@WebServlet("/staff/bill-details")
public class BillDetailsServlet extends HttpServlet {

    private static final String DB_URL = "jdbc:sqlserver://localhost:1433;databaseName=PahanaEdu;encrypt=true;trustServerCertificate=true";
    private static final String DB_USER = "sa";
    private static final String DB_PASS = "12345";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String billIdStr = request.getParameter("billId");
        if (billIdStr == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing bill ID");
            return;
        }

        int billId;
        try {
            billId = Integer.parseInt(billIdStr);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid bill ID");
            return;
        }

        // Bill info
        Map<String, Object> bill = new HashMap<>();
        // Bill items list
        List<Map<String, Object>> itemsList = new ArrayList<>();

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS)) {

            // Get bill header and customer name
            String billSql = "SELECT b.bill_id, b.Id AS customerId, c.name AS customerName, b.total_price, b.dateTime " +
                    "FROM bills b " +
                    "JOIN customers c ON b.Id = c.id " +
                    "WHERE b.bill_id = ?";

            try (PreparedStatement stmt = conn.prepareStatement(billSql)) {
                stmt.setInt(1, billId);
                try (ResultSet rs = stmt.executeQuery()) {
                    if (rs.next()) {
                        bill.put("billId", rs.getInt("bill_id"));
                        bill.put("customerId", rs.getInt("customerId"));
                        bill.put("customerName", rs.getString("customerName"));
                        bill.put("total_price", rs.getDouble("total_price"));
                        bill.put("dateTime", rs.getString("dateTime"));
                    } else {
                        response.sendError(HttpServletResponse.SC_NOT_FOUND, "Bill not found");
                        return;
                    }
                }
            }

            // Get bill items details joined with item info
            String itemsSql = "SELECT bi.item_Id, i.itemName, i.category, bi.quantity, bi.unit_Price, bi.total_Price " +
                    "FROM bill_items bi " +
                    "JOIN items i ON bi.item_Id = i.itemId " +
                    "WHERE bi.bill_Id = ?";

            try (PreparedStatement stmt = conn.prepareStatement(itemsSql)) {
                stmt.setInt(1, billId);
                try (ResultSet rs = stmt.executeQuery()) {
                    while (rs.next()) {
                        Map<String, Object> item = new HashMap<>();
                        item.put("itemId", rs.getInt("item_Id"));
                        item.put("itemName", rs.getString("itemName"));
                        item.put("category", rs.getString("category"));
                        item.put("quantity", rs.getInt("quantity"));
                        item.put("unitPrice", rs.getDouble("unit_Price"));
                        item.put("totalPrice", rs.getDouble("total_Price"));
                        itemsList.add(item);
                    }
                }
            }

            request.setAttribute("bill", bill);
            request.setAttribute("itemsList", itemsList);
            request.getRequestDispatcher("/Staff/bill-details.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error: " + e.getMessage());
        }
    }
}
