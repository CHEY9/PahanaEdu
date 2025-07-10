package com.example.pahanaedu2.auth;

import com.example.pahanaedu2.auth.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

        import java.io.IOException;

@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null || !"admin".equalsIgnoreCase(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // You can add dashboard data here, e.g. stats
        // request.setAttribute("userCount", someService.getUserCount());

        request.getRequestDispatcher("/WEB-INF/Admin/dashboard.jsp").forward(request, response);
    }
}