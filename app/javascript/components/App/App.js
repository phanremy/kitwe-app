import { createSignal } from 'solid-js';
import { Show } from 'solid-js/web';
import html from "solid-js/html";
import calcTree from 'relatives-tree';
// import PinchZoomPan from '../PinchZoomPan/PinchZoomPan';
// import Tree from '../Tree/Tree';

// import { Node } from 'relatives-tree/lib/types';
// import nodes from 'relatives-tree/samples/average-tree.json';
// import css from './App.module.css';
// const tree = calcTree({}, { rootId });
const myID = 'kuVISwh7w';

const WIDTH = 70;
const HEIGHT = 80;

function App() {
  const [rootId, setRootId] = createSignal(myID);

  const onResetClick = () => setRootId(myID);
  const onChangeRoot = (id) => setRootId(id);

  return (
    html`<div class="root">
          <header class="header">
            <h1 class="title">
              FamilyTree demo (using SolidJS)
            </h1>
            <a href="https://github.com/SanichKotikov/solid-family-tree-example">GitHub</a>
          </header>
          <PinchZoomPan
            min={0.5}
            max={2.5}
            captureWheel
            class="wrapper"
          >
            <Tree
              nodes={nodes}
              rootId={rootId()}
              width={WIDTH}
              height={HEIGHT}
              onChangeRoot={onChangeRoot}
            />
          </PinchZoomPan>
          <Show when={rootId() !== myID}>
            <button type="button" class="reset" onClick={onResetClick}>
              Reset
            </button>
          </Show>
        </div>`
  );
}

export default App;
