<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>관리자 로그인</title>
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
    console.log('admin_login.jsp 스크립트 시작');

    // 세션에서 오류 메시지 가져오기
    let errorMessage = <%= session.getAttribute("error") != null ? "\"" + session.getAttribute("error").toString().replace("\"", "\\\"") + "\"" : "null" %>;
    console.log('errorMessage:', errorMessage);

    // 오류 메시지 표시 후 세션에서 제거
    <% session.removeAttribute("error"); %>

    function Navbar() {
      return (
        <nav className="bg-gray-800 text-white p-4 sticky top-0 z-10">
          <div className="container mx-auto flex justify-between items-center">
            <h1 className="text-2xl font-bold">방송부</h1>
            <div className="flex items-center space-x-6">
              <ul className="flex space-x-6">
                <li><a href="index.jsp#home" className="hover:text-gray-300">홈</a></li>
                <li><a href="index.jsp#about" className="hover:text-gray-300">소개</a></li>
                <li><a href="/BroadcastingClub/notices" className="hover:text-gray-300">공지사항</a></li>
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

    function LoginModal() {
      return (
        <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50">
          <div className="bg-white rounded-lg shadow-xl w-full max-w-md relative">
            <a
              href="index.jsp"
              className="absolute top-3 right-3 text-gray-500 hover:text-gray-700"
              onClick={() => console.log('X 버튼 클릭됨')}
            >
              <svg className="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M6 18L18 6M6 6l12 12" />
              </svg>
            </a>
            <div className="p-6">
              <h2 className="text-2xl font-bold text-center text-gray-800 mb-6">관리자 로그인</h2>
              <form action="login_result.jsp" method="POST">
                <div className="mb-4">
                  <input
                    type="text"
                    id="username"
                    name="username"
                    placeholder="아이디"
                    className="w-full p-3 border border-gray-300 rounded-md focus:ring-2 focus:ring-blue-400 focus:border-transparent"
                    required
                  />
                </div>
                <div className="mb-6">
                  <input
                    type="password"
                    id="password"
                    name="password"
                    placeholder="비밀번호"
                    className="w-full p-3 border border-gray-300 rounded-md focus:ring-2 focus:ring-blue-400 focus:border-transparent"
                    required
                  />
                </div>
                <button
                  type="submit"
                  className="w-full bg-green-600 text-white py-3 rounded-md hover:bg-green-700 transition-colors"
                  style={{ backgroundColor: '#03C75A' }}
                >
                  로그인
                </button>
              </form>
              {errorMessage && (
                <p className="text-red-500 text-sm mt-4 text-center">
                  {errorMessage}
                </p>
              )}
            </div>
          </div>
        </div>
      );
    }

    function App() {
      console.log('admin_login.jsp App 렌더링');
      return (
        <div>
          <Navbar />
          <LoginModal />
        </div>
      );
    }

    try {
      const root = ReactDOM.createRoot(document.getElementById('root'));
      root.render(<App />);
      console.log('admin_login.jsp React 렌더링 완료');
    } catch (e) {
      console.error('admin_login.jsp React 렌더링 오류:', e);
    }
  </script>
</body>
</html>