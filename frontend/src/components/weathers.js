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
  let weatherDatas = [];
  await request
    .getWeathers(longitudeMax, longitudeMin, latitudeMax, latitudeMin)
    .then(async response => {
      await getWeathersForSpecifiedCity(response, targetCity)
        .then(specifiedCityWeathers => {
          weatherDatas = specifiedCityWeathers;
        })
        .catch(error => {
          console.log("getWeathersForSpecifiedCity failed.");
          console.log(error);
          weatherDatas = [];
        });
    })
    .catch(error => {
      console.log("getWeathers failed");
      console.log(error);
      return [];
    });
  return weatherDatas;
}

/**
 *
 *
 * @param {*} weathers
 * @param {*} targetCity
 * @return {weatherDatas}
 */
async function getWeathersForSpecifiedCity(weathers, targetCity) {
  let weatherDatas = [];

  if (targetCity == TARGET_ALL_CITY) {
    weatherDatas = weathers;
  } else if (targetCity == TARGET_MAIN_CITY) {
    await request
      .getMainCityLocations()
      .then(mainCityData => {
        if (mainCityData) {
          Object.keys(mainCityData).forEach(function(key) {
            weathers.filter(function(item, index) {
              if (item.city_id == mainCityData[key].id) {
                weatherDatas.push(item);
              }
            });
          });
        } else {
          console.log("main city does not exist.");
          weatherDatas = [];
        }
      })
      .catch(error => {
        console.log("getMainCityLocations failed.");
        console.log(error);
        weatherDatas = [];
      });
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

    let weatherDatas = [];
    await getWeathers(
      date,
      targetCity,
      longitudeMax,
      longitudeMin,
      latitudeMax,
      latitudeMin
    )
      .then(weathers => {
        weatherDatas = weathers;
      })
      .catch(error => {
        console.log("getWeathers failed.");
        console.log(error);
        weatherDatas = [];
      });
    return weatherDatas;
  } catch (error) {
    console.log(error);
  }
}

export default { getLocationWeathers };
