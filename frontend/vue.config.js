module.exports = {
  pages: {
    index: {
      // 最初に実行されるファイル名
      entry: "src/main.js",
      // テンプレートファイル
      template: "public/index.html",
      // 出力されるファイル名
      filename: "index.html",
      // タイトルの設定
      title: "Weather Report",
      // チャンクの指定
      chunks: ["chunk-vendors", "chunk-common", "index"]
    }
  },
  devServer: {
    port: 8080,
    disableHostCheck: true,
    proxy: {
      "/api/auth/registrations": {
        target: "http://0.0.0.0:3000",
        ws: true,
        changeOrigin: true
      },
      "/api/current_weather_datas": {
        target: "http://0.0.0.0:3000",
        ws: true,
        changeOrigin: true
      },
      "/api/main_city_locations": {
        target: "http://0.0.0.0:3000",
        ws: true,
        changeOrigin: true
      }
    }
  }
};
