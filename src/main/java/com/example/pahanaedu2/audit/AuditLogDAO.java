package com.example.pahanaedu2.audit;

import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class AuditLogDAO {
    private String jdbcURL = "jdbc:sqlserver://localhost:1433;databaseName=PahanaEdu;encrypt=true;trustServerCertificate=true";
    private String jdbcUsername = "sa";
    private String jdbcPassword = "12345";

    private Connection getConnection() throws SQLException {
        return DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
    }

    public void logAction(int userId, String actionType, String action_details) throws SQLException {
        String sql = "INSERT INTO audit_logs (user_id, action_type, action_details) VALUES (?, ?, ?)";

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            stmt.setString(2, actionType);
            stmt.setString(3, action_details);
            stmt.executeUpdate();
        }
    }


    public List<AuditLog> getAllLogs() throws SQLException {
        List<AuditLog> logs = new ArrayList<>();

        String sql = """
        SELECT a.log_id, u.username, a.action_type, a.action_details, a.action_time
        FROM audit_logs a
        JOIN users u ON a.user_id = u.id
        ORDER BY a.action_time DESC
    """;

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                AuditLog log = new AuditLog();
                log.setLogId(rs.getInt("log_id"));
                log.setUsername(rs.getString("username"));  // changed
                log.setAction(rs.getString("action_type"));
                log.setDescription(rs.getString("action_details"));
                log.setTimestamp(rs.getTimestamp("action_time").toLocalDateTime());
                logs.add(log);
            }
        }

        return logs;
    }
}
