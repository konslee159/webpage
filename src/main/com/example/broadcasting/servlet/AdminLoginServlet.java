package com.example.broadcasting.servlet;

import com.example.broadcasting.entity.Admin;
import org.mindrot.jbcrypt.BCrypt;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet("/admin/login")
public class AdminLoginServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/broadcasting_club?useSSL=false&serverTimezone=UTC";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "12345"; // 실제 MySQL 비밀번호로 변경

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("AdminLoginServlet doPost 호출");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        Admin admin = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
                 PreparedStatement stmt = conn.prepareStatement("SELECT id, username, password FROM admins WHERE username = ?")) {
                stmt.setString(1, username);
                ResultSet rs = stmt.executeQuery();
                if (rs.next()) {
                    String hashedPassword = rs.getString("password");
                    if (BCrypt.checkpw(password, hashedPassword)) {
                        admin = new Admin(rs.getLong("id"), rs.getString("username"), hashedPassword);
                    }
                }
            }
        } catch (Exception e) {
            System.out.println("관리자 로그인 오류: " + e.getMessage());
            e.printStackTrace();
        }

        if (admin != null) {
            HttpSession session = request.getSession();
            session.setAttribute("admin", admin);
            System.out.println("관리자 로그인 성공: " + username);
            response.sendRedirect("/BroadcastingClub/notices");
        } else {
            System.out.println("관리자 로그인 실패: 잘못된 아이디/비밀번호");
            request.setAttribute("error", "잘못된 아이디 또는 비밀번호입니다.");
            request.getRequestDispatcher("/admin_login.jsp").forward(request, response);
        }
    }
}