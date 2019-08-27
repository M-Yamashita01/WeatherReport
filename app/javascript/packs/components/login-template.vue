<template>
  <div id="login-template">
    <div>
      <label>メールアドレス:</label>
      <input type="email" placeholder="xxx@yyy.zzz" v-model="user.email">
    </div>
    <div>
      <label>パスワード</label>
      <input type="password" placeholder="xxxxxxxx" v-model="user.password">
    </div>
    <div v-if="error" class="error">
      {{ error }}
    </div>
    <button @click="loginUser">ログイン</button>
  </div>
</template>

<script>
import axios from 'axios';
import store from '../../store/index';

export default {
    data: function(){
      return {
        sending: false,
        user: this.defautUser(),
        error: null
      }
    },

    methods: {
      postUser: function (params, callback) {
        let res = axios.post("/api/auth/sign_in", {
          email: params.email,
          password: params.password,
        }).then(response => {
          loginUser.setToken(response.headers['access-token'], response.headers['client'], response.headers['uid'], response.data['data']['name'])
          store.dispatch('create', loginUser);          

          callback(null, params);
        }).catch(err => {
          callback(err, params);
        });
      },

      defautUser: function () {
        return {
          email:"",
          password: ""
        }
      },

      loginUser: function() {
        this.postUser(this.user, (function(err, user) {
          this.sending = false;
          if (err) {
            this.error = err.toString();
          } else {
            this.error = null,
            this.user = this.defautUser();

            //トップページに戻る
            document.location = '/';
          }
        }).bind(this))
      }
    },
};

  var auth = {
    login: function(id, pass) {
      window.alert("userid:" + id + "\n" + "password:" + pass);
    }
  };

var loginUser = {
  accessToken: '',
  client: '',
  uid: '',
  userName: '',
  setToken: function (accessToken, client, uid, userName) {
    this.accessToken = accessToken;
    this.client = client;
    this.uid = uid;
    this.userName = userName;
  },
}  
</script>
