<template>
  <div>
    <nav class="navbar fixed-top navbar-default navbar-toggleable-md scrolling-navbar double-nav navbar-light">
      <div class="float-left">
        <button type="button" class="navbar-toggler" data-toggle="collapse" data-target="#navigationBar" aria-controls="navigationBar" aria-expanded="true" aria-label="Toggle navigation" :class="{'is-active': $store.state.isMenuActive}">
          <span class="navbar-toggler-icon"></span>
        </button>

        <div class="navbar-collapse collapse" id="navigationBar">
          <ul class="navbar-nav">
            <li class="nav-item" v-if="!logined"><router-link to="/login" data-toggle="collapse" data-target=".navbar-collapse.show">ログイン</router-link></li>
            <li class="nav-item" v-if="logined">
              <div>ようこそ {{ userName }}さん</div>
              <router-link to="/logout" data-toggle="collapse" data-target=".navbar-collapse.show">ログアウト</router-link>
            </li>          
            <li class="nav-item"><router-link to="#" data-toggle="collapse" data-target=".navbar-collapse.show">雨雲の動き</router-link></li>
            <li class="nav-item"><router-link to="#" data-toggle="collapse" data-target=".navbar-collapse.show">地震情報</router-link></li>
          </ul>
        </div>
      </div>
      <div class="breadcrumb-dn mr-auto">
        <ul>Weather Report</ul>
      </div>
      <ul class="nav navbar-nav nav-flex-icons ml-auto">
        <li class="nav-item" v-if="!logined"><router-link to="/login" data-toggle="collapse" data-target=".navbar-collapse.show">ログイン</router-link></li>
        <li class="nav-item" v-if="logined">
          <div>
            {{ userName }}
            <router-link to="/logout" data-toggle="collapse" data-target=".navbar-collapse.show">ログアウト</router-link>
          </div>
        </li> 
      </ul>
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