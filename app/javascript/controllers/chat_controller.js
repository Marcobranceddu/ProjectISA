import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  static targets = [ "messagesList" ]

  connect() {
    this.messagesListTarget.scrollTop = this.messagesListTarget.scrollHeight;
  }

  scroll() {
    setTimeout(() => {
      this.messagesListTarget.scrollTop = this.messagesListTarget.scrollHeight;
    }, 100);
  }
}