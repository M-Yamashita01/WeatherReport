import axios from "axios";

/**
 * @param {*} longitudeMax
 * @param {*} longitudeMin
 * @param {*} latitudeMax
 * @param {*} latitudeMin
 */
async function getWeathers(
  longitudeMax,
  longitudeMin,
  latitudeMax,
  latitudeMin
) {
  let weatherDatas = [];
  await axios
    .get("/api/current_weather_datas", {
      params: {
        longitude_max: longitudeMax,
        longitude_min: longitudeMin,
        latitude_max: latitudeMax,
        latitude_min: latitudeMin
      }
    })
    .then(response => {
      console.log(response);
      weatherDatas = response.data.current_weather_data;
    })
    .catch(error => {
      printResponseErrorLog(error);
      throw error;
    });
  return weatherDatas;
}

/**
 *
 */
async function getMainCityLocations() {
  let mainCityDatas = [];
  await axios
    .get("/api/main_city_locations")
    .then(response => {
      mainCityDatas = response.data.main_city;
    })
    .catch(err => {
      printResponseErrorLog(err);
      mainCityDatas = [];
    });
  return mainCityDatas;
}

/**
 * @param {*} email
 * @param {*} password
 */
async function postSignin(email, password) {
  let signedInUser = "";
  await axios
    .post("/api/auth/sign_in", {
      email: email,
      password: password
    })
    .then(response => {
      signedInUser = response;
    })
    .catch(error => {
      printResponseErrorLog(error);
      throw error;
    });
  return signedInUser;
}

/**
 * @param {*} error
 */
function printResponseErrorLog(error) {
  if (error.response) {
    console.log(error.response.data);
    console.log(error.response.status);
    console.log(error.response.statusText);
    console.log(error.response.headers);
  } else if (error.request) {
    console.log(error.request);
  } else {
    console.log("Error", error.message);
  }
  console.log(error.config);
}

export default { getWeathers, getMainCityLocations, postSignin };
