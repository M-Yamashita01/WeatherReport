import Vue from "vue";
import Vuex from "vuex";
import createPersistedState from "vuex-persistedstate";

Vue.use(Vuex);

export default new Vuex.Store({
  state: {
    accessToken: "",
    client: "",
    uid: "",
    userName: "",
    email: "",
    id: 0
  },
  mutations: {
    create(state, data) {
      state.accessToken = data.accessToken;
      state.client = data.client;
      state.uid = data.uid;
      state.userName = data.userName;
      state.email = data.email;
      state.id = data.id;
    },
    destroy(state) {
      state.accessToken = "";
      state.client = "";
      state.uid = "";
      state.userName = "";
      state.email = "";
      state.id = 0;
    }
  },
  actions: {
    create({ commit }, payload) {
      commit("create", payload);
    },
    destroy({ commit }) {
      commit("destroy");
    }
  },
  getters: {
    hasToken(state) {
      if (state.accessToken != "") {
        return true;
      }
      return false;
    },
    getAccessToken(state) {
      return state.accessToken;
    },
    getClient(state) {
      return state.client;
    },
    getUid(state) {
      return state.uid;
    },
    getUserName(state) {
      return state.userName;
    },
    getEmail(state) {
      return state.email;
    },
    getId(state) {
      return state.id;
    }
  },
  plugins: [
    createPersistedState({
      key: "WeatherReportToken",
      storage: window.sessionStorage
    })
  ]
});
