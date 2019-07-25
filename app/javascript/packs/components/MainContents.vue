<template>
  <main role="main" class="col-md-8 ml-sm-auto col-lg-10 px-4 main-contents">
    <div id="chartdiv">
    </div>
    <!--<div id="prefectureName-example">  -->
    <!--<div id="prefectureName-example" v-for="name in prefectureNames" :key="name.location_id">
      {{ name.prefecture_name }} {{ name.location_name}} {{ name.longitude }} {{ name.latitude }}
    </div>-->
  </main>
</template>

<script>
import * as am4core from "@amcharts/amcharts4/core";
import * as am4maps from "@amcharts/amcharts4/maps";
import am4geodata_japanLow from "@amcharts/amcharts4-geodata/japanLow";
import axios from "axios";
import sunny from "1.gif";
import { constants } from 'crypto';

export default {
//  el: "#prefectureName-example",
  async mounted() {
    // Create map instance
    let map = am4core.create("chartdiv", am4maps.MapChart);

    // Set japan map definition
    map.geodata = am4geodata_japanLow;

    // Set projection
    map.projection = new am4maps.projections.Mercator();

    // Set default position
    map.homeZoomLevel = 2;
    map.homeGeoPoint = { longitude: "35", latitude: "139"}

    var polygonSeries = map.series.push(new am4maps.MapPolygonSeries());
    polygonSeries.useGeodata = true;

    polygonSeries.mapPolygons.template.events.on("hit", function(ev){
      map.zoomToMapObject(ev.target);
    });

    let imageSeries = map.series.push(new am4maps.MapImageSeries());
    let imageTemplate = imageSeries.mapImages.template;
    imageTemplate.propertyFields.longitude = "longitude";
    imageTemplate.propertyFields.latitude = "latitude";
    imageTemplate.nonScaling = true;

    let image = imageTemplate.createChild(am4core.Image);
    image.propertyFields.href = "imageURL";
    image.width = 50;
    image.height = 50;
    image.horizontalCenter = "middle";
    image.verticalCenter = "middle";

    let label = imageTemplate.createChild(am4core.Label);
    label.text = "{label}";
    label.horizontalCenter = "middle";
    label.verticalCenter = "top";
    label.dy = 20;

    await this.get_locations();

    imageSeries.data = [{}];
    this.prefectureNames.forEach( prefectureName =>{
      imageSeries.data.push({
        "latitude" : prefectureName.latitude,
        "longitude" : prefectureName.longitude,
        "imageURL" : "https://www.amcharts.com/lib/images/weather/animated/day.svg",
        "width" : 32,
        "height" : 32,
        "label" : prefectureName.prefecture_name
      });
    })
    console.log(imageSeries.data);    
  },
  data () {
    return {
      prefectureNames: [],
      error: {}
    }
  },
  methods: {
    async get_locations() {
      let res = await axios.get("/api/locations.json")
      for ( var i = 0; i < res.data.location.length; i++)
      {
        this.prefectureNames.push(res.data.location[i]);
      }
      console.log("create phase:" + this.prefectureNames.length);
    },
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
