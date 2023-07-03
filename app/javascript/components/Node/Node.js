import { Show } from 'solid-js/web';
import html from "solid-js/html";

function Node(props) {
  const onClick = () => props.onSubClick(props.node.id);

  // console.group(`node`)
  //   console.log(props.style)
  //   console.log(props.node)
  //   console.log(props.node.id)
  //   console.log(props.onSubClick(props.node.id))
  //   console.log(props.node.gender)
  //   console.log(props.node.hasSubTree)
  //   console.log(props.isRoot)
  //   console.log(props.onSubClick)
  //   console.log(onClick)
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
          >
            <div class="solid__node__id">${props.node.id}</div>
          </div>
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
