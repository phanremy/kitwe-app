import html from 'solid-js/html';

const MIN_THICKNESS = 5;

function calcSide(size, factor, thickness) {
  return Math.max(MIN_THICKNESS, size * factor + thickness);
}

function MiddleAddOn({ middleAddOn, width, height, thickness = MIN_THICKNESS }) {
  const [x1, y1, x2, y2] = middleAddOn;

  console.group('MiddleAddOn');
    console.log('middleAddOn', middleAddOn);
    console.log('width', width);
    console.log('height', height);
  console.groupEnd();

  // y stay the same
  // x need to be reworked
  return (
    html`<i
          style=${{
            position: 'absolute',
            width: calcSide(x2 - x1, width, thickness) + 'px',
            height: calcSide(y2 - y1, height, thickness) + 'px',
            background: "red",
            transform: `translate(${x1 * width - (thickness / 2)}px, ${y1 * height - (thickness / 2)}px) rotate(130deg)`,
            pointerEvents: 'none',
          }}
        />`
  );
}

export default MiddleAddOn;
