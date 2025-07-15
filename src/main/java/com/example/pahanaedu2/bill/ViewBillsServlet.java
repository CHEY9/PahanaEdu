package com.example.pahanaedu2.bill;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/view-bills")
public class ViewBillsServlet extends HttpServlet {
    private BillDAO billDAO;

    public void init() {
        billDAO = new BillDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            List<Bill> billList = billDAO.getAllBills();
            request.setAttribute("billList", billList);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/Admin/view-bills.jsp");
            dispatcher.forward(request, response);
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}
