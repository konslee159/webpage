import com.example.broadcasting.entity.Notice;
import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@WebServlet({"/notices", "/notices/create"})
public class NoticeServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/broadcasting_club?useSSL=false&serverTimezone=UTC";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "12345";

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
                String sql = "SELECT id, title, content, created_at FROM notices ORDER BY created_at DESC";
                PreparedStatement stmt = conn.prepareStatement(sql);
                ResultSet rs = stmt.executeQuery();

                List<Notice> notices = new ArrayList<>();
                while (rs.next()) {
                    Notice notice = new Notice();
                    notice.setId(rs.getLong("id"));
                    notice.setTitle(rs.getString("title"));
                    notice.setContent(rs.getString("content"));
                    notice.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
                    notices.add(notice);
                }

                req.setAttribute("notices", new Gson().toJson(notices));
                req.getRequestDispatcher("/notices.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        Long adminId = (Long) session.getAttribute("admin_id");
        if (adminId == null) {
            resp.sendRedirect("/admin_login.jsp");
            return;
        }

        String title = req.getParameter("title");
        String content = req.getParameter("content");

        try {
            Class.forName("com.mysql.cj.Driver");
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
                String sql = "INSERT INTO notices (title, content, admin_id) VALUES (?, ?, ?)";
                PreparedStatement stmt = conn.prepareStatement(sql);
                stmt.setString(1, title);
                stmt.setString(2, content);
                stmt.setLong(3, adminId);
                stmt.executeUpdate();
                resp.sendRedirect("/notices");
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}