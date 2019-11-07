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
 */
async function getWeathers(
  date,
  targetCity,
  longitudeMax,
  longitudeMin,
  latitudeMax,
  latitudeMin
) {
  console.log("getWeathers start.");
  let weatherDatas = [];
  await request
    .getWeathers(longitudeMax, longitudeMin, latitudeMax, latitudeMin)
    .then(response => {
      console.log("set response");
      console.log(response);
      console.log(response.data.current_weather_data);
      weatherDatas = response.data.current_weather_data;
      // return response; // ⇦これが見えていない。undefinedになる
      /*
      console.log("getWeathers finished.");
      console.log(response);
      console.log(response.data);
      console.log(response.data.current_weather_data);
      return response.data.current_weather_data;
      */
    })
    .catch(error => {
      console.log("weathers does not exist.");
      return [];
    });
  console.log("getWeathers return");
  return weatherDatas;
  /*    .then(weathers => {
      console.log("Start getWeathersForSpecifiedCity function");
      return getWeathersForSpecifiedCity(weathers, targetCity);
    })
    .catch(error => {
      console.log("weathers does not exist.");
      return [];
    });
    */
}

/**
 *
 *
 * @param {*} weathers
 * @param {*} targetCity
 * @return {weatherDatas}
 */
/*
function getWeathersForSpecifiedCity(weathers, targetCity) {
  const weatherDatas = [];

  console.log("getWeathersForSpecifiedCity start");
  console.log(weathers);
  if (targetCity == TARGET_ALL_CITY) {
    weatherDatas = weathers;
  } else if (targetCity == TARGET_MAIN_CITY) {
    console.log("Start getMainCityLocations");
    const mainCityData = request.getMainCityLocations();
    console.log("Fnished getMainCityLocations");
    if (mainCityData) {
      console.log("maiinCityData existed");
      Object.keys(mainCityData).forEach(function(key) {
        weathers.filter(function(item, index) {
          if (item.city_id == mainCityData[key].id) {
            weatherDatas.push(item);
          }
        });
      });
      console.log("weatherDatas pushed finished");
      console.log(weatherDatas);
    } else {
      console.log("getWeathersForSpecifiedCity error");
      return [];
    }
  } else {
    const patternPrefecture = "-ken";
    const patternOsaka = "Ōsaka-fu";
    const patternKyoto = "Kyōto-fu";
    const patternTokyo = "Tokyo";
    const patternHokkaido = "Hokkaidō";

    const currentWeatherDatas = weathers;
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
*/
/**
 *
 *
 * @param {*} date
 * @param {*} zoomLevel
 * @param {*} longitude
 * @param {*} latitude
 * @param {*} callback
 */
async function getLocationWeathers(date, zoomLevel, longitude, latitude) {
  try {
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

    console.log("Start getWeathers");
    let weatherDatas = [];
    await getWeathers(
      date,
      targetCity,
      longitudeMax,
      longitudeMin,
      latitudeMax,
      latitudeMin
    )
      .then(re => {
        console.log("Finshed getWeathers");
        console.log(re);
        weatherDatas = re;
      })
      .catch(error => {
        console.log("Error getWeathers");
        console.log(error);
        weatherDatas = [];
      });
    return weatherDatas;
  } catch (err) {
    console.log(err);
  }
}

export default { getLocationWeathers };
