package com.example.pahanaedu2.auth;

import com.example.pahanaedu2.db.DBConnection;
import com.example.pahanaedu2.customer.Customer;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/Admin/manage-customers")
public class ManageCustomersServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Customer> customers = new ArrayList<>();

        String sql = "SELECT id, name, email, phone, address FROM Customers";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Customer c = new Customer(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("email"),
                        rs.getString("phone"),
                        rs.getString("address")
                );
                customers.add(c);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error retrieving customers.");
        }

        // Set the customers list as a request attribute for the JSP
        request.setAttribute("customers", customers);

        // Forward to JSP page to display customers
        request.getRequestDispatcher("/Admin/manage-customers.jsp").forward(request, response);
    }
}
