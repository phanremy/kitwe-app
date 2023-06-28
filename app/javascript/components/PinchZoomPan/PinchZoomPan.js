import { onCleanup } from 'solid-js';
// import { create } from 'pinch-zoom-pan';
import html from "solid-js/html";

// import css from './PinchZoomPan.module.css';

function PinchZoomPan(props) {
  let element;
  let cleanup;

  // setTimeout(() => {
  //   cleanup = create({
  //     element,
  //     minZoom: props.min,
  //     maxZoom: props.max,
  //     captureWheel: props.captureWheel,
  //   });
  // });

  onCleanup(() => cleanup());

  return (
    html`<div
          ref={element}
          class="solid__pinchzoompan__root"
          classList="{{ [props.class || '']: !!props.class }}"
        >
          <div class="solid__pinchzoompan__point">
            <div class="solid__pinchzoompan__canvas">
              ${props.children}
            </div>
          </div>
        </div>`
  );
}

export default PinchZoomPan;
