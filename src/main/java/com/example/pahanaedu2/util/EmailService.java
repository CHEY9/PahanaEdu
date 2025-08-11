package com.example.pahanaedu2.util;

import java.io.*;
import java.util.Base64;
import javax.net.ssl.SSLSocket;
import javax.net.ssl.SSLSocketFactory;

public class EmailService {

    private static final String USERNAME = "pahanaedu2@gmail.com";
    private static final String PASSWORD = "pjhk kogv zaoh porv"; // App Password
    private static final String SMTP_SERVER = "smtp.gmail.com";
    private static final int SMTP_PORT = 465; //

    private static void sendEmail(String to, String subject, String body) throws IOException {
        // Create SSL connection
        SSLSocket socket = (SSLSocket) SSLSocketFactory.getDefault()
                .createSocket(SMTP_SERVER, SMTP_PORT);

        BufferedReader reader = new BufferedReader(new InputStreamReader(socket.getInputStream()));
        BufferedWriter writer = new BufferedWriter(new OutputStreamWriter(socket.getOutputStream()));

        System.out.println("S: " + reader.readLine());

        sendCommand(writer, "EHLO localhost");
        readMultilineResponse(reader);

        // AUTH LOGIN
        sendCommand(writer, "AUTH LOGIN");
        System.out.println("S: " + reader.readLine());

        sendCommand(writer, Base64.getEncoder().encodeToString(USERNAME.getBytes()));
        System.out.println("S: " + reader.readLine());

        sendCommand(writer, Base64.getEncoder().encodeToString(PASSWORD.getBytes()));
        System.out.println("S: " + reader.readLine());

        sendCommand(writer, "MAIL FROM:<" + USERNAME + ">");
        System.out.println("S: " + reader.readLine());

        sendCommand(writer, "RCPT TO:<" + to + ">");
        System.out.println("S: " + reader.readLine());

        sendCommand(writer, "DATA");
        System.out.println("S: " + reader.readLine());

        writer.write("Subject: " + subject + "\r\n");
        writer.write("From: " + USERNAME + "\r\n");
        writer.write("To: " + to + "\r\n");
        writer.write("\r\n");
        writer.write(body + "\r\n");
        writer.write(".\r\n");
        writer.flush();

        System.out.println("S: " + reader.readLine());

        sendCommand(writer, "QUIT");
        System.out.println("S: " + reader.readLine());

        writer.close();
        reader.close();
        socket.close();
    }

    private static void sendCommand(BufferedWriter writer, String cmd) throws IOException {
        System.out.println("C: " + cmd);
        writer.write(cmd + "\r\n");
        writer.flush();
    }

    private static void readMultilineResponse(BufferedReader reader) throws IOException {
        String line;
        while ((line = reader.readLine()) != null) {
            System.out.println("S: " + line);
            if (line.length() < 4) break;
            if (line.charAt(3) != '-') break;
        }
    }

    public static void sendLowStockAlert(String itemName, int stockQty, String timeStamp) {
        String to = "Pasansandeepa72726@gmail.com";
        String subject = "🔔 Low Stock Alert: " + itemName;
        String body = String.format("""
            Dear Admin,

            This is an automated alert from the PahanaEdu inventory system.

            ⚠️  The following item is running low on stock:

            ▸ Item Name: %s
            ▸ Remaining Quantity: %d

            Please restock this item as soon as possible to avoid any disruption.

            ⏰ Alert generated at: %s

            Regards,
            PahanaEdu System
            """, itemName, stockQty, timeStamp);
        try {
            sendEmail(to, subject, body);
            System.out.println("Low stock alert sent.");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static void sendOtpEmail(String toEmail, String otp) {
        String subject = "Your PahanaEdu Password Reset OTP";
        String body = String.format("""
            Dear User,

            Your One-Time Password (OTP) for password reset is:

            %s

            This OTP is valid for 5 minutes.

            If you did not request this, please ignore this email.

            Regards,
            PahanaEdu System
            """, otp);
        try {
            sendEmail(toEmail, subject, body);
            System.out.println("OTP email sent.");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
