package com.example.pahanaedu2.bill;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/staff/bill-details")
public class BillDetailsServlet extends HttpServlet {

    private static final String DB_URL = "jdbc:sqlserver://localhost:1433;databaseName=PahanaEdu;encrypt=true;trustServerCertificate=true";
    private static final String DB_USER = "sa";
    private static final String DB_PASS = "12345";

    public static class BillItem {
        public String itemName;
        public int quantity;
        public double unitPrice;
        public double totalPrice;

        public BillItem(String itemName, int quantity, double unitPrice, double totalPrice) {
            this.itemName = itemName;
            this.quantity = quantity;
            this.unitPrice = unitPrice;
            this.totalPrice = totalPrice;
        }
        public String getItemName() {
            return itemName;
        }

        public int getQuantity() {
            return quantity;
        }

        public double getUnitPrice() {
            return unitPrice;
        }

        public double getTotalPrice() {
            return totalPrice;
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String billIdStr = request.getParameter("billId");
        if (billIdStr == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing billId");
            return;
        }

        int billId;
        try {
            billId = Integer.parseInt(billIdStr);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid billId");
            return;
        }

        String customerName = "";
        String billDateTime = "";
        double totalAmount = 0;

        String staffUsername = (String) request.getSession().getAttribute("username");
        if (staffUsername == null) staffUsername = "Unknown Staff";

        List<BillItem> billItems = new ArrayList<>();

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS)) {
            // Get bill and customer info
            String billSql = "SELECT b.bill_date_time, b.totalAmount, c.name AS customerName FROM bills b JOIN customers c ON b.Id = c.id WHERE b.bill_id = ?";
            PreparedStatement ps = conn.prepareStatement(billSql);
            ps.setInt(1, billId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                billDateTime = rs.getString("bill_date_time");
                totalAmount = rs.getDouble("totalAmount");
                customerName = rs.getString("customerName");
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Bill not found");
                return;
            }
            rs.close();
            ps.close();

            // Get bill items
            String itemsSql = "SELECT i.itemName, bi.quantity, bi.unit_Price, bi.total_Price FROM bill_items bi JOIN items i ON bi.item_Id = i.itemId WHERE bi.bill_Id = ?";
            PreparedStatement psItems = conn.prepareStatement(itemsSql);
            psItems.setInt(1, billId);
            ResultSet rsItems = psItems.executeQuery();

            while (rsItems.next()) {
                billItems.add(new BillItem(
                        rsItems.getString("itemName"),
                        rsItems.getInt("quantity"),
                        rsItems.getDouble("unit_Price"),
                        rsItems.getDouble("total_Price")
                ));
            }
            rsItems.close();
            psItems.close();

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "DB error: " + e.getMessage());
            return;
        }

        request.setAttribute("customerName", customerName);
        request.setAttribute("billDateTime", billDateTime);
        request.setAttribute("totalAmount", totalAmount);
        request.setAttribute("staffUsername", staffUsername);
        request.setAttribute("billItems", billItems);

        // Forward to JSP to display bill details
        request.getRequestDispatcher("/Staff/bill-details.jsp").forward(request, response);
    }
}
