import { createSignal } from 'solid-js';
import { Show } from 'solid-js/web';
import html from "solid-js/html";
import Tree from 'components/Tree/Tree';

const WIDTH = 70;
const HEIGHT = 80;

const nodes = [
  {
    "id": "HkqEDLvxE",
    "gender": "male",
    "parents": [
      {
        "id": "011jVS4rb",
        "type": "blood"
      },
      {
        "id": "PXACjDxmR",
        "type": "blood"
      }
    ],
    "siblings": [
      {
        "id": "kuVISwh7w",
        "type": "blood"
      },
      {
        "id": "UIEjvLJMd",
        "type": "blood"
      },
      {
        "id": "ZVi8fWDBx",
        "type": "blood"
      }
    ],
    "spouses": [],
    "children": []
  },
  {
    "id": "011jVS4rb",
    "gender": "male",
    "parents": [
      {
        "id": "ypu71w9_Q",
        "type": "blood"
      },
      {
        "id": "GEf8zF7A4",
        "type": "blood"
      }
    ],
    "children": [
      {
        "id": "HkqEDLvxE",
        "type": "blood"
      },
      {
        "id": "kuVISwh7w",
        "type": "blood"
      },
      {
        "id": "UIEjvLJMd",
        "type": "blood"
      },
      {
        "id": "ZVi8fWDBx",
        "type": "blood"
      }
    ],
    "siblings": [],
    "spouses": [
      {
        "id": "PXACjDxmR",
        "type": "married"
      }
    ]
  },
  {
    "id": "PXACjDxmR",
    "gender": "female",
    "parents": [
      {
        "id": "2DlrR0fK8",
        "type": "blood"
      }
    ],
    "children": [
      {
        "id": "HkqEDLvxE",
        "type": "blood"
      },
      {
        "id": "kuVISwh7w",
        "type": "blood"
      },
      {
        "id": "UIEjvLJMd",
        "type": "blood"
      },
      {
        "id": "ZVi8fWDBx",
        "type": "blood"
      }
    ],
    "siblings": [
      {
        "id": "H-06WvsfJ",
        "type": "blood"
      }
    ],
    "spouses": [
      {
        "id": "011jVS4rb",
        "type": "married"
      }
    ]
  },
  {
    "id": "kuVISwh7w",
    "gender": "male",
    "parents": [
      {
        "id": "011jVS4rb",
        "type": "blood"
      },
      {
        "id": "PXACjDxmR",
        "type": "blood"
      }
    ],
    "children": [
      {
        "id": "Fbc9iwnJl",
        "type": "blood"
      }
    ],
    "siblings": [
      {
        "id": "HkqEDLvxE",
        "type": "blood"
      },
      {
        "id": "UIEjvLJMd",
        "type": "blood"
      },
      {
        "id": "ZVi8fWDBx",
        "type": "blood"
      }
    ],
    "spouses": [
      {
        "id": "vRSjcaDGj",
        "type": "married"
      }
    ]
  },
  {
    "id": "UIEjvLJMd",
    "gender": "female",
    "parents": [
      {
        "id": "011jVS4rb",
        "type": "blood"
      },
      {
        "id": "PXACjDxmR",
        "type": "blood"
      }
    ],
    "children": [
      {
        "id": "6_OTJvbvS",
        "type": "blood"
      },
      {
        "id": "JhSCcdFEP",
        "type": "blood"
      },
      {
        "id": "6hNxNY1-I",
        "type": "blood"
      }
    ],
    "siblings": [
      {
        "id": "HkqEDLvxE",
        "type": "blood"
      },
      {
        "id": "kuVISwh7w",
        "type": "blood"
      },
      {
        "id": "ZVi8fWDBx",
        "type": "blood"
      }
    ],
    "spouses": [
      {
        "id": "RZbkr5vAi",
        "type": "married"
      }
    ]
  },
  {
    "id": "RZbkr5vAi",
    "gender": "male",
    "parents": [],
    "children": [
      {
        "id": "6_OTJvbvS",
        "type": "blood"
      },
      {
        "id": "JhSCcdFEP",
        "type": "blood"
      },
      {
        "id": "6hNxNY1-I",
        "type": "blood"
      }
    ],
    "siblings": [],
    "spouses": [
      {
        "id": "UIEjvLJMd",
        "type": "married"
      }
    ]
  },
  {
    "id": "vRSjcaDGj",
    "gender": "female",
    "parents": [
      {
        "id": "6vASIIxhd",
        "type": "blood"
      },
      {
        "id": "iFiwqrWx-",
        "type": "blood"
      }
    ],
    "children": [
      {
        "id": "Fbc9iwnJl",
        "type": "blood"
      }
    ],
    "siblings": [],
    "spouses": [
      {
        "id": "kuVISwh7w",
        "type": "married"
      }
    ]
  },
  {
    "id": "Fbc9iwnJl",
    "gender": "female",
    "parents": [
      {
        "id": "kuVISwh7w",
        "type": "blood"
      },
      {
        "id": "vRSjcaDGj",
        "type": "blood"
      }
    ],
    "children": [],
    "siblings": [],
    "spouses": []
  },
  {
    "id": "ypu71w9_Q",
    "gender": "male",
    "parents": [
      {
        "id": "TsyAkbF89",
        "type": "blood"
      },
      {
        "id": "T54Km7uOC",
        "type": "blood"
      }
    ],
    "children": [
      {
        "id": "011jVS4rb",
        "type": "blood"
      }
    ],
    "siblings": [],
    "spouses": [
      {
        "id": "GEf8zF7A4",
        "type": "married"
      }
    ]
  },
  {
    "id": "GEf8zF7A4",
    "gender": "female",
    "parents": [
      {
        "id": "gsgwGS_Kw",
        "type": "blood"
      },
      {
        "id": "ZgTZx9uXQ",
        "type": "blood"
      }
    ],
    "children": [
      {
        "id": "011jVS4rb",
        "type": "blood"
      }
    ],
    "siblings": [],
    "spouses": [
      {
        "id": "ypu71w9_Q",
        "type": "married"
      }
    ]
  },
  {
    "id": "2DlrR0fK8",
    "gender": "male",
    "parents": [],
    "children": [
      {
        "id": "PXACjDxmR",
        "type": "blood"
      },
      {
        "id": "H-06WvsfJ",
        "type": "blood"
      }
    ],
    "siblings": [],
    "spouses": []
  },
  {
    "id": "gsgwGS_Kw",
    "gender": "male",
    "parents": [],
    "children": [
      {
        "id": "GEf8zF7A4",
        "type": "blood"
      }
    ],
    "siblings": [],
    "spouses": [
      {
        "id": "ZgTZx9uXQ",
        "type": "married"
      }
    ]
  },
  {
    "id": "ZgTZx9uXQ",
    "gender": "female",
    "parents": [],
    "children": [
      {
        "id": "GEf8zF7A4",
        "type": "blood"
      }
    ],
    "siblings": [],
    "spouses": [
      {
        "id": "gsgwGS_Kw",
        "type": "married"
      }
    ]
  },
  {
    "id": "ZVi8fWDBx",
    "gender": "male",
    "parents": [
      {
        "id": "011jVS4rb",
        "type": "blood"
      },
      {
        "id": "PXACjDxmR",
        "type": "blood"
      }
    ],
    "children": [],
    "siblings": [
      {
        "id": "HkqEDLvxE",
        "type": "blood"
      },
      {
        "id": "kuVISwh7w",
        "type": "blood"
      },
      {
        "id": "UIEjvLJMd",
        "type": "blood"
      }
    ],
    "spouses": [
      {
        "id": "wJ1EBvc5m",
        "type": "married"
      }
    ]
  },
  {
    "id": "6_OTJvbvS",
    "gender": "male",
    "parents": [
      {
        "id": "RZbkr5vAi",
        "type": "blood"
      },
      {
        "id": "UIEjvLJMd",
        "type": "blood"
      }
    ],
    "children": [],
    "siblings": [
      {
        "id": "JhSCcdFEP",
        "type": "blood"
      },
      {
        "id": "6hNxNY1-I",
        "type": "blood"
      }
    ],
    "spouses": []
  },
  {
    "id": "JhSCcdFEP",
    "gender": "female",
    "parents": [
      {
        "id": "RZbkr5vAi",
        "type": "blood"
      },
      {
        "id": "UIEjvLJMd",
        "type": "blood"
      }
    ],
    "children": [
      {
        "id": "Z0QA5oKks",
        "type": "blood"
      }
    ],
    "siblings": [
      {
        "id": "6_OTJvbvS",
        "type": "blood"
      },
      {
        "id": "6hNxNY1-I",
        "type": "blood"
      }
    ],
    "spouses": [
      {
        "id": "ilad8NH6g",
        "type": "married"
      }
    ]
  },
  {
    "id": "6hNxNY1-I",
    "gender": "male",
    "parents": [
      {
        "id": "RZbkr5vAi",
        "type": "blood"
      },
      {
        "id": "UIEjvLJMd",
        "type": "blood"
      }
    ],
    "children": [],
    "siblings": [
      {
        "id": "6_OTJvbvS",
        "type": "blood"
      },
      {
        "id": "JhSCcdFEP",
        "type": "blood"
      }
    ],
    "spouses": []
  },
  {
    "id": "ilad8NH6g",
    "gender": "male",
    "parents": [],
    "children": [
      {
        "id": "Z0QA5oKks",
        "type": "blood"
      }
    ],
    "siblings": [],
    "spouses": [
      {
        "id": "JhSCcdFEP",
        "type": "married"
      }
    ]
  },
  {
    "id": "Z0QA5oKks",
    "gender": "male",
    "parents": [
      {
        "id": "ilad8NH6g",
        "type": "blood"
      },
      {
        "id": "JhSCcdFEP",
        "type": "blood"
      }
    ],
    "children": [],
    "siblings": [],
    "spouses": []
  },
  {
    "id": "wJ1EBvc5m",
    "gender": "female",
    "parents": [],
    "children": [],
    "siblings": [],
    "spouses": [
      {
        "id": "ZVi8fWDBx",
        "type": "married"
      }
    ]
  },
  {
    "id": "TsyAkbF89",
    "gender": "male",
    "parents": [],
    "children": [
      {
        "id": "ypu71w9_Q",
        "type": "blood"
      }
    ],
    "siblings": [],
    "spouses": [
      {
        "id": "T54Km7uOC",
        "type": "married"
      }
    ]
  },
  {
    "id": "T54Km7uOC",
    "gender": "female",
    "parents": [],
    "children": [
      {
        "id": "ypu71w9_Q",
        "type": "blood"
      }
    ],
    "siblings": [],
    "spouses": [
      {
        "id": "TsyAkbF89",
        "type": "married"
      }
    ]
  },
  {
    "id": "6vASIIxhd",
    "gender": "male",
    "parents": [],
    "children": [
      {
        "id": "vRSjcaDGj",
        "type": "blood"
      }
    ],
    "siblings": [],
    "spouses": [
      {
        "id": "iFiwqrWx-",
        "type": "married"
      }
    ]
  },
  {
    "id": "iFiwqrWx-",
    "gender": "female",
    "parents": [],
    "children": [
      {
        "id": "vRSjcaDGj",
        "type": "blood"
      }
    ],
    "siblings": [],
    "spouses": [
      {
        "id": "6vASIIxhd",
        "type": "married"
      }
    ]
  },
  {
    "id": "H-06WvsfJ",
    "gender": "female",
    "parents": [
      {
        "id": "2DlrR0fK8",
        "type": "blood"
      }
    ],
    "children": [],
    "siblings": [
      {
        "id": "PXACjDxmR",
        "type": "blood"
      }
    ],
    "spouses": []
  }
]

function App() {
  const myID = document.getElementById('family-tree').dataset.id;

  const [rootId, setRootId] = createSignal(myID);

  const onResetClick = () => {
    setRootId(myID)
  };

  const onChangeRoot = (id) => {
    setRootId(id)
    document.getElementById('family-tree').dataset.id = id
  };

  // console.group('App');
  //   console.log(`rootId ${rootId}`)
  //   console.log(onChangeRoot)
  //   console.log(onResetClick)
  // console.groupEnd();

  return (
    html`
      <>
        <div class="solid__app__root">
          <header class="solid__app__header">
            <h1 class="solid__app__title">
              Family Tree of ${rootId}
            </h1>
            <small>
              <a target="_blank" href="https://github.com/SanichKotikov/solid-family-tree-example">Credits to SanichKotikov</a>
            </small>
          </header>
          <${Tree}
            nodes=${nodes}
            rootId=${rootId()}
            width=${WIDTH}
            height=${HEIGHT}
            onChangeRoot=${onChangeRoot}
          />
          <${Show} when=${rootId() !== myID}>
            <button type="button" class="solid__app__reset" onClick=${onResetClick}>
              Reset
            </button>
          </Show>
        </div>
      </>
    `
  );
}

export default App;
