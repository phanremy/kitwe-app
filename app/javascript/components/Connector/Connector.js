import html from "solid-js/html";

const MIN_THICKNESS = 1;

function calcSide(size, factor, thickness) {
  return Math.max(MIN_THICKNESS, size * factor + thickness);
}

function Connector({ connector, width, height, thickness = MIN_THICKNESS }) {
  const [x1, y1, x2, y2] = connector;

  // console.group(`connector`)
  //   console.log(connector)
  //   console.log(`width: ${calcSide(x2 - x1, width, thickness) + 'px'}`)
  //   console.log(x2, x1, width, thickness)
  //   console.log(`height: ${calcSide(y2 - y1, height, thickness) + 'px'}`)
  //   console.log(y2, y1, height, thickness)
  // console.groupEnd()

  return (
    html`<i
          style=${{
            position: 'absolute',
            width: calcSide(x2 - x1, width, thickness) + 'px',
            height: calcSide(y2 - y1, height, thickness) + 'px',
            background: "#999",
            transform: `translate(${x1 * width - (thickness / 2)}px, ${y1 * height - (thickness / 2)}px)`,
            pointerEvents: 'none',
          }}
        />`
  );
}

export default Connector;
