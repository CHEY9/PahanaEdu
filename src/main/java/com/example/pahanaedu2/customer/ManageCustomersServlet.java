package com.example.pahanaedu2.customer;

import com.example.pahanaedu2.db.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/Admin/manage-customers")
public class ManageCustomersServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String searchName = request.getParameter("searchName");
        String searchPhone = request.getParameter("searchPhone");

        List<Customer> customers;

        if ((searchName != null && !searchName.trim().isEmpty()) || (searchPhone != null && !searchPhone.trim().isEmpty())) {
            customers = searchCustomers(searchName, searchPhone);
        } else {
            customers = getAllCustomers();
        }

        request.setAttribute("customerList", customers);
        request.getRequestDispatcher("/Admin/manage-customers.jsp").forward(request, response);
    }

    private List<Customer> getAllCustomers() {
        List<Customer> list = new ArrayList<>();
        String sql = "SELECT * FROM Customers";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Customer c = new Customer();
                c.setId(rs.getInt("id"));
                c.setName(rs.getString("name"));
                c.setEmail(rs.getString("email"));
                c.setPhone(rs.getString("phone"));
                c.setAddress(rs.getString("address"));
                list.add(c);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    private List<Customer> searchCustomers(String name, String phone) {
        List<Customer> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM Customers WHERE 1=1");
        List<String> conditions = new ArrayList<>();
        List<Object> parameters = new ArrayList<>();

        if (name != null && !name.trim().isEmpty()) {
            sql.append(" AND name LIKE ?");
            parameters.add("%" + name + "%");
        }

        if (phone != null && !phone.trim().isEmpty()) {
            sql.append(" AND phone LIKE ?");
            parameters.add("%" + phone + "%");
        }

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql.toString())) {

            for (int i = 0; i < parameters.size(); i++) {
                stmt.setObject(i + 1, parameters.get(i));
            }

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Customer c = new Customer();
                c.setId(rs.getInt("id"));
                c.setName(rs.getString("name"));
                c.setEmail(rs.getString("email"));
                c.setPhone(rs.getString("phone"));
                c.setAddress(rs.getString("address"));
                list.add(c);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }
}
