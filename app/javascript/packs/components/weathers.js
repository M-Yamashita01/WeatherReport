import axios from 'axios';

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
 * @return  {res} weather from Rails API
 */
async function getWeathers(date, mainCityFlag, longitudeMax, longitudeMin, latitudeMax, latitudeMin, callback) {
	let res = await axios.get('/api/location_on_forecast_days', {
		params: {
			date: date,
			main_city_flag: mainCityFlag,
			longitude_max: longitudeMax,
			longitude_min: longitudeMin,
			latitude_max: latitudeMax,
			latitude_min: latitudeMin,
		},
	}).then( (response) => {
		callback(response);
	})
		.catch( (e) => {
			console.log('Error : Failed to get weather from Rails API.');
			console.log(e);
		});
}

export default {getWeathers};
