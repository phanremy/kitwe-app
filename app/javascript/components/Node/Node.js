import { Show } from 'solid-js/web';
// import { ExtNode } from 'relatives-tree/lib/types';
import html from "solid-js/html";

// import css from './Node.module.css';

function Node(props) {
  const onClick = () => props.onSubClick(props.node.id);

  return (
    html`<div class="solid__node__root" style={props.style}>
          <div
            class="solid__node__inner"
            classList={{
              [css.male]: props.node.gender === 'male',
              [css.female]: props.node.gender === 'female',
              [css.isRoot]: props.isRoot,
            }}
          />
          <Show when={props.node.hasSubTree}>
            <div
              class="solid__node__sub"
              classList={{
                [css.male]: props.node.gender === 'male',
                [css.female]: props.node.gender === 'female',
              }}
              onClick={onClick}
            />
          </Show>
        </div>`
  );
}

export default Node;
