<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    String id = request.getParameter("id");
    Long adminId = (Long) session.getAttribute("admin_id");

    System.out.println("notice_delete.jsp: id=" + id + ", admin_id=" + adminId);

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        // 관리자 확인
        if (adminId == null) {
            System.out.println("공지사항 삭제 실패: 관리자 로그인 필요");
            session.setAttribute("error", "관리자 로그인이 필요합니다.");
            response.sendRedirect("admin_login.jsp");
            return;
        }

        // ID 검증
        if (id == null || id.trim().isEmpty()) {
            System.out.println("공지사항 삭제 실패: ID 누락");
            session.setAttribute("error", "공지사항 ID가 필요합니다.");
            response.sendRedirect("notices.jsp");
            return;
        }

        String dbUrl = "jdbc:mysql://localhost:3306/broadcasting_club?useSSL=false&serverTimezone=UTC";
        String dbUser = "root";
        String dbPassword = "12345";
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

        // 공지사항 삭제
        String sql = "DELETE FROM notices WHERE id = ? AND admin_id = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setLong(1, Long.parseLong(id));
        pstmt.setLong(2, adminId);
        int rowsAffected = pstmt.executeUpdate();

        if (rowsAffected > 0) {
            System.out.println("공지사항 삭제 성공: id=" + id + ", admin_id=" + adminId);
            session.setAttribute("success", "공지사항이 삭제되었습니다.");
            response.sendRedirect("notices.jsp");
        } else {
            System.out.println("공지사항 삭제 실패: 해당 공지사항 없음 또는 권한 없음");
            session.setAttribute("error", "공지사항 삭제에 실패했습니다. 공지사항이 존재하지 않거나 권한이 없습니다.");
            response.sendRedirect("notices.jsp");
        }
    } catch (NumberFormatException e) {
        System.out.println("공지사항 삭제 실패: 잘못된 ID 형식, id=" + id);
        session.setAttribute("error", "잘못된 공지사항 ID 형식입니다.");
        response.sendRedirect("notices.jsp");
    } catch (Exception e) {
        System.out.println("공지사항 삭제 오류: " + e.getMessage());
        session.setAttribute("error", "공지사항 삭제 중 오류 발생: " + e.getMessage());
        response.sendRedirect("notices.jsp");
        e.printStackTrace();
    } finally {
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) {}
        if (conn != null) try { conn.close(); } catch (SQLException e) {}
    }
%>