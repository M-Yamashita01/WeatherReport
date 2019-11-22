<template>
  <div>
    <ul class="list-inline">
      <button class="list-inline-item" v-on:click="updateScope(todayDate)">
        {{ todayDate }}
      </button>
      <button class="list-inline-item" v-on:click="updateScope(tommorowDate)">
        {{ tommorowDate }}
      </button>
      <button
        class="list-inline-item"
        v-on:click="updateScope(dayAfterTommorowDate)"
      >
        {{ dayAfterTommorowDate }}
      </button>
    </ul>
    <div id="chartdiv"></div>
  </div>
</template>

<script>
import * as am4core from "@amcharts/amcharts4/core";
import * as am4maps from "@amcharts/amcharts4/maps";
import am4geodataJapanLow from "@amcharts/amcharts4-geodata/japanLow";

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
    this.map.geodata = am4geodataJapanLow;

    // Set projection
    this.map.projection = new am4maps.projections.Miller();

    // Set default position
    this.map.homeZoomLevel = 1;
    // this.map.homeGeoPoint = { longitude: "139", latitude: "35"}

    const polygonSeries = this.map.series.push(new am4maps.MapPolygonSeries());
    polygonSeries.useGeodata = true;

    // zoom event by click on map
    const polygonTemplate = polygonSeries.mapPolygons.template;
    polygonTemplate.events.on("hit", ev => {
      ev.target.series.chart.zoomToMapObject(ev.target);
      this.currentZoomLevel = ev.target.series.chart.zoomLevel;
      this.zoomGeoPoint = ev.target.series.chart.zoomGeoPoint;
    });

    // mouse wheel disable
    this.map.chartContainer.wheelable = false;

    // zoom control
    this.map.zoomControl = new am4maps.ZoomControl();

    // Add button
    const homeButton = new am4core.Button();
    homeButton.events.on("hit", () => {
      this.map.goHome();
    });
    homeButton.icon = new am4core.Sprite();
    homeButton.icon.path =
      "M16,8 L14,8 L14,16 L10,16 L10,10 L6,10 L6,16 L2,16 L2,8 L0,8 L8,0 L16,8 Z M16,8";

    homeButton.padding(7, 5, 7, 5);
    homeButton.width = 30;
    homeButton.marginBottom = 10;
    homeButton.parent = this.map.zoomControl;
    homeButton.insertBefore(this.map.zoomControl.plusButton);

    this.imageSeries = this.map.series.push(new am4maps.MapImageSeries());
    const imageTemplate = this.imageSeries.mapImages.template;
    imageTemplate.propertyFields.longitude = "longitude";
    imageTemplate.propertyFields.latitude = "latitude";
    imageTemplate.nonScaling = true;

    const image = imageTemplate.createChild(am4core.Image);
    image.propertyFields.href = "imageURL";
    image.width = 30;
    image.height = 30;
    image.horizontalCenter = "middle";
    image.verticalCenter = "bottom";

    const label = imageTemplate.createChild(am4core.Label);
    label.text = "{label}";
    label.horizontalCenter = "middle";
    label.verticalCenter = "top";
    label.dy = 5;
  },
  methods: {
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
    const dateToString = date =>
      date.getFullYear() + "-" + (date.getMonth() + 1) + "-" + date.getDate();

    const date = new Date();
    this.todayDate = dateToString(date);

    date.setDate(date.getDate() + 1);
    this.tommorowDate = dateToString(date);

    date.setDate(date.getDate() + 1);
    this.dayAfterTommorowDate = dateToString(date);
  },
  watch: {
    weathers(weathers) {
      this.imageSeries.data = [{}];
      weathers.forEach(weather => {
        this.imageSeries.data.push({
          latitude: weather.latitude,
          longitude: weather.longitude,
          imageURL:
            "http://openweathermap.org/img/wn/" +
            weather.weather_icon +
            "@2x.png",
          width: 32,
          height: 32,
          // label: weather.city_name
          label: weather.city_name_ja
        });
      });
    },
    "map.zoomLevel": function(zoomLevel) {
      if (this.timer > 0) {
        window.clearTimeout(this.timer);
      }

      this.currentZoomLevel = zoomLevel;

      this.timer = window.setTimeout(() => {
        this.updateScope(this.todayDate);
      }, 200);
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
