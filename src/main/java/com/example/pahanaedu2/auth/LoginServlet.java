package com.example.pahanaedu2.auth;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.util.regex.Pattern;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    // Declare this at class level (inside class, but outside methods)
    private static final Pattern USERNAME_PATTERN = Pattern.compile("^[a-zA-Z0-9._-]{4,20}$");

    // ... your servlet code ...
    private final AuthService authService = new AuthService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get input from form
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // Validation logic
        if (username == null || username.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Username cannot be empty.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }

        if (!USERNAME_PATTERN.matcher(username).matches()) {
            request.setAttribute("errorMessage", "Username must be 4–20 characters (letters, numbers, '.', '-', '_').");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }

        if (password == null || password.isEmpty()) {
            request.setAttribute("errorMessage", "Password cannot be empty.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }

        if (password.length() < 6 || password.contains(" ")) {
            request.setAttribute("errorMessage", "Password must be at least 6 characters and cannot contain spaces.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }

        // Authenticate user
        User user = authService.login(username, password);

        if (user != null) {
            // Login success - create session
            HttpSession session = request.getSession();
            session.setAttribute("user", user);

            // Redirect based on role
            if ("admin".equals(user.getRole())) {
                response.sendRedirect("dashboard_admin.jsp");
            } else {
                response.sendRedirect("dashboard_staff.jsp");
            }
        } else {
            // Login failed
            response.sendRedirect("/login.jsp?error=1");
        }
    }
}