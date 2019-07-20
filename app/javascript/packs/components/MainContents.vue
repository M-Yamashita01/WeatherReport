<template>
  <main role="main" class="col-md-8 ml-sm-auto col-lg-10 px-4 main-contents">
    <!--<div id="chartdiv">
    </div>-->
    <div id="prefectureName-example" v-for="name in prefectureNames" :key="name.location_id">
    <!--<div id="prefectureName-example">  -->
      {{ name.prefecture_name }}
    </div>
  </main>
</template>

<script>
import * as am4core from "@amcharts/amcharts4/core";
import * as am4maps from "@amcharts/amcharts4/maps";
import am4geodata_japanLow from "@amcharts/amcharts4-geodata/japanLow";
import axios from "axios";
import sunny from "1.gif";

export default {
  el: "#prefectureName-example",
  /*
  mounted() {
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

    imageSeries.data = [{
      "latitude": 35.4122,
      "longitude": 139.4130,
      "imageURL": "https://www.amcharts.com/lib/images/weather/animated/day.svg",
      "width": 32,
      "height": 32,
      "label": "Tokyo: 25C"
    }];
  },
  */
  data () {
    return {
      prefectureNames: [],
      error: {}
    }
  },
  created: function() {
    axios.get("/api/locations")
    .then(res => {
      this.prefectureNames = res.data.location;
      this.error = "Success."
    })
    .catch(res => {
      this.error = "Error: Failed to get location by Rails API server."
    });
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
