import VueRouter from 'vue-router';
import Index from './packs/index';

const routes = [{
	path: '/', component: Index,
}];

export default new VueRouter({routes});
