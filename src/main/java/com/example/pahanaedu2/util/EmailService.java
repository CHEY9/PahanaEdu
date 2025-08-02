package com.example.pahanaedu2.util;

import jakarta.mail.*;
import jakarta.mail.internet.*;

import java.util.Properties;

public class EmailService {

    private static final String USERNAME = "pahanaedu2@gmail.com"; //  Gmail
    private static final String PASSWORD = "pjhk kogv zaoh porv";   // App password

    public static void sendLowStockAlert(String itemName, int stockQty, String timeStamp) {
        String to = "Pasansandeepa72726@gmail.com"; // receiving email
        String subject = "🔔 Low Stock Alert: " + itemName;

        String body = """
        Dear Inventory Manager,

        This is an automated alert from the PahanaEdu inventory system.

        ⚠️  The following item is running low on stock:

        ▸ Item Name: %s
        ▸ Remaining Quantity: %d

        Please restock this item as soon as possible to avoid any disruption.

        ⏰ Alert generated at: %s

        Regards,
        PahanaEdu System
        """.formatted(itemName, stockQty, timeStamp);

        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(USERNAME, PASSWORD);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(USERNAME, "PahanaEdu System"));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
            message.setSubject(subject);
            message.setText(body);

            Transport.send(message);
            System.out.println("📧 Low stock alert sent for " + itemName);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void sendOtpEmail(String toEmail, String otp) {
        String subject = "Your PahanaEdu Password Reset OTP";
        String body = """
            Dear User,

            Your One-Time Password (OTP) for password reset is:

            %s

            This OTP is valid for 5 minutes.

            If you did not request this, please ignore this email.

            Regards,
            PahanaEdu System
            """.formatted(otp);

        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(USERNAME, PASSWORD);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(USERNAME, "PahanaEdu System"));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject(subject);
            message.setText(body);

            Transport.send(message);
            System.out.println("OTP email sent to " + toEmail);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
