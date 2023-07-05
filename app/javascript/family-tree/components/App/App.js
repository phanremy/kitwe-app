import { createSignal } from 'solid-js';
import { Show } from 'solid-js/web';
import html from 'solid-js/html';
import Tree from 'family-tree/components/Tree/Tree';

const WIDTH = 70;
const HEIGHT = 80;

function App() {
  const dataset = document.getElementById('family-tree').dataset;
  const initialId = dataset.initialId;
  const id = dataset.id;
  const nodes = JSON.parse(dataset.familyTree);

  const [rootId, setRootId] = createSignal(id);

  const updateId = (updatedId) => {
    // Temporary hack to update the rootId in the DOM so that the Stimulus controller can pick it up
    document.getElementById('family-tree').dataset.id = updatedId
  }

  const onResetClick = () => {
    setRootId(initialId)
    updateId(initialId)
  };

  const onChangeRoot = (updatedId) => {
    // setRootId(id)
    updateId(updatedId)
  };

  // console.group('App');
  //   console.log(`rootId ${rootId}`)
  //   console.log(onChangeRoot)
  //   console.log(onResetClick)
  // console.groupEnd();

  return (
    html`
      <>
        <div class="solid__app__root">
          <${Tree}
            nodes=${nodes}
            rootId=${rootId()}
            initialId=${initialId}
            width=${WIDTH}
            height=${HEIGHT}
            onChangeRoot=${onChangeRoot}
          />
          <footer class="solid__app__footer">
            <small>
              Credits to <a target="_blank" href="https://github.com/SanichKotikov/solid-family-tree-example">SanichKotikov</a>
            </small>
            <${Show} when=${rootId() !== initialId}>
              <button type="button" class="solid__app__reset" onClick=${onResetClick}>
                Reset
              </button>
            </Show>
          </footer>
        </div>
      </>
    `
  );
}

export default App;
