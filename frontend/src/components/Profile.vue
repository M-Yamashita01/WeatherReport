<template>
  <div>
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
                  <button
                    type="button"
                    class="btn btn-sm waves-effect float-right"
                    @click="$bvModal.show('commentModal')"
                  >
                    <span class="fas fa-pen fa-lg" aria-hidden="true"> </span>
                  </button>
                  <comment-modal @updatePosts="onUpdatePosts" />
                </div>
                <!--Card content-->
                <div class="card-body">
                  <div
                    class="list-group list-group-flush"
                    v-for="(post, i) in getPosts"
                    :key="i"
                  >
                    <div class="list-group-item list-group-item-action">
                      <div></div>
                      <div>
                        {{ post.name }} | {{ post.created_at | moment }}
                      </div>
                      <div>
                        {{ post.content }}
                      </div>
                    </div>
                  </div>
                  <paginate
                    v-if="paginationShow"
                    :page-count="getPageCount"
                    :click-handler="clickCallback"
                    :prev-text="'Prev'"
                    :next-text="'Next'"
                    :container-class="'pagination'"
                    :page-class="'page-item'"
                    :page-link-class="'page-link'"
                    :prev-class="'page-item'"
                    :next-class="'page-item'"
                    :prev-link-class="'page-link'"
                    :next-link-class="'page-link'"
                    :active-class="'active'"
                  >
                  </paginate>
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
  </div>
</template>

<script>
import moment from "moment";
import store from "./store/index";
import request from "./request";
import CommentModal from "./CommentModal";
import assetsImage from "@/assets/logo.png";

export default {
  data() {
    return {
      userName: "",
      email: "",
      assetsImage: assetsImage,
      posts: [],
      parPage: 10,
      currentPage: 1,
      paginationShow: false
    };
  },
  components: {
    CommentModal
  },
  filters: {
    moment: function(date) {
      return moment(date).format("YYYY/MM/DD HH:mm:ss");
    }
  },
  created() {
    this.onUpdatePosts();
  },
  methods: {
    clickCallback(pageNum) {
      this.currentPage = Number(pageNum);
    },
    onUpdatePosts() {
      this.userName = store.getters.getUserName;
      this.email = store.getters.getEmail;
      request
        .getUserPosts(store.getters.getId)
        .then(userPosts => {
          this.posts = userPosts;
          if (this.posts.length > 0) {
            this.paginationShow = true;
          }
        })
        .catch(error => {
          console.log("getUserPosts failed.");
          console.log(error);
          this.posts = [];
        });
    }
  },
  computed: {
    getPosts() {
      const current = this.currentPage * this.parPage;
      const start = current - this.parPage;
      return this.posts.slice(start, current);
    },
    getPageCount() {
      return Math.ceil(this.posts.length / this.parPage);
    }
  }
};
</script>
