# frozen_string_literal: true

# Pin npm packages by running ./bin/importmap

pin 'application', preload: true

pin '@hotwired/stimulus', to: 'stimulus.min.js', preload: true
pin '@hotwired/stimulus-loading', to: 'stimulus-loading.js', preload: true
pin '@hotwired/turbo-rails', to: 'turbo.min.js', preload: true

pin_all_from 'app/javascript/family-tree', under: 'family-tree'
pin_all_from 'app/javascript/controllers', under: 'controllers'

pin 'solid-js', to: 'https://cdn.skypack.dev/solid-js'
pin 'solid-js/dom', to: 'https://cdn.skypack.dev/solid-js/dom'
pin 'solid-js/web', to: 'https://cdn.skypack.dev/solid-js/web'
pin 'solid-js/html', to: 'https://cdn.skypack.dev/solid-js/html'
