import { Show } from 'solid-js/web';
import html from 'solid-js/html';

function Node(props) {
  const onClick = () => props.onSubClick(props.node.id);
  const showDeceased = props.deceased === true && props.showDeceased

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
              ['solid__node__isMale']: props.gender === 'male' && props.showGender,
              ['solid__node__isFemale']: props.gender === 'female' && props.showGender
            }}
            style=${{
              "background-color": `dimgray`, /* deceased and fallback2 */
              "background-image": showDeceased ? `none` :`url(${props.node.img})`, /* fallback */
              "background-image": showDeceased ? `none` : `linear-gradient(180deg, rgba(9,111,121,0) 0%, rgba(0,0,0,1) 150%), url(${props.node.img})`, /* W3C */
            }}
            data-tree-interaction-target='node'
            data-action="click->tree-interaction#onNodeClick"
            data-node-id=${props.node.id}
          >
            <${Show} when=${showDeceased}>
              <div class="solid__node__isDeceased"></div>
            </Show>
            <div class="solid__node__id">${props.node.name}</div>
          </div>
          <${Show} when=${props.node.hasSubTree}>
            <div class="solid__node__sub" onClick=${onClick}>
              <svg fill="#000000" height="10px" width="10px" version="1.1" id="Capa_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" viewBox="0 0 32.055 32.055" xml:space="preserve">
                <g>
                  <path d="M3.968,12.061C1.775,12.061,0,13.835,0,16.027c0,2.192,1.773,3.967,3.968,3.967c2.189,0,3.966-1.772,3.966-3.967 C7.934,13.835,6.157,12.061,3.968,12.061z M16.233,12.061c-2.188,0-3.968,1.773-3.968,3.965c0,2.192,1.778,3.967,3.968,3.967 s3.97-1.772,3.97-3.967C20.201,13.835,18.423,12.061,16.233,12.061z M28.09,12.061c-2.192,0-3.969,1.774-3.969,3.967 c0,2.19,1.774,3.965,3.969,3.965c2.188,0,3.965-1.772,3.965-3.965S30.278,12.061,28.09,12.061z"/>
                </g>
              </svg>
            </div>
          </Show>
        </div>`
  );
}

export default Node;
