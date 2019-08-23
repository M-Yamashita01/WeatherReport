<template>
  <div>
    <h3>LogIn</h3>
    <log-in-template></log-in-template>
    <h5><router-link to='/signin'>サインイン</router-link></h5>
  </div>

</template>

<script>
import LogInTemplate from './login-template';

export default {
  name: 'login-page',
  components: {
    LogInTemplate,
  },
};
</script>
