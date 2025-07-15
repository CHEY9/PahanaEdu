package com.example.pahanaedu2.bill;

import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class BillDAO {

    private String jdbcURL = "jdbc:sqlserver://localhost:1433;databaseName=PahanaEdu;encrypt=true;trustServerCertificate=true";
    private String jdbcUsername = "sa";
    private String jdbcPassword = "12345";

    private Connection getConnection() throws SQLException {
        return DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
    }

    public List<Bill> getAllBills() throws SQLException {
        List<Bill> bills = new ArrayList<>();

        String sql = """
            SELECT 
                b.bill_id,
                b.id, -- customer_id
                bi.item_id,
                bi.quantity,
                bi.unit_price,
                bi.total_price,
                b.bill_date_time
            FROM bills b
            JOIN bill_items bi ON b.bill_id = bi.bill_id
        """;

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Bill bill = new Bill();
                bill.setBillId(rs.getInt("bill_id"));
                bill.setId(rs.getInt("id")); // customer_id
                bill.setItemId(rs.getInt("item_id"));
                bill.setQuantity(rs.getInt("quantity"));
                bill.setUnitPrice(rs.getDouble("unit_price"));
                bill.setTotalPrice(rs.getDouble("total_price"));
                bill.setBillDateTime(rs.getTimestamp("bill_date_time").toLocalDateTime());

                bills.add(bill);
            }
        }

        return bills;
    }
}