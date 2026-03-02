import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["question", "answer", "flipButton", "answerButtons"]

  flip() {
    this.questionTarget.classList.add("hidden")
    this.answerTarget.classList.remove("hidden")
    this.flipButtonTarget.classList.add("hidden")
    this.answerButtonsTarget.classList.remove("hidden")
  }
}
