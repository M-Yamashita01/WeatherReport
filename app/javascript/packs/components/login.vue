<template>
  <div>
    <h3>LogIn</h3>
    <div id="login">
      <user-login></user-login>
    </div>
  </div>
</template>

<script>
  import LogInTemplate from './login-template';

export default {
    component: {
      'user-login': LogInTemplate
    }
};
</script>
