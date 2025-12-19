import { motion } from 'motion/react';

export function OverviewPage() {
  return (
    <div className="min-h-screen bg-white">
      {/* 상단 헤더 */}
      <header className="bg-white border-b border-amber-200 shadow-sm">
        <div className="max-w-7xl mx-auto px-6 py-4">
          <div className="flex items-center justify-between">
            {/* 로고 */}
            <motion.div
              initial={{ opacity: 0, x: -20 }}
              animate={{ opacity: 1, x: 0 }}
              transition={{ duration: 0.6 }}
            >
              <h1 className="text-amber-600">내면의 흔적</h1>
            </motion.div>

            {/* 로그인 버튼 */}
            <motion.button
              initial={{ opacity: 0, x: 20 }}
              animate={{ opacity: 1, x: 0 }}
              transition={{ duration: 0.6 }}
              className="px-6 py-2.5 bg-amber-300 hover:bg-amber-400 text-amber-900 rounded-lg transition-all shadow-sm hover:shadow-md"
            >
              로그인
            </motion.button>
          </div>
        </div>
      </header>

      {/* 메인 히어로 섹션 */}
      <main className="relative min-h-[calc(100vh-200px)] flex items-center justify-center overflow-hidden">
        {/* 배경 이미지 */}
        <div 
          className="absolute inset-0 z-0"
          style={{
            backgroundImage: 'url(https://images.unsplash.com/photo-1759791924131-ccce98a9ade4?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxwZWFjZWZ1bCUyMG1vcm5pbmclMjBsaWdodHxlbnwxfHx8fDE3NjYwNDE4OTh8MA&ixlib=rb-4.1.0&q=80&w=1080&utm_source=figma&utm_medium=referral)',
            backgroundSize: 'cover',
            backgroundPosition: 'center',
            filter: 'brightness(0.95)',
          }}
        />
        
        {/* 그라데이션 오버레이 */}
        <div className="absolute inset-0 bg-gradient-to-b from-white/40 via-amber-50/60 to-white/80 z-0" />

        {/* 콘텐츠 */}
        <div className="relative z-10 max-w-4xl mx-auto px-6 py-16 text-center">
          {/* 메시지 박스 1 */}
          <motion.div
            initial={{ opacity: 0, y: 30 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.8, delay: 0.2 }}
            className="bg-amber-100/90 backdrop-blur-sm rounded-3xl p-12 mb-8 shadow-lg border border-amber-200"
          >
            <p className="text-amber-900 leading-relaxed mb-6 text-xl">
              오늘의 위로를 내일의 너에게 "내 걸음의 방향은 언제나 내가 선택할 수 있다."
            </p>
            <p className="text-amber-800 text-lg">
              "내일의 내가 걱정되시나요?
            </p>
            <p className="text-amber-800 leading-relaxed mt-4">
              하지만 언제 그랬냐는듯 당신은 누구보다 멋지게 해낼 사람입니다.
            </p>
            <p className="text-amber-900 mt-6">
              당신의 이야기를 기록해보세요 "
            </p>
          </motion.div>

          {/* 메시지 박스 2 */}
          <motion.div
            initial={{ opacity: 0, y: 30 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.8, delay: 0.4 }}
            className="bg-amber-100/90 backdrop-blur-sm rounded-3xl p-12 mb-10 shadow-lg border border-amber-200"
          >
            <p className="text-amber-900 leading-relaxed mb-4">
              처음 "내면의 흔적"은 괴롭고,지치고,힘들거나, 또는 행복하고 감사한 일이 있을 때,
            </p>
            <p className="text-amber-900 leading-relaxed mb-4">
              부담없이 찾아와 일기를 작성하며 마음의 안정을 얻을 수 있는 장소 입니다
            </p>
            <p className="text-amber-900 leading-relaxed">
              내 감정의 맛 일기를 작성 해보시고 자유롭게 공유 해보세요.
            </p>
          </motion.div>

          {/* CTA 버튼 */}
          <motion.button
            initial={{ opacity: 0, scale: 0.9 }}
            animate={{ opacity: 1, scale: 1 }}
            transition={{ duration: 0.6, delay: 0.6 }}
            whileHover={{ scale: 1.05 }}
            whileTap={{ scale: 0.95 }}
            className="px-12 py-4 bg-gradient-to-r from-amber-400 to-yellow-400 hover:from-amber-500 hover:to-yellow-500 text-amber-900 rounded-2xl transition-all shadow-lg hover:shadow-xl"
          >
            일기 쓰러 가기
          </motion.button>
        </div>
      </main>

      {/* 푸터 */}
      <footer className="bg-white border-t border-amber-200 py-6">
        <div className="max-w-7xl mx-auto px-6 text-center text-amber-700">
          <p>© 2024 오늘의 위로를 내일의 너에게. All rights reserved.</p>
        </div>
      </footer>
    </div>
  );
}