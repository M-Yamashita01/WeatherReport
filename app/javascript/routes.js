import VueRouter from 'vue-router';
import Index from './packs/index';
import LogIn from './packs/components/login';

const routes = [
	{
		path: '/', component: Index,
	},
	{
		path: '/login', component: LogIn,
	},
];

export default new VueRouter({routes});
