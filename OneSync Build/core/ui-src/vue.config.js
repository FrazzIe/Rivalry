module.exports = {
  publicPath: "./",
  outputDir: "../ui",
  filenameHashing: false,
  productionSourceMap: false,
  configureWebpack: {
    optimization: {
      minimize: false,
    },
  },
  chainWebpack: (config) => {
    config.optimization.splitChunks(false);
  },
}