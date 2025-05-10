<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title><%= request.getParameter("pageTitle") != null ? request.getParameter("pageTitle") : "방송부" %></title>
  <script src="https://unpkg.com/react@18/umd/react.development.js"></script>
  <script src="https://unpkg.com/react-dom@18/umd/react-dom.development.js"></script>
  <script src="https://unpkg.com/@babel/standalone/babel.min.js"></script>
  <script src="https://cdn.tailwindcss.com"></script>
  <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap" rel="stylesheet">
  <style>
    body { font-family: 'Noto Sans KR', sans-serif; margin: 0; }
  </style>
</head>
<body>
  <div id="navbar-root"></div>
  <script type="text/babel">
    console.log('header.jsp 스크립트 시작');
    console.log('세션 admin_id:', <%= session.getAttribute("admin_id") != null ? session.getAttribute("admin_id") : "null" %>);

    function Navbar() {
      const isAdmin = <%= session.getAttribute("admin_id") != null %>;
      console.log('isAdmin:', isAdmin);
      return (
        <nav className="bg-gray-800 text-white p-4 sticky top-0 z-10">
          <div className="container mx-auto flex justify-between items-center">
            <h1 className="text-2xl font-bold">방송부</h1>
            <div className="flex items-center space-x-6">
              <ul className="flex space-x-6">
                <li><a href="/BroadcastingClub/index.jsp#home" className="hover:text-gray-300">홈</a></li>
                <li><a href="/BroadcastingClub/index.jsp#about" className="hover:text-gray-300">소개</a></li>
                <li><a href="/BroadcastingClub/notices.jsp" className="hover:text-gray-300">공지사항</a></li>
                <li><a href="/BroadcastingClub/index.jsp#programs" className="hover:text-gray-300">프로그램</a></li>
                <li><a href="/BroadcastingClub/index.jsp#departments" className="hover:text-gray-300">부서</a></li>
                <li><a href="/BroadcastingClub/index.jsp#contact" className="hover:text-gray-300">연락처</a></li>
              </ul>
              {isAdmin ? (
                <div className="flex items-center space-x-4">
                  <span className="text-green-400 font-semibold">ADMIN 로그인 중</span>
                  <a href="/BroadcastingClub/logout.jsp" className="bg-red-600 text-white px-4 py-2 rounded hover:bg-red-700">
                    로그아웃
                  </a>
                </div>
              ) : (
                <a href="/BroadcastingClub/admin_login.jsp" className="bg-blue-600 text-white px-4 py-2 rounded hover:bg-blue-700">
                  관리자 로그인
                </a>
              )}
            </div>
          </div>
        </nav>
      );
    }

    try {
      const navbarRoot = ReactDOM.createRoot(document.getElementById('navbar-root'));
      navbarRoot.render(<Navbar />);
      console.log('header.jsp Navbar 렌더링 완료');
    } catch (e) {
      console.error('header.jsp Navbar 렌더링 오류:', e);
    }
  </script>