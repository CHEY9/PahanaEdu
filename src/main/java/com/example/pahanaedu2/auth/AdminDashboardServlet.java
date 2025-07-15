package com.example.pahanaedu2.auth;

import com.example.pahanaedu2.item.Item;
import com.example.pahanaedu2.item.ItemDAO;
import java.util.List;
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

        ItemDAO itemDAO = new ItemDAO();
        List<Item> lowStockItems = itemDAO.getLowStockItems(10); // you added this in ItemDAO
        System.out.println("Low stock items count: " + lowStockItems.size());
        for (Item item : lowStockItems) {
            System.out.println("Item: " + item.getItemName() + " | Stock: " + item.getStockQuantity());
        }
        request.setAttribute("lowStockItems", lowStockItems);// this is a List<Item>
        // You can add dashboard data here, e.g. stats
        // request.setAttribute("userCount", someService.getUserCount());
        System.out.println("🚀 Servlet is called");
        request.getRequestDispatcher("/Admin/dashboard.jsp").forward(request, response);
    }
}