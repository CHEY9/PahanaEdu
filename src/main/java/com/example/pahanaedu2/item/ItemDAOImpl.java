package com.example.pahanaedu2.item;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ItemDAOImpl implements SimpleItemDAO {
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

    @Override
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

    @Override
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

    @Override
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

    @Override
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

    @Override
    public boolean deleteItem(int itemId) throws SQLException {
        boolean rowDeleted;
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(DELETE_ITEM_SQL)) {
            preparedStatement.setInt(1, itemId);
            rowDeleted = preparedStatement.executeUpdate() > 0;
        }
        return rowDeleted;
    }

    @Override
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
}
