<template>
  <v-app>
    <layout-header></layout-header>
    <v-container class="mx-auto" fill-height>
      <v-row justify="center">
        <v-col cols="12" md="11" lg="11" xl="11">
          <v-main>
            <router-view></router-view>
          </v-main>
        </v-col>
      </v-row>
    </v-container>
  </v-app>
</template>

<script>
import Vue from "vue";
import VueRouter from "vue-router";

import LayoutHeader from "../components/layout/LayoutHeader.vue";

import PostsFollowingPage from "./posts/PostsFollowingPage.vue";
import PostsSearchPage from "./posts/PostsSearchPage.vue";
import PostsNewPage from "./posts/PostsNewPage.vue";
import PostsEditPage from "./posts/PostsEditPage.vue";

import UsersIndexPage from "./users/UsersIndexPage.vue";
import UsersShowPage from "./users/UsersShowPage.vue";
import UsersEditPage from "./users/UsersEditPage.vue";
import UsersFollowingPage from "./users/UsersFollowingPage.vue";
import UsersFollowersPage from "./users/UsersFollowersPage.vue";

import LoginPage from "./login/LoginPage.vue";
import SignUpPage from "./login/SignUpPage.vue";

const router = new VueRouter({
  routes: [
    { path: "/", component: PostsFollowingPage },
    { path: "/posts/search", component: PostsSearchPage },
    { path: "/posts/new", name: "PostsNewPage", component: PostsNewPage },
    {
      path: "/posts/:id(\\d+)/edit",
      name: "PostsEditPage",
      component: PostsEditPage,
    },
    { path: "/users", name: "UsersIndexPage", component: UsersIndexPage },
    {
      path: "/users/:id(\\d+)",
      name: "UsersShowPage",
      component: UsersShowPage,
    },
    {
      path: "/users/:id(\\d+)/edit",
      name: "UsersEditPage",
      component: UsersEditPage,
    },
    {
      path: "/users/:id(\\d+)/following",
      name: "UsersFollowingPage",
      component: UsersFollowingPage,
    },
    {
      path: "/users/:id(\\d+)/followers",
      name: "UsersFollowersPage",
      component: UsersFollowersPage,
    },
    {
      path: "/sign_in",
      name: "LoginPage",
      component: LoginPage,
    },
    {
      path: "/sign_up",
      name: "SignUpPage",
      component: SignUpPage,
    },
  ],
});

Vue.use(VueRouter);

export default {
  components: { LayoutHeader },
  router,
  icons: {
    iconfont: "mdiSvg",
  },
};
</script>

<style scoped>
.container {
  padding: 0;
}
</style>

