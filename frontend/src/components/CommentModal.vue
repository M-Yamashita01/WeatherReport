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

      this.$bvModal.hide("commentModal");
      this.resetModal();
    },
    resetModal() {
      this.comment = "";
    }
  }
};
</script>
