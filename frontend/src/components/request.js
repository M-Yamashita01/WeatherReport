import axios from "axios";
/**
 * @param {*} longitudeMax
 * @param {*} longitudeMin
 * @param {*} latitudeMax
 * @param {*} latitudeMin
 * @param {*} callback
 * @return {weather|error}
 */
async function getWeathers(
  longitudeMax,
  longitudeMin,
  latitudeMax,
  latitudeMin,
  callback
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
    .catch(err => {
      printResponseErrorLog(err);
      callback(null, err);
    });

  callback(res.data.current_weather_data, null);
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

export default { getWeathers };
