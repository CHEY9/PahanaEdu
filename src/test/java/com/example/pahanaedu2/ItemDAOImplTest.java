package com.example.pahanaedu2;

import com.example.pahanaedu2.item.Item;
import com.example.pahanaedu2.item.ItemDAOImpl;
import org.junit.jupiter.api.*;

import java.sql.SQLException;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

class ItemDAOImplTest {

    private ItemDAOImpl itemDAO;
    private Item testItem;

    @BeforeEach
    void setUp() throws SQLException {
        itemDAO = new ItemDAOImpl();
        testItem = new Item(0, "JUnit Item", "Category A", "Test description", 50.0, 100);
        itemDAO.insertItem(testItem);
    }

    @Test
    void testInsertAndSelectItem() throws SQLException {
        List<Item> allItems = itemDAO.selectAllItems();
        assertFalse(allItems.isEmpty());

        Item lastItem = allItems.get(allItems.size() - 1);
        Item fetchedItem = itemDAO.selectItem(lastItem.getItemId());
        assertNotNull(fetchedItem);
        assertEquals("JUnit Item", fetchedItem.getItemName());
    }

    @Test
    void testUpdateItem() throws SQLException {
        List<Item> allItems = itemDAO.selectAllItems();
        Item lastItem = allItems.get(allItems.size() - 1);

        lastItem.setPrice(99.99);
        boolean updated = itemDAO.updateItem(lastItem);
        assertTrue(updated);

        Item updatedItem = itemDAO.selectItem(lastItem.getItemId());
        assertEquals(99.99, updatedItem.getPrice());
    }

    @Test
    void testDeleteItem() throws SQLException {
        List<Item> allItems = itemDAO.selectAllItems();
        Item lastItem = allItems.get(allItems.size() - 1);

        boolean deleted = itemDAO.deleteItem(lastItem.getItemId());
        assertTrue(deleted);

        Item deletedItem = itemDAO.selectItem(lastItem.getItemId());
        assertNull(deletedItem);
    }

    @AfterEach
    void tearDown() throws SQLException {
        List<Item> allItems = itemDAO.selectAllItems();
        for (Item item : allItems) {
            if (item.getItemName().startsWith("JUnit")) {
                itemDAO.deleteItem(item.getItemId());
            }
        }
    }
}
