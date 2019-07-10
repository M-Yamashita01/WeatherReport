<template>
<div>
  <nav class="navbar fixed-top navbar-expand-lg navbar-dark bg-primary">
    <a class="navbar-brand" href="#">WeatherReport</a>
  </nav>
  <div class="container-fluid">
    <div class="row">
        <nav class="col-md-2 d-none d-md-block bg-light sidebar">
            <div class="sidebar-sticky">
                <ul class="nav flex-column">
                    <li class="nav-item">
                        <a class="nav-link active" href="#">
                            <span data-feather="home"></span>
                            ダッシュボード
                            <span class="sr-only">(現在地)</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">
                            <span data-feather="file"></span>
                            オーダー
                        </a>
                    </li>
                </ul>
            </div>
        </nav>
    </div>
</div>
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
