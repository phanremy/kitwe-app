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

  return (
    html`<div
      class="solid__tree__root"
      style={{
        position: 'relative',
        width: "${tree().canvas.width * width}px",
        height: "${tree().canvas.height * height}px",
      }}
    >
      <For each={tree().connectors}>
        {(connector) => <Connector connector={connector} width={width} height={height} />}
      </For>
      <For each={tree().nodes}>
        {(node) => (
          <Node
            isRoot={node.id === props.rootId}
            node={node}
            style={{
              width: "${props.width}px",
              height: "${props.height}px",
              transform: "translate(${node.left * width}px, ${node.top * height}px)",
            }}
            onSubClick={props.onChangeRoot}
          />
        )}
      </For>
    </div>`
  );
}

export default Tree;
