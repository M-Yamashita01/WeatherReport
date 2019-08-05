<template>
    <div id="app">
      <header-component />
      <router-view />
      <footer-component />
    </div>
</template>

<script>
  import HeaderComponent from './packs/components/shared/header';
  import FooterComponent from './packs/components/shared/footer';

  export default {
    components: {
      HeaderComponent,
      FooterComponent,
    }
  }
</script>
