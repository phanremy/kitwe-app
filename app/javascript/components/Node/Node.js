import { Show } from 'solid-js/web';
// import { ExtNode } from 'relatives-tree/lib/types';
import html from "solid-js/html";

// import css from './Node.module.css';

function Node(props) {
  const onClick = () => props.onSubClick(props.node.id);

  // console.group(`node`)
  //   console.log(props.node)
  //   console.log(props.isRoot)
  //   console.log(props.style)
  //   console.log(props.onSubClick)
  // console.groupEnd()

  return (
    html`<div class="solid__node__root" style=${props.style}>
          <div
            class="solid__node__inner"
            classList=${{
              ['solid__node__male']: props.node.gender === 'male',
              ['solid__node__female']: props.node.gender === 'female',
              ['solid__node__isRoot']: props.isRoot,
            }}
          />
          <${Show} when=${props.node.hasSubTree}>
            <div
              class="solid__node__sub"
              classList=${{
                ['solid__node__male']: props.node.gender === 'male',
                ['solid__node__female']: props.node.gender === 'female',
              }}
              onClick=${onClick}
            />
          </Show>
        </div>`
  );
}

export default Node;
