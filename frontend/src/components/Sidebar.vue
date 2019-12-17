<template>
  <div>
    <!--Card-->
    <div class="card mb-4" style="height:300px">
      <!-- Card header -->
      <div class="card-header text-center">
        新着投稿
        <button
          type="button"
          class="btn btn-sm waves-effect float-right"
          v-if="showPostButton"
          @click="$bvModal.show('commentModal')"
        >
          <span class="fas fa-pen fa-lg" aria-hidden="true"> </span>
        </button>
        <comment-modal @updatePosts="onUpdatePosts" />
      </div>
      <div class="card-body overflow-auto">
        <div
          class="list-group list-group-flush"
          v-for="(post, i) in posts"
          :key="i"
        >
          <div class="list-group-item list-group-item-action">
            <div>{{ post.name }} | {{ post.created_at | moment }}</div>
            <div>
              {{ post.content }}
            </div>
            <div>
              <button
                type="button"
                class="btn btn-sm float-right"
                @click="$bvModal.show('confirmDeletePost')"
              >
                <span aria-hidden="true">削除</span>
              </button>
              <confirm-delete-post></confirm-delete-post>
            </div>
          </div>
        </div>
      </div>
    </div>
    <!--Card-->
    <div class="card mb-4">
      <!-- Card header -->
      <div class="card-header text-center">Twitter</div>
      <div class="card-body">
        <div>
          <div :index="i" v-for="(tw, i) in twitterIds" :key="tw.title">
            <timeline
              :id="tw"
              :source-type="'profile'"
              :options="{ height: twitterHeight }"
            >
            </timeline>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import TimeLine from "vue-tweet-embed/src/timeline";
import moment from "moment";
import request from "./request";
import CommentModal from "./CommentModal";
import ConfirmDeletePost from "./ConfirmDeletePost";
import store from "./store/index";

export default {
  components: {
    timeline: TimeLine,
    CommentModal,
    ConfirmDeletePost
  },
  data() {
    return {
      twitterHeight: "400",
      twitterIds: [],
      posts: [],
      showPostButton: false
    };
  },
  filters: {
    moment: function(date) {
      return moment(date).format("YYYY/MM/DD HH:mm:ss");
    }
  },
  created() {
    const ids = [];
    ids.push("JMA_kishou");
    ids.push("tenkijp");
    this.twitterIds = ids;

    this.onUpdatePosts();

    // ユーザIDは1から発番されるため
    if (store.getters.getId > 0) {
      this.showPostButton = true;
    }
  },
  methods: {
    onUpdatePosts() {
      request
        .getUserPosts()
        .then(userPosts => {
          this.posts = userPosts;
        })
        .catch(error => {
          console.log("getUserPosts failed.");
          console.log(error);
          this.posts = [];
        });
    }
  }
};
</script>
