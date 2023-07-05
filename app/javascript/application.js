// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import '@hotwired/turbo-rails'
import { Application } from '@hotwired/stimulus'

import ModalDisplayController from 'controllers/modal_display_controller'
import ModalOpenController from 'controllers/modal_open_controller'
import FlashCloseController from 'controllers/flash_close_controller'
import RevealController from 'controllers/reveal_controller'
import FamilyTreeCreatorController from 'controllers/family_tree_creator_controller'
import ClipboardController from 'controllers/clipboard_controller'

window.Stimulus = Application.start()
Stimulus.register('modal-open', ModalOpenController)
Stimulus.register('modal-display', ModalDisplayController)
Stimulus.register('flash-close', FlashCloseController)
Stimulus.register('reveal', RevealController)
Stimulus.register('family_tree_creator', FamilyTreeCreatorController)
Stimulus.register('clipboard', ClipboardController)
