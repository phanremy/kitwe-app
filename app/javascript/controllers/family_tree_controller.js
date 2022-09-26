import { Controller } from '@hotwired/stimulus'
import FamilyTree from '@balkangraph/familytree.js'

/*
 * Values:
 *
 * Notes:
 *
 * Example:
 * // https:// balkan . app / FamilyTreeJS / Docs / Edit
 */
export default class extends Controller {
  initialize () {
    console.log('family tree building')
    console.log(this.element.dataset.familyTree)
    const family = new FamilyTree(this.element, {
      enableSearch: false,
      editForm: { readOnly: true,
                  buttons: { pdf: null, share: null } },
      generateElementsFromFields: false,
      nodeBinding: {
        field_0: "name"
      },
      nodes: JSON.parse(this.element.dataset.familyTree)
    })
  }

  defaultNode () {
    return [ { id: 1, pids: [2], name: "Amber McKenzie" },
      { id: 2, pids: [1], name: "Ava Field" },
      { id: 3, mid: 1, fid: 2, name: "Peter Stevens" }
    ]
  }
}