import { LogIn } from 'lucide-react';

export function Header() {
  return (
    <div className="bg-white px-6 py-4 flex justify-between items-center border-b border-slate-200">
      <button className="px-6 py-3 bg-slate-100 hover:bg-slate-200 text-slate-800 rounded transition-colors">
        내맘의 조직
      </button>
      
      <button className="px-6 py-3 bg-slate-100 hover:bg-slate-200 text-slate-800 rounded transition-colors flex items-center gap-2">
        <LogIn className="w-5 h-5" />
        회원가입/로그인
      </button>
    </div>
  );
}