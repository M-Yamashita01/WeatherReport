import VueRouter from 'vue-router';
import Index from './packs/index';
import LogIn from './packs/components/login';
import SignIn from './packs/components/signin';

const routes = [
	{
		path: '/', component: Index,
	},
	{
		path: '/login', component: LogIn,
	},
	{
		path: '/signin', component: SignIn,
	},
];

export default new VueRouter({
	mode: 'history',
	routes,
});
