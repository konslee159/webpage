<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.sql.*, java.util.*" %>
<%
// 개발자: 이연우
// 최신 공지사항 2개 조회
String dbUrl = "jdbc:mysql://localhost:3306/broadcasting_club?useSSL=false&serverTimezone=UTC";
String dbUser = "root";
String dbPassword = "12345";
List<Map<String, Object>> noticeList = new ArrayList<>();

try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
    PreparedStatement stmt = conn.prepareStatement("SELECT id, title, content FROM notices ORDER BY created_at DESC LIMIT 2");
    ResultSet rs = stmt.executeQuery();

    while (rs.next()) {
        Map<String, Object> notice = new HashMap<>();
        notice.put("id", rs.getLong("id"));
        notice.put("title", rs.getString("title"));
        notice.put("content", rs.getString("content"));
        noticeList.add(notice);
    }

    request.setAttribute("notices", noticeList);
    rs.close();
    stmt.close();
    conn.close();
    System.out.println("index.jsp: 공지사항 조회 성공, 개수=" + noticeList.size());
} catch (Exception e) {
    System.out.println("index.jsp: 공지사항 조회 오류: " + e.getMessage());
    e.printStackTrace();
    // 오류 시 기본 데이터
    Map<String, Object> notice1 = new HashMap<>();
    notice1.put("id", 1L);
    notice1.put("title", "2025년 4월 방송부원 모집");
    notice1.put("content", "4월 20일까지 신청서를 제출해주세요.");
    Map<String, Object> notice2 = new HashMap<>();
    notice2.put("id", 2L);
    notice2.put("title", "봄 축제 방송 일정");
    notice2.put("content", "5월 10일, 축제 현장을 생중계합니다.");
    noticeList.add(notice1);
    noticeList.add(notice2);
    request.setAttribute("notices", noticeList);
}
%>
<!DOCTYPE html>
<html lang="ko">
<jsp:include page="header.jsp">
    <jsp:param name="pageTitle" value="방송부" />
</jsp:include>
<body>
    <!-- Slider Banner -->
    <section id="banner" class="relative w-full h-96 overflow-hidden">
        <div class="slider">
            <div class="slide active">
                <img src="/BroadcastingClub/images/123.jpg" alt="방송 스튜디오" class="w-full h-full object-cover">
                <div class="caption">최첨단 방송 스튜디오</div>
            </div>
            <div class="slide">
                <img src="/BroadcastingClub/images/asfoikj.png" alt="이벤트 방송" class="w-full h-full object-cover">
                <div class="caption">생동감 넘치는 이벤트 현장</div>
            </div>
            <div class="slide">
                <img src="/BroadcastingClub/images/team_collaboration.jpg" alt="팀 협업" class="w-full h-full object-cover">
                <div class="caption">창의적인 팀워크</div>
            </div>
        </div>
        <button class="prev absolute top-1/2 left-4 transform -translate-y-1/2 bg-gray-800 text-white p-2 rounded-full">❮</button>
        <button class="next absolute top-1/2 right-4 transform -translate-y-1/2 bg-gray-800 text-white p-2 rounded-full">❯</button>
    </section>

    <!-- Home Section -->
    <section id="home" class="py-16">
        <div class="container mx-auto px-4 text-center">
            <h2 class="text-4xl font-bold mb-4">방송부에 오신 것을 환영합니다!</h2>
            <p class="text-lg text-gray-600">우리는 창의적인 방송 콘텐츠를 제작하고, 최고의 프로그램을 제공합니다.</p>
        </div>
    </section>

    <!-- About Section -->
    <section id="about" class="py-16">
        <div class="container mx-auto px-4">
            <h2 class="text-3xl font-bold mb-8 text-center">소개</h2>
            <p class="text-lg text-gray-600 max-w-3xl mx-auto">
                방송부는 2000년에 설립되어, 다양한 방송 프로그램을 기획하고 제작해 왔습니다.
                우리의 목표는 청중에게 즐거움과 정보를 제공하는 것입니다.
            </p>
        </div>
    </section>

    <!-- Notices Section -->
    <section id="notices" class="py-16 bg-gray-100">
        <div class="container mx-auto px-4">
            <h2 class="text-3xl font-bold mb-8 text-center">공지사항</h2>
            <c:choose>
                <c:when test="${empty notices}">
                    <p class="text-center text-gray-600">공지사항이 없습니다.</p>
                </c:when>
                <c:otherwise>
                    <ul class="max-w-3xl mx-auto space-y-4">
                        <c:forEach var="notice" items="${notices}">
                            <li class="bg-white p-4 rounded-lg shadow-md">
                                <a href="/BroadcastingClub/notice_view.jsp?id=${notice.id}">
                                    <h3 class="text-lg font-semibold"><c:out value="${notice.title}"/></h3>
                                    <p class="text-gray-600"><c:out value="${notice.content}"/></p>
                                </a>
                            </li>
                        </c:forEach>
                    </ul>
                </c:otherwise>
            </c:choose>
        </div>
    </section>

    <!-- Programs Section -->
    <section id="programs" class="py-16">
        <div class="container mx-auto px-4">
            <h2 class="text-3xl font-bold mb-8 text-center">프로그램</h2>
            <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
                <div class="bg-white p-6 rounded-lg shadow-md">
                    <h3 class="text-xl font-semibold mb-2">아침 뉴스</h3>
                    <p class="text-gray-600">매일 종을 맟추며</p>
                </div>
                <div class="bg-white p-6 rounded-lg shadow-md">
                    <h3 class="text-xl font-semibold mb-2">뮤직 쇼</h3>
                    <p class="text-gray-600">최신 음악과 함께하는 즐거운 시간.</p>
                </div>
                <div class="bg-white p-6 rounded-lg shadow-md">
                    <h3 class="text-xl font-semibold mb-2">토크쇼</h3>
                    <p class="text-gray-600">다양한 산연들을 읽어 드립니다.</p>
                </div>
            </div>
        </div>
    </section>

    <!-- Departments Section -->
    <section id="departments" class="py-16">
        <div class="container mx-auto px-4">
            <h2 class="text-3xl font-bold mb-8 text-center">부서</h2>
            <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
                <div class="bg-white p-6 rounded-lg shadow-md">
                    <h3 class="text-xl font-semibold mb-2">제작부</h3>
                    <p class="text-gray-600">프로그램 기획 및 제작을 담당합니다.</p>
                </div>
                <div class="bg-white p-6 rounded-lg shadow-md">
                    <h3 class="text-xl font-semibold mb-2">기술부</h3>
                    <p class="text-gray-600">방송 장비 관리와 기술 지원.</p>
                </div>
                <div class="bg-white p-6 rounded-lg shadow-md">
                    <h3 class="text-xl font-semibold mb-2">홍보부</h3>
                    <p class="text-gray-600">방송부의 활동을 홍보합니다.</p>
                </div>
            </div>
        </div>
    </section>

    <!-- Contact Section -->
    <section id="contact" class="py-16">
        <div class="container mx-auto px-4 text-center">
            <h2 class="text-3xl font-bold mb-8">연락처</h2>
            <p class="text-lg text-gray-600 mb-4">궁금한 점이 있으시면 연락주세요!</p>
            <p class="text-lg">이메일: </p>
            <p class="text-lg">전화: </p>
        </div>
    </section>

    <jsp:include page="footer.jsp"/>
    <script>
        console.log('index.jsp: 슬라이더 초기화');
        const slides = document.querySelectorAll('.slide');
        const prevButton = document.querySelector('.prev');
        const nextButton = document.querySelector('.next');
        let currentSlide = 0;

        function showSlide(index) {
            slides.forEach((slide, i) => {
                slide.classList.toggle('active', i === index);
            });
        }

        function nextSlide() {
            currentSlide = (currentSlide + 1) % slides.length;
            showSlide(currentSlide);
        }

        function prevSlide() {
            currentSlide = (currentSlide - 1 + slides.length) % slides.length;
            showSlide(currentSlide);
        }

        // 자동 슬라이드
        let slideInterval = setInterval(nextSlide, 5000);

        // 버튼 이벤트
        nextButton.addEventListener('click', () => {
            clearInterval(slideInterval);
            nextSlide();
            slideInterval = setInterval(nextSlide, 5000);
        });

        prevButton.addEventListener('click', () => {
            clearInterval(slideInterval);
            prevSlide();
            slideInterval = setInterval(nextSlide, 5000);
        });

        // 이미지 로드 오류 처리
        slides.forEach(slide => {
            const img = slide.querySelector('img');
            img.onerror = () => {
                console.error('이미지 로드 실패:', img.src);
                img.src = '/BroadcastingClub/images/fallback.jpg'; // 대체 이미지
            };
        });

        console.log('index.jsp: 슬라이더 설정 완료, 슬라이드 수=', slides.length);
    </script>

    <style>
        body { font-family: 'Noto Sans KR', sans-serif; margin: 0; }
        .py-16 { padding-top: 4rem; padding-bottom: 4rem; }
        .bg-gray-100 { background-color: #f7fafc; }
        .bg-gray-800 { background-color: #2d3748; }
        .text-white { color: #ffffff; }
        .text-gray-600 { color: #4a5568; }
        .text-lg { font-size: 1.125rem; }
        .text-3xl { font-size: 1.875rem; }
        .text-4xl { font-size: 2.25rem; }
        .font-bold { font-weight: 700; }
        .font-semibold { font-weight: 600; }
        .mb-4 { margin-bottom: 1rem; }
        .mb-8 { margin-bottom: 2rem; }
        .text-center { text-align: center; }
        .container { max-width: 1200px; margin-left: auto; margin-right: auto; }
        .px-4 { padding-left: 1rem; padding-right: 1rem; }
        .max-w-3xl { max-width: 48rem; }
        .mx-auto { margin-left: auto; margin-right: auto; }
        .space-y-4 > :not(:last-child) { margin-bottom: 1rem; }
        .bg-white { background-color: #ffffff; }
        .p-4 { padding: 1rem; }
        .p-6 { padding: 1.5rem; }
        .rounded-lg { border-radius: 0.5rem; }
        .shadow-md { box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06); }
        .grid { display: grid; }
        .grid-cols-1 { grid-template-columns: repeat(1, minmax(0, 1fr)); }
        .gap-6 { gap: 1.5rem; }
        @media (min-width: 768px) {
            .md\:grid-cols-3 { grid-template-columns: repeat(3, minmax(0, 1fr)); }
        }
        a { color: #2b6cb0; text-decoration: none; }
        a:hover { text-decoration: underline; }

        /* Slider Styles */
        #banner { position: relative; }
        .slider { width: 100%; height: 100%; }
        .slide { display: none; position: relative; }
        .slide.active { display: block; }
        .slide img { width: 100%; height: 100%; object-fit: cover; }
        .caption {
            position: absolute;
            bottom: 20px;
            left: 20px;
            background-color: rgba(0, 0, 0, 0.7);
            color: white;
            padding: 10px 20px;
            border-radius: 5px;
            font-size: 1.2rem;
        }
        .prev, .next {
            cursor: pointer;
            user-select: none;
            transition: background-color 0.3s;
        }
        .prev:hover, .next:hover { background-color: rgba(0, 0, 0, 0.8); }
    </style>
</body>
</html>