package com.example.pahanaedu2.customer;

import java.util.HashMap;
import java.util.Map;
import java.util.Scanner;

public class CustomerRegistration {

    // Stores registered customers: username -> Customer object
    private Map<String, Customer> customerMap = new HashMap<>();
    private int nextId = 1;  // For auto-incrementing customer IDs

    public boolean registerCustomer(Scanner scanner) {
        System.out.print("Enter Username: ");
        String username = scanner.nextLine().trim();

        if (username.isEmpty()) {
            System.out.println("Username cannot be empty.");
            return false;
        }

        if (customerMap.containsKey(username)) {
            System.out.println("Username already exists.");
            return false;
        }

        // Optional: You can remove this password if it's not necessary for customers here
        System.out.print("Enter Password (min 6 characters): ");
        String password = scanner.nextLine().trim();
        if (password.length() < 6) {
            System.out.println("Password must be at least 6 characters.");
            return false;
        }

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

        // Assign auto-incremented id
        int id = nextId++;

        // Create new Customer object with collected info
        Customer newCustomer = new Customer(id, name, email, phone, address);

        // Store in map with username as key
        customerMap.put(username, newCustomer);

        System.out.println("Registration successful!");
        return true;
    }

    // For accessing registered customers map externally
    public Map<String, Customer> getCustomerMap() {
        return customerMap;
    }
}
