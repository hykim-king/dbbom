import imgSection01 from "figma:asset/20a2784d06f227dac5e3b5313926ccfe87deeb66.png";
import imgSection02 from "figma:asset/cbd169562279fa197c3b10e8c660043a252ad3f6.png";
import imgSection03 from "figma:asset/0da3575a77ef63bbf82cf1a8887f92784faf4d5b.png";
import imgSection04 from "figma:asset/c4b7c34a4d633bad8c257998813f7288b5864261.png";

function Website() {
  return (
    <div
      className="box-border content-stretch flex flex-col h-[733px] items-start justify-start overflow-clip p-0 relative shrink-0 w-[550px]"
      data-name="Website"
    >
      <div
        className="[background-size:100%_100%] bg-no-repeat bg-top-left h-[101px] shrink-0 w-[550px]"
        data-name="Section 01"
        style={{ backgroundImage: `url('${imgSection01}')` }}
      />
      <div
        className="[background-size:100%_100%] bg-no-repeat bg-top-left h-[364px] shrink-0 w-[550px]"
        data-name="Section 02"
        style={{ backgroundImage: `url('${imgSection02}')` }}
      />
      <div
        className="[background-size:100%_100%] bg-no-repeat bg-top-left h-[364px] shrink-0 w-[550px]"
        data-name="Section 03"
        style={{ backgroundImage: `url('${imgSection03}')` }}
      />
      <div
        className="[background-size:100%_100%] bg-no-repeat bg-top-left h-[364px] shrink-0 w-[550px]"
        data-name="Section 04"
        style={{ backgroundImage: `url('${imgSection04}')` }}
      />
    </div>
  );
}

export default function Mockup() {
  return (
    <div className="bg-[#ebffb2] relative size-full" data-name="Mockup">
      <div className="flex flex-row items-center justify-center relative size-full">
        <div className="box-border content-stretch flex flex-row gap-2.5 items-center justify-center p-[10px] relative size-full">
          <Website />
        </div>
      </div>
    </div>
  );
}