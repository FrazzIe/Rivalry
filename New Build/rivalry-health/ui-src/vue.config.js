const path = require("path");

module.exports = {
  outputDir: path.resolve(__dirname, "../ui"),
  baseUrl: './',
  assetsDir: undefined,
  runtimeCompiler: undefined,
  productionSourceMap: false,
  parallel: undefined,
  css: undefined,
  configureWebpack: {
    optimization: {
      minimize: true,
    },
  },
  filenameHashing: false,
  chainWebpack: (config) => {
    config.optimization.splitChunks(false);
  },
}