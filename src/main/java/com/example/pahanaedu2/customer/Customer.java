package com.example.pahanaedu2.customer;
import java.util.HashMap;
import java.util.Map;
import java.util.Scanner;

public class Customer {
        // no-arg constructor
        private int id;
        private String name;
        private String email;
        private String phone;
        private String address;

        public Customer(int id, String name, String email, String phone, String address) {
            this.id = id;
            this.name = name;
            this.email = email;
            this.phone = phone;
            this.address = address;
        }
    // Stores registered customers: email -> Customer object
    private Map<String, Customer> customerMap = new HashMap<>();
    private int nextId = 1; // to simulate auto-incrementing ID

    public boolean registerCustomer(Scanner scanner) {
        System.out.print("Enter Name: ");
        String name = scanner.nextLine().trim();
        if (name.isEmpty()) {
            System.out.println("Name cannot be empty.");
            return false;
        }

        System.out.print("Enter Email: ");
        String email = scanner.nextLine().trim();
        if (email.isEmpty() || !email.matches("^[\\w.-]+@[\\w.-]+\\.\\w{2,}$")) {
            System.out.println("Invalid or empty email.");
            return false;
        }

        if (customerMap.containsKey(email)) {
            System.out.println("A customer with this email already exists.");
            return false;
        }

        System.out.print("Enter Address: ");
        String address = scanner.nextLine().trim();
        if (address.isEmpty()) {
            System.out.println("Address cannot be empty.");
            return false;
        }

        System.out.print("Enter Phone (10 digits): ");
        String phone = scanner.nextLine().trim();
        if (!phone.matches("\\d{10}")) {
            System.out.println("Invalid phone number. Must be 10 digits.");
            return false;
        }

        // Create and store new customer
        Customer newCustomer = new Customer(nextId++, name, email, phone, address);
        customerMap.put(email, newCustomer);

        System.out.println("Registration successful!");
        return true;
    }

    public Map<String, Customer> getCustomerMap() {
        return customerMap;
    }
}