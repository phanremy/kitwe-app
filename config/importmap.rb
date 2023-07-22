# frozen_string_literal: true

# Pin npm packages by running ./bin/importmap

pin 'application', preload: true

pin "@hotwired/stimulus", to: "https://ga.jspm.io/npm:@hotwired/stimulus@3.2.1/dist/stimulus.js"
pin "@hotwired/turbo-rails", to: "https://ga.jspm.io/npm:@hotwired/turbo-rails@7.3.0/app/javascript/turbo/index.js"
pin "@hotwired/turbo", to: "https://ga.jspm.io/npm:@hotwired/turbo@7.3.0/dist/turbo.es2017-esm.js"
pin "@rails/actioncable/src", to: "https://ga.jspm.io/npm:@rails/actioncable@7.0.6/src/index.js"
# pin '@hotwired/stimulus', to: 'stimulus.min.js', preload: true
# pin '@hotwired/stimulus-loading', to: 'stimulus-loading.js', preload: true
# pin '@hotwired/turbo-rails', to: 'turbo.min.js', preload: true

pin_all_from 'app/javascript/family-tree', under: 'family-tree'
pin_all_from 'app/javascript/controllers', under: 'controllers'

pin 'solid-js', to: 'https://cdn.skypack.dev/solid-js'
pin 'solid-js/dom', to: 'https://cdn.skypack.dev/solid-js/dom'
pin 'solid-js/web', to: 'https://cdn.skypack.dev/solid-js/web'
pin 'solid-js/html', to: 'https://cdn.skypack.dev/solid-js/html'
