import { BookOpen, Heart, Sparkles, Sun, Calendar, Bell, MessageSquare, User, LogIn, UserPlus } from 'lucide-react';

export function MainPage() {
  return (
    <div className="min-h-screen bg-amber-50/30">
      {/* 상단 네비게이션 */}
      <header className="bg-white border-b border-amber-200 shadow-sm">
        <div className="max-w-7xl mx-auto px-6 py-4">
          <div className="flex items-center justify-between">
            {/* 로고/홈 버튼 */}
            <button className="px-6 py-2.5 bg-gradient-to-r from-amber-400 to-yellow-400 hover:from-amber-500 hover:to-yellow-500 text-amber-900 rounded-lg transition-all shadow-md hover:shadow-lg">
              내면의 흔적
            </button>

            {/* 로그인 버튼 */}
            <div className="flex items-center gap-3">
              <button className="px-6 py-2.5 bg-amber-300 hover:bg-amber-400 text-amber-900 rounded-lg transition-all shadow-sm hover:shadow-md">
                로그인
              </button>
            </div>
          </div>
        </div>
      </header>

      {/* 메뉴 바 */}
      <nav className="bg-gradient-to-r from-amber-300 via-yellow-300 to-amber-300 border-b border-amber-400">
        <div className="max-w-7xl mx-auto px-6 py-4">
          <div className="flex items-center justify-center gap-8">
            <button className="px-6 py-2 text-amber-900 hover:bg-amber-200/50 rounded-lg transition-colors">
              메뉴
            </button>
            <button className="px-6 py-2 text-amber-900 hover:bg-amber-200/50 rounded-lg transition-colors">
              개요
            </button>
            <button className="px-6 py-2 text-amber-900 hover:bg-amber-200/50 rounded-lg transition-colors">
              공지사항
            </button>
            <button className="px-6 py-2 text-amber-900 hover:bg-amber-200/50 rounded-lg transition-colors">
              게시판
            </button>
          </div>
        </div>
      </nav>

      {/* 메인 컨텐츠 */}
      <main className="max-w-7xl mx-auto px-6 py-8">
        {/* 슬로건 섹션 */}
        <section className="mb-8 bg-white rounded-2xl border-2 border-amber-200 shadow-md p-8 text-center">
          <h2 className="text-amber-900 mb-2">오늘의 위로를 내일의 너에게</h2>
          <p className="text-amber-700">당신의 이야기를 기록해보세요</p>
        </section>

        {/* 일기 타입 선택 섹션 */}
        <section className="mb-12">
          <div className="grid grid-cols-1 md:grid-cols-4 gap-6">
            {/* 명언일기 */}
            <div className="bg-white rounded-xl border-2 border-purple-300 hover:border-purple-400 hover:shadow-xl transition-all cursor-pointer overflow-hidden group">
              <div className="bg-purple-200 p-6 text-center group-hover:bg-purple-300 transition-colors">
                <div className="w-16 h-16 bg-purple-500 rounded-full flex items-center justify-center mx-auto mb-3 group-hover:scale-110 transition-transform">
                  <BookOpen className="w-8 h-8 text-white" />
                </div>
                <h3 className="text-purple-900">명언일기</h3>
              </div>
              <div className="p-4 bg-purple-50 text-center">
                <p className="text-purple-700">영감을 주는 명언과 함께</p>
              </div>
            </div>

            {/* 행운일기 */}
            <div className="bg-white rounded-xl border-2 border-green-300 hover:border-green-400 hover:shadow-xl transition-all cursor-pointer overflow-hidden group">
              <div className="bg-green-200 p-6 text-center group-hover:bg-green-300 transition-colors">
                <div className="w-16 h-16 bg-green-500 rounded-full flex items-center justify-center mx-auto mb-3 group-hover:scale-110 transition-transform">
                  <Sparkles className="w-8 h-8 text-white" />
                </div>
                <h3 className="text-green-900">행운일기</h3>
              </div>
              <div className="p-4 bg-green-50 text-center">
                <p className="text-green-700">오늘의 행운을 기록하세요</p>
              </div>
            </div>

            {/* 감사일기 */}
            <div className="bg-white rounded-xl border-2 border-blue-300 hover:border-blue-400 hover:shadow-xl transition-all cursor-pointer overflow-hidden group">
              <div className="bg-blue-200 p-6 text-center group-hover:bg-blue-300 transition-colors">
                <div className="w-16 h-16 bg-blue-500 rounded-full flex items-center justify-center mx-auto mb-3 group-hover:scale-110 transition-transform">
                  <Heart className="w-8 h-8 text-white" />
                </div>
                <h3 className="text-blue-900">감사일기</h3>
              </div>
              <div className="p-4 bg-blue-50 text-center">
                <p className="text-blue-700">감사한 순간을 담아보세요</p>
              </div>
            </div>

            {/* 성찰일기 */}
            <div className="bg-white rounded-xl border-2 border-yellow-300 hover:border-yellow-400 hover:shadow-xl transition-all cursor-pointer overflow-hidden group">
              <div className="bg-yellow-200 p-6 text-center group-hover:bg-yellow-300 transition-colors">
                <div className="w-16 h-16 bg-yellow-500 rounded-full flex items-center justify-center mx-auto mb-3 group-hover:scale-110 transition-transform">
                  <Sun className="w-8 h-8 text-white" />
                </div>
                <h3 className="text-yellow-900">성찰일기</h3>
              </div>
              <div className="p-4 bg-yellow-50 text-center">
                <p className="text-yellow-700">나를 돌아보는 시간</p>
              </div>
            </div>
          </div>
        </section>

        {/* 일기 게시글 섹션 */}
        <section>
          <div className="bg-white rounded-xl border-2 border-amber-200 shadow-md overflow-hidden">
            {/* 섹션 헤더 */}
            <div className="bg-amber-100 px-6 py-4 border-b border-amber-200">
              <h2 className="text-amber-900">일기 게시글</h2>
            </div>

            {/* 게시글 목록 */}
            <div className="p-6">
              <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
                {/* 일기 공개 일기 1 */}
                <div className="bg-white rounded-lg border-2 border-purple-200 hover:border-purple-300 hover:shadow-lg transition-all cursor-pointer overflow-hidden">
                  <div className="bg-purple-100 px-4 py-3 border-b border-purple-200">
                    <h3 className="text-purple-900">일기 공개 일기1</h3>
                  </div>
                  <div className="p-4 space-y-2">
                    <div className="flex items-center justify-between">
                      <span className="text-slate-600">타입:</span>
                      <span className="px-3 py-1 bg-purple-200 text-purple-800 rounded-full">명언</span>
                    </div>
                    <div className="flex items-center justify-between">
                      <span className="text-slate-600">감정:</span>
                      <span className="text-slate-700">평온</span>
                    </div>
                    <div className="pt-2 border-t border-purple-100">
                      <p className="text-slate-500">2024.11.20</p>
                    </div>
                  </div>
                </div>

                {/* 일기 공개 일기 2 */}
                <div className="bg-white rounded-lg border-2 border-blue-200 hover:border-blue-300 hover:shadow-lg transition-all cursor-pointer overflow-hidden">
                  <div className="bg-blue-100 px-4 py-3 border-b border-blue-200">
                    <h3 className="text-blue-900">일기 공개 일기2</h3>
                  </div>
                  <div className="p-4 space-y-2">
                    <div className="flex items-center justify-between">
                      <span className="text-slate-600">타입:</span>
                      <span className="px-3 py-1 bg-blue-200 text-blue-800 rounded-full">감사</span>
                    </div>
                    <div className="flex items-center justify-between">
                      <span className="text-slate-600">감정:</span>
                      <span className="text-slate-700">행복</span>
                    </div>
                    <div className="pt-2 border-t border-blue-100">
                      <p className="text-slate-500">2024.11.19</p>
                    </div>
                  </div>
                </div>

                {/* 일기 공개 일기 3 */}
                <div className="bg-white rounded-lg border-2 border-green-200 hover:border-green-300 hover:shadow-lg transition-all cursor-pointer overflow-hidden">
                  <div className="bg-green-100 px-4 py-3 border-b border-green-200">
                    <h3 className="text-green-900">일기 공개 일기3</h3>
                  </div>
                  <div className="p-4 space-y-2">
                    <div className="flex items-center justify-between">
                      <span className="text-slate-600">타입:</span>
                      <span className="px-3 py-1 bg-green-200 text-green-800 rounded-full">행운</span>
                    </div>
                    <div className="flex items-center justify-between">
                      <span className="text-slate-600">감정:</span>
                      <span className="text-slate-700">설렘</span>
                    </div>
                    <div className="pt-2 border-t border-green-100">
                      <p className="text-slate-500">2024.11.18</p>
                    </div>
                  </div>
                </div>
              </div>

              {/* 더보기 버튼 */}
              <div className="mt-8 text-center">
                <button className="px-8 py-3 bg-gradient-to-r from-amber-400 to-yellow-400 hover:from-amber-500 hover:to-yellow-500 text-amber-900 rounded-lg transition-all shadow-md hover:shadow-lg">
                  더 많은 일기 보기
                </button>
              </div>
            </div>
          </div>
        </section>
      </main>

      {/* 푸터 */}
      <footer className="mt-16 bg-white border-t border-amber-200">
        <div className="max-w-7xl mx-auto px-6 py-8 text-center text-amber-700">
          <p>© 2024 오늘의 위로를 내일의 너에게. All rights reserved.</p>
        </div>
      </footer>
    </div>
  );
}