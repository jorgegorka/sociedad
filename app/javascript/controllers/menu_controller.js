import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["mobile"];

  connect() {
    this.mobileTarget.classList.add("hidden");
  }

  toggle() {
    this.mobileTarget.classList.toggle("hidden");
  }
}
