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
                <canvas id="pieChart"></canvas>
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
import store from "./store/index";
import assetsImage from "@/assets/logo.png";

export default {
  data() {
    return {
      userName: "",
      email: "",
      assetsImage: assetsImage
    };
  },
  created() {
    this.userName = store.getters.getUserName;
    this.email = store.getters.getEmail;
  }
};
</script>
