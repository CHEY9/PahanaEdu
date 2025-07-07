package com.example.pahanaedu2.customer;

import java.util.HashMap;
import java.util.Map;
import java.util.Scanner;

public class CustomerRegistration {

    // Stores registered customers: username -> Customer object
    private Map<String, Customer> customerMap = new HashMap<>();

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

        Customer newCustomer = new Customer(username, password, name, address, phone);
        customerMap.put(username, newCustomer);

        System.out.println("Registration successful!");
        return true;
    }

    // This is for future login class to access registered customers
    public Map<String, Customer> getCustomerMap() {
        return customerMap;
    }
}