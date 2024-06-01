// postcss.config.js
module.exports = {
  autoprefixer: {},
  plugins: {
    'postcss-px-to-viewport': {
      viewportWidth: 375,
      // selectorBlackList: ['message']
    },
  },
};
