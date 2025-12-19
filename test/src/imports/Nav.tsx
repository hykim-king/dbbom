import svgPaths from "./svg-hzhp63opm2";

function Header() {
  return (
    <div
      className="h-[18.714px] relative shrink-0 w-[111.529px]"
      data-name="Header"
    >
      <svg
        className="block size-full"
        fill="none"
        preserveAspectRatio="none"
        viewBox="0 0 112 19"
      >
        <g clipPath="url(#clip0_4003_19)" id="Header">
          <g id="Â©Alex Carter">
            <path d={svgPaths.p3b8ca980} fill="var(--fill-0, black)" />
            <path d={svgPaths.p1d678eb2} fill="var(--fill-0, black)" />
            <path d={svgPaths.p1c607b80} fill="var(--fill-0, black)" />
            <path d={svgPaths.p2803fb00} fill="var(--fill-0, black)" />
            <path d={svgPaths.p3946c080} fill="var(--fill-0, black)" />
            <path d={svgPaths.p2104c9c0} fill="var(--fill-0, black)" />
            <path d={svgPaths.p34456280} fill="var(--fill-0, black)" />
            <path d={svgPaths.p2ae6e900} fill="var(--fill-0, black)" />
            <path d={svgPaths.p3b181700} fill="var(--fill-0, black)" />
            <path d={svgPaths.p3ca04800} fill="var(--fill-0, black)" />
            <path d={svgPaths.p123cc800} fill="var(--fill-0, black)" />
          </g>
        </g>
        <defs>
          <clipPath id="clip0_4003_19">
            <rect fill="white" height="18.7136" width="111.529" />
          </clipPath>
        </defs>
      </svg>
    </div>
  );
}

function Frame2147241569() {
  return (
    <div className="box-border content-stretch flex flex-row font-['Manrope:Bold',_sans-serif] font-bold gap-8 items-center justify-start leading-[0] p-0 relative shrink-0 text-[#000000] text-[16px] text-left text-nowrap tracking-[-0.96px]">
      <div className="relative shrink-0">
        <p className="adjustLetterSpacing block leading-[1.2] text-nowrap whitespace-pre">
          About
        </p>
      </div>
      <div className="relative shrink-0">
        <p className="adjustLetterSpacing block leading-[1.2] text-nowrap whitespace-pre">
          Work
        </p>
      </div>
      <div className="relative shrink-0">
        <p className="adjustLetterSpacing block leading-[1.2] text-nowrap whitespace-pre">
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
    <div className="bg-[#c4baff] relative size-full" data-name="Nav">
      <div className="flex flex-row justify-center relative size-full">
        <div className="box-border content-stretch flex flex-row gap-4 items-start justify-center relative size-full">
          <Frame2147241568 />
        </div>
      </div>
    </div>
  );
}