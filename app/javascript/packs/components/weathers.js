import axios from "axios";

const SEARCH_MAIN_CITY = 1;
const SEARCH_PREFECTURE_CITY = 2;
const SEARCH_ALL_CITY = "";
/**
 *
 *
 * @param {*} date
 * @param {*} mainCityFlag
 * @param {*} longitudeMax
 * @param {*} longitudeMin
 * @param {*} latitudeMax
 * @param {*} latitudeMin
 * @param {*} callback
 * @return  {res.data} weather from Rails API
 */
async function getWeathers(
  date,
  mainCityFlag,
  longitudeMax,
  longitudeMin,
  latitudeMax,
  latitudeMin
) {
  const res = await axios
    .get("/api/current_weather_datas", {
      params: {
        longitude_max: longitudeMax,
        longitude_min: longitudeMin,
        latitude_max: latitudeMax,
        latitude_min: latitudeMin
      }
    })
    .catch(e => {
      console.log("Error : Failed to get weather from Rails API.");
      console.log(e);
    });

  let weatherDatas = [];
  if (mainCityFlag == SEARCH_ALL_CITY) {
    weatherDatas = res.data.current_weather_data;
  } else if (mainCityFlag == SEARCH_MAIN_CITY) {
    const httpObj = new XMLHttpRequest();
    httpObj.onreadystatechange = function() {
      if (httpObj.responseText == "") {
        console.log("main city locations is none.");
        return;
      }
      const jsonRes = JSON.parse(httpObj.responseText || "null");
      const mainCityData = jsonRes["main_city"];
      Object.keys(mainCityData).forEach(function(key) {
        res.data.current_weather_data.filter(function(item, index) {
          if (item.city_id == mainCityData[key].id) {
            weatherDatas.push(item);
          }
        });
      });
    };

    httpObj.open("get", "/api/main_city_locations", false);
    httpObj.send(null);
  } else {
    const patternPrefecture = "-ken";
    const patternOsaka = "Ōsaka-fu";
    const patternKyoto = "Kyōto-fu";
    const patternTokyo = "Tokyo";
    const patternHokkaido = "Hokkaidō";

    const currentWeatherDatas = res.data.current_weather_data;
    Object.keys(currentWeatherDatas).forEach(function(key) {
      if (
        currentWeatherDatas[key].city_name.endsWith(patternPrefecture) ||
        currentWeatherDatas[key].city_name == patternOsaka ||
        currentWeatherDatas[key].city_name == patternKyoto ||
        currentWeatherDatas[key].city_name == patternTokyo ||
        currentWeatherDatas[key].city_name == patternHokkaido
      ) {
        weatherDatas.push(currentWeatherDatas[key]);
      }
    });
  }
  return weatherDatas;
}
/**
 *
 *
 * @param {*} date
 * @param {*} zoomLevel
 * @param {*} longitude
 * @param {*} latitude
 * @param {*} callback
 * @return  {getWeathers} weather from Rails API
 */
function getLocationWeathers(date, zoomLevel, longitude, latitude) {
  // DBで検索する地域を、主要都市のみ、県のみ、全地域のみかズームの度合いで決定する
  // デフォルトは主要都市のみ検索とする

  console.log(zoomLevel);
  let mainCityFlag = SEARCH_MAIN_CITY;
  if (10 >= zoomLevel && zoomLevel >= 3) {
    mainCityFlag = SEARCH_PREFECTURE_CITY;
  } else if (zoomLevel > 10) {
    mainCityFlag = SEARCH_ALL_CITY;
  }

  let longitudeMax = "";
  let longitudeMin = "";
  let latitudeMax = "";
  let latitudeMin = "";
  if (mainCityFlag == SEARCH_ALL_CITY) {
    // 検索する緯度、経度の範囲を指定する
    // 範囲の数値は適当
    longitudeMax = parseInt(longitude, 10) + 3;
    longitudeMin = parseInt(longitude) - 3;
    latitudeMax = parseInt(latitude) + 1;
    latitudeMin = parseInt(latitude) - 1;
  }

  return getWeathers(
    date,
    mainCityFlag,
    longitudeMax,
    longitudeMin,
    latitudeMax,
    latitudeMin
  );
}

export default { getLocationWeathers };
