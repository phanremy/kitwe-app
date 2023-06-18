import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  connect() {
    // Fetch data from Rails, then call a method to handle the data
    const data = JSON.parse(this.element.dataset.familyTree) // These are the data
    this.updateFamilyTreeView(data)
  }

  updateFamilyTreeView(data) {
    data.forEach(person => {
      // Create a new div for the person
      const personDiv = document.createElement("div")
      personDiv.textContent = person.name

      // If the person has parents, add them to the div
      if (person.pids) {
        const parentDiv = document.createElement("div")
        parentDiv.textContent = "Parents: "
        person.pids.forEach(pid => {
          const parent = data.find(p => p.id === pid)
          if (parent) {
            parentDiv.textContent += parent.name + " "
          }
        })
        personDiv.appendChild(parentDiv)
      }

      // If the person has a mother and father, add them to the div
      else if (person.mid && person.fid) {
        const parentDiv = document.createElement("div")
        const mother = data.find(p => p.id === person.mid)
        const father = data.find(p => p.id === person.fid)
        if (mother && father) {
          parentDiv.textContent = "Mother: " + mother.name + ", Father: " + father.name
        }
        personDiv.appendChild(parentDiv)
      }

      // Append the person's div to the family tree div

      this.element.appendChild(personDiv)
    })
  }
}
