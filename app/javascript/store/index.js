import Vue from 'vue';
import Vuex from 'vuex';
import createPersistedState from 'vuex-persistedstate';


Vue.use(Vuex);

export default new Vuex.Store({
	state: {
		accessToken: '',
		client: '',
		uid: '',
	},
	mutations: {
		create(state, data) {
			state.accessToken = data.accessToken;
			state.client = data.client;
			state.uid = data.uid;
		},
		destroy(state) {
			state.accessToken = '';
			state.client = '';
			state.uid = '';
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
	},
	plugins: [createPersistedState({
		key: 'WeatherReportToken',
		storage: window.sessionStorage,
	})],
});
