<template>
  <div>
    <h3>Hello World</h3>
      <!--
    <navigation></navigation>
    <div class="container-fluid">
      <div class="row">
      <maincontents></maincontents>
      </div>
    </div>-->
  </div>
</template>

<script>
import Navigation from './components/navigation.vue';
import MainContents from './components/MainContents';

export default {
    name: "top",
    components : {
        'navigation': Navigation,
        'maincontents': MainContents,
    }
}
</script>