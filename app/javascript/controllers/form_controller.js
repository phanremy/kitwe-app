import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static values = {
    initialSubmit: Boolean
  }

  connect() {
    if (this.initialSubmitValue) {
      this.proceed()
    }
  }

  proceed(event) {
    this.element.requestSubmit()
  }
}
