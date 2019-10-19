<template>
  <div>
    <div
      class="twitter-widget"
      style="width:400px;"
      :index="i"
      v-for="(tw, i) in twitterIds"
      :key="tw.title"
    >
      <timeline
        :id="tw"
        :source-type="'profile'"
        :options="{ height: twitterHeight }"
      >
      </timeline>
    </div>
  </div>
</template>

<script>
import TimeLine from "vue-tweet-embed/src/timeline";

export default {
  components: {
    timeline: TimeLine
  },
  data() {
    return {
      twitterHeight: "400",
      twitterIds: []
    };
  },
  created() {
    const ids = [];
    ids.push("JMA_kishou");
    ids.push("tenkijp");
    this.twitterIds = ids;
  }
};
</script>
