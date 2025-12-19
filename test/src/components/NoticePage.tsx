import { Bell } from 'lucide-react';

const mockNotices = [
  {
    id: 1,
    title: '2024년 1분기 정기 총회 안내',
    date: '2024.11.20',
    author: '관리자',
  },
  {
    id: 2,
    title: '신규 회원 가입 절차 변경 안내',
    date: '2024.11.18',
    author: '관리자',
  },
  {
    id: 3,
    title: '12월 조직 행사 일정 공지',
    date: '2024.11.15',
    author: '관리자',
  },
  {
    id: 4,
    title: '홈페이지 개편 작업 완료',
    date: '2024.11.10',
    author: '관리자',
  },
];

export function NoticePage() {
  return (
    <div className="bg-gradient-to-br from-slate-50 to-white rounded-2xl p-8 shadow-sm border border-slate-200">
      <div className="flex items-center gap-3 mb-6 pb-4 border-b-2 border-slate-200">
        <Bell className="w-6 h-6 text-slate-600" />
        <h2 className="text-slate-800">공지사항</h2>
      </div>
      
      <div className="space-y-3">
        {mockNotices.map((notice) => (
          <div
            key={notice.id}
            className="p-4 bg-white border-2 border-slate-200 rounded-lg hover:border-slate-400 hover:shadow-md transition-all cursor-pointer"
          >
            <div className="flex justify-between items-start">
              <h3 className="text-slate-800 flex-1">{notice.title}</h3>
              <span className="text-slate-500 ml-4">{notice.date}</span>
            </div>
            <p className="text-slate-600 mt-2">작성자: {notice.author}</p>
          </div>
        ))}
      </div>
    </div>
  );
}