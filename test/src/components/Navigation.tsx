import { Menu } from 'lucide-react';

type PageType = 'overview' | 'notice' | 'board';

interface NavigationProps {
  currentPage: PageType;
  onPageChange: (page: PageType) => void;
}

export function Navigation({ currentPage, onPageChange }: NavigationProps) {
  return (
    <div className="bg-white border-b border-slate-200 px-6 py-4 flex items-center gap-4">
      <div className="flex items-center gap-2 text-slate-700">
        <Menu className="w-6 h-6" />
        <span>메뉴</span>
      </div>
      
      <div className="h-6 w-px bg-slate-300" />
      
      <div className="flex gap-6 text-slate-700">
        <button
          onClick={() => onPageChange('overview')}
          className={`hover:text-slate-900 transition-all ${
            currentPage === 'overview' ? 'text-slate-900 underline decoration-2 underline-offset-4' : ''
          }`}
        >
          개요
        </button>
        
        <span className="text-slate-400">/</span>
        
        <button
          onClick={() => onPageChange('notice')}
          className={`hover:text-slate-900 transition-all ${
            currentPage === 'notice' ? 'text-slate-900 underline decoration-2 underline-offset-4' : ''
          }`}
        >
          공지사항
        </button>
        
        <span className="text-slate-400">/</span>
        
        <button
          onClick={() => onPageChange('board')}
          className={`hover:text-slate-900 transition-all ${
            currentPage === 'board' ? 'text-slate-900 underline decoration-2 underline-offset-4' : ''
          }`}
        >
          게시판
        </button>
      </div>
    </div>
  );
}