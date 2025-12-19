import { MessageSquare, Search } from 'lucide-react';
import { useState } from 'react';

const mockPosts = [
  {
    id: 1,
    title: '신규 회원입니다. 잘 부탁드립니다!',
    author: '김철수',
    date: '2024.11.24',
    views: 42,
    comments: 5,
  },
  {
    id: 2,
    title: '12월 모임 장소 추천해주세요',
    author: '이영희',
    date: '2024.11.23',
    views: 67,
    comments: 12,
  },
  {
    id: 3,
    title: '지난주 행사 정말 좋았습니다',
    author: '박민수',
    date: '2024.11.22',
    views: 89,
    comments: 8,
  },
  {
    id: 4,
    title: '회원 혜택 문의드립니다',
    author: '정수진',
    date: '2024.11.21',
    views: 34,
    comments: 3,
  },
  {
    id: 5,
    title: '다음 프로젝트 아이디어 공유',
    author: '최동욱',
    date: '2024.11.20',
    views: 125,
    comments: 15,
  },
];

export function BoardPage() {
  const [searchTerm, setSearchTerm] = useState('');

  const filteredPosts = mockPosts.filter((post) =>
    post.title.toLowerCase().includes(searchTerm.toLowerCase())
  );

  return (
    <div className="bg-gradient-to-br from-slate-50 to-white rounded-2xl p-8 shadow-sm border border-slate-200">
      <div className="flex items-center justify-between mb-6 pb-4 border-b-2 border-slate-200">
        <div className="flex items-center gap-3">
          <MessageSquare className="w-6 h-6 text-slate-600" />
          <h2 className="text-slate-800">게시판</h2>
        </div>
        
        <div className="relative">
          <input
            type="text"
            value={searchTerm}
            onChange={(e) => setSearchTerm(e.target.value)}
            placeholder="게시글 검색..."
            className="pl-10 pr-4 py-2 border-2 border-slate-200 rounded-lg focus:outline-none focus:border-slate-400 transition-colors bg-white"
          />
          <Search className="w-5 h-5 text-slate-400 absolute left-3 top-1/2 -translate-y-1/2" />
        </div>
      </div>

      <div className="mb-4">
        <button className="px-6 py-2 bg-slate-700 hover:bg-slate-800 text-white rounded transition-colors">
          글쓰기
        </button>
      </div>
      
      <div className="overflow-x-auto bg-white rounded-lg border border-slate-200">
        <table className="w-full">
          <thead>
            <tr className="bg-slate-50 border-b-2 border-slate-200">
              <th className="px-4 py-3 text-left text-slate-700">번호</th>
              <th className="px-4 py-3 text-left text-slate-700">제목</th>
              <th className="px-4 py-3 text-left text-slate-700">작성자</th>
              <th className="px-4 py-3 text-left text-slate-700">날짜</th>
              <th className="px-4 py-3 text-center text-slate-700">조회</th>
            </tr>
          </thead>
          <tbody>
            {filteredPosts.map((post) => (
              <tr
                key={post.id}
                className="border-b border-slate-200 hover:bg-slate-50 transition-colors cursor-pointer"
              >
                <td className="px-4 py-3 text-slate-600">{post.id}</td>
                <td className="px-4 py-3">
                  <div className="flex items-center gap-2">
                    <span className="text-slate-800">{post.title}</span>
                    {post.comments > 0 && (
                      <span className="text-slate-600">
                        [{post.comments}]
                      </span>
                    )}
                  </div>
                </td>
                <td className="px-4 py-3 text-slate-600">{post.author}</td>
                <td className="px-4 py-3 text-slate-600">{post.date}</td>
                <td className="px-4 py-3 text-center text-slate-600">{post.views}</td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>

      {filteredPosts.length === 0 && (
        <div className="text-center py-12 text-slate-400">
          검색 결과가 없습니다
        </div>
      )}
    </div>
  );
}