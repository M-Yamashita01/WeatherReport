<template>
  <div>
    <nav class="navbar fixed-top navbar-expand-lg navbar-dark bg-info">
      <a class="navbar-brand text-white" href="#">WeatherReport</a>
      <button
        type="button"
        class="navbar-toggler"
        data-toggle="collapse"
        data-target="#navigationBar"
        aria-controls="navigationBar"
        aria-expanded="false"
        aria-label="Toggle navigation"
      >
        <span class="navbar-toggler-icon"></span>
      </button>

      <div class="collapse navbar-collapse" id="navigationBar">
        <ul class="navbar-nav">
          <li class="nav-item"><a class="nav-link" href="#">雨雲の動き</a></li>
          <li class="nav-item"><a class="nav-link" href="#">地震情報</a></li>
          <li class="nav-item">
            <router-link to="/login">ログイン</router-link>
          </li>
        </ul>
      </div>
    </nav>
  </div>
</template>

<script></script>
