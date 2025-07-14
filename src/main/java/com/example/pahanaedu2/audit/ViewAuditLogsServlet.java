package com.example.pahanaedu2.audit;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/Admin/view-audit-logs")
public class ViewAuditLogsServlet extends HttpServlet {
    private AuditLogDAO auditLogDAO;

    public void init() {
        auditLogDAO = new AuditLogDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            List<AuditLog> logs = auditLogDAO.getAllLogs();
            request.setAttribute("logList", logs);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/Admin/view-audit-logs.jsp");
            dispatcher.forward(request, response);
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}
