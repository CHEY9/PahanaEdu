package com.example.pahanaedu2;

import com.example.pahanaedu2.auth.User;
import com.example.pahanaedu2.auth.AuthService;
import com.example.pahanaedu2.db.DBConnection;
import org.junit.jupiter.api.*;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import static org.junit.jupiter.api.Assertions.*;

class AuthServiceTest {

    private AuthService authService;
    private User testUser;

    @BeforeEach
    void init() {
        authService = new AuthService();
        testUser = new User("authuser", "authpass", "auth@example.com", "0987654321", "Admin");

        // Register the test user before running tests
        boolean registered = authService.registerUser(testUser);
        System.out.println("User registered: " + registered);
    }

    @Test
    void testValidLogin() {
        User result = authService.login("authuser", "authpass");
        assertNotNull(result, "Login should return a valid user");
    }

    @Test
    void testInvalidLogin() {
        User result = authService.login("authuser", "wrongpass");
        assertNull(result, "Login should return null for wrong password");
    }

    @AfterEach
    void cleanUp() {
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "DELETE FROM Users WHERE username = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, testUser.getUsername());
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
