import { ChevronLeft, ChevronRight } from 'lucide-react';
import { useState } from 'react';
import type { Diary } from '../types/diary';

interface CalendarProps {
  diaries: Diary[];
  selectedDate: Date | null;
  onDateSelect: (date: Date) => void;
}

export function Calendar({ diaries, selectedDate, onDateSelect }: CalendarProps) {
  const [currentMonth, setCurrentMonth] = useState(new Date());

  const daysInMonth = new Date(
    currentMonth.getFullYear(),
    currentMonth.getMonth() + 1,
    0
  ).getDate();

  const firstDayOfMonth = new Date(
    currentMonth.getFullYear(),
    currentMonth.getMonth(),
    1
  ).getDay();

  const monthNames = [
    '1월', '2월', '3월', '4월', '5월', '6월',
    '7월', '8월', '9월', '10월', '11월', '12월'
  ];

  const dayNames = ['일', '월', '화', '수', '목', '금', '토'];

  const previousMonth = () => {
    setCurrentMonth(new Date(currentMonth.getFullYear(), currentMonth.getMonth() - 1));
  };

  const nextMonth = () => {
    setCurrentMonth(new Date(currentMonth.getFullYear(), currentMonth.getMonth() + 1));
  };

  const isSelectedDate = (day: number) => {
    if (!selectedDate) return false;
    return (
      selectedDate.getDate() === day &&
      selectedDate.getMonth() === currentMonth.getMonth() &&
      selectedDate.getFullYear() === currentMonth.getFullYear()
    );
  };

  const getDiariesForDate = (day: number) => {
    const dateToCheck = new Date(
      currentMonth.getFullYear(),
      currentMonth.getMonth(),
      day
    );
    return diaries.filter(
      (d) =>
        d.date.getDate() === dateToCheck.getDate() &&
        d.date.getMonth() === dateToCheck.getMonth() &&
        d.date.getFullYear() === dateToCheck.getFullYear()
    );
  };

  const handleDateClick = (day: number) => {
    const newDate = new Date(
      currentMonth.getFullYear(),
      currentMonth.getMonth(),
      day
    );
    onDateSelect(newDate);
  };

  const isToday = (day: number) => {
    const today = new Date();
    return (
      today.getDate() === day &&
      today.getMonth() === currentMonth.getMonth() &&
      today.getFullYear() === currentMonth.getFullYear()
    );
  };

  return (
    <div className="bg-white rounded-2xl shadow-lg p-8">
      <div className="flex items-center justify-between mb-8">
        <h2 className="text-slate-900">
          {currentMonth.getFullYear()}년 {monthNames[currentMonth.getMonth()]}
        </h2>
        <div className="flex gap-2">
          <button
            onClick={previousMonth}
            className="p-2 hover:bg-slate-100 rounded-lg transition-colors"
          >
            <ChevronLeft className="w-5 h-5 text-slate-600" />
          </button>
          <button
            onClick={nextMonth}
            className="p-2 hover:bg-slate-100 rounded-lg transition-colors"
          >
            <ChevronRight className="w-5 h-5 text-slate-600" />
          </button>
        </div>
      </div>

      <div className="grid grid-cols-7 gap-3">
        {dayNames.map((day, index) => (
          <div
            key={day}
            className={`text-center py-3 ${
              index === 0 ? 'text-red-500' : index === 6 ? 'text-blue-500' : 'text-slate-500'
            }`}
          >
            {day}
          </div>
        ))}

        {Array.from({ length: firstDayOfMonth }).map((_, index) => (
          <div key={`empty-${index}`} />
        ))}

        {Array.from({ length: daysInMonth }).map((_, index) => {
          const day = index + 1;
          const dayDiaries = getDiariesForDate(day);
          const hasDiaries = dayDiaries.length > 0;
          const selected = isSelectedDate(day);
          const today = isToday(day);

          return (
            <button
              key={day}
              onClick={() => handleDateClick(day)}
              className={`
                relative aspect-square rounded-xl transition-all p-2
                ${
                  selected
                    ? 'bg-indigo-600 text-white shadow-lg scale-105 ring-2 ring-indigo-300'
                    : hasDiaries
                    ? 'bg-slate-50 text-slate-800 hover:bg-slate-100 border-2 border-slate-200'
                    : 'text-slate-400 hover:bg-slate-50'
                }
                ${today && !selected ? 'ring-2 ring-indigo-200' : ''}
              `}
            >
              <span className="block mb-1">{day}</span>
              
              {hasDiaries && (
                <div className="absolute bottom-1 left-1/2 -translate-x-1/2 flex gap-0.5 flex-wrap justify-center max-w-full px-1">
                  {dayDiaries.map((diary) => (
                    <div
                      key={diary.id}
                      className={`w-1.5 h-1.5 rounded-full ${
                        selected ? 'bg-white/80' :
                        diary.type === 'lucky'
                          ? 'bg-green-500'
                          : diary.type === 'gratitude'
                          ? 'bg-blue-500'
                          : diary.type === 'quote'
                          ? 'bg-purple-500'
                          : 'bg-yellow-500'
                      }`}
                    />
                  ))}
                </div>
              )}
            </button>
          );
        })}
      </div>

      <div className="mt-8 pt-6 border-t border-slate-200">
        <div className="flex flex-wrap gap-4 justify-center">
          <div className="flex items-center gap-2">
            <div className="w-3 h-3 rounded-full bg-green-500" />
            <span className="text-slate-600">행운일기</span>
          </div>
          <div className="flex items-center gap-2">
            <div className="w-3 h-3 rounded-full bg-blue-500" />
            <span className="text-slate-600">감사일기</span>
          </div>
          <div className="flex items-center gap-2">
            <div className="w-3 h-3 rounded-full bg-purple-500" />
            <span className="text-slate-600">명언일기</span>
          </div>
          <div className="flex items-center gap-2">
            <div className="w-3 h-3 rounded-full bg-yellow-500" />
            <span className="text-slate-600">성찰일기</span>
          </div>
        </div>
      </div>
    </div>
  );
}
