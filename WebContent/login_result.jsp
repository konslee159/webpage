<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
// 로그인 처리 로직
String username = request.getParameter("username");
String password = request.getParameter("password");
String dbUrl = "jdbc:mysql://localhost:3306/broadcasting_club?useSSL=false&serverTimezone=UTC";
String dbUser = "root";
String dbPassword = "12345"; // 실제 MySQL 비밀번호로 변경

Connection conn = null;
PreparedStatement stmt = null;
ResultSet rs = null;

try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
    stmt = conn.prepareStatement("SELECT id, username, password FROM admins WHERE username = ?");
    stmt.setString(1, username);
    rs = stmt.executeQuery();

    if (rs.next()) {
        String storedPassword = rs.getString("password");
        if (password != null && password.equals(storedPassword)) {
            // 세션 설정
            session.setAttribute("admin_id", rs.getLong("id"));
            session.setAttribute("admin_username", rs.getString("username"));
            // /BroadcastingClub/notices로 리다이렉션
            response.sendRedirect("notices.jsp");
        } else {
            session.setAttribute("error", "잘못된 아이디 또는 비밀번호입니다.");
            response.sendRedirect("admin_login.jsp");
        }
    } else {
        session.setAttribute("error", "잘못된 아이디 또는 비밀번호입니다.");
        response.sendRedirect("admin_login.jsp");
    }
} catch (Exception e) {
    session.setAttribute("error", "로그인 처리 중 오류 발생: " + e.getMessage());
    response.sendRedirect("admin_login.jsp");
    e.printStackTrace();
} finally {
    if (rs != null) try { rs.close(); } catch (SQLException e) {}
    if (stmt != null) try { stmt.close(); } catch (SQLException e) {}
    if (conn != null) try { conn.close(); } catch (SQLException e) {}
}
%>