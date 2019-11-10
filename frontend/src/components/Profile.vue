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
                <router-link class="text-body" to="/profile-edit">
                  <button
                    type="button"
                    class="btn btn-sm waves-effect profile-edit"
                  >
                    編集
                  </button>
                </router-link>
                <img :src="assetsImage" width="100" height="100" />
                <div>
                  {{ userName }}
                </div>
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
                投稿一覧
              </div>
              <!--Card content-->
              <div class="card-body">
                <div
                  class="list-group list-group-flush"
                  v-for="(post, i) in posts"
                  :key="i"
                >
                  <div class="list-group-item list-group-item-action">
                    <div>
                      {{ post.created_at | moment }}
                    </div>
                    <div>
                      {{ post.content }}
                    </div>
                  </div>
                </div>
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
import moment from "moment";
import store from "./store/index";
import request from "./request";
import assetsImage from "@/assets/logo.png";

export default {
  data() {
    return {
      userName: "",
      email: "",
      assetsImage: assetsImage,
      posts: []
    };
  },
  filters: {
    moment: function(date) {
      return moment(date).format("YYYY/MM/DD HH:mm:ss");
    }
  },
  created() {
    this.userName = store.getters.getUserName;
    this.email = store.getters.getEmail;
    request
      .getUserPosts(store.getters.getId)
      .then(userPosts => {
        this.posts = userPosts;
      })
      .catch(error => {
        console.log("getUserPosts failed.");
        console.log(error);
        this.posts = [];
      });
  }
};
</script>
