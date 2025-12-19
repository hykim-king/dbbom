import svgPaths from "./svg-9x3jhbkxsz";
import imgDiv03 from "figma:asset/8d5e804857f89f7ac2c2e979318733a18dc6a0c6.png";
import imgFrame from "figma:asset/67ffee6a770afd75dd77f647bc6983bc1d7bdc7c.png";
import imgDiv01 from "figma:asset/801e68f51207bc90e5f9537ccb20eafdfeb2e3d0.png";
import imgDiv02 from "figma:asset/56b8a2b37184a422dbaa8f404deebf29d6addddb.png";
import imgDiv04 from "figma:asset/a10cb816b29173237f84c1da0aeb7ea8b5e2201f.png";
import imgDiv06 from "figma:asset/56ab794abd105723bbb9790c478779f5eb89dd41.png";
import imgDiv07 from "figma:asset/58ce385940580291c6f347c3a0ae3eb15c70e713.png";
import imgDiv08 from "figma:asset/9e16f51c09dc355118df9cb145554bdd8e0a22e0.png";
import imgDiv09 from "figma:asset/e9cb75a9b35d2dc6ffc3708a57aa8b9746cb7c8d.png";
import imgDiv10 from "figma:asset/30f5237fe8b86e685a5e6ca6dcc0e7a8f3b977b6.png";

function Header() {
  return (
    <div
      className="box-border content-stretch flex flex-col gap-2.5 items-start justify-start overflow-clip px-0 py-2 relative shrink-0 w-full"
      data-name="Header"
    >
      <div
        className="aspect-[530/74] relative shrink-0 w-full"
        data-name="©Alex Carter"
      >
        <svg
          className="block size-full"
          fill="none"
          preserveAspectRatio="none"
          viewBox="0 0 568 80"
        >
          <g id="Â©Alex Carter">
            <path d={svgPaths.p3b1fa400} fill="var(--fill-0, black)" />
            <path d={svgPaths.p339ae500} fill="var(--fill-0, black)" />
            <path d={svgPaths.p39ff6600} fill="var(--fill-0, black)" />
            <path d={svgPaths.p114c6600} fill="var(--fill-0, black)" />
            <path d={svgPaths.p23637380} fill="var(--fill-0, black)" />
            <path d={svgPaths.p38954000} fill="var(--fill-0, black)" />
            <path d={svgPaths.p2c107400} fill="var(--fill-0, black)" />
            <path d={svgPaths.p19cf2700} fill="var(--fill-0, black)" />
            <path d={svgPaths.p21cd3600} fill="var(--fill-0, black)" />
            <path d={svgPaths.p24754100} fill="var(--fill-0, black)" />
            <path d={svgPaths.p3a768380} fill="var(--fill-0, black)" />
          </g>
        </svg>
      </div>
    </div>
  );
}

function Nav() {
  return (
    <div
      className="bg-[#c4baff] box-border content-stretch flex flex-col gap-4 items-start justify-start p-[16px] relative shrink-0 w-[600px]"
      data-name="Nav"
    >
      <Header />
    </div>
  );
}

function Div03() {
  return (
    <div
      className="bg-center bg-cover bg-no-repeat h-[400px] shrink-0 w-[600px]"
      data-name="Div 03"
      style={{ backgroundImage: `url('${imgDiv03}')` }}
    />
  );
}

function Frame2147241479() {
  return (
    <div className="box-border content-stretch flex flex-row gap-[11.312px] items-center justify-end p-0 relative shrink-0 w-full">
      <div className="font-['Manrope:ExtraBold',_sans-serif] font-extrabold leading-[0] relative shrink-0 text-[#000000] text-[66px] text-nowrap text-right tracking-[-3.96px]">
        <p className="adjustLetterSpacing block leading-[1.2] whitespace-pre">
          Commercial
        </p>
      </div>
    </div>
  );
}

function Frame() {
  return (
    <div
      className="basis-0 bg-center bg-cover bg-no-repeat grow min-h-px min-w-px shrink-0 w-full"
      data-name="Frame"
      style={{ backgroundImage: `url('${imgFrame}')` }}
    />
  );
}

function Frame2147241546() {
  return (
    <div className="box-border content-stretch flex flex-col gap-4 h-full items-end justify-start p-0 relative shrink-0 w-[359px]">
      <Frame />
    </div>
  );
}

function Frame2147241481() {
  return (
    <div className="bg-[#c4baff] box-border content-stretch flex flex-row gap-4 h-[312px] items-start justify-end pb-4 pt-0 px-0 relative shrink-0 w-full">
      <Frame2147241546 />
    </div>
  );
}

function Div05() {
  return (
    <div
      className="bg-[#c4baff] box-border content-stretch flex flex-col gap-6 h-[400px] items-start justify-start overflow-clip p-[16px] relative shrink-0 w-[600px]"
      data-name="Div 05"
    >
      <Frame2147241479 />
      <Frame2147241481 />
    </div>
  );
}

export default function ScrollArea() {
  return (
    <div
      className="box-border content-stretch flex flex-col items-center justify-start p-0 relative size-full"
      data-name="Scroll Area"
    >
      <Nav />
      <div
        className="[background-size:100%_100%] bg-no-repeat bg-top-left h-[401px] shrink-0 w-[600px]"
        data-name="Div 01"
        style={{ backgroundImage: `url('${imgDiv01}')` }}
      />
      <div
        className="[background-size:100%_100%] bg-no-repeat bg-top-left h-[401px] shrink-0 w-[600px]"
        data-name="Div 02"
        style={{ backgroundImage: `url('${imgDiv02}')` }}
      />
      <Div03 />
      <div
        className="[background-size:100%_100%] bg-no-repeat bg-top-left h-[401px] shrink-0 w-[600px]"
        data-name="Div 04"
        style={{ backgroundImage: `url('${imgDiv04}')` }}
      />
      <Div05 />
      <div
        className="[background-size:100%_100%] bg-no-repeat bg-top-left h-[401px] shrink-0 w-[600px]"
        data-name="Div 06"
        style={{ backgroundImage: `url('${imgDiv06}')` }}
      />
      <div
        className="[background-size:100%_100%] bg-no-repeat bg-top-left h-[401px] shrink-0 w-[600px]"
        data-name="Div 07"
        style={{ backgroundImage: `url('${imgDiv07}')` }}
      />
      <div
        className="[background-size:100%_100%] bg-no-repeat bg-top-left h-[401px] shrink-0 w-[600px]"
        data-name="Div 08"
        style={{ backgroundImage: `url('${imgDiv08}')` }}
      />
      <div
        className="[background-size:100%_100%] bg-no-repeat bg-top-left h-[401px] shrink-0 w-[600px]"
        data-name="Div 09"
        style={{ backgroundImage: `url('${imgDiv09}')` }}
      />
      <div
        className="[background-size:100%_100%] bg-no-repeat bg-top-left h-[401px] shrink-0 w-[600px]"
        data-name="Div 10"
        style={{ backgroundImage: `url('${imgDiv10}')` }}
      />
    </div>
  );
}