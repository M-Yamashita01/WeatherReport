<template>
<div>
  <nav class="navbar fixed-top navbar-expand-lg navbar-dark bg-primary">
    <a class="navbar-brand" href="#">WeatherReport</a>
  </nav>
  <main role="main" class="container">
    <div class="jumbotron">
      <h3>Weather Report</h3>
      <p class="lead">{{ message }}</p>
      <button class="btn btn-outline-primary" type="submit">enter</button>
    </div>
  </main>
</div>


<!--
  <div>
    <ul id="dropdown" class="dropdown-content">
      <li><router-link to='/'>Top</router-link></li>
      <li><a href='/about'>About</a></li>
      <li><a href='/help'>Help</a></li>
    </ul>
    <nav>
      <div class="nav-wrapper">
        <a href="/" class="brand-logo left">Weather Report</a>
        <ul class="right hide-on-med-and-down">
          <li><router-link to='/'>Top</router-link></li>
          <li><router-link to="/about">About</router-link></li>
          <li><router-link to="/help">Help</router-link></li>
        </ul>
        <ul class="right hide-on-large-only">
          <li>
            <a class="dropdown-button" href="#!" data-activates="dropdown">
              Menu<i class="material-icons right">arrow_drop_down</i>
            </a>
          </li>
        </ul>
      </div>
    </nav>
  </div>
  -->
</template>

<script>
export default {
  data() {
    return {
      message: 'Welcome to WeatherReport site.'
    };
  }
};
</script>
