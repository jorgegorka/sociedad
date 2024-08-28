import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="resources"
export default class extends Controller {
  static targets = ["resourceId", "bookingImage"];
  static values = { rid: Number };

  connect() {
    console.log(this.resourceIdTarget);
  }

  toggle(_event) {
    if (this.resourceIdTarget.value == this.ridValue) {
      this.resourceIdTarget.value = null;
      this.bookingImageTarget.classList.remove("border-4", "border-blue-500");
    } else {
      this.resourceIdTarget.value = this.ridValue;
      this.bookingImageTarget.classList.add("border-4", "border-blue-500");
    }
  }
}
