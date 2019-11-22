<template>
  <div class="container-for-admin">
    <!--Main layout-->
    <main class="pt-5 mx-lg-5">
      <div class="container-fluid mt-5">
        <!--Grid row-->
        <div class="row wow fadeIn">
          <!--Grid column-->
          <div class="col-md-8 mb-4">
            <maincontents></maincontents>
          </div>
          <div class="col-md-4 mb-4">
            <sidebarcontents></sidebarcontents>
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
import MainContents from "./MainContents";
import SideBarContents from "./Sidebar";

export default {
  name: "top",
  components: {
    maincontents: MainContents,
    sidebarcontents: SideBarContents
  }
};
</script>
