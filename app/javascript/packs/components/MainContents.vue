<template>
  <weather-map
    :weathers="weathers"
    @scopechange="onScopeChanged"
  />
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
    async onScopeChanged(evt) {
      const locationWeathers = await Weathers.getLocationWeathers(
        evt.date,
        evt.zoomLevel,
        evt.longitude,
        evt.latitude
      );
      this.weathers = locationWeathers.current_weather_data;
    }
  }
};
</script>
