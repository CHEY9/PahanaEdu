package com.example.pahanaedu2.staff;

import com.example.pahanaedu2.auth.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.File;
import java.io.IOException;

@WebServlet("/staff/update-profile")
@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 2 * 1024 * 1024)
public class UpdateProfileServlet extends HttpServlet {

    private static final String UPLOAD_DIR = "uploads/profile-pictures";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null || !"staff".equalsIgnoreCase(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String newPassword = request.getParameter("newPassword");

        if (newPassword != null && !newPassword.trim().isEmpty()) {
            System.out.println("Updating password to: " + newPassword);
        }

        Part filePart = request.getPart("profilePicture");
        if (filePart != null && filePart.getSize() > 0) {
            String fileName = user.getUsername() + "_staff_profile.jpg";
            String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;

            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdirs();

            filePart.write(uploadPath + File.separator + fileName);

            System.out.println("Profile picture saved: " + uploadPath + File.separator + fileName);
        }

        response.sendRedirect(request.getContextPath() + "/Staff/dashboard.jsp");
    }
}
