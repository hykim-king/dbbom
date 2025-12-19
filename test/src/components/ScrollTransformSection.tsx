import { useEffect, useRef, useCallback } from 'react';

interface ScrollTransformSectionProps {
  children?: React.ReactNode;
  fullHeight: number;
  collapsedHeight: number;
  className?: string;
  backgroundColor?: string;
  sectionIndex?: number;
}

export function ScrollTransformSection({ 
  children, 
  fullHeight, 
  collapsedHeight, 
  className = "",
  backgroundColor,
  sectionIndex = 1
}: ScrollTransformSectionProps) {
  const containerRef = useRef<HTMLDivElement>(null);
  const contentRef = useRef<HTMLDivElement>(null);
  const rafId = useRef<number>();
  const lastProgress = useRef(0);

  const updateHeight = useCallback(() => {
    if (!containerRef.current || !contentRef.current) return;
    
    const scrollContainer = document.getElementById('scroll-container');
    if (!scrollContainer) return;

    const containerRect = scrollContainer.getBoundingClientRect();
    const sectionRect = containerRef.current.getBoundingClientRect();
    
    // Calculate the top of the section relative to the scroll container
    const sectionTop = sectionRect.top - containerRect.top;
    
    // Progress from 0 (section top at container top) to 1 (section completely past)
    let progress = 0;
    
    if (sectionTop <= 0) {
      // Section has started scrolling past the top
      const scrolledAmount = Math.abs(sectionTop);
      // Progress reaches 100% when we've scrolled by the full height
      progress = Math.min(scrolledAmount / fullHeight, 1);
    }

    // Only update if progress has changed significantly (reduces unnecessary updates)
    if (Math.abs(progress - lastProgress.current) > 0.001) {
      lastProgress.current = progress;
      
      // Calculate height based on scroll progress
      const currentHeight = Math.max(fullHeight * (1 - progress), 0);
      
      // Use transform for better performance, but fall back to height for layout
      contentRef.current.style.height = `${currentHeight}px`;
      
      // Manage sticky positioning
      if (progress > 0 && progress < 1) {
        contentRef.current.style.position = 'sticky';
        contentRef.current.style.top = '0px';
        contentRef.current.style.zIndex = '10';
      } else {
        contentRef.current.style.position = 'static';
        contentRef.current.style.zIndex = 'auto';
      }
    }
  }, [fullHeight]);

  const handleScroll = useCallback(() => {
    if (rafId.current) {
      cancelAnimationFrame(rafId.current);
    }
    
    rafId.current = requestAnimationFrame(updateHeight);
  }, [updateHeight]);

  useEffect(() => {
    const scrollContainer = document.getElementById('scroll-container');
    
    if (scrollContainer) {
      scrollContainer.addEventListener('scroll', handleScroll, { passive: true });
      // Initial calculation
      handleScroll();
      
      return () => {
        scrollContainer.removeEventListener('scroll', handleScroll);
        if (rafId.current) {
          cancelAnimationFrame(rafId.current);
        }
      };
    }
  }, [handleScroll]);

  return (
    <div 
      ref={containerRef}
      className={`w-full shrink-0 block ${className}`}
      style={{ 
        height: `${fullHeight}px`, 
        margin: 0, 
        padding: 0,
        lineHeight: 0,
        fontSize: 0,
        border: 'none',
        outline: 'none'
      }}
    >
      <div
        ref={contentRef}
        className="w-full overflow-hidden block"
        style={{ 
          backgroundColor,
          height: `${fullHeight}px`,
          margin: 0,
          padding: 0,
          lineHeight: 0,
          fontSize: 0,
          border: 'none',
          outline: 'none',
          willChange: 'height, transform'
        }}
      >
        <div 
          className="w-full h-full block" 
          style={{ 
            margin: 0, 
            padding: 0,
            lineHeight: 0,
            fontSize: 0,
            border: 'none',
            outline: 'none'
          }}
        >
          {children}
        </div>
      </div>
    </div>
  );
}