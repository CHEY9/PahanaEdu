package com.example.pahanaedu2.item;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ItemDAOImpl {
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

    public Item selectItem(int itemId) throws SQLException {
        Item item = null;
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ITEM_BY_ID)) {
            preparedStatement.setInt(1, itemId);
            ResultSet rs = preparedStatement.executeQuery();
            if (rs.next()) {
                item = mapResultSetToItem(rs);
            }
        }
        return item;
    }

    public List<Item> selectAllItems() throws SQLException {
        List<Item> items = new ArrayList<>();
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL_ITEMS)) {
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                items.add(mapResultSetToItem(rs));
            }
        }
        return items;
    }

    public boolean updateItem(Item item) throws SQLException {
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_ITEM_SQL)) {
            preparedStatement.setString(1, item.getItemName());
            preparedStatement.setString(2, item.getCategory());
            preparedStatement.setString(3, item.getDescription());
            preparedStatement.setDouble(4, item.getPrice());
            preparedStatement.setInt(5, item.getStockQuantity());
            preparedStatement.setInt(6, item.getItemId());
            return preparedStatement.executeUpdate() > 0;
        }
    }

    public boolean deleteItem(int itemId) throws SQLException {
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(DELETE_ITEM_SQL)) {
            preparedStatement.setInt(1, itemId);
            return preparedStatement.executeUpdate() > 0;
        }
    }

    public List<Item> getItemsByCategory(String category) throws SQLException {
        List<Item> items = new ArrayList<>();
        String sql = "SELECT * FROM Items WHERE category = ?";
        try (Connection connection = getConnection();
             PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, category);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                items.add(mapResultSetToItem(rs));
            }
        }
        return items;
    }

    public List<Item> getItemsByName(String name) throws SQLException {
        List<Item> items = new ArrayList<>();
        String sql = "SELECT * FROM Items WHERE ItemName LIKE ?";
        try (Connection connection = getConnection();
             PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, "%" + name + "%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                items.add(mapResultSetToItem(rs));
            }
        }
        return items;
    }

    public List<Item> getItemsByMinPrice(double minPrice) throws SQLException {
        List<Item> items = new ArrayList<>();
        String sql = "SELECT * FROM Items WHERE price >= ?";
        try (Connection connection = getConnection();
             PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setDouble(1, minPrice);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                items.add(mapResultSetToItem(rs));
            }
        }
        return items;
    }

    public List<Item> getItemsByMaxPrice(double maxPrice) throws SQLException {
        List<Item> items = new ArrayList<>();
        String sql = "SELECT * FROM Items WHERE price <= ?";
        try (Connection connection = getConnection();
             PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setDouble(1, maxPrice);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                items.add(mapResultSetToItem(rs));
            }
        }
        return items;
    }

    public List<Item> getItemsByStockLessThan(int quantity) throws SQLException {
        List<Item> items = new ArrayList<>();
        String sql = "SELECT * FROM Items WHERE stockQuantity < ?";
        try (Connection connection = getConnection();
             PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, quantity);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                items.add(mapResultSetToItem(rs));
            }
        }
        return items;
    }

    public List<Item> getItemsByPriceRange(double min, double max) throws SQLException {
        List<Item> items = new ArrayList<>();
        String sql = "SELECT * FROM Items WHERE price BETWEEN ? AND ?";
        try (Connection connection = getConnection();
             PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setDouble(1, min);
            ps.setDouble(2, max);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                items.add(mapResultSetToItem(rs));
            }
        }
        return items;
    }

    public List<Item> getItemsSortedByPrice(boolean ascending) throws SQLException {
        List<Item> items = new ArrayList<>();
        String sql = "SELECT * FROM Items ORDER BY price " + (ascending ? "ASC" : "DESC");
        try (Connection connection = getConnection();
             PreparedStatement ps = connection.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                items.add(mapResultSetToItem(rs));
            }
        }
        return items;
    }

    public List<Item> getItemsSortedByStock(boolean ascending) throws SQLException {
        List<Item> items = new ArrayList<>();
        String sql = "SELECT * FROM Items ORDER BY stockQuantity " + (ascending ? "ASC" : "DESC");
        try (Connection connection = getConnection();
             PreparedStatement ps = connection.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                items.add(mapResultSetToItem(rs));
            }
        }
        return items;
    }

    public List<Item> searchItems(String keyword) throws SQLException {
        List<Item> items = new ArrayList<>();
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SEARCH_ITEMS_SQL)) {
            String searchTerm = "%" + keyword + "%";
            preparedStatement.setString(1, searchTerm);
            preparedStatement.setString(2, searchTerm);
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                items.add(mapResultSetToItem(rs));
            }
        }
        return items;
    }

    private Item mapResultSetToItem(ResultSet rs) throws SQLException {
        return new Item(
                rs.getInt("itemId"),
                rs.getString("ItemName"),
                rs.getString("category"),
                rs.getString("description"),
                rs.getDouble("price"),
                rs.getInt("stockQuantity")
        );
    }
}
