<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <script src="https://unpkg.com/react@18/umd/react.development.js"></script>
  <script src="https://unpkg.com/react-dom@18/umd/react-dom.development.js"></script>
  <script src="https://unpkg.com/@babel/standalone/babel.min.js"></script>
  <script src="https://cdn.tailwindcss.com"></script>
  <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap" rel="stylesheet">
  <style>
    body { font-family: 'Noto Sans KR', sans-serif; }
  </style>
</head>
<body>
  <div id="header-root"></div>
  <script type="text/babel">
    function Navbar() {
      return (
        <nav className="bg-gray-800 text-white p-4 sticky top-0 z-10">
          <div className="container mx-auto flex justify-between items-center">
            <h1 className="text-2xl font-bold">방송부</h1>
            <div className="flex items-center space-x-6">
              <ul className="flex space-x-6">
                <li><a href="#home" className="hover:text-gray-300">홈</a></li>
                <li><a href="#about" className="hover:text-gray-300">소개</a></li>
                <li><a href="notices.jsp" className="hover:text-gray-300">공지사항</a></li>
                <li><a href="#programs" className="hover:text-gray-300">프로그램</a></li>
                <li><a href="#departments" className="hover:text-gray-300">부서</a></li>
                <li><a href="#contact" className="hover:text-gray-300">연락처</a></li>
              </ul>
              <a href="admin_login.jsp" className="bg-blue-600 text-white px-4 py-2 rounded hover:bg-blue-700">
                관리자 로그인
              </a>
            </div>
          </div>
        </nav>
      );
    }

    try {
      const headerRoot = ReactDOM.createRoot(document.getElementById('header-root'));
      headerRoot.render(<Navbar />);
      console.log('header.jsp React 렌더링 완료');
    } catch (e) {
      console.error('header.jsp React 렌더링 오류:', e);
    }
  </script>
</body>
</html>