module.exports = {
  devServer: {
    proxy: {
      "^/api*": {
        target: "http://server_latest:3000",
        ws: true,
        changeOrigin: true
      }
    },
    disableHostCheck: true
  },
  publicPath: "./"
};
