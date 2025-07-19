package com.example.pahanaedu2.bill;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.sql.*;
import java.util.*;

@WebServlet("/Staff/create-bill-form")
public class CreateBillFormServlet extends HttpServlet {

    String jdbcURL = "jdbc:sqlserver://localhost:1433;databaseName=PahanaEdu;encrypt=true;trustServerCertificate=true";
    String jdbcUsername = "sa";
    String jdbcPassword = "12345";

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Map<String, Object>> customers = new ArrayList<>();
        List<Map<String, Object>> items = new ArrayList<>();

        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            Connection conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);

            // Load customers - updated column names
            String sqlCustomers = "SELECT id, name FROM customers";
            PreparedStatement ps1 = conn.prepareStatement(sqlCustomers);
            ResultSet rs1 = ps1.executeQuery();
            while (rs1.next()) {
                Map<String, Object> customer = new HashMap<>();
                customer.put("id", rs1.getInt("id"));
                customer.put("name", rs1.getString("name"));
                customers.add(customer);
            }
            System.out.println("Customers loaded: " + customers.size());

            // Load items - updated column names
            String sqlItems = "SELECT ItemID, ItemName, Category, Price, StockQuantity FROM items";
            PreparedStatement ps2 = conn.prepareStatement(sqlItems);
            ResultSet rs2 = ps2.executeQuery();
            while (rs2.next()) {
                Map<String, Object> item = new HashMap<>();
                item.put("id", rs2.getInt("ItemID"));
                item.put("name", rs2.getString("ItemName"));
                item.put("category", rs2.getString("Category"));
                item.put("price", rs2.getDouble("Price"));
                item.put("stock", rs2.getInt("StockQuantity"));
                items.add(item);
            }
            System.out.println("Items loaded: " + items.size());

            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("customers", customers);
        request.setAttribute("items", items);

        RequestDispatcher dispatcher = request.getRequestDispatcher("/Staff/create-bill.jsp");
        dispatcher.forward(request, response);
    }
}
