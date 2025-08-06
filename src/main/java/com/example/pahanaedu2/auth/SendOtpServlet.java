package com.example.pahanaedu2.auth;

import com.example.pahanaedu2.util.EmailService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;

@WebServlet("/send-otp")
public class SendOtpServlet extends HttpServlet {

    private static final int OTP_EXPIRY_MINUTES = 10;
    private static final String DB_URL = "jdbc:sqlserver://localhost:1433;databaseName=PahanaEdu;encrypt=true;trustServerCertificate=true";
    private static final String DB_USER = "sa";
    private static final String DB_PASS = "12345";

    static {
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            System.out.println("SQL Server JDBC Driver loaded successfully.");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        if (email == null || email.isBlank()) {
            request.setAttribute("errorMessage", "Email is required.");
            request.getRequestDispatcher("forgot-password.jsp").forward(request, response);
            return;
        }

        email = email.trim().toLowerCase();

        // Check if email exists in DB
        if (!emailExists(email)) {
            request.setAttribute("errorMessage", "Email not registered.");
            request.getRequestDispatcher("forgot-password.jsp").forward(request, response);
            return;
        }

        // Generate OTP
        String otp = String.format("%06d", (int) (Math.random() * 1000000));

        // Store OTP and expiry in session
        HttpSession session = request.getSession();
        session.setAttribute("otp", otp);
        session.setAttribute("otpExpiry", System.currentTimeMillis() + OTP_EXPIRY_MINUTES * 60 * 1000);
        session.setAttribute("otpEmail", email);

        // Send OTP email (assuming EmailService has sendOtpEmail method)
        EmailService.sendOtpEmail(email, otp);

        // Redirect to OTP verification page
        response.sendRedirect("verify-otp.jsp");
    }

    private boolean emailExists(String email) {
        System.out.println("Checking email existence for: '" + email + "'");
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS)) {
            System.out.println("Database connection established.");
            String sql = "SELECT COUNT(*) FROM users WHERE LOWER(email) = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                int count = rs.getInt(1);
                System.out.println("Email count: " + count);
                return count > 0;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
