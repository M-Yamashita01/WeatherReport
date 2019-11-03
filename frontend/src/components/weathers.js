import request from "./request";

const TARGET_MAIN_CITY = 1;
const TARGET_PREFECTURE_CITY = 2;
const TARGET_ALL_CITY = 3;
/**
 *
 *
 * @param {*} date
 * @param {*} targetCity
 * @param {*} longitudeMax
 * @param {*} longitudeMin
 * @param {*} latitudeMax
 * @param {*} latitudeMin
 * @param {*} callback
 * @return  {res.data} weather from Rails API
 */
function getWeathers(
  date,
  targetCity,
  longitudeMax,
  longitudeMin,
  latitudeMax,
  latitudeMin
) {
  try {
    let weatherDatas = [];

    request.getWeathers(
      longitudeMax,
      longitudeMin,
      latitudeMax,
      latitudeMin,
      function(weathers, error) {
        if (error) {
          return [];
        } else {
          if (targetCity == TARGET_ALL_CITY) {
            weatherDatas = weathers;
          } else if (targetCity == TARGET_MAIN_CITY) {
            const httpObj = new XMLHttpRequest();
            httpObj.onreadystatechange = function() {
              if (httpObj.responseText == "") {
                console.log("main city locations is none.");
                return;
              }
              const jsonRes = JSON.parse(httpObj.responseText || "null");
              const mainCityData = jsonRes["main_city"];
              Object.keys(mainCityData).forEach(function(key) {
                weathers.filter(function(item, index) {
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
                currentWeatherDatas[key].city_name.endsWith(
                  patternPrefecture
                ) ||
                currentWeatherDatas[key].city_name == patternOsaka ||
                currentWeatherDatas[key].city_name == patternKyoto ||
                currentWeatherDatas[key].city_name == patternTokyo ||
                currentWeatherDatas[key].city_name == patternHokkaido
              ) {
                weatherDatas.push(currentWeatherDatas[key]);
              }
            });
          }
        }
      }
    );
    return weatherDatas;
  } catch (e) {
    console.log(e);
  }
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
  // 表示する地域を、主要都市のみ、県のみ、全地域のみかズームの度合いで決定する
  // デフォルトは主要都市のみ検索とする
  let targetCity = TARGET_MAIN_CITY;
  if (10 >= zoomLevel && zoomLevel >= 3) {
    targetCity = TARGET_PREFECTURE_CITY;
  } else if (zoomLevel > 10) {
    targetCity = TARGET_ALL_CITY;
  }

  let longitudeMax = "";
  let longitudeMin = "";
  let latitudeMax = "";
  let latitudeMin = "";
  if (targetCity == TARGET_ALL_CITY) {
    // 検索する緯度、経度の範囲を指定する
    // 範囲の数値は適当
    longitudeMax = parseInt(longitude, 10) + 3;
    longitudeMin = parseInt(longitude) - 3;
    latitudeMax = parseInt(latitude) + 1;
    latitudeMin = parseInt(latitude) - 1;
  }

  const response = getWeathers(
    date,
    targetCity,
    longitudeMax,
    longitudeMin,
    latitudeMax,
    latitudeMin
  );
  return response;
}

export default { getLocationWeathers };
