package com.example.pahanaedu2.customer;

import com.example.pahanaedu2.db.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import com.example.pahanaedu2.audit.AuditLogDAO;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet("/Admin/delete-customer")
public class DeleteCustomerServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idStr = request.getParameter("id");
        if (idStr == null) {
            response.sendRedirect(request.getContextPath() + "/Admin/manage-customers");
            return;
        }

        int id = Integer.parseInt(idStr);

        String sql = "DELETE FROM Customers WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            stmt.executeUpdate();
            HttpSession session = request.getSession();
            int userId = (int) session.getAttribute("userId");

            AuditLogDAO logDAO = new AuditLogDAO();
            logDAO.logAction(userId, "Delete Customer", "Deleted customer ID: " + id);


        } catch (SQLException e) {
            e.printStackTrace();
            // Optional: set error message in session/request
        }

        response.sendRedirect(request.getContextPath() + "/Admin/manage-customers?success=3");
    }
}
