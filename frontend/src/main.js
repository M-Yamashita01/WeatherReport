import Vue from "vue";
import VueRouter from "vue-router";
import BootstrapVue from "bootstrap-vue";
import store from "./components/store/index";
import router from "./routes";
import App from "./App";

import "bootstrap/dist/css/bootstrap.css";
import "bootstrap-vue/dist/bootstrap-vue.css";

import "./assets/application.scss";

Vue.use(VueRouter);
Vue.use(BootstrapVue);

new Vue({
  name: "#application",
  store: store,
  router,
  render: h => h(App)
}).$mount("#app");
