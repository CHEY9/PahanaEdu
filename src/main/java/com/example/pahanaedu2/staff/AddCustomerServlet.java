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

@WebServlet("/Staff/add-customer")
public class AddCustomerServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");

        try (Connection conn = DBConnection.getConnection()) {
            String sql = "INSERT INTO customers (name, email, phone, address) VALUES (?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, name);
            stmt.setString(2, email);
            stmt.setString(3, phone);
            stmt.setString(4, address);
            stmt.executeUpdate();



            HttpSession session = request.getSession(false);
            if (session != null && session.getAttribute("user") != null) {
                User currentUser = (User) session.getAttribute("user");
                int staffId = currentUser.getId();

                AuditLogDAO auditLogDAO = new AuditLogDAO();
                auditLogDAO.logAction(staffId, "Add Customer", "Staff added new customer: " + name);
            }


            response.sendRedirect(request.getContextPath() + "/Staff/manage-customers");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to add customer");
        }
    }
}
