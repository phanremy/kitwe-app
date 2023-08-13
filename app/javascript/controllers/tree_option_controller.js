import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  toggle(event) {
    const option = event.currentTarget.dataset.option
    const isChecked = event.currentTarget.querySelector('input').checked
    const familyTree = document.getElementById('family-tree')
    familyTree.dataset[option] = isChecked ? 'on' : 'off'
  }
}
