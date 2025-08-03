package com.example.pahanaedu2.bill;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import com.example.pahanaedu2.item.Item;
import com.example.pahanaedu2.customer.Customer;

import java.io.IOException;
import java.sql.*;
import java.util.*;

@WebServlet("/Staff/create-bill-form")
public class CreateBillFormServlet extends HttpServlet {

    private static final String jdbcURL = "jdbc:sqlserver://localhost:1433;databaseName=PahanaEdu;encrypt=true;trustServerCertificate=true";
    private static final String jdbcUsername = "sa";
    private static final String jdbcPassword = "12345";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Customer> customers = new ArrayList<>();
        List<Item> items = new ArrayList<>();

        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");

            try (Connection conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword)) {

                // Load customers
                String sqlCustomers = "SELECT id, name FROM customers";
                try (PreparedStatement ps1 = conn.prepareStatement(sqlCustomers);
                     ResultSet rs1 = ps1.executeQuery()) {
                    while (rs1.next()) {
                        Customer cust = new Customer();
                        cust.setId(rs1.getInt("id"));
                        cust.setName(rs1.getString("name"));
                        customers.add(cust);
                    }
                }

                // Load items
                String sqlItems = "SELECT ItemID, ItemName, Category, Price, StockQuantity FROM items";
                try (PreparedStatement ps2 = conn.prepareStatement(sqlItems);
                     ResultSet rs2 = ps2.executeQuery()) {
                    while (rs2.next()) {
                        Item item = new Item();
                        item.setItemId(rs2.getInt("ItemID"));
                        item.setItemName(rs2.getString("ItemName"));
                        item.setCategory(rs2.getString("Category"));
                        item.setPrice(rs2.getDouble("Price"));
                        item.setStockQuantity(rs2.getInt("StockQuantity"));
                        items.add(item);
                    }
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            // Consider logging and/or sending error response here
        }

        request.setAttribute("customers", customers);
        request.setAttribute("items", items);

        RequestDispatcher dispatcher = request.getRequestDispatcher("/Staff/create-bill.jsp");
        dispatcher.forward(request, response);
    }
}
