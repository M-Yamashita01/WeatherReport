import VueRouter from "vue-router";
import Index from "./components/Index";
import LogIn from "./components/Login";
import SignIn from "./components/SignIn";
import LogOut from "./components/Logout";
import Profile from "./components/Profile";
import ProfileEdit from "./components/ProfileEdit";

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
  },
  {
    path: "/profile",
    component: Profile
  },
  {
    path: "/profile-edit",
    component: ProfileEdit
  }
];

export default new VueRouter({
  mode: "history",
  routes
});
