<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.sql.*" %>
<%
    Long adminId = (Long) session.getAttribute("admin_id");
    String idParam = request.getParameter("id");
    long id = 0;
    Map<String, Object> notice = new HashMap<>();

    if (idParam != null) {
        try {
            id = Long.parseLong(idParam);
            String dbUrl = "jdbc:mysql://localhost:3306/broadcasting_club?useSSL=false&serverTimezone=UTC";
            String dbUser = "root";
            String dbPassword = "12345";

            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
            PreparedStatement stmt = conn.prepareStatement("SELECT id, title, content, image_path FROM notices WHERE id = ?");
            stmt.setLong(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                notice.put("id", rs.getLong("id"));
                notice.put("title", rs.getString("title"));
                notice.put("content", rs.getString("content"));
                notice.put("image_path", rs.getString("image_path"));
            }

            rs.close();
            stmt.close();
            conn.close();
            System.out.println("notice_view.jsp: 공지사항 조회 성공, ID=" + id);
        } catch (Exception e) {
            System.out.println("notice_view.jsp: 공지사항 조회 오류: " + e.getMessage());
            e.printStackTrace();
        }
    }
    request.setAttribute("notice", notice);
%>
<!DOCTYPE html>
<html lang="ko">
<jsp:include page="header.jsp">
    <jsp:param name="pageTitle" value="공지사항 상세" />
</jsp:include>
<body>
    <main>
        <section class="banner">
            <h1>공지사항 상세</h1>
        </section>
        <section class="popular-guides">
            <c:choose>
                <c:when test="${empty notice}">
                    <p>공지사항을 찾을 수 없습니다.</p>
                </c:when>
                <c:otherwise>
                    <h2><c:out value="${notice.title}"/></h2>
                    <p><c:out value="${notice.content}"/></p>
                    <c:if test="${not empty notice.image_path}">
                        <img src="${notice.image_path}" alt="공지사항 이미지" style="max-width: 100%; height: auto; margin-top: 10px;">
                    </c:if>
                    <div>
                        <a href="notices.jsp">목록으로 돌아가기</a>
                        <c:if test="${sessionScope.admin_id != null}">
                            <a href="notice_delete.jsp?id=${notice.id}">삭제</a>
                        </c:if>
                    </div>
                </c:otherwise>
            </c:choose>
        </section>
    </main>

    <jsp:include page="footer.jsp"/>

    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        body { font-family: 'Noto Sans KR', sans-serif; margin: 0; }
        .banner { text-align: center; padding: 20px; background-color: #f0f0f0; }
        .popular-guides { max-width: 800px; margin: 0 auto; padding: 20px; }
        .popular-guides h2 { font-size: 1.5rem; font-weight: bold; margin-bottom: 10px; }
        .popular-guides p { margin-bottom: 15px; }
        .popular-guides a { color: #03C75A; text-decoration: none; margin-right: 10px; }
        .popular-guides a:hover { text-decoration: underline; }
    </style>
    <script>
        console.log('notice_view.jsp: admin_id=', <%= adminId %>);
        console.log('notice_view.jsp: notice=', <%= notice %>);
    </script>
</body>
</html>