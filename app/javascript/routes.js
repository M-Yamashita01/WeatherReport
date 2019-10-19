import VueRouter from "vue-router";
import Index from "./packs/Index";
import LogIn from "./packs/components/Login";
import SignIn from "./packs/components/SignIn";
import LogOut from "./packs/components/Logout";

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
