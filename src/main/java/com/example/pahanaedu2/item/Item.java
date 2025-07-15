package com.example.pahanaedu2.item;

public class Item {
    private int itemId;
    private String ItemName;
    private String category;
    private String description;
    private double price;
    private int stockQuantity;

    // Constructors
    public Item() {}

    public Item(int itemId, String ItemName, String category, String description, double price, int stockQuantity) {
        this.itemId = itemId;
        this.ItemName = ItemName;
        this.category = category;
        this.description = description;
        this.price = price;
        this.stockQuantity = stockQuantity;
    }

    // Getters and Setters
    public int getItemId() {
        return itemId;
    }

    public void setItemId(int itemId) {
        this.itemId = itemId;
    }

    public String getItemName() {
        return ItemName;
    }

    public void setItemName(String ItemName) {
        this.ItemName = ItemName;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getStockQuantity() {
        return stockQuantity;
    }

    public void setStockQuantity(int stockQuantity) {
        this.stockQuantity = stockQuantity;
    }
}
