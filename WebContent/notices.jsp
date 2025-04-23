<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>공지사항</title>
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
  <div id="root"></div>
  <script type="text/babel">
    console.log('notices.jsp 스크립트 시작');

    function Navbar() {
      return (
        <nav className="bg-gray-800 text-white p-4 sticky top-0 z-10">
          <div className="container mx-auto flex justify-between items-center">
            <h1 className="text-2xl font-bold">방송부</h1>
            <div className="flex items-center space-x-6">
              <ul className="flex space-x-6">
                <li><a href="index.jsp#home" className="hover:text-gray-300">홈</a></li>
                <li><a href="index.jsp#about" className="hover:text-gray-300">소개</a></li>
                <li><a href="notices.jsp" className="hover:text-gray-300">공지사항</a></li>
                <li><a href="index.jsp#programs" className="hover:text-gray-300">프로그램</a></li>
                <li><a href="index.jsp#departments" className="hover:text-gray-300">부서</a></li>
                <li><a href="index.jsp#contact" className="hover:text-gray-300">연락처</a></li>
              </ul>
              <a href="admin_login.jsp" className="bg-blue-600 text-white px-4 py-2 rounded hover:bg-blue-700">
                관리자 로그인
              </a>
            </div>
          </div>
        </nav>
      );
    }

    function NoticeList() {
      const notices = <%= request.getAttribute("notices") != null ? request.getAttribute("notices") : "[{title: '2025년 4월 방송부원 모집', content: '4월 20일까지 신청서를 제출해주세요.'}, {title: '봄 축제 방송 일정', content: '5월 10일, 축제 현장을 생중계합니다.'}]" %>;
      return (
        <section className="py-16 bg-gray-100">
          <div className="container mx-auto px-4">
            <h2 className="text-3xl font-bold mb-8 text-center">공지사항</h2>
            <ul className="max-w-3xl mx-auto space-y-4">
              {notices.map((notice, index) => (
                <li key={index} className="bg-white p-4 rounded-lg shadow-md">
                  <h3 className="text-lg font-semibold">{notice.title}</h3>
                  <p className="text-gray-600">{notice.content}</p>
                </li>
              ))}
            </ul>
          </div>
        </section>
      );
    }

    function NoticeForm() {
      const isAdmin = <%= session.getAttribute("admin") != null %>;
      if (!isAdmin) return null;
      return (
        <section className="py-16">
          <div className="container mx-auto px-4 max-w-md">
            <h2 className="text-2xl font-bold mb-6 text-center">공지사항 작성</h2>
            <form action="/notices" method="POST">
              <div className="mb-4">
                <input
                  type="text"
                  name="title"
                  placeholder="제목"
                  className="w-full p-3 border border-gray-300 rounded-md focus:ring-2 focus:ring-blue-400 focus:border-transparent"
                  required
                />
              </div>
              <div className="mb-6">
                <textarea
                  name="content"
                  placeholder="내용"
                  className="w-full p-3 border border-gray-300 rounded-md focus:ring-2 focus:ring-blue-400 focus:border-transparent"
                  rows="5"
                  required
                ></textarea>
              </div>
              <button
                type="submit"
                className="w-full bg-green-600 text-white py-3 rounded-md hover:bg-green-700 transition-colors"
                style={{ backgroundColor: '#03C75A' }}
              >
                작성
              </button>
            </form>
          </div>
        </section>
      );
    }

    function Footer() {
      return (
        <footer className="bg-gray-800 text-white py-8">
          <div className="container mx-auto px-4 text-center">
            <p>© 2025 방송부. All rights reserved.</p>
          </div>
        </footer>
      );
    }

    function App() {
      console.log('notices.jsp App 렌더링');
      return (
        <div>
          <Navbar />
          <NoticeList />
          <NoticeForm />
          <Footer />
        </div>
      );
    }

    try {
      const root = ReactDOM.createRoot(document.getElementById('root'));
      root.render(<App />);
      console.log('notices.jsp React 렌더링 완료');
    } catch (e) {
      console.error('notices.jsp React 렌더링 오류:', e);
    }
  </script>
</body>
</html>