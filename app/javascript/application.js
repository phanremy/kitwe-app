// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import '@hotwired/turbo-rails'
import { Application } from '@hotwired/stimulus'

import ModalDisplayController from 'controllers/modal_display_controller'
import ModalOpenController from 'controllers/modal_open_controller'
import RemoveController from 'controllers/remove_controller'
import RevealController from 'controllers/reveal_controller'
import TreeCreatorController from 'controllers/tree_creator_controller'
import TreeInteractionController from 'controllers/tree_interaction_controller'
import Form from 'controllers/form_controller'
import ClipboardController from 'controllers/clipboard_controller'

window.Stimulus = Application.start()
Stimulus.register('modal-open', ModalOpenController)
Stimulus.register('modal-display', ModalDisplayController)
Stimulus.register('remove', RemoveController)
Stimulus.register('reveal', RevealController)
Stimulus.register('tree-creator', TreeCreatorController)
Stimulus.register('tree-interaction', TreeInteractionController)
Stimulus.register('form', Form)
Stimulus.register('clipboard', ClipboardController)
