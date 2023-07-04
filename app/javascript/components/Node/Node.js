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
              ['solid__node__isRoot']: props.isRoot,
            }}
            style=${{
              "background-image": "url('https://res.cloudinary.com/phanremy/image/upload/c_fill,h_200,w_200/v1/kitwe-app/4t9oyyi4b1bfeb31422erbela2qs')", /* fallback */
              "background-image": "linear-gradient(180deg, rgba(9,111,121,0) 0%, rgba(0,0,0,1) 150%), url('https://res.cloudinary.com/phanremy/image/upload/c_fill,h_200,w_200/v1/kitwe-app/4t9oyyi4b1bfeb31422erbela2qs')", /* W3C */
            }}
          >
            <div class="solid__node__id">${props.node.id}</div>
          </div>
          <${Show} when=${props.node.hasSubTree}>
            <div
              class="solid__node__sub"
              onClick=${onClick}
            />
          </Show>
        </div>`
  );
}

export default Node;
