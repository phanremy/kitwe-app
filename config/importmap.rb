# frozen_string_literal: true

# Pin npm packages by running ./bin/importmap

pin "application", preload: true

pin "solid-js", to: "https://cdn.skypack.dev/solid-js"
pin "solid-js/dom", to: "https://cdn.skypack.dev/solid-js/dom"
pin "solid-js/web", to: "https://cdn.skypack.dev/solid-js/web"
pin "solid-js/html", to: "https://cdn.skypack.dev/solid-js/html"

pin '@hotwired/stimulus', to: 'stimulus.min.js', preload: true
pin '@hotwired/stimulus-loading', to: 'stimulus-loading.js', preload: true
pin_all_from 'app/javascript/controllers', under: 'controllers'
pin_all_from 'app/javascript/components', under: 'components'
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
# pin "@balkangraph/familytree.js", to: "https://ga.jspm.io/npm:@balkangraph/familytree.js@1.6.12/familytree.js"
# pin "solid-js", to: "https://cdn.skypack.dev/pin/solid-js@v1.7.6-aiGCnWkV3BmpUGZxYiod/mode=imports/optimized/solid-js.js"
# pin "solid-js/dom", to: "https://cdn.skypack.dev/pin/solid-js@v1.7.6-aiGCnWkV3BmpUGZxYiod/mode=raw/dom"
# pin "solid-js/html", to: "https://cdn.skypack.dev/pin/solid-js@v1.7.6-aiGCnWkV3BmpUGZxYiod/mode=imports/optimized/solid-js/html.js"
