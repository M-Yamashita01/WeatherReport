<template>
  <div class="main-contents">
    <h3>SignIn</h3>
    <sign-in-template></sign-in-template>
    <h5><router-link to="/login">ログイン</router-link></h5>
  </div>
</template>

<script>
import SignInTemplate from "./SignInTemplate";

export default {
  components: {
    SignInTemplate
  }
};
</script>
