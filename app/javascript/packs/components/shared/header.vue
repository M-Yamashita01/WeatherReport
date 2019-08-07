<template>
  <div>
    <nav class="navbar fixed-top navbar-expand-lg navbar-dark bg-info">
      <router-link to="/">WeatherReport</router-link>
      <button type="button" class="navbar-toggler" data-toggle="collapse" data-target="#navigationBar" aria-controls="navigationBar" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>

      <div class="collapse navbar-collapse" id="navigationBar">
        <ul class="navbar-nav">
          <li class="nav-item"><router-link to="#">雨雲の動き</router-link></li>
          <li class="nav-item"><router-link to="#">地震情報</router-link></li>
          <li class="nav-item"><router-link to="/login">ログイン</router-link></li>
        </ul>
      </div>
    </nav>
  </div>  
</template>