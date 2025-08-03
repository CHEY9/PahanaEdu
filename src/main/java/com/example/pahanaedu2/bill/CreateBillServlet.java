package com.example.pahanaedu2.bill;

import com.example.pahanaedu2.customer.Customer;
import com.example.pahanaedu2.item.Item;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import com.example.pahanaedu2.util.EmailService;


@WebServlet("/Staff/create-bill")
public class CreateBillServlet extends HttpServlet {

    private static final int LOW_STOCK_THRESHOLD = 10;
    private static final String DB_URL = "jdbc:sqlserver://localhost:1433;databaseName=PahanaEdu;encrypt=true;trustServerCertificate=true";
    private static final String DB_USER = "sa";
    private static final String DB_PASS = "12345";

    @Override

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS)) {
            List<Customer> customers = new ArrayList<>();
            List<Item> items = new ArrayList<>();

            // Load customers
            try (PreparedStatement custStmt = conn.prepareStatement("SELECT id, name FROM customers");
                 ResultSet custRs = custStmt.executeQuery()) {
                while (custRs.next()) {
                    Customer cust = new Customer();
                    cust.setId(custRs.getInt("id"));
                    cust.setName(custRs.getString("name"));
                    customers.add(cust);
                }
            }

            // Load items
            try (PreparedStatement itemStmt = conn.prepareStatement("SELECT itemId, itemName, category, price, stockQuantity FROM items");
                 ResultSet itemRs = itemStmt.executeQuery()) {
                while (itemRs.next()) {
                    Item item = new Item();
                    item.setItemId(itemRs.getInt("itemId"));
                    item.setItemName(itemRs.getString("itemName"));
                    item.setCategory(itemRs.getString("category"));
                    item.setPrice(itemRs.getDouble("price"));
                    item.setStockQuantity(itemRs.getInt("stockQuantity"));
                    items.add(item);
                }
            }

            request.setAttribute("customers", customers);
            request.setAttribute("items", items);

            request.getRequestDispatcher("/Staff/create-bill.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error while loading form data.");
        }
    }

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
            }
        }

        if (filteredItemIds.isEmpty()) {
            // Set error message
            request.setAttribute("errorMessage", "Please select at least one item to generate the bill.");

            // Reload customers and items to show in the form again
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS)) {
                List<Customer> customers = new ArrayList<>();
                List<Item> items = new ArrayList<>();

                // Load customers
                PreparedStatement custStmt = conn.prepareStatement("SELECT id, name FROM customers");
                ResultSet custRs = custStmt.executeQuery();
                while (custRs.next()) {
                    Customer cust = new Customer();
                    cust.setId(custRs.getInt("id"));
                    cust.setName(custRs.getString("name"));
                    customers.add(cust);
                }
                custRs.close();
                custStmt.close();

                // Load items
                PreparedStatement itemStmt = conn.prepareStatement("SELECT itemId, itemName, category, price, stockQuantity FROM items");
                ResultSet itemRs = itemStmt.executeQuery();
                while (itemRs.next()) {
                    Item item = new Item();
                    item.setItemId(itemRs.getInt("itemId"));
                    item.setItemName(itemRs.getString("itemName"));
                    item.setCategory(itemRs.getString("category"));
                    item.setPrice(itemRs.getDouble("price"));
                    item.setStockQuantity(itemRs.getInt("stockQuantity"));
                    items.add(item);
                }
                itemRs.close();
                itemStmt.close();

                // Set as request attributes
                request.setAttribute("customers", customers);
                request.setAttribute("items", items);

                // Forward back to form
                request.getRequestDispatcher("/Staff/create-bill.jsp").forward(request, response);
                return;
            } catch (SQLException e) {
                e.printStackTrace();
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error while loading form data.");
                return;
            }
        }


        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS)) {
            conn.setAutoCommit(false);

            try {
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
                String insertBillSQL = "INSERT INTO bills (Id, totalAmount, bill_date_time) VALUES (?, ?, ?)";
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

                String updateStockSQL = "UPDATE items SET stockQuantity = ? WHERE itemId = ?";
                PreparedStatement updateStockStmt = conn.prepareStatement(updateStockSQL);

                for (int i = 0; i < filteredItemIds.size(); i++) {
                    int itemId = filteredItemIds.get(i);
                    int qty = filteredQuantities.get(i);
                    double unitPrice = unitPrices[i];
                    double totalPrice = unitPrice * qty;
                    int newStockQty = stockQuantities[i] - qty;

                    if (newStockQty < LOW_STOCK_THRESHOLD) {
                        String itemName = ""; // Default in case name fetch fails
                        try (PreparedStatement itemNameStmt = conn.prepareStatement("SELECT ItemName FROM items WHERE itemId = ?")) {
                            itemNameStmt.setInt(1, itemId);
                            try (ResultSet itemRs = itemNameStmt.executeQuery()) {
                                if (itemRs.next()) {
                                    itemName = itemRs.getString("ItemName");
                                }
                            }
                        }

                        // Send low stock alert

                        String timestamp = java.time.LocalDateTime.now().format(
                                java.time.format.DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")
                        );

                        EmailService.sendLowStockAlert(itemName, newStockQty, timestamp);

                    }

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

                // Load bill items
                String billItemsSQL = "SELECT bi.item_Id, i.itemName, bi.quantity, bi.unit_Price, bi.total_Price " +
                        "FROM bill_items bi JOIN items i ON bi.item_Id = i.itemId WHERE bi.bill_Id = ?";

                PreparedStatement billItemsStmt = conn.prepareStatement(billItemsSQL);
                billItemsStmt.setInt(1, billId);
                ResultSet rsItems = billItemsStmt.executeQuery();

                List<Bill> billItems = new ArrayList<>();
                while (rsItems.next()) {
                    Bill bi = new Bill();

                    bi.setItemId(rsItems.getInt("item_Id"));
                    bi.setItemName(rsItems.getString("itemName"));
                    bi.setQuantity(rsItems.getInt("quantity"));
                    bi.setUnitPrice(rsItems.getDouble("unit_Price"));
                    bi.setTotalPrice(rsItems.getDouble("total_Price"));

                    billItems.add(bi);
                }
                rsItems.close();
                billItemsStmt.close();

                request.setAttribute("billItems", billItems);

                // Load customer details
                String customerSQL = "SELECT id, name FROM customers WHERE id = ?";
                PreparedStatement customerStmt = conn.prepareStatement(customerSQL);
                customerStmt.setInt(1, customerId);
                ResultSet rsCustomer = customerStmt.executeQuery();

                Customer customer = null;
                if (rsCustomer.next()) {
                    customer = new Customer();
                    customer.setId(rsCustomer.getInt("id"));
                    customer.setName(rsCustomer.getString("name"));
                }
                rsCustomer.close();
                customerStmt.close();

                request.setAttribute("customer", customer);

                // Load bill info
                String billInfoSQL = "SELECT totalAmount, bill_date_time FROM bills WHERE bill_id = ?";
                PreparedStatement billInfoStmt = conn.prepareStatement(billInfoSQL);
                billInfoStmt.setInt(1, billId);
                ResultSet rsBillInfo = billInfoStmt.executeQuery();

                double totalAmountFromDB = 0;
                String billDateTime = "";
                if (rsBillInfo.next()) {
                    totalAmountFromDB = rsBillInfo.getDouble("totalAmount");
                    billDateTime = rsBillInfo.getString("bill_date_time");
                }
                rsBillInfo.close();
                billInfoStmt.close();

                request.setAttribute("totalAmount", totalAmountFromDB);
                request.setAttribute("billDateTime", billDateTime);
                request.setAttribute("billId", billId);

                HttpSession session = request.getSession(false);
                String staffUsername = (session != null) ? (String) session.getAttribute("username") : "Unknown";
                int userId = (session != null && session.getAttribute("userId") != null)
                        ? (int) session.getAttribute("userId") : -1;

                if (userId != -1) {
                    String staffSQL = "SELECT username FROM users WHERE id = ?";
                    PreparedStatement staffStmt = conn.prepareStatement(staffSQL);
                    staffStmt.setInt(1, userId);
                    ResultSet rsStaff = staffStmt.executeQuery();
                    if (rsStaff.next()) {
                        staffUsername = rsStaff.getString("username");
                    }
                    rsStaff.close();
                    staffStmt.close();
                }

                request.setAttribute("staffUsername", staffUsername);
                System.out.println("Staff username from DB: " + staffUsername);

                request.setAttribute("staffUsername", staffUsername);
                System.out.println("Staff username in session: " + staffUsername);

                request.getRequestDispatcher("/Staff/bill-details.jsp").forward(request, response);

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