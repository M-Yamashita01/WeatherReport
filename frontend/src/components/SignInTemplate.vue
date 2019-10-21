<template>
  <div id="SignInTemplate">
    <div>
      <label>ユーザ名:</label>
      <input type="text" placeholder="xxxxxx" v-model="user.name" />
    </div>
    <div>
      <label>メールアドレス:</label>
      <input type="email" placeholder="xxx@yyy.zzz" v-model="user.email" />
    </div>
    <div>
      <label>パスワード(8文字以上):</label>
      <input type="password" placeholder="xxxxxxxx" v-model="user.password" />
    </div>
    <div v-if="error" class="error">
      {{ error }}
    </div>
    <button @click="createUser">サインイン</button>
  </div>
</template>

<script>
import axios from "axios";
import store from "./store/index";

export default {
  el: "login",
  data: function() {
    return {
      sending: false,
      user: this.defaultUser(),
      error: null
    };
  },

  methods: {
    postUser: function(params, callback) {
      axios
        .post("/api/auth", {
          name: params.name,
          email: params.email,
          password: params.password
        })
        .then(response => {
          loginUser.setToken(
            response.headers["access-token"],
            response.headers["client"],
            response.headers["uid"],
            name
          );
          store.dispatch("create", loginUser);

          callback(null, params);
        })
        .catch(err => {
          callback(err, params);
        });
    },

    defaultUser: function() {
      return {
        name: "",
        email: "",
        password: ""
      };
    },
    createUser: function() {
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

      this.postUser(
        this.user,
        function(err, user) {
          this.sending = false;
          if (err) {
            this.error = err.toString();
          } else {
            (this.error = null),
              alert("新規ユーザが登録されました。ユーザ名 : " + this.user.name);
            this.user = this.defaultUser();

            // トップページにもどる
            this.$router.push("/");
          }
        }.bind(this)
      );
    }
  }
};

const loginUser = {
  accessToken: "",
  client: "",
  uid: "",
  userName: "",
  setToken: function(accessToken, client, uid, useName) {
    this.accessToken = accessToken;
    this.client = client;
    this.uid = uid;
    this.userName = userName;
  }
};
</script>
