package com.example.pahanaedu2.auth;

import com.example.pahanaedu2.db.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;

@WebServlet("/Admin/edit-user")
public class EditUserServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int userId = Integer.parseInt(request.getParameter("id"));

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement("SELECT * FROM Users WHERE id = ?")) {

            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setUsername(rs.getString("username"));
                user.setEmail(rs.getString("email"));
                user.setPhone(rs.getString("phone"));
                user.setRole(rs.getString("role"));

                request.setAttribute("user", user);
                request.getRequestDispatcher("/Admin/edit-user.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/Admin/manage-users");
            }

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/Admin/manage-users");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String username = request.getParameter("username").trim();
        String email = request.getParameter("email").trim();
        String phone = request.getParameter("phone").trim();
        String role = request.getParameter("role");

        String sql = "UPDATE Users SET username = ?, email = ?, phone = ?, role = ? WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, username);
            stmt.setString(2, email);
            stmt.setString(3, phone);
            stmt.setString(4, role);
            stmt.setInt(5, id);

            stmt.executeUpdate();
            response.sendRedirect(request.getContextPath() + "/Admin/manage-users");

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error updating user.");
            request.getRequestDispatcher("/Admin/edit-user.jsp").forward(request, response);
        }
    }
}
