import Vue from 'vue';
import Vuex from 'vuex';
import createPersistedState from 'vuex-persistedstate';


Vue.use(Vuex);

export default new Vuex.Store({
	state: {
		accessToken: '',
		client: '',
		uid: '',
		userName: '',
	},
	mutations: {
		create(state, data) {
			state.accessToken = data.accessToken;
			state.client = data.client;
			state.uid = data.uid;
			state.userName = data.userName;
		},
		destroy(state) {
			state.accessToken = '';
			state.client = '';
			state.uid = '';
			state.userName = '';
		},
	},
	actions: {
		create({commit}, payload) {
			commit('create', payload);
		},
		destroy({commit}) {
			commit('destroy');
		},
	},
	getters: {
		hasToken(state) {
			if (state.accessToken != '') {
				return true;
			}
			return false;
		},
		getUserName(state) {
			return state.userName;
		},
	},
	plugins: [createPersistedState({
		key: 'WeatherReportToken',
		storage: window.sessionStorage,
	})],
});
