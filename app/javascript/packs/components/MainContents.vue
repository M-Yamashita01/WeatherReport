<template>
  <div>
    <ul class="list-inline">
      <button class="list-inline-item" v-on:click="getTodayWeathers">{{ todayDate}}</button>
      <button class="list-inline-item" v-on:click="getTommorowWeathers">{{ tommorowDate }}</button>
      <button class="list-inline-item" v-on:click="getDayAfterTommorowDate">{{ dayAfterTommorowDate }}</button>
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
import { constants } from 'crypto';
import { circleIn } from '@amcharts/amcharts4/.internal/core/utils/Ease';

import Weathers from "./weathers.js";

export default {
//  el: "#prefectureName-example",
  //async mounted() {
    mounted() {
    // Create map instance
    this.map = am4core.create("chartdiv", am4maps.MapChart);

    // Set japan map definition
    this.map.geodata = am4geodata_japanLow;

    // Set projection
    this.map.projection = new am4maps.projections.Miller();

    // Set default position
    this.map.homeZoomLevel = 1;
    this.map.homeGeoPoint = { longitude: "35", latitude: "139"}

    var polygonSeries = this.map.series.push(new am4maps.MapPolygonSeries());
    polygonSeries.useGeodata = true;

    // zoom event by click on map
    var polygonTemplate = polygonSeries.mapPolygons.template;
    polygonTemplate.events.on("hit", function(ev) {
      ev.target.series.chart.zoomToMapObject(ev.target);
      this.currentZoomLevel = ev.target.series.chart.zoomLevel;
      this.zoomGeoPoint = ev.target.series.chart.zoomGeoPoint;
      console.log(this.zoomGeoPoint.longitude);
      console.log(this.zoomGeoPoint.latitude);
    }.bind(this));

    // mouse wheel disable
    this.map.chartContainer.wheelable = false;

    // zoom control
    this.map.zoomControl = new am4maps.ZoomControl();

    //Add button
    var homeButton = new am4core.Button();
    homeButton.events.on("hit", function() {
      this.map.goHome();
    });
    homeButton.icon = new am4core.Sprite();
    homeButton.icon.path = "M16,8 L14,8 L14,16 L10,16 L10,10 L6,10 L6,16 L2,16 L2,8 L0,8 L8,0 L16,8 Z M16,8";

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
  data () {
    return {
      imageSeries: null,
      prefectureNames: [],
      error: {},
      todayDate: '',
      tommorowDate: '',
      dayAfterTommorowDate: '',
      map: null,
      currentZoomLevel: 1,
      remainingTime: this.initRemainingTime(),
      weathers: "",
      zoomGeoPoint: this.initZoomGeoPoint(),
    }
  },
  components: {
    Weathers,
  },
  methods: {
    async getWeathers(date, main_city_flag, longitude_max, longitude_min, latitude_max, latitude_min) {
      let res = await Weathers.getWeathers(date, main_city_flag, longitude_max, longitude_min, latitude_max, latitude_min, this.setWeathers);
      /* let res = await axios.get("/api/location_on_forecast_days", {
        params: {
          date: date,
          main_city_flag: main_city_flag,
          longitude_max: longitude_max,
          longitude_min: longitude_min,
          latitude_max: latitude_max,
          latitude_min: latitude_min
        },
      }); */

      if (this.prefectureNames.length != 0)
      {
        this.prefectureNames = [];
      }

      for ( var i = 0; i < this.weathers.data.location_on_forecast.length; i++)
      {
        this.prefectureNames.push(this.weathers.data.location_on_forecast[i]);
      }

      this.imageSeries.data = [{}];

      this.prefectureNames.forEach( prefectureName =>{
        this.imageSeries.data.push({
          "latitude" : prefectureName.latitude,
          "longitude" : prefectureName.longitude,
          "imageURL" : prefectureName.weather_image_link,
          "width" : 32,
          "height" : 32,
          "label" : prefectureName.location_name
        });
      });      
    },
    getLocationWeathers(date, longitude_max, longitude_min, latitude_max, latitude_min) {
      var main_city_flag = 1;
      if (this.currentZoomLevel >= 3) { // 3は適当
        main_city_flag = '';
      }
      getWeathers(date, main_city_flag, longitude_max, longitude_min, latitude_max, latitude_min)
    },
    getTodayWeathers() {
      this.getWeathers(this.todayDate);
    },
    getTommorowWeathers() {
      this.getWeathers(this.tommorowDate);
    },
    getDayAfterTommorowDate() {
      this.getWeathers(this.dayAfterTommorowDate);
    },
    setCurrentZoomLevel(zoomLevel) {
      this.currentZoomLevel = zoomLevel;
    },
    setWeathers: function(weathers) {
      this.weathers = weathers;
    },
    initRemainingTime() {
      this.remainingTime = 2;
    },
    initZoomGeoPoint() {
      this.zoomGeoPoint = { longitude: "35", latitude: "139"};
    }
  },
  async created() {
      let today = new Date();
      this.todayDate = today.getFullYear() + '-' + (today.getMonth() + 1) + '-' + today.getDate();
      this.tommorowDate = today.getFullYear() + '-' + (today.getMonth() + 1) + '-' + (today.getDate() + 1);
      this.dayAfterTommorowDate = today.getFullYear() + '-' + (today.getMonth() + 1) + '-' + (today.getDate() + 2);
      this.getWeathers(this.todayDate, 1);
  },
  watch : {
    'map.zoomLevel': function(val) {
      var zoomLevelNum = Math.floor(val);
      if ( this.currentZoomLevel != zoomLevelNum ) {
        this.currentZoomLevel = zoomLevelNum;
        this.initRemainingTime();
        setTimeout(() => {this.remainingTime--}, 1000);
      }
    },
    remainingTime: function(val) {
      if (val <= 0) {
        // 緯度、経度の中心からの幅の数値は適当
        var longitudeMax = this.zoomGeoPoint.longitude + 3;
        var longitudeMin = this.zoomGeoPoint.longitude - 3;
        var latitudeMax = this.zoomGeoPoint.latitude + 1;
        var latitudeMin = this.zoomGeoPoint.latitude - 1;
        this.getWeathers(this.todayDate, '', longitudeMax, longitudeMin, latitudeMax, latitudeMin);
        this.initRemainingTime();
      }
    }
  },
  beforeDestroy() {
    if (this.map) {
      this.map.dispose()
    }
  }
}
</script>
<style scoped>
#chartdiv {
  width: 100%;
  height: 600px;
}
</style>
