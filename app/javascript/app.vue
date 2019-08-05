<template>
    <div id="app">
      <header-component />
      <router-view />
      <footer-component />
    </div>
</template>

<script>
  import HeaderComponent from './packs/components/header';
  import FooterComponent from './packs/components/footer';

  export default {
    HeaderComponent,
    FooterComponent
  }
</script>
