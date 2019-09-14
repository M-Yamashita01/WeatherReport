import axios from 'axios';

const SEARCH_ONLY_MAIN_CITY = 1;
const SEARCH_ALL_CITY = '';
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
async function getWeathers(date, mainCityFlag, longitudeMax, longitudeMin, latitudeMax, latitudeMin) {
	let res = await axios.get('/api/location_on_forecast_days', {
		params: {
			date: date,
			main_city_flag: mainCityFlag,
			longitude_max: longitudeMax,
			longitude_min: longitudeMin,
			latitude_max: latitudeMax,
			latitude_min: latitudeMin,
		},
	}).catch((e) => {
		console.log('Error : Failed to get weather from Rails API.');
		console.log(e);
	});
	return res.data;
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
function getLocationWeathers(date, zoomLevel, longitude, latitude) {
	// DBで検索する地域を、主要都市のみか全地域のみかズームの度合いで決定する
	// デフォルトは主要都市のみ検索とする
	let mainCityFlag = SEARCH_ONLY_MAIN_CITY;
	if (zoomLevel >= 3) {
		mainCityFlag = SEARCH_ALL_CITY;
	}

	let longitudeMax = '';
	let longitudeMin = '';
	let latitudeMax = '';
	let latitudeMin = '';
	if (mainCityFlag == SEARCH_ALL_CITY) {
		// 検索する緯度、経度の範囲を指定する
		// 範囲の数値は適当
		longitudeMax = parseInt(longitude, 10) + 3;
		longitudeMin = parseInt(longitude) - 3;
		latitudeMax = parseInt(latitude) + 1;
		latitudeMin = parseInt(latitude) - 1;
	}

	return getWeathers(date, mainCityFlag, longitudeMax, longitudeMin, latitudeMax, latitudeMin);
}

export default { getLocationWeathers };

