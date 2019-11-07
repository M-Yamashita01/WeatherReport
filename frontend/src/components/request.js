/* eslint-disable no-unused-vars */
import axios from "axios";
import { resolve } from "path";
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
  return await axios
    .get("/api/current_weather_datas", {
      params: {
        longitude_max: longitudeMax,
        longitude_min: longitudeMin,
        latitude_max: latitudeMax,
        latitude_min: latitudeMin
      }
    })
    .then(response => {
      return response;
    })
    .catch(error => {
      printResponseErrorLog(error);
      throw error;
    });
}

/**
 *
 */
async function getMainCityLocations() {
  const res = await axios
    .get("/api/main_city_locations")
    .then(response => {
      return response.data.main_city;
    })
    .catch(err => {
      printResponseErrorLog(err);
      return [];
    });
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

export default { getWeathers, getMainCityLocations };
