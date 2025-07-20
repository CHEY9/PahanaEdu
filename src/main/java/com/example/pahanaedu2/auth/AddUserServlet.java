package com.example.pahanaedu2.auth;

import com.example.pahanaedu2.db.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;

@WebServlet("/Admin/add-user")
public class AddUserServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username").trim();
        String password = request.getParameter("password").trim();
        String email = request.getParameter("email").trim();
        String phone = request.getParameter("phone").trim();
        String role = request.getParameter("role");

        // SQL insert
        String sql = "INSERT INTO Users (username, password, email, phone, role) VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, username);
            stmt.setString(2, password);
            stmt.setString(3, email);
            stmt.setString(4, phone);
            stmt.setString(5, role);

            int rows = stmt.executeUpdate();

            if (rows > 0) {
                // Success: redirect to manage users page with a success msg
                response.sendRedirect(request.getContextPath() + "/Admin/manage-users?success=1");
            } else {
                // Insert failed (no rows affected), show error and refill form
                request.setAttribute("errorMessage", "Failed to add user.");
                request.setAttribute("formData", request.getParameterMap());
                request.getRequestDispatcher("/Admin/add-user.jsp").forward(request, response);
            }

        } catch (SQLException e) {
            e.printStackTrace();
            // On SQL error, forward back to form with error message
            request.setAttribute("errorMessage", "Database error: " + e.getMessage());
            request.setAttribute("formData", request.getParameterMap());
            request.getRequestDispatcher("/Admin/add-user.jsp").forward(request, response);
        }
    }
}
