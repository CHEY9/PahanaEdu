package com.example.pahanaedu2.item;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.example.pahanaedu2.audit.AuditLogDAO;
import jakarta.servlet.http.HttpSession;


import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/Admin/manage-items")
public class ManageItemsServlet extends HttpServlet {
    private ItemDAO itemDAO;

    @Override
    public void init() {
        itemDAO = new ItemDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) action = "list";

        try {
            switch (action) {
                case "new":
                    showNewForm(request, response);
                    break;
                case "insert":
                    insertItem(request, response);
                    break;
                case "delete":
                    deleteItem(request, response);
                    break;
                case "edit":
                    showEditForm(request, response);
                    break;
                case "update":
                    updateItem(request, response);
                    break;
                case "search":
                    String ItemName = request.getParameter("itemName");
                    String category = request.getParameter("category");
                    String minPrice = request.getParameter("minPrice");
                    String maxPrice = request.getParameter("maxPrice");

                    List<Item> listItems = itemDAO.searchItems(ItemName, category, minPrice, maxPrice);
                    request.setAttribute("listItems", listItems);
                    request.getRequestDispatcher("/Admin/manage-items.jsp").forward(request, response);

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
        request.getRequestDispatcher("/Admin/manage-items.jsp").forward(request, response);
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/Admin/item-form.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Item existingItem = itemDAO.selectItem(id);
        request.setAttribute("item", existingItem);
        request.getRequestDispatcher("/Admin/item-form.jsp").forward(request, response);
    }

    private void insertItem(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        String ItemName = request.getParameter("ItemName");
        String category = request.getParameter("category");
        String description = request.getParameter("description");
        double price = Double.parseDouble(request.getParameter("price"));
        int stock = Integer.parseInt(request.getParameter("stock"));

        Item newItem = new Item();
        newItem.setItemName(ItemName);
        newItem.setCategory(category);
        newItem.setDescription(description);
        newItem.setPrice(price);
        newItem.setStockQuantity(stock);

        itemDAO.insertItem(newItem);
        response.sendRedirect(request.getContextPath() + "/Admin/manage-items");
        HttpSession session = request.getSession();
        int userId = (int) session.getAttribute("userId");  // set at login

        AuditLogDAO logDAO = new AuditLogDAO();
        logDAO.logAction(userId, "Add Item", "Added item: " + ItemName + ", Category: " + category);

    }

    private void updateItem(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String ItemName = request.getParameter("ItemName");
        String category = request.getParameter("category");
        String description = request.getParameter("description");
        double price = Double.parseDouble(request.getParameter("price"));
        int stock = Integer.parseInt(request.getParameter("stock"));

        Item item = new Item(id, ItemName, category, description, price, stock);
        itemDAO.updateItem(item);
        response.sendRedirect(request.getContextPath() + "/Admin/manage-items");
        HttpSession session = request.getSession();
        int userId = (int) session.getAttribute("userId");

        AuditLogDAO logDAO = new AuditLogDAO();
        logDAO.logAction(userId, "Update Item", "Updated item ID: " + id);

    }

    private void deleteItem(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        itemDAO.deleteItem(id);
        response.sendRedirect(request.getContextPath() + "/Admin/manage-items");
        HttpSession session = request.getSession();
        int userId = (int) session.getAttribute("userId"); // Get user ID from session (or however you store logged-in admin ID)
        AuditLogDAO logDAO = new AuditLogDAO();
        logDAO.logAction(userId, "Delete Item", "Deleted item with ID: " + id);

    }

    private void searchItems(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        String keyword = request.getParameter("keyword");
        List<Item> result = itemDAO.searchItems(keyword);
        request.setAttribute("listItems", result);
        request.getRequestDispatcher("/Admin/manage-items.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
