import svgPaths from "./svg-7rwxdjq856";

function Header() {
  return (
    <div
      className="h-[16.2px] relative shrink-0 w-[96.548px]"
      data-name="Header"
    >
      <svg
        className="block size-full"
        fill="none"
        preserveAspectRatio="none"
        viewBox="0 0 97 17"
      >
        <g clipPath="url(#clip0_4003_58)" id="Header">
          <g id="Â©Alex Carter">
            <path d={svgPaths.p1fa38d80} fill="var(--fill-0, white)" />
            <path d={svgPaths.p3a03c380} fill="var(--fill-0, white)" />
            <path d={svgPaths.p3b3be180} fill="var(--fill-0, white)" />
            <path d={svgPaths.p11e53400} fill="var(--fill-0, white)" />
            <path d={svgPaths.p2daab400} fill="var(--fill-0, white)" />
            <path d={svgPaths.p79eff00} fill="var(--fill-0, white)" />
            <path d={svgPaths.p1a4e1800} fill="var(--fill-0, white)" />
            <path d={svgPaths.p1d6fb800} fill="var(--fill-0, white)" />
            <path d={svgPaths.p3be1bc00} fill="var(--fill-0, white)" />
            <path d={svgPaths.p190ce1c0} fill="var(--fill-0, white)" />
            <path d={svgPaths.p39656d00} fill="var(--fill-0, white)" />
          </g>
        </g>
        <defs>
          <clipPath id="clip0_4003_58">
            <rect fill="white" height="16.2" width="96.5483" />
          </clipPath>
        </defs>
      </svg>
    </div>
  );
}

function Frame2147241569() {
  return (
    <div className="box-border content-stretch flex flex-row font-['Manrope:Bold',_sans-serif] font-bold gap-8 items-center justify-start leading-[0] p-0 relative shrink-0 text-[#ffffff] text-[16px] text-left text-nowrap tracking-[-0.96px] antialiased">
      <div className="relative shrink-0">
        <p className="adjustLetterSpacing block leading-[1.2] text-nowrap whitespace-pre antialiased">
          About
        </p>
      </div>
      <div className="relative shrink-0">
        <p className="adjustLetterSpacing block leading-[1.2] text-nowrap whitespace-pre antialiased">
          Work
        </p>
      </div>
      <div className="relative shrink-0">
        <p className="adjustLetterSpacing block leading-[1.2] text-nowrap whitespace-pre antialiased">
          Contact
        </p>
      </div>
    </div>
  );
}

function Frame2147241568() {
  return (
    <div className="basis-0 box-border content-stretch flex flex-row grow items-center justify-between min-h-px min-w-px p-0 relative shrink-0">
      <Header />
      <Frame2147241569 />
    </div>
  );
}

export default function Nav() {
  return (
    <div className="bg-[#000000] relative size-full" data-name="Nav">
      <div className="flex flex-row justify-center relative size-full">
        <div className="box-border content-stretch flex flex-row gap-4 items-start justify-center p-[16px] relative size-full">
          <Frame2147241568 />
        </div>
      </div>
    </div>
  );
}