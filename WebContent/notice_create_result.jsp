<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*, org.apache.commons.fileupload.*, org.apache.commons.fileupload.disk.*, org.apache.commons.fileupload.servlet.*, java.io.*" %>
<%
    Long adminId = (Long) session.getAttribute("admin_id");
    if (adminId == null) {
        response.sendRedirect("admin_login.jsp");
        return;
    }

    String dbUrl = "jdbc:mysql://localhost:3306/broadcasting_club?useSSL=false&serverTimezone=UTC";
    String dbUser = "root";
    String dbPassword = "12345";
    String title = null;
    String content = null;
    String imagePath = null;
    String uploadDir = application.getRealPath("/uploads/");

    // 업로드 디렉토리 생성
    File uploadDirFile = new File(uploadDir);
    if (!uploadDirFile.exists()) {
        uploadDirFile.mkdirs();
    }

    try {
        // FileUpload 설정
        DiskFileItemFactory factory = new DiskFileItemFactory();
        factory.setRepository(new File(uploadDir));
        ServletFileUpload upload = new ServletFileUpload(factory);
        upload.setSizeMax(10 * 1024 * 1024); // 10MB 제한

        // 폼 데이터 파싱
        List<FileItem> items = upload.parseRequest(request);
        for (FileItem item : items) {
            if (item.isFormField()) {
                // 일반 필드
                String fieldName = item.getFieldName();
                String fieldValue = item.getString("UTF-8");
                if ("title".equals(fieldName)) {
                    title = fieldValue;
                } else if ("content".equals(fieldName)) {
                    content = fieldValue;
                } else if ("admin_id".equals(fieldName)) {
                    adminId = Long.parseLong(fieldValue);
                }
            } else {
                // 파일 필드
                if (item.getSize() > 0) {
                    String fileName = new File(item.getName()).getName();
                    String uniqueFileName = System.currentTimeMillis() + "_" + fileName;
                    File uploadedFile = new File(uploadDir, uniqueFileName);
                    item.write(uploadedFile);
                    imagePath = "/BroadcastingClub/Uploads/" + uniqueFileName;
                    System.out.println("notice_create_result.jsp: 이미지 업로드 성공, 경로=" + imagePath);
                }
            }
        }

        // DB 저장
        Class.forName("com.mysql.cj.jdbc.Driver");
        try (Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
             PreparedStatement stmt = conn.prepareStatement(
                 "INSERT INTO notices (title, content, admin_id, image_path) VALUES (?, ?, ?, ?)",
                 Statement.RETURN_GENERATED_KEYS)) {
            stmt.setString(1, title);
            stmt.setString(2, content);
            stmt.setLong(3, adminId);
            stmt.setString(4, imagePath);
            stmt.executeUpdate();

            // 생성된 공지사항 ID 가져오기
            ResultSet rs = stmt.getGeneratedKeys();
            long noticeId = rs.next() ? rs.getLong(1) : -1;
            System.out.println("notice_create_result.jsp: 공지사항 생성 성공, ID=" + noticeId);
        }
    } catch (Exception e) {
        System.out.println("notice_create_result.jsp: 오류: " + e.getMessage());
        e.printStackTrace();
        response.sendRedirect("notice_create.jsp?error=1");
        return;
    }
%>
<!DOCTYPE html>
<html lang="ko">
<jsp:include page="header.jsp">
    <jsp:param name="pageTitle" value="공지사항 작성 완료" />
</jsp:include>
<body>
    <main>
        <section class="banner">
            <h1>공지사항 작성 완료</h1>
        </section>
        <section class="popular-guides">
            <p>공지사항이 성공적으로 작성되었습니다.</p>
            <a href="notices.jsp">공지사항 목록으로 돌아가기</a>
        </section>
    </main>

    <jsp:include page="footer.jsp"/>

    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        body { font-family: 'Noto Sans KR', sans-serif; margin: 0; }
        .banner { text-align: center; padding: 20px; background-color: #f0f0f0; }
        .popular-guides { max-width: 800px; margin: 0 auto; padding: 20px; }
        .popular-guides p { margin-bottom: 15px; }
        .popular-guides a { color: #03C75A; text-decoration: none; }
        .popular-guides a:hover { text-decoration: underline; }
    </style>
</body>
</html>