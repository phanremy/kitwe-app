import { createSignal } from 'solid-js';
import { createMemo } from 'solid-js';
import { For } from 'solid-js/web';
import html from 'solid-js/html';
import calcTree from 'family-tree/relatives';
import Connector from 'family-tree/components/Connector/Connector';
import Node from 'family-tree/components/Node/Node';

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
              isRoot=${node.id === props.initialId}
              node=${node}
              gender=${node.gender}
              deceased=${node.deceased}
              showGender=${props.showGender}
              showDeceased=${props.showDeceased}
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

  return (
    html`
      <div
        class="solid__tree__root"
        style=${{
          position: 'relative',
          width: '100%',
          height: '40vh',
        }}
      >
        ${Connectors()}
        ${Nodes()}
     </div>`
  );
}

export default Tree;
