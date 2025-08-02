package com.example.pahanaedu2.bill;

import com.example.pahanaedu2.db.DBConnection;

import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class BillDAOImpl {

    public List<Bill> getAllBills() {
        List<Bill> bills = new ArrayList<>();

        String sql = """
            SELECT 
                b.bill_id,
                b.id,
                bi.item_id,
                i.itemName,
                bi.quantity,
                bi.unit_price,
                bi.total_price,
                b.bill_date_time
            FROM bills b
            JOIN bill_items bi ON b.bill_id = bi.bill_id
            JOIN items i ON bi.item_id = i.itemId
            ORDER BY b.bill_id
        """;

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Bill bill = new Bill();
                bill.setBillId(rs.getInt("bill_id"));
                bill.setId(rs.getInt("id")); // customer id
                bill.setItemId(rs.getInt("item_id"));
                bill.setItemName(rs.getString("itemName"));
                bill.setQuantity(rs.getInt("quantity"));
                bill.setUnitPrice(rs.getDouble("unit_price"));
                bill.setTotalPrice(rs.getDouble("total_price"));
                Timestamp ts = rs.getTimestamp("bill_date_time");
                if (ts != null) {
                    bill.setBillDateTime(ts.toLocalDateTime());
                }
                bills.add(bill);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return bills;
    }

    public Bill getBillById(int billId) {
        String sql = """
            SELECT 
                b.bill_id,
                b.id,
                bi.item_id,
                i.itemName,
                bi.quantity,
                bi.unit_price,
                bi.total_price,
                b.bill_date_time
            FROM bills b
            JOIN bill_items bi ON b.bill_id = bi.bill_id
            JOIN items i ON bi.item_id = i.itemId
            WHERE b.bill_id = ?
        """;

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, billId);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Bill bill = new Bill();
                    bill.setBillId(rs.getInt("bill_id"));
                    bill.setId(rs.getInt("id")); // customer id
                    bill.setItemId(rs.getInt("item_id"));
                    bill.setItemName(rs.getString("itemName"));
                    bill.setQuantity(rs.getInt("quantity"));
                    bill.setUnitPrice(rs.getDouble("unit_price"));
                    bill.setTotalPrice(rs.getDouble("total_price"));
                    Timestamp ts = rs.getTimestamp("bill_date_time");
                    if (ts != null) {
                        bill.setBillDateTime(ts.toLocalDateTime());
                    }
                    return bill;
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    public List<Bill> getBillsByCustomerId(int customerId) {
        List<Bill> bills = new ArrayList<>();
        String sql = """
        SELECT 
            b.bill_id,
            b.id,
            bi.item_id,
            i.itemName,
            bi.quantity,
            bi.unit_price,
            bi.total_price,
            b.bill_date_time
        FROM bills b
        JOIN bill_items bi ON b.bill_id = bi.bill_id
        JOIN items i ON bi.item_id = i.itemId
        WHERE b.id = ?
        ORDER BY b.bill_id
    """;

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, customerId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Bill bill = new Bill();
                bill.setBillId(rs.getInt("bill_id"));
                bill.setId(rs.getInt("id"));
                bill.setItemId(rs.getInt("item_id"));
                bill.setItemName(rs.getString("itemName"));
                bill.setQuantity(rs.getInt("quantity"));
                bill.setUnitPrice(rs.getDouble("unit_price"));
                bill.setTotalPrice(rs.getDouble("total_price"));
                Timestamp ts = rs.getTimestamp("bill_date_time");
                if (ts != null) bill.setBillDateTime(ts.toLocalDateTime());

                bills.add(bill);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return bills;
    }

    public List<Bill> getBillsByDateRange(LocalDateTime from, LocalDateTime to) {
        List<Bill> bills = new ArrayList<>();
        String sql = """
        SELECT 
            b.bill_id,
            b.id,
            bi.item_id,
            i.itemName,
            bi.quantity,
            bi.unit_price,
            bi.total_price,
            b.bill_date_time
        FROM bills b
        JOIN bill_items bi ON b.bill_id = bi.bill_id
        JOIN items i ON bi.item_id = i.itemId
        WHERE b.bill_date_time BETWEEN ? AND ?
        ORDER BY b.bill_date_time
    """;

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setTimestamp(1, Timestamp.valueOf(from));
            stmt.setTimestamp(2, Timestamp.valueOf(to));
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Bill bill = new Bill();
                bill.setBillId(rs.getInt("bill_id"));
                bill.setId(rs.getInt("id"));
                bill.setItemId(rs.getInt("item_id"));
                bill.setItemName(rs.getString("itemName"));
                bill.setQuantity(rs.getInt("quantity"));
                bill.setUnitPrice(rs.getDouble("unit_price"));
                bill.setTotalPrice(rs.getDouble("total_price"));
                Timestamp ts = rs.getTimestamp("bill_date_time");
                if (ts != null) bill.setBillDateTime(ts.toLocalDateTime());

                bills.add(bill);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return bills;
    }

}
