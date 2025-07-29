package com.example.pahanaedu2;

import com.example.pahanaedu2.bill.Bill;
import com.example.pahanaedu2.bill.BillDAOImpl;
import org.junit.jupiter.api.*;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

class BillDAOImplTest {

    private BillDAOImpl billDAO;

    @BeforeEach
    void setup() {
        billDAO = new BillDAOImpl();
    }

    @Test
    void testGetAllBills() {
        List<Bill> bills = billDAO.getAllBills();
        assertNotNull(bills);

        if (!bills.isEmpty()) {
            Bill first = bills.get(0);
            assertTrue(first.getBillId() > 0);
            assertTrue(first.getItemId() > 0);
            assertNotNull(first.getItemName());
            assertTrue(first.getQuantity() > 0);
        }
    }

    @Test
    void testGetBillById() {
        int existingBillId = 1;
        Bill bill = billDAO.getBillById(existingBillId);
        assertNotNull(bill, "Bill with ID " + existingBillId + " should exist.");
        assertEquals(existingBillId, bill.getBillId());
    }
}
