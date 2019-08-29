<template>
  <!--<main role="main" class="col-md-8 ml-sm-auto col-lg-10 px-4 main-contents">-->
  <div class="main-contents">
    <ul class="list-inline">
      <button class="list-inline-item" v-on:click="getTodayWeathers">{{ todayDate}}</button>
      <button class="list-inline-item" v-on:click="getTommorowWeathers">{{ tommorowDate }}</button>
      <button class="list-inline-item" v-on:click="getDayAfterTommorowDate">{{ dayAfterTommorowDate }}</button>
    </ul>    
  <!--<main role="main" class="main-contents">-->
  <main role="main">
    <div id="chartdiv">
    </div>
  </main>
  </div>
</template>

<script>
import * as am4core from "@amcharts/amcharts4/core";
import * as am4maps from "@amcharts/amcharts4/maps";
import am4geodata_japanLow from "@amcharts/amcharts4-geodata/japanLow";
import axios from "axios";
import { constants } from 'crypto';
import { circleIn } from '@amcharts/amcharts4/.internal/core/utils/Ease';

export default {
//  el: "#prefectureName-example",
  //async mounted() {
    mounted() {
    // Create map instance
    let map = am4core.create("chartdiv", am4maps.MapChart);

    // Set japan map definition
    map.geodata = am4geodata_japanLow;

    // Set projection
    map.projection = new am4maps.projections.Miller();

    // Set default position
    map.homeZoomLevel = 1;
    map.homeGeoPoint = { longitude: "35", latitude: "139"}

    var polygonSeries = map.series.push(new am4maps.MapPolygonSeries());
    polygonSeries.useGeodata = true;

    this.imageSeries = map.series.push(new am4maps.MapImageSeries());
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
    }
  },
  methods: {
    async getWeathers(date) {
      console.log(date);
      let res = await axios.get("/api/location_on_forecast_days", {
        params: {
          main_city_flag: 1,
          date: date
        },
      });

      if (this.prefectureNames.length != 0)
      {
        this.prefectureNames = [];
      }

      for ( var i = 0; i < res.data.location_on_forecast.length; i++)
      {
        this.prefectureNames.push(res.data.location_on_forecast[i]);
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
    getTodayWeathers() {
      this.getWeathers(this.todayDate);
    },
    getTommorowWeathers() {
      this.getWeathers(this.tommorowDate);
    },
    getDayAfterTommorowDate() {
      this.getWeathers(this.dayAfterTommorowDate);
    }
  },
  async created() {
      let today = new Date();
      this.todayDate = today.getFullYear() + '-' + (today.getMonth() + 1) + '-' + today.getDate();
      this.tommorowDate = today.getFullYear() + '-' + (today.getMonth() + 1) + '-' + (today.getDate() + 1);
      this.dayAfterTommorowDate = today.getFullYear() + '-' + (today.getMonth() + 1) + '-' + (today.getDate() + 2);
      this.getWeathers(this.todayDate);      
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
