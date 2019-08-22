<template>
  <div>
    <nav class="navbar navbar-default fixed-top navbar-dark bg-primary">
      <router-link to="/" class="navbar-brand text-white">WeatherReport</router-link>
      <button type="button" class="navbar-toggler" data-toggle="collapse" data-target="#navigationBar" aria-controls="navigationBar" aria-expanded="true" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>

      <div class="navbar-collapse collapse" id="navigationBar">
        <ul class="navbar-nav">
          <li class="nav-item"><router-link to="#" class="text-white">雨雲の動き</router-link></li>
          <li class="nav-item"><router-link to="#" class="text-white">地震情報</router-link></li>
          <li class="nav-item"><router-link to="/login" class="text-white">ログイン</router-link></li>
          <li class="nav-item"><router-link to="/logout" class="text-white">ログアウト</router-link></li>
        </ul>
      </div>
    </nav>
  </div>  
</template>