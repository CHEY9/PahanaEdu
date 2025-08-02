package com.example.pahanaedu2.auth;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;

@WebServlet("/reset-password")
public class ResetPasswordServlet extends HttpServlet {

    private static final String DB_URL = "jdbc:sqlserver://localhost:1433;databaseName=PahanaEdu;encrypt=true;trustServerCertificate=true";
    private static final String DB_USER = "sa";
    private static final String DB_PASS = "12345";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        HttpSession session = request.getSession(false);

        if (session == null) {
            response.sendRedirect("forgot-password.jsp");
            return;
        }

        if (password == null || confirmPassword == null || !password.equals(confirmPassword)) {
            request.setAttribute("errorMessage", "Passwords do not match.");
            request.getRequestDispatcher("reset-password.jsp").forward(request, response);
            return;
        }

        String email = (String) session.getAttribute("otpEmail");
        if (email == null) {
            response.sendRedirect("forgot-password.jsp");
            return;
        }
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS)) {
            String sql = "UPDATE users SET password = ? WHERE email = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, password); // Use hashed password in production!
            stmt.setString(2, email);

            int rowsUpdated = stmt.executeUpdate();

            if (rowsUpdated > 0) {
                // Clear session OTP data
                session.removeAttribute("otp");
                session.removeAttribute("otpExpiry");
                session.removeAttribute("otpEmail");

                // Redirect to login page with success param
                response.sendRedirect("login.jsp?reset=1");
            } else {
                request.setAttribute("errorMessage", "Unable to reset password. Try again.");
                request.getRequestDispatcher("reset-password.jsp").forward(request, response);
            }

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Database error: " + e.getMessage());
            request.getRequestDispatcher("reset-password.jsp").forward(request, response);
        }
    }
}
