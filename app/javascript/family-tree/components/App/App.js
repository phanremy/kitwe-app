import { createSignal } from 'solid-js';
import { Show } from 'solid-js/web';
import html from 'solid-js/html';
import Tree from 'family-tree/components/Tree/Tree';
import { isShowingGender, isShowingDeceased, isShowingCoupleStatus } from 'family-tree/relatives/utils/treeTogglingOptions';

const WIDTH = 70;
const HEIGHT = 80;

function App() {
  const dataset = document.getElementById('tree-data').dataset;
  const initialId = dataset.initialId;
  const id = dataset.id;
  const nodes = JSON.parse(dataset.familyTree);
  const showGender = isShowingGender();
  const showDeceased = isShowingDeceased();
  const showCoupleStatus = isShowingCoupleStatus();

  const [rootId, setRootId] = createSignal(id);

  const updateId = (updatedId) => {
    // Update the rootId in the DOM so that the Stimulus controller can pick it up
    document.getElementById('tree-data').dataset.id = updatedId
  }

  const onResetClick = () => {
    setRootId(initialId)
    updateId(initialId)
  };

  const onChangeRoot = (updatedId) => {
    // setRootId(id)
    updateId(updatedId)
  };

  // Pinch to zoom
  return (
    html`
      <>
        <div class="solid__app__header">
          <${Show} when=${rootId() !== initialId}>
            <button type="button" class="solid__app__reset" onClick=${onResetClick}>
              Reset
            </button>
          </Show>
        </div>
        <div class="solid__app__root"
             data-controller="tree-interaction"
             data-tree-interaction-form-outlet="#tree-interaction-form">
          <${Tree}
            nodes=${nodes}
            rootId=${rootId()}
            initialId=${initialId}
            width=${WIDTH}
            height=${HEIGHT}
            onChangeRoot=${onChangeRoot}
            showGender=${showGender}
            showDeceased=${showDeceased}
            showCoupleStatus=${showCoupleStatus}
          />
        </div>
      </>
    `
  );
}

export default App;
