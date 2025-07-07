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
    private static final Pattern USERNAME_PATTERN = Pattern.compile("^[a-zA-Z0-9._-]{6,20}$");
    private static final Pattern PASSWORD_PATTERN = Pattern.compile(
            "^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%^&+=]).{8,20}$"
    );
    private static final Pattern EMAIL_PATTERN = Pattern.compile(
            "^[\\w.-]+@[\\w.-]+\\.\\w{2,}$"
    );
    private static final Pattern PHONE_PATTERN = Pattern.compile("^\\d{10,15}$");

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Read form data
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String role = request.getParameter("role"); // admin or staff (optional depending on UI)

        // Validate input
        StringBuilder errorMsg = new StringBuilder();

        if (username == null || !USERNAME_PATTERN.matcher(username).matches()) {
            errorMsg.append("Username must be 6-20 characters long and contain letters, numbers, ., _, or -.<br>");
        }
        if (password == null || !PASSWORD_PATTERN.matcher(password).matches()) {
            errorMsg.append("Password must be 8-20 characters, include uppercase, lowercase, digit, and special character.<br>");
        }
        if (confirmPassword == null || !password.equals(confirmPassword)) {
            errorMsg.append("Passwords do not match.<br>");
        }
        if (email == null || !EMAIL_PATTERN.matcher(email).matches()) {
            errorMsg.append("Invalid email format.<br>");
        }
        if (phone == null || !PHONE_PATTERN.matcher(phone).matches()) {
            errorMsg.append("Phone must be 10-15 digits.<br>");
        }

        if (errorMsg.length() > 0) {
            // Send back errors to register.jsp
            request.setAttribute("error", errorMsg.toString());
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        // Create user object (assuming you have a User class)
        User newUser = new User(username, password, email, phone, role);

        // Register user using your AuthService (implement this!)
        boolean registered = authService.registerUser(newUser);

        if (registered) {
            // Registration success, redirect to login with a success message
            response.sendRedirect("login.jsp?registered=1");
        } else {
            // Registration failed (e.g., username/email exists)
            request.setAttribute("error", "Username or email already exists.");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
        }
    }
}