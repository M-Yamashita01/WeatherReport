<template>
  <div class="main-contents">
    <h3>LogIn</h3>
    <log-in-template></log-in-template>
    <h5><router-link to="/SignIn">サインイン</router-link></h5>
  </div>
</template>

<script>
import LogInTemplate from "./LoginTemplate";

export default {
  name: "login-page",
  components: {
    LogInTemplate
  }
};
</script>
