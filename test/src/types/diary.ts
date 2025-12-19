export type DiaryType = 'lucky' | 'gratitude' | 'reflection' | 'quote';

export interface Diary {
  id: string;
  type: DiaryType;
  title: string;
  content: string;
  date: Date;
  author?: string;
}

export const diaryConfig: Record<
  DiaryType,
  {
    label: string;
    color: string;
    bgColor: string;
    borderColor: string;
    hoverColor: string;
  }
> = {
  lucky: {
    label: '행운일기',
    color: 'text-green-700',
    bgColor: 'bg-green-100',
    borderColor: 'border-green-300',
    hoverColor: 'hover:bg-green-200',
  },
  gratitude: {
    label: '감사일기',
    color: 'text-blue-700',
    bgColor: 'bg-blue-100',
    borderColor: 'border-blue-300',
    hoverColor: 'hover:bg-blue-200',
  },
  reflection: {
    label: '성찰일기',
    color: 'text-yellow-700',
    bgColor: 'bg-yellow-100',
    borderColor: 'border-yellow-300',
    hoverColor: 'hover:bg-yellow-200',
  },
  quote: {
    label: '명언일기',
    color: 'text-purple-700',
    bgColor: 'bg-purple-100',
    borderColor: 'border-purple-300',
    hoverColor: 'hover:bg-purple-200',
  },
};
