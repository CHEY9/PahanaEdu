package com.example.pahanaedu2.customer;

import com.example.pahanaedu2.db.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import com.example.pahanaedu2.audit.AuditLogDAO;

import java.io.IOException;
import java.sql.*;

@WebServlet("/Admin/edit-customer")
public class EditCustomerServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Get customer ID from query parameter
        String idStr = request.getParameter("id");
        if (idStr == null) {
            response.sendRedirect(request.getContextPath() + "/Admin/manage-customers");
            return;
        }

        int id = Integer.parseInt(idStr);
        Customer customer = null;

        String sql = "SELECT * FROM Customers WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    customer = new Customer();
                    customer.setId(rs.getInt("id"));
                    customer.setName(rs.getString("name"));
                    customer.setEmail(rs.getString("email"));
                    customer.setPhone(rs.getString("phone"));
                    customer.setAddress(rs.getString("address"));
                } else {
                    response.sendRedirect(request.getContextPath() + "/Admin/manage-customers");
                    return;
                }
                HttpSession session = request.getSession();
                int userId = (int) session.getAttribute("userId");

                AuditLogDAO logDAO = new AuditLogDAO();
                logDAO.logAction(userId, "Edit Customer", "Updated customer ID: " + id);

            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Database error: " + e.getMessage());
        }

        request.setAttribute("customer", customer);
        request.getRequestDispatcher("/Admin/edit-customer.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name").trim();
        String email = request.getParameter("email").trim();
        String phone = request.getParameter("phone").trim();
        String address = request.getParameter("address").trim();

        String sql = "UPDATE Customers SET name = ?, email = ?, phone = ?, address = ? WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, name);
            stmt.setString(2, email);
            stmt.setString(3, phone);
            stmt.setString(4, address);
            stmt.setInt(5, id);

            int rows = stmt.executeUpdate();
            if (rows > 0) {
                response.sendRedirect(request.getContextPath() + "/Admin/manage-customers?success=2");
            } else {
                request.setAttribute("errorMessage", "Failed to update customer.");
                request.getRequestDispatcher("/Admin/edit-customer.jsp").forward(request, response);
            }

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Database error: " + e.getMessage());
            request.getRequestDispatcher("/Admin/edit-customer.jsp").forward(request, response);
        }
    }
}
