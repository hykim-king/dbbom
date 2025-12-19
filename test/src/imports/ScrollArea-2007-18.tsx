import svgPaths from "./svg-6iv5mt4sqe";
import imgDiv03 from "figma:asset/9c85e3d98f7dd538bd4e1997ebd193672b783966.png";
import imgDiv01 from "figma:asset/e845683f8197f46833c939b694b59e3fd5c89d10.png";
import imgDiv02 from "figma:asset/8b461ed990e4866a004ea25ef6a4f98936ba0a4f.png";
import imgDiv04 from "figma:asset/f8cf7e33cd800ff5474c452cfb76ed962ebebff5.png";
import imgDiv05 from "figma:asset/7caed319073e265aaa630d53c99f2fadbdc86790.png";
import imgDiv06 from "figma:asset/41e89c090df68b99e338dedc2dae13ee3a112e89.png";
import imgDiv07 from "figma:asset/ecbf4abd9cf16dd8a27c7a3f1b6f27beb4f8a3a3.png";
import imgDiv08 from "figma:asset/d5979eaf23a152165c637ce29d2a6c7ae787c937.png";
import imgDiv09 from "figma:asset/51f4b5f6e4dd5fa5c91c5739be703bb6d9ce29bc.png";
import imgDiv10 from "figma:asset/ce43a006e9ec4c267f7cd74912aa9afa803b5909.png";

function Header() {
  return (
    <div
      className="h-[47.653px] relative shrink-0 w-[284px]"
      data-name="Header"
    >
      <svg
        className="block size-full"
        fill="none"
        preserveAspectRatio="none"
        viewBox="0 0 284 48"
      >
        <g id="Header">
          <g id="Â©Alex Carter">
            <path d={svgPaths.p2c134700} fill="var(--fill-0, black)" />
            <path d={svgPaths.p1fa91100} fill="var(--fill-0, black)" />
            <path d={svgPaths.p194c2600} fill="var(--fill-0, black)" />
            <path d={svgPaths.p3def9900} fill="var(--fill-0, black)" />
            <path d={svgPaths.p1651af00} fill="var(--fill-0, black)" />
            <path d={svgPaths.p111eb500} fill="var(--fill-0, black)" />
            <path d={svgPaths.p287f2e00} fill="var(--fill-0, black)" />
            <path d={svgPaths.p94b9a00} fill="var(--fill-0, black)" />
            <path d={svgPaths.p307d700} fill="var(--fill-0, black)" />
            <path d={svgPaths.p22640c80} fill="var(--fill-0, black)" />
            <path d={svgPaths.p25dad800} fill="var(--fill-0, black)" />
          </g>
        </g>
      </svg>
    </div>
  );
}

function Nav() {
  return (
    <div
      className="bg-[#c4baff] box-border content-stretch flex flex-col gap-4 items-center justify-start mb-[-1px] p-[16px] relative shrink-0 w-[600px]"
      data-name="Nav"
    >
      <Header />
    </div>
  );
}

function Div03() {
  return (
    <div
      className="bg-center bg-cover bg-no-repeat h-[400px] mb-[-1px] shrink-0 w-[600px]"
      data-name="Div 03"
      style={{ backgroundImage: `url('${imgDiv03}')` }}
    />
  );
}

export default function ScrollArea() {
  return (
    <div
      className="box-border content-stretch flex flex-col items-center justify-start pb-px pt-0 px-0 relative size-full"
      data-name="Scroll Area"
    >
      <Nav />
      <div
        className="[background-size:100%_100%] bg-no-repeat bg-top-left h-[401px] mb-[-1px] shrink-0 w-[600px]"
        data-name="Div 01"
        style={{ backgroundImage: `url('${imgDiv01}')` }}
      />
      <div
        className="[background-size:100%_100%] bg-no-repeat bg-top-left h-[401px] mb-[-1px] shrink-0 w-[600px]"
        data-name="Div 02"
        style={{ backgroundImage: `url('${imgDiv02}')` }}
      />
      <Div03 />
      <div
        className="[background-size:100%_100%] bg-no-repeat bg-top-left h-[401px] mb-[-1px] shrink-0 w-[600px]"
        data-name="Div 04"
        style={{ backgroundImage: `url('${imgDiv04}')` }}
      />
      <div
        className="[background-size:100%_100%] bg-no-repeat bg-top-left h-[401px] mb-[-1px] shrink-0 w-[600px]"
        data-name="Div 05"
        style={{ backgroundImage: `url('${imgDiv05}')` }}
      />
      <div
        className="[background-size:100%_100%] bg-no-repeat bg-top-left h-[401px] mb-[-1px] shrink-0 w-[600px]"
        data-name="Div 06"
        style={{ backgroundImage: `url('${imgDiv06}')` }}
      />
      <div
        className="[background-size:100%_100%] bg-no-repeat bg-top-left h-[401px] mb-[-1px] shrink-0 w-[600px]"
        data-name="Div 07"
        style={{ backgroundImage: `url('${imgDiv07}')` }}
      />
      <div
        className="[background-size:100%_100%] bg-no-repeat bg-top-left h-[401px] mb-[-1px] shrink-0 w-[600px]"
        data-name="Div 08"
        style={{ backgroundImage: `url('${imgDiv08}')` }}
      />
      <div
        className="[background-size:100%_100%] bg-no-repeat bg-top-left h-[401px] mb-[-1px] shrink-0 w-[600px]"
        data-name="Div 09"
        style={{ backgroundImage: `url('${imgDiv09}')` }}
      />
      <div
        className="[background-size:100%_100%] bg-no-repeat bg-top-left h-[401px] mb-[-1px] shrink-0 w-[600px]"
        data-name="Div 10"
        style={{ backgroundImage: `url('${imgDiv10}')` }}
      />
    </div>
  );
}