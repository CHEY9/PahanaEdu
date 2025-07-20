package com.example.pahanaedu2.reports;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.*;

@WebServlet("/Admin/reports/daily-monthly-reports")
public class DailyMonthlyReportServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            System.out.println("🚀 DailyMonthlyReportServlet has been triggered!");


            List<Map<String, Object>> dailySales = new ArrayList<>();
        List<Map<String, Object>> monthlySales = new ArrayList<>();

        String sqlDaily = "SELECT CONVERT(date, b.bill_date_time) AS BillDate, " +
                "SUM(bi.total_price) AS TotalSales " +
                "FROM bill_items bi JOIN bills b ON bi.bill_id = b.bill_id " +
                "GROUP BY CONVERT(date, b.bill_date_time) ORDER BY BillDate";

        String sqlMonthly = "SELECT FORMAT(b.bill_date_time, 'yyyy-MM') AS Month, " +
                "SUM(bi.total_price) AS TotalSales " +
                "FROM bill_items bi JOIN bills b ON bi.bill_id = b.bill_id " +
                "GROUP BY FORMAT(b.bill_date_time, 'yyyy-MM') ORDER BY Month";

        try (Connection conn = DriverManager.getConnection(
                "jdbc:sqlserver://localhost:1433;databaseName=PahanaEdu;encrypt=true;trustServerCertificate=true",
                "sa", "12345")) {

            // Daily Sales
            try (PreparedStatement dailyStmt = conn.prepareStatement(sqlDaily);
                 ResultSet rsDaily = dailyStmt.executeQuery()) {

                while (rsDaily.next()) {
                    Map<String, Object> row = new HashMap<>();
                    row.put("date", rsDaily.getString("BillDate"));
                    row.put("sales", rsDaily.getDouble("TotalSales"));
                    dailySales.add(row);
                }
            }

            // Monthly Sales
            try (PreparedStatement monthStmt = conn.prepareStatement(sqlMonthly);
                 ResultSet rsMonth = monthStmt.executeQuery()) {

                while (rsMonth.next()) {
                    Map<String, Object> row = new HashMap<>();
                    row.put("month", rsMonth.getString("Month"));
                    row.put("sales", rsMonth.getDouble("TotalSales"));
                    monthlySales.add(row);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        request.setAttribute("dailySales", dailySales);
        request.setAttribute("monthlySales", monthlySales);

        System.out.println("Daily Sales Count: " + dailySales.size());
        System.out.println("Monthly Sales Count: " + monthlySales.size());

        request.getRequestDispatcher("/Admin/reports/daily-monthly.jsp").forward(request, response);
    }
}
