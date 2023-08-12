import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static outlets = ['form']
  static targets = ['node']

  onNodeClick(event) {
    if (!this.nodeTargets.includes(event.target)) {
      return
    }

    this.nodeTargets.forEach((node) => { node.classList.remove('solid__node__isRoot') })
    event.target.classList.toggle('solid__node__isRoot')

    document.getElementById('outline-id').value = event.target.dataset.nodeId
    this.formOutlet.proceed(`form submit ${event.target.dataset.nodeId}`)
  }
}
