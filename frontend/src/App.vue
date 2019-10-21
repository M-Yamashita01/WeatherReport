<template>
  <div id="app">
    <header-component />
    <router-view />
    <footer-component />
  </div>
</template>

<script>
import HeaderComponent from "./components/shared/Header";
import FooterComponent from "./components/shared/Footer";

export default {
  name: "app",
  components: {
    HeaderComponent,
    FooterComponent
  }
};
</script>
