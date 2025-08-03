package com.example.pahanaedu2.bill;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.*;

@WebServlet("/staff/delete-bill")
public class DeleteBillServlet extends HttpServlet {

    private static final String DB_URL = "jdbc:sqlserver://localhost:1433;databaseName=PahanaEdu;encrypt=true;trustServerCertificate=true";
    private static final String DB_USER = "sa";
    private static final String DB_PASS = "12345";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String billIdStr = request.getParameter("billId");
        if (billIdStr == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing billId parameter");
            return;
        }

        int billId;
        try {
            billId = Integer.parseInt(billIdStr);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid billId parameter");
            return;
        }

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS)) {

            try (PreparedStatement psDeleteItems = conn.prepareStatement("DELETE FROM bill_items WHERE bill_Id = ?")) {
                psDeleteItems.setInt(1, billId);
                psDeleteItems.executeUpdate();
            }

            try (PreparedStatement psDeleteBill = conn.prepareStatement("DELETE FROM bills WHERE bill_id = ?")) {
                psDeleteBill.setInt(1, billId);
                int affectedRows = psDeleteBill.executeUpdate();
                if (affectedRows == 0) {
                    response.sendError(HttpServletResponse.SC_NOT_FOUND, "Bill not found with id " + billId);
                    return;
                }
            }

            // Redirect back to bill list page after deletion
            response.sendRedirect(request.getContextPath() + "/staff/manage-bills");

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error while deleting bill");
        }
    }
}
