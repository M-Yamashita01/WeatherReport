<template>
  <div>
    <div class="card mb-4">
      <!-- Card header -->
      <div class="card-header text-center">Twitter</div>
      <div class="card-body">
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
      </div>
    </div>

    <!--Card-->
    <div class="card mb-4">
      <!-- Card header -->
      <div class="card-header text-center">新着投稿</div>
      <div class="card-body">
        test
      </div>
    </div>
    <!--Card-->
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
