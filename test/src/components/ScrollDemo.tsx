import { ScrollTransformSection } from './ScrollTransformSection';
import NavComponent from "../imports/Nav-4003-108";
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

function Nav() {
  return (
    <div
      className="box-border content-stretch flex flex-col items-center justify-start relative shrink-0 w-[600px] sticky top-0 z-50"
      data-name="Nav"
    >
      <div className="w-full">
        <NavComponent />
      </div>
    </div>
  );
}

function Div01() {
  return (
    <div
      className="[background-size:100%_100%] bg-no-repeat bg-top-left h-full shrink-0 w-full block"
      data-name="Div 01"
      style={{ backgroundImage: `url('${imgDiv01}')` }}
    />
  );
}

function Div02() {
  return (
    <div
      className="[background-size:100%_100%] bg-no-repeat bg-top-left h-full shrink-0 w-full block"
      data-name="Div 02"
      style={{ backgroundImage: `url('${imgDiv02}')` }}
    />
  );
}

function Div03() {
  return (
    <div
      className="[background-size:100%_100%] bg-no-repeat bg-top-left h-full shrink-0 w-full block"
      data-name="Div 03"
      style={{ backgroundImage: `url('${imgDiv03}')` }}
    />
  );
}

function Div04() {
  return (
    <div
      className="[background-size:100%_100%] bg-no-repeat bg-top-left h-full shrink-0 w-full block"
      data-name="Div 04"
      style={{ backgroundImage: `url('${imgDiv04}')` }}
    />
  );
}

function Div05() {
  return (
    <div
      className="[background-size:100%_100%] bg-no-repeat bg-top-left h-full shrink-0 w-full block"
      data-name="Div 05"
      style={{ backgroundImage: `url('${imgDiv05}')` }}
    />
  );
}

function Div06() {
  return (
    <div
      className="[background-size:100%_100%] bg-no-repeat bg-top-left h-full shrink-0 w-full block"
      data-name="Div 06"
      style={{ backgroundImage: `url('${imgDiv06}')` }}
    />
  );
}

function Div07() {
  return (
    <div
      className="[background-size:100%_100%] bg-no-repeat bg-top-left h-full shrink-0 w-full block"
      data-name="Div 07"
      style={{ backgroundImage: `url('${imgDiv07}')` }}
    />
  );
}

function Div08() {
  return (
    <div
      className="[background-size:100%_100%] bg-no-repeat bg-top-left h-full shrink-0 w-full block"
      data-name="Div 08"
      style={{ backgroundImage: `url('${imgDiv08}')` }}
    />
  );
}

function Div09() {
  return (
    <div
      className="[background-size:100%_100%] bg-no-repeat bg-top-left h-full shrink-0 w-full block"
      data-name="Div 09"
      style={{ backgroundImage: `url('${imgDiv09}')` }}
    />
  );
}

function Div10() {
  return (
    <div
      className="[background-size:100%_100%] bg-no-repeat bg-top-left h-full shrink-0 w-full block"
      data-name="Div 10"
      style={{ backgroundImage: `url('${imgDiv10}')` }}
    />
  );
}

export function ScrollDemo() {
  const SECTION_HEIGHT = 400; // 400px height with 1:1 scroll ratio
  const COLLAPSED_HEIGHT = 0; // All sections squish to 0px

  return (
    <div className="bg-[#ebffb2] min-h-screen flex items-center justify-center p-4 cursor-none">
      <div className="w-[600px] h-[800px] bg-[#c4baff] overflow-hidden">
        <div className="box-border content-stretch flex flex-col items-center justify-start p-0 relative size-full">
          {/* Sticky Nav at the top */}
          <Nav />
          
          {/* Scrollable content container */}
          <div 
            id="scroll-container"
            className="flex flex-col w-full flex-1 overflow-y-auto scrollbar-none"
            style={{
              scrollbarWidth: 'none', /* Firefox */
              msOverflowStyle: 'none', /* Internet Explorer 10+ */
              lineHeight: 0,
              fontSize: 0,
              gap: 0,
              margin: 0,
              padding: 0
            }}
          >
            {/* Section 1 */}
            <ScrollTransformSection
              fullHeight={SECTION_HEIGHT}
              collapsedHeight={COLLAPSED_HEIGHT}
              sectionIndex={1}
            >
              <Div01 />
            </ScrollTransformSection>

            {/* Section 2 */}
            <ScrollTransformSection
              fullHeight={SECTION_HEIGHT}
              collapsedHeight={COLLAPSED_HEIGHT}
              sectionIndex={2}
              className="-mt-0.5"
            >
              <Div02 />
            </ScrollTransformSection>

            {/* Section 3 */}
            <ScrollTransformSection
              fullHeight={SECTION_HEIGHT}
              collapsedHeight={COLLAPSED_HEIGHT}
              sectionIndex={3}
              className="-mt-0.5"
            >
              <Div03 />
            </ScrollTransformSection>

            {/* Section 4 */}
            <ScrollTransformSection
              fullHeight={SECTION_HEIGHT}
              collapsedHeight={COLLAPSED_HEIGHT}
              sectionIndex={4}
              className="-mt-0.5"
            >
              <Div04 />
            </ScrollTransformSection>

            {/* Section 5 */}
            <ScrollTransformSection
              fullHeight={SECTION_HEIGHT}
              collapsedHeight={COLLAPSED_HEIGHT}
              sectionIndex={5}
              className="-mt-0.5"
            >
              <Div05 />
            </ScrollTransformSection>

            {/* Section 6 */}
            <ScrollTransformSection
              fullHeight={SECTION_HEIGHT}
              collapsedHeight={COLLAPSED_HEIGHT}
              sectionIndex={6}
              className="-mt-0.5"
            >
              <Div06 />
            </ScrollTransformSection>

            {/* Section 7 */}
            <ScrollTransformSection
              fullHeight={SECTION_HEIGHT}
              collapsedHeight={COLLAPSED_HEIGHT}
              sectionIndex={7}
              className="-mt-0.5"
            >
              <Div07 />
            </ScrollTransformSection>

            {/* Section 8 */}
            <ScrollTransformSection
              fullHeight={SECTION_HEIGHT}
              collapsedHeight={COLLAPSED_HEIGHT}
              sectionIndex={8}
              className="-mt-0.5"
            >
              <Div08 />
            </ScrollTransformSection>

            {/* Section 9 */}
            <ScrollTransformSection
              fullHeight={SECTION_HEIGHT}
              collapsedHeight={COLLAPSED_HEIGHT}
              sectionIndex={9}
              className="-mt-0.5"
            >
              <Div09 />
            </ScrollTransformSection>

            {/* Section 10 */}
            <ScrollTransformSection
              fullHeight={SECTION_HEIGHT}
              collapsedHeight={COLLAPSED_HEIGHT}
              sectionIndex={10}
              className="-mt-0.5"
            >
              <Div10 />
            </ScrollTransformSection>
          </div>
        </div>
      </div>
    </div>
  );
}