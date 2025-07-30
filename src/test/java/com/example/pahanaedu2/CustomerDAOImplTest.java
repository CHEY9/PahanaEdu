package com.example.pahanaedu2;

import com.example.pahanaedu2.customer.Customer;
import com.example.pahanaedu2.customer.CustomerDAOImpl;
import com.example.pahanaedu2.db.DBConnection;
import org.junit.jupiter.api.*;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

class CustomerDAOImplTest {

    private CustomerDAOImpl customerDAO;
    private Customer testCustomer;

    @BeforeEach
    void setUp() {
        customerDAO = new CustomerDAOImpl();
        testCustomer = new Customer(0, "JUnit User", "junit@example.com", "0771234567", "Colombo");
        customerDAO.addCustomer(testCustomer);
    }

    @Test
    void testGetCustomerById() {
        int id = getLastInsertedCustomerId();
        Customer result = customerDAO.getCustomerById(id);
        assertNotNull(result, "Customer should not be null");
        assertEquals("JUnit User", result.getName());
    }

    @Test
    void testDeleteCustomer() {
        int id = getLastInsertedCustomerId();
        boolean deleted = customerDAO.deleteCustomer(id);
        assertTrue(deleted, "Customer should be deleted successfully");
        assertNull(customerDAO.getCustomerById(id), "Deleted customer should return null");
    }

    @Test
    void testUpdateCustomer() {
        int id = getLastInsertedCustomerId();
        Customer customer = customerDAO.getCustomerById(id);
        assertNotNull(customer);

        customer.setName("Updated Name");
        customer.setEmail("updated@example.com");
        customer.setPhone("0711111111");
        customer.setAddress("Galle");

        boolean updated = customerDAO.updateCustomer(customer);
        assertTrue(updated);

        Customer updatedCustomer = customerDAO.getCustomerById(id);
        assertEquals("Updated Name", updatedCustomer.getName());
        assertEquals("updated@example.com", updatedCustomer.getEmail());
        assertEquals("0711111111", updatedCustomer.getPhone());
        assertEquals("Galle", updatedCustomer.getAddress());
    }

    @Test
    void testGetCustomerByEmail() {
        Customer result = customerDAO.getCustomerByEmail(testCustomer.getEmail());
        assertNotNull(result);
        assertEquals(testCustomer.getEmail(), result.getEmail());
    }

    @Test
    void testGetCustomerByPhone() {
        Customer result = customerDAO.getCustomerByPhone(testCustomer.getPhone());
        assertNotNull(result);
        assertEquals(testCustomer.getPhone(), result.getPhone());
    }

    @Test
    void testGetCustomersByName() {
        List<Customer> results = customerDAO.getCustomersByName("JUnit");
        assertFalse(results.isEmpty());
        boolean found = results.stream().anyMatch(c -> c.getName().equals("JUnit User"));
        assertTrue(found, "Customer name 'JUnit User' should be in the result list.");
    }


    @AfterEach
    void tearDown() {

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement("DELETE FROM Customers WHERE email = ?")) {
            stmt.setString(1, testCustomer.getEmail());
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private int getLastInsertedCustomerId() {
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement("SELECT TOP 1 id FROM Customers ORDER BY id DESC")) {
            var rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }
}
