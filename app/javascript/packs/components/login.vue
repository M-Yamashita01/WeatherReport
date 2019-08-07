<template>
  <div>
    <h3>LogIn</h3>
    <log-in-template></log-in-template>
  </div>
</template>

<script>
  import LogInTemplate from './login-template';

export default {
    components: {
      LogInTemplate,
    },
    name: 'login-page',
};
</script>
