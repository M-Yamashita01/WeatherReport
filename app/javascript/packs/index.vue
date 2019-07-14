<template>
  <div>
    <navigation></navigation>
    <div class="container-fluid">
      <div class="row">
      <sidebar></sidebar>
      <maincontents></maincontents>
      <sideBarRightTop></sideBarRightTop>
      </div>
    </div>
  </div>
</template>

<script>
import Navigation from './components/navigation.vue';
import SideBar from './components/sidebar.vue';
import MainContents from './components/MainContents';

export default {
    name: "top",
    components : {
        'navigation': Navigation,
        'sidebar': SideBar,
        'maincontents': MainContents,
    }
}
</script>