package com.example.pahanaedu2.customer;

import java.util.HashMap;
import java.util.Map;
import java.util.Scanner;

public class CustomerRegistration {


    private Map<String, Customer> customerMap = new HashMap<>();
    private int nextId = 1;

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

        int id = nextId++;

        Customer newCustomer = new Customer(id, name, email, phone, address);

        customerMap.put(username, newCustomer);

        System.out.println("Registration successful!");
        return true;
    }

    public Map<String, Customer> getCustomerMap() {
        return customerMap;
    }
}
