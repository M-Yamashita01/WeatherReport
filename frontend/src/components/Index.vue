<template>
  <div class="container main-content">
    <div class="row">
      <div class="col-md-9 content-area main-contents japan-weather">
        <maincontents></maincontents>
      </div>
      <div class="col-md-3 sidebar main-contents">
        <aside>
          <sidebarcontents></sidebarcontents>
        </aside>
      </div>
    </div>
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
