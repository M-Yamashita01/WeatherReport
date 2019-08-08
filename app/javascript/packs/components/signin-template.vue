<template>
  <div id="signin-template">
    <div>
      <label>ユーザ名:</label>
      <input type="text" placeholder="xxxxxx" v-model="user.name">
    </div>    
    <div>
      <label>メールアドレス:</label>
      <input type="email" placeholder="xxx@yyy.zzz" v-model="user.email">
    </div>
    <div>
      <label>パスワード:</label>
      <input type="password" placeholder="xxxxxxxx" v-model="user.password">
    </div>
    <div v-if="error" class="error">
      {{ error }}
    </div>
    <button @click="createUser">サインイン</button>
  </div>
</template>

<script>
export default {
  el: "login",
  data: function　() {
    return {
      sending: false,
      user: this.defaultUser(),
      error: null
    }
  },

  created: function () {
  },

  methods: {
    postUser : function (params, callback) {
      setTimeout(function(){
        callback(null, params)
      }, 1000)
    },

    defaultUser: function () {
      return {
        name: "",
        email: "",
        password: "",
      }
    },
    createUser: function () {
      // 入力パラメータのバリデーション
      if (this.user.name.trim() === "") {
        this.error = "ユーザ名は必須です";
        return;
      }
      if (this.user.email.trim() === "") {
        this.error = "メールアドレスは必須です";
        return;
      }
      if (this.user.password.trim() === "") {
        this.error = "パスワードは必須です";
        return;
      }

      this.postUser(this.user, (function(err, user) {
        this.sending = false;
        if (err){
          this.error = err.toString();
        } else {
          this.error = null,
          alert("新規ユーザが登録されました。ユーザ名 : " + this.user.name);
          this.user = this.defaultUser();
          
          //トップページにもどる
          this.$router.push("/");
        }

      }).bind(this))
    }
  }
}
</script>
