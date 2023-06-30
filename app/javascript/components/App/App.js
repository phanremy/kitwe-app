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
const WIDTH = 70;
const HEIGHT = 80;

// const myID = 'kuVISwh7w';

// const nodes = [
//   {
//     "id": "kuVISwh7w",
//     "gender": "male",
//     "parents": [],
//     "siblings": [],
//     "spouses": [],
//     "children": []
//   }
// ]

const myID = 'dyTpfj6sr';

const nodes = [
  {
    "id": "dyTpfj6sr",
    "gender": "male",
    "spouses": [],
    "siblings": [],
    "parents": [],
    "children": [
      {
        "id": "ahfR5lR2s",
        "type": "blood"
      },
      {
        "id": "aoF9dn5Ew",
        "type": "blood"
      }
    ]
  },
  {
    "id": "ahfR5lR2s",
    "gender": "female",
    "spouses": [],
    "siblings": [],
    "parents": [
      {
        "id": "dyTpfj6sr",
        "type": "blood"
      }
    ],
    "children": []
  },
  {
    "id": "aoF9dn5Ew",
    "gender": "male",
    "spouses": [],
    "siblings": [],
    "parents": [
      {
        "id": "dyTpfj6sr",
        "type": "blood"
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
              nodes=${nodes}
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
