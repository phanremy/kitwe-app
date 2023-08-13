import { Controller } from '@hotwired/stimulus'
import { render } from 'solid-js/web';
import App from 'family-tree/components/App/App';
import { switchDegradedMode } from 'family-tree/relatives/utils/treeTogglingOptions';

export default class extends Controller {
  connect() {
    this.updateFamilyTreeView();
    this.createMutationObserver();
  }

  updateFamilyTreeView() {
    this.element.innerHTML = '';
    try {
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

    observer.observe(this.element, {
      attributes: true
    });
  }
}
