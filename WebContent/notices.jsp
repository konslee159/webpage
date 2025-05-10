<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.sql.*, java.util.*" %>
<%
    int pageSize = 10; // 한 페이지에 보여줄 공지사항 수
    int pageNumber = 1; // 기본 페이지 번호
    String searchValue = request.getParameter("searchValue"); // 검색어
    if (request.getParameter("page") != null) {
        try {
            pageNumber = Integer.parseInt(request.getParameter("page"));
        } catch (NumberFormatException e) {
            pageNumber = 1;
        }
    }

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    List<Map<String, Object>> noticeList = new ArrayList<>();
    int totalCount = 0;
    int totalPages = 0;

    try {
        String dbUrl = "jdbc:mysql://localhost:3306/broadcasting_club?useSSL=false&serverTimezone=UTC";
        String dbUser = "root";
        String dbPassword = "12345";
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

        // 전체 공지사항 수
        String countSql = searchValue != null && !searchValue.isEmpty() ?
            "SELECT COUNT(*) AS total FROM notices WHERE title LIKE ?" :
            "SELECT COUNT(*) AS total FROM notices";
        pstmt = conn.prepareStatement(countSql);
        if (searchValue != null && !searchValue.isEmpty()) {
            pstmt.setString(1, "%" + searchValue + "%");
        }
        rs = pstmt.executeQuery();
        if (rs.next()) {
            totalCount = rs.getInt("total");
        }
        rs.close();
        pstmt.close();

        totalPages = (int) Math.ceil((double) totalCount / pageSize);
        int startRow = (pageNumber - 1) * pageSize;

        // 현재 페이지 공지사항 조회
        String sql = searchValue != null && !searchValue.isEmpty() ?
            "SELECT id, title, content, created_at, admin_id FROM notices WHERE title LIKE ? ORDER BY created_at DESC LIMIT ?, ?" :
            "SELECT id, title, content, created_at, admin_id FROM notices ORDER BY created_at DESC LIMIT ?, ?";
        pstmt = conn.prepareStatement(sql);
        if (searchValue != null && !searchValue.isEmpty()) {
            pstmt.setString(1, "%" + searchValue + "%");
            pstmt.setInt(2, startRow);
            pstmt.setInt(3, pageSize);
        } else {
            pstmt.setInt(1, startRow);
            pstmt.setInt(2, pageSize);
        }
        rs = pstmt.executeQuery();

        while (rs.next()) {
            Map<String, Object> notice = new HashMap<>();
            notice.put("id", rs.getLong("id"));
            notice.put("title", rs.getString("title"));
            notice.put("content", rs.getString("content"));
            notice.put("created_at", rs.getTimestamp("created_at"));
            notice.put("admin_id", rs.getLong("admin_id"));
            noticeList.add(notice);
        }
        request.setAttribute("notices", noticeList);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("currentPage", pageNumber);
        request.setAttribute("searchValue", searchValue);
    } catch (Exception e) {
        e.printStackTrace();
        session.setAttribute("error", "공지사항 목록 조회 중 오류 발생: " + e.getMessage());
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) {}
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) {}
        if (conn != null) try { conn.close(); } catch (SQLException e) {}
    }
%>
<!DOCTYPE html>
<html lang="ko">
<jsp:include page="header.jsp">
    <jsp:param name="pageTitle" value="공지사항" />
</jsp:include>
<body>
    <main>
        <section class="search-form">
            <form action="notices.jsp" method="get">
                <input type="text" name="searchValue" placeholder="공지사항 제목 검색" aria-label="공지사항 제목 검색" value="<c:out value='${searchValue}'/>">
                <button type="submit">검색</button>
            </form>
        </section>

        <section class="banner">
            <h1>공지사항</h1>
        </section>

        <section class="popular-guides">
            <h2>공지사항 목록</h2>
            <div class="guide-list">
                <c:choose>
                    <c:when test="${empty notices}">
                        <p>검색 결과가 없습니다.</p>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="notice" items="${notices}">
                            <div class="guide">
                                <h3>
                                    <a href="notice_view.jsp?id=${notice.id}"><c:out value="${notice.title}"/></a>
                                    <c:if test="${not empty sessionScope.admin_id}">
                                        <a href="notice_delete.jsp?id=${notice.id}" class="delete-button" onclick="return confirm('정말로 삭제하시겠습니까?');">삭제</a>
                                    </c:if>
                                </h3>
                                <p>작성일: <c:out value="${notice.created_at}"/></p>
                            </div>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>
        </section>

        <!-- 페이지 네비게이션 -->
        <div class="pagination">
            <c:if test="${currentPage > 1}">
                <a href="notices.jsp?page=${currentPage - 1}&searchValue=${searchValue}">이전</a>
            </c:if>
            <c:forEach begin="1" end="${totalPages}" var="i">
                <a href="notices.jsp?page=${i}&searchValue=${searchValue}" <c:if test="${i == currentPage}">class="active"</c:if>>${i}</a>
            </c:forEach>
            <c:if test="${currentPage < totalPages}">
                <a href="notices.jsp?page=${currentPage + 1}&searchValue=${searchValue}">다음</a>
            </c:if>
        </div>

        <!-- 공지사항 작성 버튼 -->
        <div class="post-button">
            <c:if test="${not empty sessionScope.admin_id}">
                <a class="circle-button" href="notice_create.jsp">공지사항 작성</a>
            </c:if>
        </div>
    </main>

    <jsp:include page="footer.jsp"/>

    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        body { font-family: 'Noto Sans KR', sans-serif; margin: 0; }
        .search-form { text-align: center; margin: 20px 0; }
        .search-form input[type="text"] { padding: 8px; width: 300px; }
        .search-form button { padding: 8px 16px; background-color: #03C75A; color: white; border: none; cursor: pointer; }
        .banner { text-align: center; padding: 20px; background-color: #f0f0f0; }
        .popular-guides { max-width: 800px; margin: 0 auto; padding: 20px; }
        .guide { border-bottom: 1px solid #ddd; padding: 10px 0; }
        .guide h3 { margin: 0; font-size: 1.2em; display: flex; justify-content: space-between; align-items: center; }
        .guide p { margin: 5px 0; color: #555; }
        .delete-button { padding: 5px 10px; background-color: #dc3545; color: white; text-decoration: none; border-radius: 4px; font-size: 0.9em; }
        .delete-button:hover { background-color: #c82333; }
        .pagination { text-align: center; margin: 20px 0; }
        .pagination a { margin: 0 5px; padding: 5px 10px; text-decoration: none; color: #333; }
        .pagination a.active { background-color: #03C75A; color: white; }
        .pagination a:hover { background-color: #ddd; }
        .post-button { text-align: center; margin: 20px 0; }
        .circle-button { display: inline-block; padding: 10px 20px; background-color: #03C75A; color: white; text-decoration: none; border-radius: 20px; }
        .circle-button:hover { background-color: #028a3f; }
    </style>
</body>
</html>