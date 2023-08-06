import { Controller } from '@hotwired/stimulus'
import SlimSelect from 'slim-select'

// require('slim-select/dist/slimselect.min.css')

export default class extends Controller {

  connect () {
    new SlimSelect({
      select: this.element,
      placeholder: this.element.dataset.placeholder
    })
  }
}
