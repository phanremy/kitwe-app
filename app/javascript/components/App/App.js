import { createSignal } from 'solid-js';
import { Show } from 'solid-js/web';
import html from "solid-js/html";
import calcTree from 'relatives-tree';
import PinchZoomPan from '../PinchZoomPan/PinchZoomPan';
import Tree from '../Tree/Tree';

// import { Node } from 'relatives-tree/lib/types';
// import nodes from 'relatives-tree/samples/average-tree.json';
// import css from './App.module.css';
// const tree = calcTree({}, { rootId });
const myID = 'kuVISwh7w';

const WIDTH = 70;
const HEIGHT = 80;

const nodes = [
  {
    "id": "jsyRsE5sr",
    "gender": "male",
    "parents": [],
    "siblings": [],
    "spouses": [
      {
        "id": "pdRwdtR54",
        "type": "married"
      }
    ],
    "children": []
  },
  {
    "id": "pdRwdtR54",
    "gender": "female",
    "parents": [],
    "siblings": [],
    "spouses": [
      {
        "id": "jsyRsE5sr",
        "type": "married"
      }
    ],
    "children": []
  }
]

function App() {
  const [rootId, setRootId] = createSignal(myID);

  const onResetClick = () => setRootId(myID);
  const onChangeRoot = (id) => setRootId(id);

  return (
    html`
      <>
        <div class="solid__app__root">
          <header class="solid__app__header">
            <h1 class="solid__app__title">
              Family Tree
            </h1>
            <a target="_blank" href="https://github.com/SanichKotikov/solid-family-tree-example">Credits to SanichKotikov</a>
          </header>
          <${PinchZoomPan}
            min=${0.5}
            max=${2.5}
            captureWheel
            class="solid__app__wrapper"
          >
            <${Tree}
              nodes=${nodes as Node[]}
              rootId=${rootId()}
              width=${WIDTH}
              height=${HEIGHT}
              onChangeRoot=${onChangeRoot}
            />
          </PinchZoomPan>
          <${Show} when=${rootId() !== myID}>
            <button type="button" class="solid__app__reset" onClick=${onResetClick}>
              Reset
            </button>
          </Show>
        </div>
      </>`
  );
}

export default App;
