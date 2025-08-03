package com.example.pahanaedu2.reports;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.*;

@WebServlet("/Admin/reports/most-sold-items")
public class MostSoldItemsServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Map<String, Object>> mostSoldItems = new ArrayList<>();
        String sql = "SELECT i.ItemName, SUM(bi.quantity) AS TotalSold " +
                "FROM bill_items bi " +
                "JOIN items i ON bi.item_id = i.ItemID " +
                "GROUP BY i.ItemName " +
                "ORDER BY TotalSold DESC";



        try (Connection conn = DriverManager.getConnection(
                "jdbc:sqlserver://localhost:1433;databaseName=PahanaEdu;encrypt=true;trustServerCertificate=true",
                "sa", "12345");
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                String itemName = rs.getString("ItemName");
                int totalSold = rs.getInt("TotalSold");
                System.out.println("DEBUG - Item: " + itemName + ", Total Sold: " + totalSold);

                Map<String, Object> row = new HashMap<>();
                row.put("itemName", itemName);
                row.put("totalSold", totalSold);
                mostSoldItems.add(row);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        request.setAttribute("mostSoldItems", mostSoldItems);
        request.getRequestDispatcher("/Admin/reports/most-sold-items.jsp").forward(request, response);
    }
}
