import { useState } from 'react';
import { X, Save } from 'lucide-react';
import type { Diary } from '../types/diary';
import { diaryConfig } from '../types/diary';

interface EditDiaryModalProps {
  diary: Diary;
  onSave: (diary: Diary) => void;
  onClose: () => void;
}

export function EditDiaryModal({ diary, onSave, onClose }: EditDiaryModalProps) {
  const [title, setTitle] = useState(diary.title);
  const [content, setContent] = useState(diary.content);
  const [author, setAuthor] = useState(diary.author || '');

  const config = diaryConfig[diary.type];

  const handleSave = () => {
    if (!title.trim() || !content.trim()) {
      alert('제목과 내용을 모두 입력해주세요.');
      return;
    }

    onSave({
      ...diary,
      title: title.trim(),
      content: content.trim(),
      author: author.trim() || undefined,
    });
  };

  const handleBackdropClick = (e: React.MouseEvent) => {
    if (e.target === e.currentTarget) {
      onClose();
    }
  };

  return (
    <div
      className="fixed inset-0 bg-black/50 backdrop-blur-sm flex items-center justify-center p-4 z-50"
      onClick={handleBackdropClick}
    >
      <div className="bg-white rounded-2xl shadow-2xl max-w-2xl w-full max-h-[90vh] overflow-y-auto">
        <div className={`${config.bgColor} ${config.borderColor} border-b-4 p-6 flex items-center justify-between sticky top-0`}>
          <div>
            <span className={`inline-block px-3 py-1 rounded-full ${config.color} bg-white/60 mb-2`}>
              {config.label}
            </span>
            <h2 className="text-slate-900">일기 수정</h2>
          </div>
          <button
            onClick={onClose}
            className="p-2 hover:bg-white/50 rounded-lg transition-colors"
          >
            <X className="w-6 h-6 text-slate-600" />
          </button>
        </div>

        <div className="p-6 space-y-6">
          <div>
            <label className="block text-slate-700 mb-2">
              제목
            </label>
            <input
              type="text"
              value={title}
              onChange={(e) => setTitle(e.target.value)}
              className="w-full px-4 py-3 border-2 border-slate-200 rounded-xl focus:outline-none focus:border-indigo-400 transition-colors"
              placeholder="일기 제목을 입력하세요"
            />
          </div>

          <div>
            <label className="block text-slate-700 mb-2">
              내용
            </label>
            <textarea
              value={content}
              onChange={(e) => setContent(e.target.value)}
              rows={8}
              className="w-full px-4 py-3 border-2 border-slate-200 rounded-xl focus:outline-none focus:border-indigo-400 transition-colors resize-none"
              placeholder="일기 내용을 입력하세요"
            />
          </div>

          {diary.type === 'quote' && (
            <div>
              <label className="block text-slate-700 mb-2">
                작가 (선택사항)
              </label>
              <input
                type="text"
                value={author}
                onChange={(e) => setAuthor(e.target.value)}
                className="w-full px-4 py-3 border-2 border-slate-200 rounded-xl focus:outline-none focus:border-indigo-400 transition-colors"
                placeholder="명언의 작가를 입력하세요"
              />
            </div>
          )}

          <div className="flex gap-3 pt-4">
            <button
              onClick={handleSave}
              className="flex-1 flex items-center justify-center gap-2 px-6 py-3 bg-indigo-600 hover:bg-indigo-700 text-white rounded-xl transition-colors"
            >
              <Save className="w-5 h-5" />
              저장하기
            </button>
            <button
              onClick={onClose}
              className="px-6 py-3 bg-slate-200 hover:bg-slate-300 text-slate-700 rounded-xl transition-colors"
            >
              취소
            </button>
          </div>
        </div>
      </div>
    </div>
  );
}
