import { createSignal } from 'solid-js';
import { createMemo } from 'solid-js';
import { For } from 'solid-js/web';
import html from "solid-js/html";
import calcTree from 'relatives-tree';
import Connector from 'components/Connector/Connector';
import Node from 'components/Node/Node';

function Tree(props) {
  const width = props.width / 2;
  const height = props.height / 2;

  const tree = createMemo(() =>
    calcTree(props.nodes, {
      rootId: props.rootId,
      placeholders: props.placeholders,
    }),
  );

  const Connectors = () => {

    // console.group(`Connectors`)
    //   console.log(tree().connectors)
    //   console.log(width)
    //   console.log(height)
    // console.groupEnd()

    return html`
      <${For} each=${tree().connectors}>
        ${(connector) => {
          return (html`<${Connector} connector=${connector} width=${width} height=${height}/>`)
        }}
      </For>`;
  };

  const Nodes = () => {

    // console.group(`Nodes`)
    //   console.log(tree().nodes)
    //   console.log(props.width)
    //   console.log(props.height)
    //   console.log(props.onChangeRoot)
    // console.groupEnd()

    return html`
      <${For} each=${tree().nodes}>
        ${(node) => {
          return (html`
            <${Node}
              isRoot=${node.id === props.rootId}
              node=${node}
              style=${{
                width: `${props.width}px`,
                height: `${props.height}px`,
                transform: `translate(${node.left * width}px, ${node.top * height}px)`,
              }}
              onSubClick=${props.onChangeRoot} />`)
        }}
      </For>`;
  };

  // console.group(`tree`)
  //   console.log(tree())
  //   console.log(tree().canvas)
  //   console.log(width)
  //   console.log(height)
  // console.groupEnd()

  // width: tree().canvas.width * width + `px`,
  // height: tree().canvas.height * height + `px`,

  return (
    html`
      <div
        class="solid__tree__root"
        style=${{
          position: 'relative',
          width: '100%',
          height: '70vh',
        }}
      >
        ${Connectors()}
        ${Nodes()}
     </div>`
  );
}

export default Tree;
