import Vue from "vue";
import VueRouter from "vue-router";
import BootstrapVue from "bootstrap-vue";
import Paginate from "vuejs-paginate";
import store from "./components/store/index";
import router from "./routes";
import App from "./App";

import "./assets/application.scss";

Vue.use(VueRouter);
Vue.use(BootstrapVue);
Vue.component("paginate", Paginate);

new Vue({
  name: "#application",
  store: store,
  router,
  render: h => h(App)
}).$mount("#app");
