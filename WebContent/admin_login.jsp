<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<jsp:include page="header.jsp">
  <jsp:param name="pageTitle" value="관리자 로그인" />
</jsp:include>
<body>
  <div id="root"></div>
  <script type="text/babel">
    console.log('admin_login.jsp 스크립트 시작');

    let errorMessage = <%= session.getAttribute("error") != null ? "\"" + session.getAttribute("error").toString().replace("\"", "\\\"") + "\"" : "null" %>;
    console.log('errorMessage:', errorMessage);

    <% session.removeAttribute("error"); %>

    function LoginModal() {
      return (
        <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50">
          <div className="bg-white rounded-lg shadow-xl w-full max-w-md relative">
            <a
              href="/BroadcastingClub/index.jsp"
              className="absolute top-3 right-3 text-gray-500 hover:text-gray-700"
              onClick={() => console.log('X 버튼 클릭됨')}
            >
              <svg className="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M6 18L18 6M6 6l12 12" />
              </svg>
            </a>
            <div className="p-6">
              <h2 className="text-2xl font-bold text-center text-gray-800 mb-6">관리자 로그인</h2>
              <form action="/BroadcastingClub/login_result.jsp" method="POST">
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