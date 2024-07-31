import { Controller } from "@hotwired/stimulus"
import { enter, leave } from 'el-transition';

export default class extends Controller {
  static targets = ['dropdownOptions', 'dropdownButton']

  show(event) {
    event.preventDefault()
    enter(this.dropdownOptionsTarget)
  }

  hide(event) {
    const buttonClicked = this.dropdownButtonTarget.contains(event.target)

    if (!buttonClicked) {
      leave(this.dropdownOptionsTarget)
    }
  }

  closeWithEsc(event) {
    if (event.code == "Escape") {
      leave(this.dropdownOptionsTarget)
    }
  }


  toggle(event) {
    event.preventDefault();

    if (this.dropdownOptionsTarget.classList.contains('hidden')) {
      enter(this.dropdownOptionsTarget)
    } else {
      leave(this.dropdownOptionsTarget)
    }
  }
}
