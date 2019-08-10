<template>
  <div>
    <h3>SignIn</h3>
    <sign-in-template></sign-in-template>
    <h5><router-link to="/login">ログイン</router-link></h5>
  </div>
</template>

<script>
import SignInTemplate from "./signin-template";

export default {
  components: {
    SignInTemplate,
  },
};
</script>
