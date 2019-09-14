<template>
  <weather-map
    :weathers="weathers"
    @scopechange="onScopeChanged"
  />
</template>

<script>
import * as am4core from "@amcharts/amcharts4/core";
import * as am4maps from "@amcharts/amcharts4/maps";
import am4geodata_japanLow from "@amcharts/amcharts4-geodata/japanLow";
import axios from "axios";
import { constants } from "crypto";
import { circleIn } from "@amcharts/amcharts4/.internal/core/utils/Ease";

import Weathers from "./weathers.js";
import { setTimeout } from "timers";
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
      this.weathers = locationWeathers.location_on_forecast;
    }
  }
};
</script>
