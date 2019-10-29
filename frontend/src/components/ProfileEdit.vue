<template>
  <div class="container-for-admin">
    <!--Main layout-->
    <main class="pt-5 mx-lg-5">
      <div class="container-fluid mt-5">
        <!--Grid row-->
        <div class="row wow fadeIn">
          <!--Grid column-->
          <div class="col-md-4 mb-4">
            <!--Card-->
            <div class="card text-center">
              <!--Card content-->
              <div class="card-body">
                <router-link class="text-body" to="/">
                  <button type="button" class="btn btn-sm waves-effect">
                    プロフィールへ戻る
                  </button>
                </router-link>
              </div>
            </div>
            <!--/.Card-->
          </div>
          <!--Grid column-->
          <!--Grid column-->
          <div class="col-md-8 mb-4">
            <!--Card-->
            <div class="card mb-4">
              <!-- Card header -->
              <div class="card-header text-center">
                アカウント編集
              </div>
              <!--Card content-->
              <div class="card-body">
                <!-- List group links -->
                <div class="list-group list-group-flush">
                  <a
                    class="list-group-item list-group-item-action waves-effect"
                  >
                    <div>
                      <img :src="user.assetsImage" class="profile-image" />
                    </div>
                    <div>
                      <input type="file" v-on:change="onFileChange" />
                    </div>
                  </a>
                  <a
                    class="list-group-item list-group-item-action waves-effect"
                  >
                    <!-- Material input -->
                    <div class="md-form">
                      <i class="fas fa-user prefix"></i>
                      <input
                        type="text"
                        class="form-control"
                        placeholder="名前"
                        v-model="user.userName"
                      />
                      <label for="inputIconEx2"></label>
                    </div>
                  </a>
                  <a
                    class="list-group-item list-group-item-action waves-effect"
                  >
                    <!-- Material input -->
                    <div class="md-form">
                      <i class="fas fa-envelope prefix"></i>
                      <input
                        type="text"
                        class="form-control"
                        placeholder="メールアドレス"
                        v-model="user.email"
                      />
                      <label for="inputIconEx1"></label>
                    </div>
                  </a>
                  <a
                    class="list-group-item list-group-item-action waves-effect"
                  >
                    <!-- Material input -->
                    <div class="md-form">
                      <i class="fas fa-lock prefix"></i>
                      <input
                        type="password"
                        class="form-control"
                        placeholder="パスワード"
                        value="abcdef"
                      />
                    </div>
                  </a>
                  <a
                    class="list-group-item list-group-item-action waves-effect"
                  >
                    <div>
                      <button
                        @click="updateUser"
                        type="button"
                        class="btn btn-block waves-effect"
                      >
                        更新
                      </button>
                    </div>
                  </a>
                </div>
                <!-- List group links -->
              </div>
            </div>
            <!--/.Card-->
          </div>
          <!--Grid column-->
        </div>
        <!--Grid row-->
      </div>
    </main>
    <!--Main layout-->
  </div>
</template>

<script>
import axios from "axios";
import store from "./store/index";
import assetsImage from "@/assets/logo.png";

export default {
  data() {
    return {
      user: this.currentUserProfile()
    };
  },
  created() {
    this.setUserProfile();
  },
  methods: {
    onFileChange(e) {
      const files = e.target.files || e.dataTransfer.files;
      this.createImage(files[0]);
    },
    // アップロードした画像を表示
    createImage(file) {
      const reader = new FileReader();
      reader.onload = e => {
        this.user.assetsImage = e.target.result;
      };
      reader.readAsDataURL(file);
    },
    putUser: function(params, callback) {
      axios
        .put("/api/auth", {
          "access-token": params.accessToken,
          client: params.client,
          uid: params.uid,
          name: params.userName,
          email: params.email
        })
        .then(response => {
          loginUser.setToken(
            response.headers["access-token"],
            response.headers["client"],
            response.headers["uid"],
            params.userName,
            params.email
          );

          store.dispatch("create", loginUser);
          this.setUserProfile();

          callback(null, params);
        })
        .catch(err => {
          callback(err, params);
        });
    },
    updateUser: function() {
      this.putUser(this.user, function(err, user) {
        if (err) {
          alert(
            "更新できませんでした。ユーザ名、メールアドレス、パスワードにミスがあります。"
          );
          console.log(err.toString());
        } else {
          alert("更新しました。");
        }
      });
    },
    currentUserProfile: function() {
      return {
        userName: "",
        email: "",
        assetsImage: "",
        accessToken: "",
        client: "",
        uid: ""
      };
    },
    setUserProfile: function() {
      this.user.userName = store.getters.getUserName;
      this.user.email = store.getters.getEmail;
      this.user.assetsImage = assetsImage;
      this.user.accessToken = store.getters.getAccessToken;
      this.user.client = store.getters.getClient;
      this.user.uid = store.getters.getUid;
    }
  }
};
const loginUser = {
  accessToken: "",
  client: "",
  uid: "",
  userName: "",
  email: "",
  setToken: function(accessToken, client, uid, userName, email) {
    this.accessToken = accessToken;
    this.client = client;
    this.uid = uid;
    this.userName = userName;
    this.email = email;
  }
};
</script>
