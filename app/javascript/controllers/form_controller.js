import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  connect() {
    console.log('form_submit_controller - start')
  }

  proceed(event) {
    console.log(event)
  }
}
