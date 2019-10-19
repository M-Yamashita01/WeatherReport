import Vue from "vue";
import VueRouter from "vue-router";
import BootstrapVue from "bootstrap-vue";
import store from "../store/index";
import router from "../routes";
import App from "../App";

import "bootstrap/dist/css/bootstrap.css";
import "bootstrap-vue/dist/bootstrap-vue.css";

import "../../assets/stylesheets/application";

Vue.use(VueRouter);
Vue.use(BootstrapVue);

document.addEventListener("DOMContentLoaded", () => {
  new Vue({
    el: "#application",
    store: store,
    router,
    render: h => h(App)
  });
});
