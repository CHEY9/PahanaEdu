package com.example.pahanaedu2.item;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ItemDAO {
    private String jdbcURL = "jdbc:sqlserver://localhost:1433;databaseName=PahanaEdu;encrypt=true;trustServerCertificate=true";
    private String jdbcUsername = "sa";
    private String jdbcPassword = "12345";

    private static final String INSERT_ITEM_SQL = "INSERT INTO Items (ItemName, category, description, price, stockQuantity) VALUES (?, ?, ?, ?, ?)";
    private static final String SELECT_ITEM_BY_ID = "SELECT * FROM Items WHERE itemId = ?";
    private static final String SELECT_ALL_ITEMS = "SELECT * FROM Items";
    private static final String DELETE_ITEM_SQL = "DELETE FROM Items WHERE itemId = ?";
    private static final String UPDATE_ITEM_SQL = "UPDATE Items SET ItemName = ?, category = ?, description = ?, price = ?, stockQuantity = ? WHERE itemId = ?";
    private static final String SEARCH_ITEMS_SQL = "SELECT * FROM Items WHERE ItemName LIKE ? OR category LIKE ?";

    protected Connection getConnection() throws SQLException {
        return DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
    }

    // Insert new item
    public void insertItem(Item item) throws SQLException {
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(INSERT_ITEM_SQL)) {
            preparedStatement.setString(1, item.getItemName());
            preparedStatement.setString(2, item.getCategory());
            preparedStatement.setString(3, item.getDescription());
            preparedStatement.setDouble(4, item.getPrice());
            preparedStatement.setInt(5, item.getStockQuantity());
            preparedStatement.executeUpdate();
        }
    }

    // Select item by ID
    public Item selectItem(int itemId) throws SQLException {
        Item item = null;
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ITEM_BY_ID)) {
            preparedStatement.setInt(1, itemId);
            ResultSet rs = preparedStatement.executeQuery();
            if (rs.next()) {
                item = new Item(
                        rs.getInt("itemId"),
                        rs.getString("ItemName"),
                        rs.getString("category"),
                        rs.getString("description"),
                        rs.getDouble("price"),
                        rs.getInt("stockQuantity")
                );
            }
        }
        return item;
    }

    // Select all items
    public List<Item> selectAllItems() throws SQLException {
        List<Item> items = new ArrayList<>();
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL_ITEMS)) {
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                Item item = new Item(
                        rs.getInt("itemId"),
                        rs.getString("ItemName"),
                        rs.getString("category"),
                        rs.getString("description"),
                        rs.getDouble("price"),
                        rs.getInt("stockQuantity")
                );
                items.add(item);
            }
        }
        return items;
    }
    public List<Item> getLowStockItems(int threshold) {
        List<Item> lowStockItems = new ArrayList<>();
        String sql = "SELECT * FROM Items WHERE stockQuantity < ?";

        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            preparedStatement.setInt(1, threshold);
            ResultSet rs = preparedStatement.executeQuery();

            System.out.println("Fetching low stock items from DB...");
            while (rs.next()) {
                int stockQty = rs.getInt("stockQuantity");
                String itemName = rs.getString("ItemName");

                System.out.println("Found: " + itemName + " (Stock: " + stockQty + ")");

                Item item = new Item(
                        rs.getInt("itemId"),
                        itemName,
                        rs.getString("category"),
                        rs.getString("description"),
                        rs.getDouble("price"),
                        stockQty
                );
                lowStockItems.add(item);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return lowStockItems;
    }

    // Update item
    public boolean updateItem(Item item) throws SQLException {
        boolean rowUpdated;
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_ITEM_SQL)) {
            preparedStatement.setString(1, item.getItemName());
            preparedStatement.setString(2, item.getCategory());
            preparedStatement.setString(3, item.getDescription());
            preparedStatement.setDouble(4, item.getPrice());
            preparedStatement.setInt(5, item.getStockQuantity());
            preparedStatement.setInt(6, item.getItemId());

            rowUpdated = preparedStatement.executeUpdate() > 0;
        }
        return rowUpdated;
    }

    // Delete item
    public boolean deleteItem(int itemId) throws SQLException {
        boolean rowDeleted;
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(DELETE_ITEM_SQL)) {
            preparedStatement.setInt(1, itemId);
            rowDeleted = preparedStatement.executeUpdate() > 0;
        }
        return rowDeleted;
    }

    // Search items by name or category
    public List<Item> searchItems(String keyword) throws SQLException {
        List<Item> items = new ArrayList<>();
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SEARCH_ITEMS_SQL)) {
            String searchTerm = "%" + keyword + "%";
            preparedStatement.setString(1, searchTerm);
            preparedStatement.setString(2, searchTerm);
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                Item item = new Item(
                        rs.getInt("itemId"),
                        rs.getString("ItemName"),
                        rs.getString("category"),
                        rs.getString("description"),
                        rs.getDouble("price"),
                        rs.getInt("stockQuantity")
                );
                items.add(item);
            }
        }
        return items;
    }
    public List<Item> searchItems(String ItemName, String category, String minPriceStr, String maxPriceStr) {
        List<Item> items = new ArrayList<>();

        String sql = "SELECT * FROM Items WHERE 1=1";
        List<Object> params = new ArrayList<>();

        if (ItemName != null && !ItemName.trim().isEmpty()) {
            sql += " AND ItemName LIKE ?";
            params.add("%" + ItemName + "%");
        }

        if (category != null && !category.trim().isEmpty()) {
            sql += " AND category LIKE ?";
            params.add("%" + category + "%");
        }

        if (minPriceStr != null && !minPriceStr.trim().isEmpty()) {
            sql += " AND price >= ?";
            params.add(Double.parseDouble(minPriceStr));
        }

        if (maxPriceStr != null && !maxPriceStr.trim().isEmpty()) {
            sql += " AND price <= ?";
            params.add(Double.parseDouble(maxPriceStr));
        }

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            for (int i = 0; i < params.size(); i++) {
                stmt.setObject(i + 1, params.get(i));
            }

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Item item = new Item();
                item.setItemId(rs.getInt("itemid"));
                item.setItemName(rs.getString("ItemName"));
                item.setCategory(rs.getString("category"));
                item.setDescription(rs.getString("description"));
                item.setPrice(rs.getDouble("price"));
                item.setStockQuantity(rs.getInt("stockQuantity"));
                items.add(item);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return items;
    }
}
