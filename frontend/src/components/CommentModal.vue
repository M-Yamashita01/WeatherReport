<template>
  <b-modal id="commentModal" @show="resetModal" @hidden="resetModal">
    <template v-slot:modal-title>
      コメント
    </template>
    <input type="text" class="form-control" v-model="comment" />
    <template v-slot:modal-footer="{ ok, cancel }">
      <b-button size="sm" variant="primary" @click="postComment()">
        投稿
      </b-button>
      <b-button size="sm" variant="light" @click="cancel()">
        キャンセル
      </b-button>
    </template>
  </b-modal>
</template>

<script>
import request from "./request";
import store from "./store/index";

export default {
  data() {
    return {
      comment: "",
      commentState: null
    };
  },
  methods: {
    postComment() {
      if (this.comment == "") {
        return;
      }

      request
        .postComment(store.getters.getId, this.comment)
        .then(resultPost => {
          // nothing
        })
        .catch(error => {
          console.log("postComment failed.");
          console.log(error);
          alert("投稿できませんでした。もう一度試してみてください。");
          return;
        });

      this.$bvModal.hide("commentModal");
      this.resetModal();
    },
    resetModal() {
      this.comment = "";
    }
  }
};
</script>
