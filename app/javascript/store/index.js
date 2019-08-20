import Vue from 'vue';
import Vuex from 'vuex';
import createPersistedState from 'vuex-persistedstate';
import auth from './modules/auth';

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
	},
	actions: {
		create({commit}, payload) {
			commit('create', payload);
		},
	},
	plugins: [createPersistedState({
		key: 'WeatherReportToken',
		storage: window.sessionStorage,
	})],
});
