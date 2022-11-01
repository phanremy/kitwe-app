import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static values = { target: String }

  initialize () {
    new ClipboardJS(this.targetValue);
  }
}
