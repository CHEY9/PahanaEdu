package com.example.pahanaedu2.customer;

import com.example.pahanaedu2.db.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet("/Admin/add-customer")
public class AddCustomerServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name").trim();
        String email = request.getParameter("email").trim();
        String phone = request.getParameter("phone").trim();
        String address = request.getParameter("address").trim();

        String sql = "INSERT INTO Customers (name, email, phone, address) VALUES (?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, name);
            stmt.setString(2, email);
            stmt.setString(3, phone);
            stmt.setString(4, address);

            int rows = stmt.executeUpdate();

            if (rows > 0) {
                response.sendRedirect(request.getContextPath() + "/Admin/manage-customers?success=1");
            } else {
                request.setAttribute("errorMessage", "Failed to add customer.");
                request.getRequestDispatcher("/Admin/add-customer.jsp").forward(request, response);
            }

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Database error: " + e.getMessage());
            request.getRequestDispatcher("/Admin/add-customer.jsp").forward(request, response);
        }
    }
}
