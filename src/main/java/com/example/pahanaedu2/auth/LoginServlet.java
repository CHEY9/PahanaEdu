package com.example.pahanaedu2.auth;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.regex.Pattern;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private static final Pattern USERNAME_PATTERN = Pattern.compile("^[a-zA-Z0-9._-]{4,20}$");
    private final AuthService authService = new AuthService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // Validation: username
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

        // Validation: password
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
            // Save to session
            HttpSession session = request.getSession();
            session.setAttribute("user", user);

            // Redirect based on role
            if ("admin".equalsIgnoreCase(user.getRole())) {
                response.sendRedirect("admin/dashboard.jsp");
            } else if ("staff".equalsIgnoreCase(user.getRole())) {
                response.sendRedirect("staff/dashboard.jsp");
            } else {
                request.setAttribute("errorMessage", "Unknown role. Contact administrator.");
                request.getRequestDispatcher("/login.jsp").forward(request, response);
            }
        } else {
            request.setAttribute("errorMessage", "Invalid username or password.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }
}
