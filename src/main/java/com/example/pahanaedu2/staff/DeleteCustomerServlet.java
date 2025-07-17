package com.example.pahanaedu2.staff;

import com.example.pahanaedu2.audit.AuditLogDAO;
import com.example.pahanaedu2.auth.User;
import com.example.pahanaedu2.db.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet("/Staff/delete-customer")
public class DeleteCustomerServlet extends HttpServlet {

    // Helper method to get customer name by ID before deleting
    private String getCustomerName(Connection conn, int customerId) throws SQLException {
        String name = "Unknown";
        String sql = "SELECT name FROM customers WHERE id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, customerId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    name = rs.getString("name");
                }
            }
        }
        return name;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int customerId = Integer.parseInt(request.getParameter("id"));

        try (Connection conn = DBConnection.getConnection()) {

            // Get customer name for audit logging
            String customerName = getCustomerName(conn, customerId);

            // Delete the customer
            String sql = "DELETE FROM customers WHERE id = ?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setInt(1, customerId);
                stmt.executeUpdate();
            }

            // Get current user from session to log who deleted
            HttpSession session = request.getSession(false);
            if (session != null) {
                User currentUser = (User) session.getAttribute("user");
                if (currentUser != null) {
                    int staffId = currentUser.getId();
                    AuditLogDAO auditLogDAO = new AuditLogDAO();
                    auditLogDAO.logAction(staffId, "Delete Customer",
                            "Staff deleted customer (ID: " + customerId + ", Name: " + customerName + ")");
                }
            }

            // Redirect after deletion
            response.sendRedirect(request.getContextPath() + "/Staff/manage-customers");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to delete customer.");
        }
    }
}
