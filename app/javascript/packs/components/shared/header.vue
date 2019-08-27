<template>
  <div>
    <nav class="navbar navbar-default fixed-top navbar-dark bg-primary">
      <router-link to="/" class="navbar-brand text-white">WeatherReport</router-link>
      <button type="button" class="navbar-toggler" data-toggle="collapse" data-target="#navigationBar" aria-controls="navigationBar" aria-expanded="true" aria-label="Toggle navigation" :class="{'is-active': $store.state.isMenuActive}">
        <span class="navbar-toggler-icon"></span>
      </button>

      <div class="navbar-collapse collapse" id="navigationBar">
        <ul class="navbar-nav">
          <li class="nav-item" v-if="!logined"><router-link to="/login" class="text-white" data-toggle="collapse" data-target=".navbar-collapse.show">ログイン</router-link></li>
          <li class="nav-item" v-if="logined">
            <div class="text-white">ようこそ {{ userName }}さん</div>
            <router-link to="/logout" class="text-white" data-toggle="collapse" data-target=".navbar-collapse.show">ログアウト</router-link>
          </li>          
          <li class="nav-item"><router-link to="#" class="text-white" data-toggle="collapse" data-target=".navbar-collapse.show">雨雲の動き</router-link></li>
          <li class="nav-item"><router-link to="#" class="text-white" data-toggle="collapse" data-target=".navbar-collapse.show">地震情報</router-link></li>
        </ul>
      </div>
    </nav>
  </div>  
</template>

<script>
import store from "../../../store/index";

export default {
  data() {
    return {
      logined : false,
      userName : '',
    }
  },
  created() {
    this.logined = store.getters.hasToken;
    this.userName = store.getters.getUserName;
  },
};
</script>