// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import '@hotwired/turbo-rails'
import { Application } from '@hotwired/stimulus'

import ClipboardController from 'controllers/clipboard_controller'
import Form from 'controllers/form_controller'
import ModalDisplayController from 'controllers/modal_display_controller'
import ModalOpenController from 'controllers/modal_open_controller'
import RemoveController from 'controllers/remove_controller'
import RevealController from 'controllers/reveal_controller'
import SlimSelectController from 'controllers/slim_select_controller'
import ToggleClassController from 'controllers/toggle_class_controller'
import TreeCreatorController from 'controllers/tree_creator_controller'
import TreeInteractionController from 'controllers/tree_interaction_controller'

window.Stimulus = Application.start()
Stimulus.register('clipboard', ClipboardController)
Stimulus.register('form', Form)
Stimulus.register('modal-display', ModalDisplayController)
Stimulus.register('modal-open', ModalOpenController)
Stimulus.register('remove', RemoveController)
Stimulus.register('reveal', RevealController)
Stimulus.register('slim-select', SlimSelectController)
Stimulus.register('toggle-class', ToggleClassController)
Stimulus.register('tree-creator', TreeCreatorController)
Stimulus.register('tree-interaction', TreeInteractionController)
