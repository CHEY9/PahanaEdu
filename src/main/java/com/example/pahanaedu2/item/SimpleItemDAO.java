package com.example.pahanaedu2.item;

import java.sql.SQLException;
import java.util.List;

public interface SimpleItemDAO {
    void insertItem(Item item) throws SQLException;
    Item selectItem(int itemId) throws SQLException;
    List<Item> selectAllItems() throws SQLException;
    boolean updateItem(Item item) throws SQLException;
    boolean deleteItem(int itemId) throws SQLException;
    List<Item> searchItems(String keyword) throws SQLException;
}
