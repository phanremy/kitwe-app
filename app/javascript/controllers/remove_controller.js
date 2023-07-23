import { Controller } from '@hotwired/stimulus'

/*
 * Values:
 *
 * Notes:
 *
 * Example:
 *
 */
export default class extends Controller {
  initialize () {
    if (this.element.dataset.closeIfClickOutOfPanel === 'true') {
      this.setClickListenerOutOfPanel()
    }
  }

  setClickListenerOutOfPanel () {
    window.addEventListener('click', (e) => {
      if (!this.element.contains(e.target)) {
        this.proceed()
      }
    })
  }

  proceed () {
    this.element.remove()
  }
}
