import html from 'solid-js/html';
import { Show } from 'solid-js/web';

const MIN_THICKNESS = 5;

function calcSide(size, factor, thickness) {
  return Math.max(MIN_THICKNESS, size * factor + thickness);
}

function MiddleAddOn({ middleAddOn, width, height, thickness = MIN_THICKNESS }) {
  const [x1, y1, x2, y2, status] = middleAddOn;

  const Separated = () => {
    return (
      html`<i
            style=${{
              position: 'absolute',
              width: '20px',
              height: '1px',
              background: 'black',
              transform: `translate(${(x1 + x2)/2 * width - (thickness / 2) - 7}px, ${y1 * height - (thickness / 2) + 2}px) rotate(130deg)`,
              pointerEvents: 'none',
            }}
          />`
    );
  };

  const Divorced = () => {
    return (
      html`<i
            style=${{
              position: 'absolute',
              width: '20px',
              height: '1px',
              background: 'black',
              transform: `translate(${(x1 + x2)/2 * width - (thickness / 2) - 5}px, ${y1 * height - (thickness / 2) + 2}px) rotate(130deg)`,
              pointerEvents: 'none',
            }}
          />
          <i
            style=${{
              position: 'absolute',
              width: '20px',
              height: '1px',
              background: 'black',
              transform: `translate(${(x1 + x2)/2 * width - (thickness / 2) - 9}px, ${y1 * height - (thickness / 2) + 2}px) rotate(130deg)`,
              pointerEvents: 'none',
            }}
          />`
    );
  };

  return (
    html`
      <${Show} when=${status === 'divorced'}>
        ${Divorced()}
      </Show>
      <${Show} when=${status === 'separated'}>
        ${Separated()}
      </Show>`
  );
}

export default MiddleAddOn;
