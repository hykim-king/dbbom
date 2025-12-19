import { Edit2, Calendar as CalendarIcon } from 'lucide-react';
import type { Diary } from '../types/diary';
import { diaryConfig } from '../types/diary';

interface DiaryPanelProps {
  selectedDate: Date | null;
  diaries: Diary[];
  onEditDiary: (diary: Diary) => void;
}

export function DiaryPanel({ selectedDate, diaries, onEditDiary }: DiaryPanelProps) {
  const formatDate = (date: Date) => {
    const year = date.getFullYear();
    const month = String(date.getMonth() + 1).padStart(2, '0');
    const day = String(date.getDate()).padStart(2, '0');
    const dayNames = ['일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일'];
    return `${year}.${month}.${day} ${dayNames[date.getDay()]}`;
  };

  if (!selectedDate) {
    return (
      <div className="bg-white rounded-2xl shadow-lg p-8 h-full flex flex-col items-center justify-center text-center">
        <CalendarIcon className="w-16 h-16 text-slate-300 mb-4" />
        <p className="text-slate-400 mb-2">날짜를 선택해주세요</p>
        <p className="text-slate-300">
          캘린더에서 날짜를 클릭하면
          <br />
          작성한 일기를 확인할 수 있습니다
        </p>
      </div>
    );
  }

  return (
    <div className="bg-white rounded-2xl shadow-lg p-6 h-full flex flex-col">
      <div className="mb-6 pb-4 border-b border-slate-200">
        <h3 className="text-slate-900 mb-1">
          {formatDate(selectedDate)}
        </h3>
        <p className="text-slate-500">
          {diaries.length > 0 ? `${diaries.length}개의 일기` : '작성된 일기가 없습니다'}
        </p>
      </div>

      <div className="flex-1 overflow-y-auto space-y-3 pr-2">
        {diaries.length > 0 ? (
          diaries.map((diary) => {
            const config = diaryConfig[diary.type];
            return (
              <div
                key={diary.id}
                className={`${config.bgColor} ${config.borderColor} border-2 rounded-xl p-4 transition-all hover:shadow-md group`}
              >
                <div className="flex items-start justify-between mb-3">
                  <div>
                    <span className={`inline-block px-3 py-1 rounded-full ${config.color} bg-white/60 mb-2`}>
                      {config.label}
                    </span>
                    <h4 className="text-slate-900">{diary.title}</h4>
                  </div>
                  <button
                    onClick={() => onEditDiary(diary)}
                    className={`p-2 rounded-lg bg-white/60 ${config.hoverColor} transition-all opacity-0 group-hover:opacity-100`}
                    title="일기 수정"
                  >
                    <Edit2 className="w-4 h-4 text-slate-600" />
                  </button>
                </div>
                
                <p className="text-slate-700 leading-relaxed mb-2">
                  {diary.content}
                </p>
                
                {diary.author && (
                  <p className="text-slate-500 italic mt-3 pt-3 border-t border-white/50">
                    — {diary.author}
                  </p>
                )}
              </div>
            );
          })
        ) : (
          <div className="text-center py-12 text-slate-400">
            <p>이 날짜에 작성된 일기가 없습니다</p>
            <p className="mt-2">일기를 작성해보세요!</p>
          </div>
        )}
      </div>
    </div>
  );
}
