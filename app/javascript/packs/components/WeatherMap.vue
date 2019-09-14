<template>
  <div>
    <ul class="list-inline">
      <button
        class="list-inline-item"
        v-on:click="updateScope(todayDate)"
      >{{ todayDate}}</button>
      <button
        class="list-inline-item"
        v-on:click="updateScope(tommorowDate);"
      >{{ tommorowDate }}</button>
      <button
        class="list-inline-item"
        v-on:click="updateScope(dayAfterTommorowDate)"
      >{{ dayAfterTommorowDate }}</button>
    </ul>
    <div id="chartdiv">
    </div>
  </div>
</template>

<script>
import * as am4core from "@amcharts/amcharts4/core";
import * as am4maps from "@amcharts/amcharts4/maps";
import am4geodata_japanLow from "@amcharts/amcharts4-geodata/japanLow";
import axios from "axios";
import { constants } from "crypto";
import { circleIn } from "@amcharts/amcharts4/.internal/core/utils/Ease";

import { setTimeout } from "timers";

export default {
  props: {
    weathers: {
      type: Array,
      required: false,
      default: () => []
    }
  },
  data() {
    return {
      imageSeries: null,
      error: {},
      todayDate: "",
      tommorowDate: "",
      dayAfterTommorowDate: "",
      map: null,
      currentZoomLevel: 1,
      zoomGeoPoint: { longitude: "139", latitude: "35" },
      timer: null
    };
  },
  mounted() {
    // Create map instance
    this.map = am4core.create("chartdiv", am4maps.MapChart);

    // Set japan map definition
    this.map.geodata = am4geodata_japanLow;

    // Set projection
    this.map.projection = new am4maps.projections.Miller();

    // Set default position
    this.map.homeZoomLevel = 1;
    //this.map.homeGeoPoint = { longitude: "139", latitude: "35"}

    var polygonSeries = this.map.series.push(new am4maps.MapPolygonSeries());
    polygonSeries.useGeodata = true;

    // zoom event by click on map
    var polygonTemplate = polygonSeries.mapPolygons.template;
    polygonTemplate.events.on(
      "hit",
      function(ev) {
        ev.target.series.chart.zoomToMapObject(ev.target);
        this.currentZoomLevel = ev.target.series.chart.zoomLevel;
        this.zoomGeoPoint = ev.target.series.chart.zoomGeoPoint;
      }.bind(this)
    );

    // mouse wheel disable
    this.map.chartContainer.wheelable = false;

    // zoom control
    this.map.zoomControl = new am4maps.ZoomControl();

    //Add button
    var homeButton = new am4core.Button();
    homeButton.events.on(
      "hit",
      function() {
        this.map.goHome();
      }.bind(this)
    );
    homeButton.icon = new am4core.Sprite();
    homeButton.icon.path =
      "M16,8 L14,8 L14,16 L10,16 L10,10 L6,10 L6,16 L2,16 L2,8 L0,8 L8,0 L16,8 Z M16,8";

    homeButton.padding(7, 5, 7, 5);
    homeButton.width = 30;
    homeButton.marginBottom = 10;
    homeButton.parent = this.map.zoomControl;
    homeButton.insertBefore(this.map.zoomControl.plusButton);

    this.imageSeries = this.map.series.push(new am4maps.MapImageSeries());
    let imageTemplate = this.imageSeries.mapImages.template;
    imageTemplate.propertyFields.longitude = "longitude";
    imageTemplate.propertyFields.latitude = "latitude";
    imageTemplate.nonScaling = true;

    let image = imageTemplate.createChild(am4core.Image);
    image.propertyFields.href = "imageURL";
    image.width = 30;
    image.height = 30;
    image.horizontalCenter = "middle";
    image.verticalCenter = "bottom";

    let label = imageTemplate.createChild(am4core.Label);
    label.text = "{label}";
    label.horizontalCenter = "middle";
    label.verticalCenter = "top";
    label.dy = 5;
  },
  methods: {
    getTodayWeathers() {
      this.updateScope(this.todayDate);
    },
    getTommorowWeathers() {
      this.updateScope(this.tommorowDate);
    },
    getDayAfterTommorowDate() {
      this.updateScope(this.dayAfterTommorowDate);
    },
    updateScope(date) {
      this.$emit("scopechange", {
        date,
        zoomLevel: this.currentZoomLevel,
        longitude: this.zoomGeoPoint.longitude,
        latitude: this.zoomGeoPoint.latitude
      });
    }
  },
  async created() {
    let today = new Date();
    this.todayDate =
      today.getFullYear() +
      "-" +
      (today.getMonth() + 1) +
      "-" +
      today.getDate();
    this.tommorowDate =
      today.getFullYear() +
      "-" +
      (today.getMonth() + 1) +
      "-" +
      (today.getDate() + 1);
    this.dayAfterTommorowDate =
      today.getFullYear() +
      "-" +
      (today.getMonth() + 1) +
      "-" +
      (today.getDate() + 2);
    this.updateScope(this.todayDate);
  },
  watch: {
    weathers(weathers) {
      this.imageSeries.data = [{}];

      weathers.forEach(weather => {
        this.imageSeries.data.push({
          latitude: weather.latitude,
          longitude: weather.longitude,
          imageURL: weather.weather_image_link,
          width: 32,
          height: 32,
          label: weather.location_name
        });
      });
    },
    "map.zoomLevel": function(zoomLevel) {
      if (this.timer > 0) {
        window.clearTimeout(this.timer);
      }

      this.currentZoomLevel = zoomLevel;

      this.timer = window.setTimeout(
        function() {
          this.updateScope(this.todayDate);
        }.bind(this),
        200
      );
    }
  },
  beforeDestroy() {
    if (this.map) {
      this.map.dispose();
    }
  }
};
</script>
<style scoped>
#chartdiv {
  width: 100%;
  height: 600px;
}
</style>
