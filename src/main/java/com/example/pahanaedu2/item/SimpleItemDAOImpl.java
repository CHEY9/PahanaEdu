package com.example.pahanaedu2.item;

import java.sql.SQLException;
import java.util.List;

public class SimpleItemDAOImpl implements SimpleItemDAO {

    private ItemDAO itemDAO = new ItemDAO();

    @Override
    public void insertItem(Item item) throws SQLException {
        itemDAO.insertItem(item);
    }

    @Override
    public Item selectItem(int itemId) throws SQLException {
        return itemDAO.selectItem(itemId);
    }

    @Override
    public List<Item> selectAllItems() throws SQLException {
        return itemDAO.selectAllItems();
    }

    @Override
    public boolean updateItem(Item item) throws SQLException {
        return itemDAO.updateItem(item);
    }

    @Override
    public boolean deleteItem(int itemId) throws SQLException {
        return itemDAO.deleteItem(itemId);
    }

    @Override
    public List<Item> searchItems(String keyword) throws SQLException {
        return itemDAO.searchItems(keyword);
    }
}
