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
