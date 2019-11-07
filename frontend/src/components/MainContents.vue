<template>
  <weather-map :weathers="weathers" @scopechange="onScopeChanged" />
</template>

<script>
import Weathers from "./weathers.js";
import WeatherMap from "./WeatherMap";

export default {
  components: {
    WeatherMap
  },
  data() {
    return {
      weathers: []
    };
  },
  methods: {
    onScopeChanged(evt) {
      Weathers.getLocationWeathers(
        evt.date,
        evt.zoomLevel,
        evt.longitude,
        evt.latitude
      )
        .then(weathers => {
          this.weathers = weathers;
        })
        .catch(error => {
          this.weathers = [];
        });
    }
  }
};
</script>
