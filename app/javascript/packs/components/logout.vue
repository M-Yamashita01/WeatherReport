<template>
  <div>
    ログアウトしました。 トップページに戻ります。
  </div>
</template>

<script>
import store from "../../store/index";

export default {
  data: function() {
    return {
      remainingTime: 5
    };
  },
  created: function() {
    store.dispatch("destroy");
    setInterval(() => {
      this.remainingTime--;
    }, 1000);
  },
  watch: {
    remainingTime: function(v) {
      if (v <= 0) {
        document.location = "/";
      }
    }
  }
};
</script>
