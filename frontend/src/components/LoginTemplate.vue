<template>
  <div class="container-for-admin">
    <!--Main layout-->
    <main class="pt-5 mx-lg-5">
      <div class="container-fluid mt-5">
        <!--Grid row-->
        <div class="row wow fadeIn">
          <!--Grid column-->
          <div class="col-md-8 mb-4">
            <div id="login-template">
              <div>
                <label>メールアドレス:</label>
                <input
                  type="email"
                  placeholder="weather@report.com"
                  v-model="user.email"
                />
              </div>
              <div>
                <label>パスワード</label>
                <input
                  type="password"
                  placeholder="xxxxxxxx"
                  v-model="user.password"
                />
              </div>
              <div v-if="error" class="error">
                {{ error }}
              </div>
              <button @click="loginUser">ログイン</button>
            </div>
          </div>
        </div>
      </div>
    </main>
  </div>
</template>

<script>
import request from "./request";
import store from "./store/index";

export default {
  data: function() {
    return {
      sending: false,
      user: this.defautUser(),
      error: null
    };
  },

  methods: {
    postUser: async function(params, callback) {
      await request
        .postLogin(params.email, params.password)
        .then(response => {
          loginUser.setToken(
            response.headers["access-token"],
            response.headers["client"],
            response.headers["uid"],
            response.data["data"]["name"],
            response.data["data"]["email"],
            response.data["data"]["id"]
          );
          store.dispatch("create", loginUser);
        })
        .catch(error => {
          throw error;
        });
    },

    defautUser: function() {
      return {
        email: "",
        password: ""
      };
    },

    loginUser: function() {
      this.postUser(this.user)
        .then(response => {
          this.error = null;
          this.user = this.defautUser();
          alert("ログインしました");
          // トップページに戻る
          document.location = "/";
        })
        .catch(error => {
          if (error.response.status == 401) {
            this.error = "メールアドレス、もしくはパスワードが間違っています。";
            this.user.password = "";
          } else {
            console.log("postUser failed.");
            console.log(error);
            this.error = "予期せぬ例外が発生しました。ログイン画面に戻ります。";
            this.user = this.defautUser;
            document.location = "/";
          }
        });
    }
  }
};

const loginUser = {
  accessToken: "",
  client: "",
  uid: "",
  userName: "",
  email: "",
  setToken: function(accessToken, client, uid, userName, email, id) {
    this.accessToken = accessToken;
    this.client = client;
    this.uid = uid;
    this.userName = userName;
    this.email = email;
    this.id = id;
  }
};
</script>
