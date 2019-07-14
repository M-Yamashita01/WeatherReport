<template>
  <main role="main" class="col-md-8 ml-sm-auto col-lg-10 px-4">
    <img v-bind:src="weatherImage" width="800" height="600"/>
  </main>
</template>

<script>
  import weatherImage from "img.jpg";

  export default {
    data() {
      return {
        weatherImage,
      }
    }
  }
</script>