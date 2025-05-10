<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    Long adminId = (Long) session.getAttribute("admin_id");
    if (adminId == null) {
        response.sendRedirect("admin_login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="ko">
<jsp:include page="header.jsp">
    <jsp:param name="pageTitle" value="공지사항 작성" />
</jsp:include>
<body>
    <main>
        <section class="banner">
            <h1>공지사항 작성</h1>
        </section>

        <section class="popular-guides">
            <form action="notice_create_result.jsp" method="post" enctype="multipart/form-data">
                <input type="hidden" name="admin_id" value="<%= adminId %>">
                <div>
                    <label for="title">제목:</label>
                    <input type="text" id="title" name="title" required>
                </div>
                <div>
                    <label for="content">내용:</label>
                    <textarea id="content" name="content" required></textarea>
                </div>
                <div>
                    <label for="image">이미지 업로드:</label>
                    <input type="file" id="image" name="image" accept="image/*">
                </div>
                <button type="submit">작성하기</button>
            </form>
        </section>
    </main>

    <jsp:include page="footer.jsp"/>

    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        body { font-family: 'Noto Sans KR', sans-serif; margin: 0; }
        .banner { text-align: center; padding: 20px; background-color: #f0f0f0; }
        .popular-guides { max-width: 800px; margin: 0 auto; padding: 20px; }
        .popular-guides div { margin-bottom: 15px; }
        .popular-guides label { display: block; margin-bottom: 5px; font-weight: bold; }
        .popular-guides input[type="text"], .popular-guides input[type="file"] { width: 100%; padding: 8px; }
        .popular-guides textarea { width: 100%; height: 200px; padding: 8px; }
        .popular-guides button { padding: 10px 20px; background-color: #03C75A; color: white; border: none; cursor: pointer; }
        .popular-guides button:hover { background-color: #028a3f; }
    </style>
    <script>
        console.log('notice_create.jsp: admin_id=', <%= adminId %>);
    </script>