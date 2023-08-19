import { createMemo } from 'solid-js';
import { For, Show } from 'solid-js/web';
import html from 'solid-js/html';
import calcTree from 'family-tree/relatives';
import Connector from 'family-tree/components/Connector/Connector';
import Node from 'family-tree/components/Node/Node';
import MiddleAddOn from 'family-tree/components/MiddleAddOn/MiddleAddOn';

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
          return (html`<${Connector} connector=${connector} width=${width} height=${height} />`)
        }}
      </For>`;
  };

  const MiddleAddOns = () => {
    return html`
      <${For} each=${tree().middleAddOns}>
        ${(middleAddOn) => {
          return (html`<${MiddleAddOn} middleAddOn=${middleAddOn} width=${width} height=${height} />`)
        }}
      </For>`;
  };

  const Nodes = () => {
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

  return (
    html`
      <div
        class="solid__tree__root"
        style=${{
          position: 'relative',
          width: '100%'
        }}
      >
        ${Connectors()}
        <${Show} when=${props.showCoupleStatus}>
          ${MiddleAddOns()}
        </Show>
        ${Nodes()}
     </div>`
  );
}

export default Tree;
