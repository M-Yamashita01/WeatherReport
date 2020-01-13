<template>
  <b-modal id="confirmDeletePost" @show="resetModal" @hidden="resetModal">
    <template v-slot:modal-title>
      コメント削除
    </template>
    <div>
      コメントを削除します。よろしいですか？
    </div>
    <template v-slot:modal-footer="{ ok, cancel }">
      <b-button size="sm" variant="primary" @click="deleteComment()"
        >はい</b-button
      >
      <b-button size="sm" variant="light" @click="cancel()"
        >キャンセル</b-button
      >
    </template>
  </b-modal>
</template>

<script>
import request from "./request";
import store from "./store/index";

export default {
  props: {
    postId: Number
  },
  data() {
    return {
      comment: "",
      commentState: null
    };
  },
  methods: {
    deleteComment() {
      console.log("delete post id is :" + this.postId);
      request
        .deleteComment(this.postId)
        .then(resultDelete => {
          // nothing
        })
        .catch(error => {
          console.log("deleteComment failed.");
          console.log(error);
          alert("削除できませんでした。もう一度試してみてください。");
          return;
        });
      this.$bvModal.hide("confirmDeletePost");
      this.$emit("updatePosts");
    },
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

      this.$bvModal.hide("confirmDeletePost");
      this.resetModal();
      this.$emit("updatePosts");
    },
    resetModal() {
      this.comment = "";
    }
  }
};
</script>
