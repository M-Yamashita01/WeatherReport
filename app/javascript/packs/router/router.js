import Vue from 'vue/dist/vue.esm.js';
import VueRouter from 'vue-router';
import Index from '../components/index.vue';
import About from '../components/about.vue';
import Help from '../components/help.vue';

Vue.use(VueRouter);

export default new VueRouter({
	mode: 'history',
	routes: [
		{path: '/', component: Index},
		{path: '/about', component: About},
		{path: '/help', component: Help},
	],
});
