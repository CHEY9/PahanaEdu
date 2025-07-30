package com.example.pahanaedu2;

import com.example.pahanaedu2.auth.User;
import com.example.pahanaedu2.db.DBConnection;
import org.junit.jupiter.api.*;

import java.sql.*;

import static org.junit.jupiter.api.Assertions.*;

class UserDAOImplTest {

    private User testUser;

    @BeforeEach
    void setUp() {
        testUser = new User("testuser", "testpass", "test@example.com", "0123456789", "Admin");
    }

        @Test
    void testRegisterUser() {
        boolean registered = new UserDAOImpl().registerUser(testUser);
        assertTrue(registered);
    }

    @Test
    void testUserExists() {
        new UserDAOImpl().registerUser(testUser);
        boolean exists = new UserDAOImpl().isUserExists("testuser", "test@example.com");
        assertTrue(exists);
    }

    @Test
    void testAddUser() {
        boolean added = new UserDAOImpl().registerUser(testUser);
        assertTrue(added);
    }

    @Test
    void testGetAllUsers() {
        new UserDAOImpl().registerUser(testUser);
        assertNotNull(new UserDAOImpl().getAllUsers());
    }

    @Test
    void testUpdateUser() {
        UserDAOImpl dao = new UserDAOImpl();
        dao.registerUser(testUser);

        testUser.setEmail("updated@example.com");
        boolean updated = dao.updateUser(testUser);
        assertTrue(updated);
    }

    @Test
    void testDeleteUser() {
        UserDAOImpl dao = new UserDAOImpl();
        dao.registerUser(testUser);

        boolean deleted = dao.deleteUser(testUser.getUsername());
        assertTrue(deleted);
    }

    @Test
    void testGetUserById() {
        UserDAOImpl dao = new UserDAOImpl();
        dao.registerUser(testUser);

        User user = dao.getUserByUsername("testuser");
        assertNotNull(user);

        User fetchedById = dao.getUserById(user.getId());
        assertNotNull(fetchedById);
        assertEquals("testuser", fetchedById.getUsername());
    }

    @Test
    void testGetUserByEmail() {
        UserDAOImpl dao = new UserDAOImpl();
        dao.registerUser(testUser);

        User user = dao.getUserByEmail("test@example.com");
        assertNotNull(user);
        assertEquals("testuser", user.getUsername());
    }

    @Test
    void testGetUserByUsername() {
        UserDAOImpl dao = new UserDAOImpl();
        dao.registerUser(testUser);

        User user = dao.getUserByUsername("testuser");
        assertNotNull(user);
        assertEquals("test@example.com", user.getEmail());
    }

    @Test
    void testGetUserByPhone() {
        UserDAOImpl dao = new UserDAOImpl();
        dao.registerUser(testUser);

        User user = dao.getUserByPhone("0123456789");
        assertNotNull(user);
        assertEquals("testuser", user.getUsername());
    }


    @AfterEach
    void tearDown() {
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "DELETE FROM Users WHERE username = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, "testuser");
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
