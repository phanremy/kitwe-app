const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}'
  ],
  variants: {
    borderColor: ['responsive', 'hover', 'focus', 'focus-within'],
  },
  theme: {
    extend: {
      fontFamily: {
        sans: ['Inter var', ...defaultTheme.fontFamily.sans],
      },
      transformOrigin: {
        "0": "0%",
      },
      zIndex: {
        "-1": "-1",
      },
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/typography'),
  ]
}
