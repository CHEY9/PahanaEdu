package com.example.pahanaedu2.bill;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/Staff/create-bill")
public class CreateBillServlet extends HttpServlet {

    private static final String DB_URL = "jdbc:sqlserver://localhost:1433;databaseName=PahanaEdu;encrypt=true;trustServerCertificate=true";
    private static final String DB_USER = "sa";
    private static final String DB_PASS = "12345";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String customerIdStr = request.getParameter("customerId");
        String[] itemIds = request.getParameterValues("itemIds");
        String[] quantities = request.getParameterValues("quantities");

        if (customerIdStr == null || itemIds == null || quantities == null || itemIds.length != quantities.length) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid input data");
            return;
        }

        int customerId;
        try {
            customerId = Integer.parseInt(customerIdStr);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid customer ID");
            return;
        }

        // Filter out items with quantity <= 0
        List<Integer> filteredItemIds = new ArrayList<>();
        List<Integer> filteredQuantities = new ArrayList<>();

        for (int i = 0; i < itemIds.length; i++) {
            try {
                int qty = Integer.parseInt(quantities[i]);
                if (qty > 0) {
                    filteredItemIds.add(Integer.parseInt(itemIds[i]));
                    filteredQuantities.add(qty);
                }
            } catch (NumberFormatException e) {
                // skip invalid quantities
            }
        }

        if (filteredItemIds.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "No items selected to purchase.");
            return;
        }

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS)) {
            conn.setAutoCommit(false);  // start transaction

            try {
                // Prepare statement to get price and stock for each item
                String priceQuery = "SELECT price, stockQuantity FROM items WHERE itemId = ?";
                PreparedStatement priceStmt = conn.prepareStatement(priceQuery);

                double totalAmount = 0;
                double[] unitPrices = new double[filteredItemIds.size()];
                int[] stockQuantities = new int[filteredItemIds.size()];

                for (int i = 0; i < filteredItemIds.size(); i++) {
                    int itemId = filteredItemIds.get(i);
                    int qty = filteredQuantities.get(i);

                    priceStmt.setInt(1, itemId);
                    ResultSet rs = priceStmt.executeQuery();

                    if (!rs.next()) {
                        conn.rollback();
                        response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Item ID " + itemId + " not found.");
                        return;
                    }

                    double price = rs.getDouble("price");
                    int stockQty = rs.getInt("stockQuantity");

                    if (qty > stockQty) {
                        conn.rollback();
                        response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Not enough stock for item ID " + itemId);
                        return;
                    }

                    unitPrices[i] = price;
                    stockQuantities[i] = stockQty;

                    totalAmount += price * qty;
                    rs.close();
                }
                priceStmt.close();

                // Insert into bills table
                String insertBillSQL = "INSERT INTO bills (Id, totalAmount, dateTime) VALUES (?, ?, ?)";
                PreparedStatement billStmt = conn.prepareStatement(insertBillSQL, Statement.RETURN_GENERATED_KEYS);

                LocalDateTime now = LocalDateTime.now();
                billStmt.setInt(1, customerId);
                billStmt.setDouble(2, totalAmount);
                billStmt.setString(3, now.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));

                int affectedRows = billStmt.executeUpdate();
                if (affectedRows == 0) {
                    conn.rollback();
                    response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Creating bill failed, no rows affected.");
                    return;
                }

                ResultSet generatedKeys = billStmt.getGeneratedKeys();
                int billId;
                if (generatedKeys.next()) {
                    billId = generatedKeys.getInt(1);
                } else {
                    conn.rollback();
                    response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Creating bill failed, no ID obtained.");
                    return;
                }
                billStmt.close();

                // Insert into bill_items table
                String insertBillItemSQL = "INSERT INTO bill_items (bill_Id, item_Id, quantity, unit_Price, total_Price) VALUES (?, ?, ?, ?, ?)";
                PreparedStatement billItemStmt = conn.prepareStatement(insertBillItemSQL);

                // Update stock quantity SQL
                String updateStockSQL = "UPDATE items SET stockQuantity = ? WHERE itemId = ?";
                PreparedStatement updateStockStmt = conn.prepareStatement(updateStockSQL);

                for (int i = 0; i < filteredItemIds.size(); i++) {
                    int itemId = filteredItemIds.get(i);
                    int qty = filteredQuantities.get(i);
                    double unitPrice = unitPrices[i];
                    double totalPrice = unitPrice * qty;
                    int newStockQty = stockQuantities[i] - qty;

                    billItemStmt.setInt(1, billId);
                    billItemStmt.setInt(2, itemId);
                    billItemStmt.setInt(3, qty);
                    billItemStmt.setDouble(4, unitPrice);
                    billItemStmt.setDouble(5, totalPrice);
                    billItemStmt.addBatch();

                    updateStockStmt.setInt(1, newStockQty);
                    updateStockStmt.setInt(2, itemId);
                    updateStockStmt.addBatch();
                }

                billItemStmt.executeBatch();
                updateStockStmt.executeBatch();

                conn.commit();

                response.sendRedirect(request.getContextPath() + "/staff/bills?success=true");

            } catch (Exception e) {
                conn.rollback();
                e.printStackTrace();
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error saving bill: " + e.getMessage());
            }

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database connection error: " + e.getMessage());
        }
    }
}
