<template>
  <div id="app">
    <header-component />
    <router-view />
    <footer-component />
  </div>
</template>

<script>
import HeaderComponent from "./packs/components/shared/Header";
import FooterComponent from "./packs/components/shared/Footer";

export default {
  components: {
    HeaderComponent,
    FooterComponent
  }
};
</script>
