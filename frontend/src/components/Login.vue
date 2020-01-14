<template>
  <div class="container-for-admin">
    <!--Main layout-->
    <main class="pt-5 mx-lg-5">
      <div class="container-fluid mt-5">
        <!--Grid row-->
        <div class="row wow fadeIn">
          <!--Grid column-->
          <!--<div class="col-md-8 mb-4>-->
          <div class="mx-auto" style="width: 25rem;">
            <!--Card-->
            <div class="card">
              <!--Card content-->
              <div class="card-body">
                <h4 class="card-title text-center mb-3">Weather Report</h4>
                <h6 class="card-subtitle text-center mb-3">ログイン</h6>
                <div id="login-template">
                  <div class="mb-3">
                    <div class="mb-3">メールアドレス</div>
                    <input
                      type="email"
                      class="form-control"
                      placeholder="weather@report.com"
                      v-model="user.email"
                    />
                  </div>
                  <div class="mb-5">
                    <div class="mb-3">パスワード</div>
                    <input
                      type="password"
                      class="form-control"
                      placeholder="xxxxxxxx"
                      v-model="user.password"
                    />
                  </div>
                  <div v-if="error" class="error">
                    {{ error }}
                  </div>
                  <button
                    @click="loginUser"
                    type="button"
                    class="btn btn-block waves-effect mb-3"
                  >
                    ログイン
                  </button>
                  <router-link to="/signin">サインイン</router-link>
                </div>
              </div>
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
    postUser: async function(params) {
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
        .then(() => {
          this.error = null;
          this.user = this.defautUser();
          alert("ログインしました");
          // トップページに戻る
          document.location = "/";
        })
        .catch(error => {
          if (error.response.status == 401) {
            this.error =
              "メールアドレス、もしくはパスワードが正しくないようです。。";
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

<!--
<template>

  <div class="main-contents">
    <h3>LogIn</h3>
    <log-in-template></log-in-template>
    <h5><router-link to="/SignIn">サインイン</router-link></h5>
  </div>
</template>

<script>
import LogInTemplate from "./LoginTemplate";

export default {
  name: "login-page",
  components: {
    LogInTemplate
  }
};
</script>
-->
