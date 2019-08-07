<template>
  <div id="signin-template">
    <div>
      <h5>ユーザ名:</h5><input type="text" placeholder="xxxxxx" v-model="userName">
    </div>    
    <div>
      <h5>メールアドレス</h5>
      <input type="email" placeholder="xxx@yyy.zzz" v-model="email">
    </div>
    <div>
      <h5>パスワード</h5>
      <input type="password" placeholder="xxxxxxxx" v-model="password">
    </div>
    <button @click="signin()">サインイン</button>
  </div>
</template>

<script>
export default {
    el: "login",
    data: function(){
      return {
        userName: '',
        email: '',
        password: ""
      }
    },

    methods: {
      signin: function() {
        // auth.login(this.userid, this.password);
      }
    },
};
</script>
