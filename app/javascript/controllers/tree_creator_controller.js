import { Controller } from '@hotwired/stimulus'
import { render } from 'solid-js/web';
import App from 'family-tree/components/App/App';
import { switchDegradedMode } from 'family-tree/relatives/utils/treeTogglingOptions';

export default class extends Controller {
  static values = { error: { type: Boolean, default: false } }


  connect() {
    this.updateFamilyTreeView();
    this.createMutationObserver();
  }

  updateFamilyTreeView() {
    this.element.innerHTML = '';
    try {
      if (this.errorValue) {
        throw new Error(this.element.dataset.familyTree);
      }
      this.render()
    } catch (error) {
      console.error(error);
      this.element.innerHTML = 'An error occurred, please try again later';
    }
  }

  render() {
    try {
      render(App, this.element);
    } catch (error) {
      console.error(error);
      switchDegradedMode('on');
      render(App, this.element);
    }
  }

  createMutationObserver() {
    var observer = new MutationObserver((mutations) => {
      mutations.forEach((mutation) => {
        if (mutation.type === 'attributes') {
          this.updateFamilyTreeView();
        }
      });
    });

    // id: tree-data : div
    observer.observe(this.element, { attributes: true });
    // id: tree : turboframe
    observer.observe(this.element.parentElement, { attributes: true });
  }
}
