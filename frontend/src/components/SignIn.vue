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
                <h6 class="card-subtitle text-center mb-3">サインイン</h6>

                <div id="SignInTemplate">
                  <div class="mb-3">
                    <div class="mb-3">ユーザ名</div>
                    <input
                      type="text"
                      class="form-control"
                      placeholder="Weather Report"
                      v-model="user.name"
                    />
                  </div>
                  <div class="mb-3">
                    <div class="mb-3">メールアドレス</div>
                    <input
                      type="email"
                      class="form-control"
                      placeholder="weather@report.com"
                      v-model="user.email"
                    />
                  </div>
                  <div class="mb-3">
                    <div class="mb-3">パスワード(8文字以上)</div>
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
                    @click="createUser"
                    type="button"
                    class="btn btn-block waves-effect mb-3"
                  >
                    サインイン
                  </button>
                  <router-link to="/login">ログイン</router-link>
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
      user: this.defaultUser(),
      error: null
    };
  },

  methods: {
    postUser: async function(params, callback) {
      await request
        .postSignIn(params.name, params.email, params.password)
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

      this.postUser(this.user)
        .then(response => {
          this.error = null;
          alert("新規ユーザが登録されました。ユーザ名 : " + this.user.name);
          this.user = this.defaultUser();

          // トップページにもどる
          document.location = "/";
        })
        .catch(error => {
          if (error.response.status == 422) {
            this.error = "入力内容が間違っています。";
            this.user.password = "";
          } else {
            console.log("postUser failed.");
            console.log(error);
            this.error =
              "予期せぬ例外が発生しました。サインイン画面に戻ります。";
            this.user = this.defautUser;
            document.location = "/";
          }
          this.error = err.toString();
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
