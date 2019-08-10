<template>
  <div id="login-template">
    <div>
      <input type="text" placeholder="ログインID" v-model="userid">
    </div>
    <div>
      <input type="password" placeholder="パスワード" v-model="password">
    </div>
    <button @click="login()">ログイン</button>
  </div>
</template>

<script>
export default {
    el: "login",
    data: function(){
      return {
        userid: "",
        password: ""
      }
    },

    methods: {
      login: function() {
        auth.login(this.userid, this.password);
      }
    },
};

  var auth = {
    login: function(id, pass) {
      window.alert("userid:" + id + "\n" + "password:" + pass);
    }
  };
</script>
