import { createMemo } from 'solid-js';
import { For } from 'solid-js/web';
import html from "solid-js/html";
import calcTree from 'relatives-tree';
import Connector from '../Connector/Connector';
import Node from '../Node/Node';

// import css from './Tree.module.css';

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
    return html`
      <${For} each=${tree().connectors}>
        ${(connector) => {
          // console.log(connector, width, height)
          return (html`<${Connector} connector=${connector} width=${width} height=${height}/>`)
        }}
      </For>`;
  };

  const Nodes = () => {
    return html`
      <${For} each=${tree().nodes}>
        ${(node) => {
          // console.log(props.width, props.height, node.left, node.top, node.id, width, height, props.rootId)
          return (html`
            <${Node}
              isRoot=${node.id === props.rootId}
              node=${node}
              style=''
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

  // return (
  //   html`
  //     <div
  //       class="solid__tree__root"
  //       style=${{
  //         position: 'relative',
  //         width: tree().canvas.width * width + `px`,
  //         height: tree().canvas.height * height + `px`,
  //       }}
  //     >
  //       ${Connectors()}
  //       ${Nodes()}
  //    </div>`
  // );
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
