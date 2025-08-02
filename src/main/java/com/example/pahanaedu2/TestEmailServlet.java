package com.example.pahanaedu2;

import com.example.pahanaedu2.util.EmailService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@WebServlet("/test-send-email")
public class TestEmailServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String itemName = "Test Item";
        int stockQty = 3;

        // Generate current timestamp
        String timeStamp = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));

        // Call improved send method with extra info
        EmailService.sendLowStockAlert(itemName, stockQty, timeStamp);

        resp.getWriter().println("📧 Test low stock email sent. Check your inbox.");
    }
}
