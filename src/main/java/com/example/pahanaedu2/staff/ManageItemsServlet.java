package com.example.pahanaedu2.staff;

import com.example.pahanaedu2.audit.AuditLogDAO;
import com.example.pahanaedu2.item.Item;
import com.example.pahanaedu2.item.ItemDAO;
import com.example.pahanaedu2.auth.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/Staff/manage-items")
public class ManageItemsServlet extends HttpServlet {
    private ItemDAO itemDAO;

    @Override
    public void init() {
        itemDAO = new ItemDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Role check: ensure user is logged in and has staff role
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;
        if (user == null || !"staff".equalsIgnoreCase(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String action = request.getParameter("action");
        if (action == null) action = "list";

        try {
            switch (action) {
                case "new":
                    showNewForm(request, response);
                    break;
                case "insert":
                    insertItem(request, response, user.getId());
                    break;
                case "delete":
                    deleteItem(request, response, user.getId());
                    break;
                case "edit":
                    showEditForm(request, response);
                    break;
                case "update":
                    updateItem(request, response, user.getId());
                    break;
                case "search":
                    searchItems(request, response);
                    break;
                default:
                    listItems(request, response);
                    break;
            }
        } catch (SQLException ex) {
            throw new ServletException(ex);
        }
    }

    private void listItems(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        List<Item> listItems = itemDAO.selectAllItems();
        request.setAttribute("listItems", listItems);
        request.getRequestDispatcher("/Staff/manage-items.jsp").forward(request, response);
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/Staff/item-form.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Item existingItem = itemDAO.selectItem(id);
        request.setAttribute("item", existingItem);
        request.getRequestDispatcher("/Staff/item-form.jsp").forward(request, response);
    }

    private void insertItem(HttpServletRequest request, HttpServletResponse response, int userId) throws SQLException, IOException {
        String itemName = request.getParameter("itemName");
        String category = request.getParameter("category");
        String description = request.getParameter("description");
        double price = Double.parseDouble(request.getParameter("price"));
        int stock = Integer.parseInt(request.getParameter("stock"));

        Item newItem = new Item();
        newItem.setItemName(itemName);
        newItem.setCategory(category);
        newItem.setDescription(description);
        newItem.setPrice(price);
        newItem.setStockQuantity(stock);

        itemDAO.insertItem(newItem);

        // Audit log
        AuditLogDAO logDAO = new AuditLogDAO();
        logDAO.logAction(userId, "Add Item", "Staff added new item: " + itemName + ", Category: " + category);

        response.sendRedirect(request.getContextPath() + "/Staff/manage-items");
    }

    private void updateItem(HttpServletRequest request, HttpServletResponse response, int userId) throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String itemName = request.getParameter("itemName");
        String category = request.getParameter("category");
        String description = request.getParameter("description");
        double price = Double.parseDouble(request.getParameter("price"));
        int stock = Integer.parseInt(request.getParameter("stock"));

        Item item = new Item(id, itemName, category, description, price, stock);
        itemDAO.updateItem(item);

        // Audit log
        AuditLogDAO logDAO = new AuditLogDAO();
        logDAO.logAction(userId, "Update Item", "Staff updated item ID: " + id);

        response.sendRedirect(request.getContextPath() + "/Staff/manage-items");
    }

    private void deleteItem(HttpServletRequest request, HttpServletResponse response, int userId) throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        itemDAO.deleteItem(id);

        // Audit log
        AuditLogDAO logDAO = new AuditLogDAO();
        logDAO.logAction(userId, "Delete Item", "Staff deleted item ID: " + id);

        response.sendRedirect(request.getContextPath() + "/Staff/manage-items");
    }

    private void searchItems(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        String itemName = request.getParameter("itemName");
        String category = request.getParameter("category");
        String minPrice = request.getParameter("minPrice");
        String maxPrice = request.getParameter("maxPrice");

        List<Item> listItems = itemDAO.searchItems(itemName, category, minPrice, maxPrice);
        request.setAttribute("listItems", listItems);
        request.getRequestDispatcher("/Staff/manage-items.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
