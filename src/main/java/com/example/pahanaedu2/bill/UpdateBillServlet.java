package com.example.pahanaedu2.bill;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;

@WebServlet("/staff/update-bill")
public class UpdateBillServlet extends HttpServlet {

    private static final String DB_URL = "jdbc:sqlserver://localhost:1433;databaseName=PahanaEdu;encrypt=true;trustServerCertificate=true";
    private static final String DB_USER = "sa";
    private static final String DB_PASS = "12345";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String billIdStr = request.getParameter("billId");
        String[] quantitiesStr = request.getParameterValues("quantities");
        String[] itemNames = request.getParameterValues("itemNames");
        String[] unitPricesStr = request.getParameterValues("unitPrices");

        if (billIdStr == null || quantitiesStr == null || itemNames == null || unitPricesStr == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing parameters");
            return;
        }

        int billId;
        try {
            billId = Integer.parseInt(billIdStr);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid billId");
            return;
        }

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS)) {
            conn.setAutoCommit(false);

            // Update each bill item quantity and total price
            String updateSql = "UPDATE bill_items SET quantity = ?, total_Price = ? WHERE bill_Id = ? AND item_Id = (SELECT itemId FROM items WHERE itemName = ?)";

            try (PreparedStatement ps = conn.prepareStatement(updateSql)) {
                double newTotalAmount = 0;

                for (int i = 0; i < quantitiesStr.length; i++) {
                    int quantity = Integer.parseInt(quantitiesStr[i]);
                    double unitPrice = Double.parseDouble(unitPricesStr[i]);
                    double totalPrice = quantity * unitPrice;

                    ps.setInt(1, quantity);
                    ps.setDouble(2, totalPrice);
                    ps.setInt(3, billId);
                    ps.setString(4, itemNames[i]);
                    ps.addBatch();

                    newTotalAmount += totalPrice;
                }

                ps.executeBatch();

                // Update totalAmount in bills table
                String updateBillSql = "UPDATE bills SET totalAmount = ? WHERE bill_id = ?";
                try (PreparedStatement psBill = conn.prepareStatement(updateBillSql)) {
                    psBill.setDouble(1, newTotalAmount);
                    psBill.setInt(2, billId);
                    psBill.executeUpdate();
                }

                conn.commit();
            } catch (SQLException e) {
                conn.rollback();
                throw e;
            }

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "DB error: " + e.getMessage());
            return;
        }

        // Redirect back to bill details page after update
        response.sendRedirect(request.getContextPath() + "/staff/bill-details?billId=" + billId);
    }
}
