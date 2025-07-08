package com.example.pahanaedu2.auth;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.regex.Pattern;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private final AuthService authService = new AuthService();

    // Validation patterns
    private static final Pattern USERNAME_PATTERN = Pattern.compile("^[a-zA-Z0-9._-]{5,10}$");
    private static final Pattern PASSWORD_PATTERN = Pattern.compile(
            "^(?=.*[a-z])(?=.*[0-9])(?=.*[A-Z])(?=.*[@#$%^&+=!]).{5,10}$"
    );
    private static final Pattern EMAIL_PATTERN = Pattern.compile(
            "^[A-Za-z0-9+_.-]+@[A-Za-z.-]+$"
    );
    private static final Pattern PHONE_PATTERN = Pattern.compile("^\\d{10}$");

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Read form data
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String role = request.getParameter("role");

        // Validate input
        StringBuilder errorMsg = new StringBuilder();

        if (username == null || !USERNAME_PATTERN.matcher(username).matches()) {
            errorMsg.append("Username must be 5–10 characters (letters, numbers, ., _, -).<br>");
        }

        if (password == null || !PASSWORD_PATTERN.matcher(password).matches()) {
            errorMsg.append("Password must be 5–10 characters, include uppercase, lowercase, digit, and special character.<br>");
        }

        if (confirmPassword == null || !password.equals(confirmPassword)) {
            errorMsg.append("Passwords do not match.<br>");
        }

        if (email == null || !EMAIL_PATTERN.matcher(email).matches()) {
            errorMsg.append("Invalid email format.<br>");
        }

        if (phone == null || !PHONE_PATTERN.matcher(phone).matches()) {
            errorMsg.append("Phone number must be exactly 10 digits.<br>");
        }

        // If any errors, return to form
        if (errorMsg.length() > 0) {
            request.setAttribute("error", errorMsg.toString());
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        // Create user object
        User newUser = new User(username, password, email, phone, role);

        // Try registering the user
        boolean registered = authService.registerUser(newUser);

        if (registered) {
            // Success! Redirect to login.jsp with success flag
            response.sendRedirect("login.jsp?registered=1");
        } else {
            // User already exists, or DB error
            request.setAttribute("error", "Username or email already exists.");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
        }
    }
}