<template>
  <div>
    <nav
      class="navbar fixed-top navbar-default navbar-toggleable-md bs-navbar navbar-dark"
    >
      <button
        type="button"
        class="navbar-toggler"
        data-toggle="collapse"
        data-target="#navigationBar"
        aria-controls="navigationBar"
        aria-expanded="false"
        aria-label="Toggle navigation"
      >
        <span class="navbar-toggler-icon"></span>
      </button>
      <router-link to="/" class="navbar-brand">Weather Report</router-link>
      <ul class="nav navbar-nav nav-flex-icons ml-auto text-white">
        <li class="nav-item" v-if="!logined">
          <router-link
            to="/login"
            data-toggle="collapse"
            data-target=".navbar-collapse.show"
            >ログイン</router-link
          >
        </li>
        <li class="nav-item" v-if="logined">
          <div>
            <router-link
              to="/profile"
              data-toggle="collapse"
              data-target=".navbar-collapse.show"
              class="text-white"
            >
              {{ userName }}
            </router-link>
            <router-link
              to="/logout"
              data-toggle="collapse"
              data-target=".navbar-collapse.show"
              class="text-white"
              >ログアウト</router-link
            >
          </div>
        </li>
      </ul>

      <div class="navbar-collapse collapse" id="navigationBar">
        <ul class="navbar-nav mr-auto">
          <li class="nav-item">
            <router-link
              to="#"
              data-toggle="collapse"
              data-target=".navbar-collapse.show"
              class="text-white"
              >雨雲の動き</router-link
            >
          </li>
          <li class="nav-item">
            <router-link
              to="#"
              data-toggle="collapse"
              data-target=".navbar-collapse.show"
              class="text-white"
              >地震情報</router-link
            >
          </li>
        </ul>
      </div>
    </nav>
  </div>
</template>

<script>
import store from "../store/index";

export default {
  data() {
    return {
      logined: false,
      userName: ""
    };
  },
  created() {
    this.logined = store.getters.hasToken;
    this.userName = store.getters.getUserName;
  }
};
</script>
