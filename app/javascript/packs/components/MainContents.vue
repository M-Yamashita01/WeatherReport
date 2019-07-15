<template>
  <main role="main" class="col-md-8 ml-sm-auto col-lg-10 px-4 main-contents">
    <!--<img v-bind:src="weatherImage" width="800" height="600"/>-->
    <div id="chartdiv">
    </div>
  </main>
</template>

<script>
import * as am4core from "@amcharts/amcharts4/core";
import * as am4maps from "@amcharts/amcharts4/maps";
import am4geodata_japanLow from "@amcharts/amcharts4-geodata/japanLow";

export default {
  mounted() {
    let map = am4core.create("chartdiv", am4maps.MapChart);
    map.geodata = am4geodata_japanLow;
    map.projection = new am4maps.projections.Miller;
    var polygonSeries = map.series.push(new am4maps.MapPolygonSeries());
    polygonSeries.useGeodata = true;

    polygonSeries.mapPolygons.template.events.on("hit", function(ev){
      map.zoomToMapObject(ev.target);
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
