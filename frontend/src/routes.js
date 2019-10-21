import VueRouter from "vue-router";
import Index from "./components/Index";
import LogIn from "./components/Login";
import SignIn from "./components/SignIn";
import LogOut from "./components/Logout";

const routes = [
  {
    path: "/",
    component: Index
  },
  {
    path: "/login",
    component: LogIn
  },
  {
    path: "/signin",
    component: SignIn
  },
  {
    path: "/logout",
    component: LogOut
  }
];

export default new VueRouter({
  mode: "history",
  routes
});
