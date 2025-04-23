<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>방송부</title>
  <script src="https://unpkg.com/react@18/umd/react.development.js"></script>
  <script src="https://unpkg.com/react-dom@18/umd/react-dom.development.js"></script>
  <script src="https://unpkg.com/@babel/standalone/babel.min.js"></script>
  <script src="https://cdn.tailwindcss.com"></script>
  <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap" rel="stylesheet">
  <style>
    body { font-family: 'Noto Sans KR', sans-serif; margin: 0; }
    .banner { background: url('https://picsum.photos/1920/600') no-repeat center/cover; }
  </style>
</head>
<body>
  <jsp:include page="header.jsp" />
  <div id="root"></div>
  <script type="text/babel">
    console.log('index.jsp 스크립트 시작');

    function Banner() {
      return (
        <section id="home" className="banner h-96 flex items-center justify-center text-white">
          <div className="text-center">
            <h2 className="text-4xl font-bold mb-4">방송부에 오신 것을 환영합니다!</h2>
            <p className="text-lg">학교의 소식을 생생하게 전달하는 방송부입니다.</p>
          </div>
        </section>
      );
    }

    function About() {
      return (
        <section id="about" className="py-16">
          <div className="container mx-auto px-4">
            <h2 className="text-3xl font-bold mb-8 text-center">소개</h2>
            <div className="flex flex-col md:flex-row gap-8 max-w-3xl mx-auto">
              <div className="flex-1">
                <p className="text-lg text-gray-700">
                  방송부는 학교의 다양한 소식과 이벤트를 학생들에게 전달하는 역할을 합니다. 
                  매일 아침 방송을 통해 최신 공지사항과 재미있는 콘텐츠를 제공합니다.
                </p>
              </div>
              <div className="md:w-1/3">
                <div className="bg-gray-50 p-4 rounded-lg border border-gray-200 shadow-sm">
                  <h3 className="text-lg font-semibold text-gray-800 mb-3">활동시간</h3>
                  <ul className="text-gray-600 space-y-2">
                    <li>🕐 정규 활동: 화 목 점심 13:20-13:45 (점심 방송)</li>
                    <li>🕐 부서 회의: 수요일 동아리 시간</li>
                    <li>🕐 특별 활동: 학교 행사, 방송 테스트</li>
                  </ul>
                </div>
              </div>
            </div>
          </div>
        </section>
      );
    }

    function Notices() {
      let notices;
      try {
        notices = <%= request.getAttribute("notices") != null ? request.getAttribute("notices") : "[{title: '2025년 4월 방송부원 모집', content: '4월 20일까지 신청서를 제출해주세요.'}, {title: '봄 축제 방송 일정', content: '5월 10일, 축제 현장을 생중계합니다.'}]" %>;
        console.log('notices:', notices);
      } catch (e) {
        console.error('notices 처리 오류:', e);
        notices = [];
      }
      return (
        <section id="notices" className="py-16 bg-gray-100">
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

    function Programs() {
      return (
        <section id="programs" className="py-16">
          <div className="container mx-auto px-4">
            <h2 className="text-3xl font-bold mb-8 text-center">프로그램</h2>
            <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
              <div className="bg-white p-6 rounded-lg shadow-md">
                <h3 className="text-xl font-semibold mb-4">아침 방송</h3>
                <p className="text-gray-600">매일 아침 8시, 학교 소식과 함께 하루를 시작합니다.</p>
              </div>
              <div className="bg-white p-6 rounded-lg shadow-md">
                <h3 className="text-xl font-semibold mb-4">특별 인터뷰</h3>
                <p className="text-gray-600">학생, 교사와의 인터뷰를 통해 다양한 이야기를 들려드립니다.</p>
              </div>
              <div className="bg-white p-6 rounded-lg shadow-md">
                <h3 className="text-xl font-semibold mb-4">이벤트 중계</h3>
                <p className="text-gray-600">학교 행사를 생생하게 중계하여 모두가 함께 즐깁니다.</p>
              </div>
            </div>
          </div>
        </section>
      );
    }

    function Departments() {
      return (
        <section id="departments" className="py-16 bg-gray-100">
          <div className="container mx-auto px-4">
            <h2 className="text-3xl font-bold mb-8 text-center">부서</h2>
            <ul className="max-w-3xl mx-auto space-y-6">
              <li className="bg-gray-50 p-6 rounded-lg border border-gray-200">
                <h3 className="text-xl font-semibold text-blue-600 mb-2">📋 기획팀</h3>
                <p className="text-gray-600">방송 콘텐츠와 이벤트를 기획하며, 창의적인 아이디어를 제안합니다.</p>
              </li>
              <li className="bg-gray-50 p-6 rounded-lg border border-gray-200">
                <h3 className="text-xl font-semibold text-blue-600 mb-2">🎥 제작팀</h3>
                <p className="text-gray-600">방송 콘텐츠를 촬영하고 편집하여 고품질의 프로그램을 제작합니다.</p>
              </li>
              <li className="bg-gray-50 p-6 rounded-lg border border-gray-200">
                <h3 className="text-xl font-semibold text-blue-600 mb-2">🔧 기술팀</h3>
                <p className="text-gray-600">방송 장비를 관리하고, 원활한 방송 송출을 지원합니다.</p>
              </li>
            </ul>
          </div>
        </section>
      );
    }

    function Contact() {
      return (
        <section id="contact" className="py-16">
          <div className="container mx-auto px-4">
            <h2 className="text-3xl font-bold mb-8 text-center">연락처</h2>
            <p className="text-lg text-gray-700 max-w-3xl mx-auto text-center">
              이메일: broadcast@school.com<br />
              전화: 02-123-4567<br />
              위치: 학교 본관 3층 방송실
            </p>
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
      console.log('index.jsp App 렌더링');
      return (
        <div>
          <Banner />
          <About />
          <Notices />
          <Programs />
          <Departments />
          <Contact />
          <Footer />
          <a
            href="/request-song"
            title="노래 신청"
            className="fixed bottom-4 right-4 sm:bottom-6 sm:right-6 bg-blue-600 text-white w-12 h-12 flex items-center justify-center rounded-full shadow-lg hover:bg-blue-700 transition-colors z-20"
          >
            🎵
          </a>
        </div>
      );
    }

    try {
      const root = ReactDOM.createRoot(document.getElementById('root'));
      root.render(<App />);
      console.log('index.jsp React 렌더링 완료');
    } catch (e) {
      console.error('index.jsp React 렌더링 오류:', e);
    }
  </script>
</body>
</html>