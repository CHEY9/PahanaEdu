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
        // Insert a test item
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
        lastItem.setStockQuantity(200);
        boolean updated = itemDAO.updateItem(lastItem);
        assertTrue(updated);

        Item updatedItem = itemDAO.selectItem(lastItem.getItemId());
        assertEquals(99.99, updatedItem.getPrice());
        assertEquals(200, updatedItem.getStockQuantity());
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

    @Test
    void testGetItemsByName() throws SQLException {
        List<Item> foundItems = itemDAO.getItemsByName("JUnit Item");
        assertNotNull(foundItems);
        assertFalse(foundItems.isEmpty());
        assertTrue(foundItems.stream().anyMatch(item -> "JUnit Item".equals(item.getItemName())));
    }

    @Test
    void testGetItemsByMinPrice() throws SQLException {
        List<Item> minPriceItems = itemDAO.getItemsByMinPrice(40.0);
        assertNotNull(minPriceItems);
        assertFalse(minPriceItems.isEmpty());
        for (Item item : minPriceItems) {
            assertTrue(item.getPrice() >= 40.0);
        }
    }

    @Test
    void testGetItemsByMaxPrice() throws SQLException {
        List<Item> maxPriceItems = itemDAO.getItemsByMaxPrice(60.0);
        assertNotNull(maxPriceItems);
        assertFalse(maxPriceItems.isEmpty());
        for (Item item : maxPriceItems) {
            assertTrue(item.getPrice() <= 60.0);
        }
    }

    @Test
    void testGetItemsByCategory() throws SQLException {
        List<Item> items = itemDAO.getItemsByCategory("Category A");
        assertNotNull(items);
        assertFalse(items.isEmpty());
        for (Item item : items) {
            assertEquals("Category A", item.getCategory());
        }
    }

    @Test
    void testGetItemsByStockLessThan() throws SQLException {
        List<Item> lowStockItems = itemDAO.getItemsByStockLessThan(150);
        assertNotNull(lowStockItems);
        assertFalse(lowStockItems.isEmpty());
        for (Item item : lowStockItems) {
            assertTrue(item.getStockQuantity() < 150);
        }
    }

    @Test
    void testGetItemsByPriceRange() throws SQLException {
        List<Item> rangeItems = itemDAO.getItemsByPriceRange(40.0, 60.0);
        assertNotNull(rangeItems);
        assertFalse(rangeItems.isEmpty());
        for (Item item : rangeItems) {
            assertTrue(item.getPrice() >= 40.0 && item.getPrice() <= 60.0);
        }
    }

    @Test
    void testGetItemsSortedByPrice() throws SQLException {
        List<Item> ascItems = itemDAO.getItemsSortedByPrice(true);
        List<Item> descItems = itemDAO.getItemsSortedByPrice(false);

        assertNotNull(ascItems);
        assertNotNull(descItems);
        assertFalse(ascItems.isEmpty());
        assertFalse(descItems.isEmpty());

        for (int i = 0; i < ascItems.size() - 1; i++) {
            assertTrue(ascItems.get(i).getPrice() <= ascItems.get(i + 1).getPrice());
        }

        for (int i = 0; i < descItems.size() - 1; i++) {
            assertTrue(descItems.get(i).getPrice() >= descItems.get(i + 1).getPrice());
        }
    }

    @Test
    void testGetItemsSortedByStock() throws SQLException {
        List<Item> ascItems = itemDAO.getItemsSortedByStock(true);
        List<Item> descItems = itemDAO.getItemsSortedByStock(false);

        assertNotNull(ascItems);
        assertNotNull(descItems);
        assertFalse(ascItems.isEmpty());
        assertFalse(descItems.isEmpty());

        for (int i = 0; i < ascItems.size() - 1; i++) {
            assertTrue(ascItems.get(i).getStockQuantity() <= ascItems.get(i + 1).getStockQuantity());
        }
        for (int i = 0; i < descItems.size() - 1; i++) {
            assertTrue(descItems.get(i).getStockQuantity() >= descItems.get(i + 1).getStockQuantity());
        }
    }

    @Test
    void testSearchItems() throws SQLException {
        List<Item> searchedItems = itemDAO.searchItems("JUnit");
        assertNotNull(searchedItems);
        assertFalse(searchedItems.isEmpty());
        assertTrue(searchedItems.stream().anyMatch(item -> item.getItemName().contains("JUnit") || item.getCategory().contains("JUnit")));
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
