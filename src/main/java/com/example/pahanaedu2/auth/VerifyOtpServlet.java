package com.example.pahanaedu2.auth;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/verify-otp")
public class VerifyOtpServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userOtp = request.getParameter("otp");
        HttpSession session = request.getSession(false);

        if (session == null || userOtp == null || userOtp.isBlank()) {
            request.setAttribute("errorMessage", "Invalid OTP submission.");
            request.getRequestDispatcher("verify-otp.jsp").forward(request, response);
            return;
        }

        String sessionOtp = (String) session.getAttribute("otp");
        Long otpExpiry = (Long) session.getAttribute("otpExpiry");

        if (sessionOtp == null || otpExpiry == null) {
            request.setAttribute("errorMessage", "OTP expired or not found. Please try again.");
            request.getRequestDispatcher("forgot-password.jsp").forward(request, response);
            return;
        }

        long now = System.currentTimeMillis();
        if (now > otpExpiry) {
            session.removeAttribute("otp");
            session.removeAttribute("otpExpiry");
            session.removeAttribute("otpEmail");

            request.setAttribute("errorMessage", "OTP expired. Please request a new one.");
            request.getRequestDispatcher("forgot-password.jsp").forward(request, response);
            return;
        }

        if (sessionOtp.equals(userOtp)) {
            // OTP valid, forward to reset password page
            response.sendRedirect("reset-password.jsp");
        } else {
            request.setAttribute("errorMessage", "Incorrect OTP. Please try again.");
            request.getRequestDispatcher("verify-otp.jsp").forward(request, response);
        }
    }
}
