package com.example.pahanaedu2.staff;

import com.example.pahanaedu2.audit.AuditLogDAO;
import com.example.pahanaedu2.auth.User;
import com.example.pahanaedu2.customer.Customer;
import com.example.pahanaedu2.db.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet("/Staff/edit-customer")
public class EditCustomerServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int customerId = Integer.parseInt(request.getParameter("id"));

        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT * FROM customers WHERE id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, customerId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                Customer customer = new Customer(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("email"),
                        rs.getString("phone"),
                        rs.getString("address")
                );
                request.setAttribute("customer", customer);

                // Forward to JSP
                request.getRequestDispatcher("/Staff/edit-customer.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/Staff/manage-customers");
            }


        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error loading customer details.");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");

        try (Connection conn = DBConnection.getConnection()) {
            String sql = "UPDATE customers SET name = ?, email = ?, phone = ?, address = ? WHERE id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, name);
            stmt.setString(2, email);
            stmt.setString(3, phone);
            stmt.setString(4, address);
            stmt.setInt(5, id);
            stmt.executeUpdate();

            HttpSession session = request.getSession(false);
            if (session != null && session.getAttribute("user") != null) {
                User currentUser = (User) session.getAttribute("user");
                int staffId = currentUser.getId();

                AuditLogDAO auditLogDAO = new AuditLogDAO();
                auditLogDAO.logAction(staffId, "Update Customer", "Staff updated customer with ID: " + id);
            }
            response.sendRedirect(request.getContextPath() + "/Staff/manage-customers");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to update customer.");
        }
    }
}
