import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  proceed(event) {
    this.element.requestSubmit()
  }
}
