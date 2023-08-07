import { Controller } from '@hotwired/stimulus'
import { render } from 'solid-js/web';
import App from 'family-tree/components/App/App';

export default class extends Controller {
  connect() {
    this.updateFamilyTreeView();

    var observer = new MutationObserver((mutations) => {
      mutations.forEach((mutation) => {
        if (mutation.type === 'attributes') {
          // console.log(this.element.dataset.id);

          // Example of accessing the element for which
          // event was triggered
          // mutation.target.textContent = 'Attribute of the element changed';
          this.updateFamilyTreeView();
        }
      });
    });

    observer.observe(this.element, {
      attributes: true //configure it to listen to attribute changes
    });
  }

  updateFamilyTreeView() {
    this.element.innerHTML = '';
    // TODO: all male if error before catch
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
      this.element.dataset.degradedMode = '1';
      console.error(error);
      console.error('Degraded mode activated');
      render(App, this.element);
    }
  }
}
