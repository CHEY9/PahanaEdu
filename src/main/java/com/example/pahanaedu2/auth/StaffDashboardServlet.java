package com.example.pahanaedu2.auth;

import com.example.pahanaedu2.item.Item;
import com.example.pahanaedu2.item.ItemDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/Staff/staff-dashboard")
public class StaffDashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null || !"staff".equalsIgnoreCase(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // low stock items
        ItemDAO itemDAO = new ItemDAO();
        List<Item> lowStockItems = itemDAO.getLowStockItems(10);
        request.setAttribute("lowStockItems", lowStockItems);

        request.getRequestDispatcher("/Staff/dashboard.jsp").forward(request, response);
    }
}
