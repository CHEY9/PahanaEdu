package com.example.pahanaedu2.bill;

import java.time.LocalDateTime;

public class Bill {
    private int billId;
    private int Id;
    private int itemId;
    private String itemName;
    private int quantity;
    private double unitPrice;
    private double totalPrice;
    private LocalDateTime billDateTime;

    // Constructors
    public Bill() {}

    public Bill(int billId, int Id, int itemId, int quantity, double unitPrice, double totalPrice, LocalDateTime billDateTime) {
        this.billId = billId;
        this.Id = Id;
        this.itemId = itemId;
        this.quantity = quantity;
        this.unitPrice = unitPrice;
        this.totalPrice = totalPrice;
        this.billDateTime = billDateTime;
    }

    // Getters and Setters
    public int getBillId() {
        return billId;
    }

    public void setBillId(int billId) {
        this.billId = billId;
    }

    public int getId() {
        return Id;
    }

    public void setId(int Id) {
        this.Id = Id;
    }

    public int getitemId() {
        return itemId;
    }

    public void setItemId(int itemId) {
        this.itemId = itemId;
    }

    public String getItemName() {return itemName;}

    public void setItemName(String itemName) {this.itemName = itemName;}

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public double getUnitPrice() {
        return unitPrice;
    }

    public void setUnitPrice(double unitPrice) {
        this.unitPrice = unitPrice;
    }

    public double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }

    public LocalDateTime getBillDateTime() {
        return billDateTime;
    }

    public void setBillDateTime(LocalDateTime billDateTime) {
        this.billDateTime = billDateTime;
    }
}
