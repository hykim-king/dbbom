import svgPaths from "./svg-wn5460rof7";
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
      <div
        className="[background-size:100%_100%] bg-no-repeat bg-top-left h-[401px] shrink-0 w-[600px]"
        data-name="Div 05"
        style={{ backgroundImage: `url('${imgDiv05}')` }}
      />
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